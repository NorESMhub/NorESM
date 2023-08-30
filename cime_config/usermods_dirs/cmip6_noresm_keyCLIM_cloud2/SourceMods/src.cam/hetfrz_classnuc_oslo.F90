module hetfrz_classnuc_oslo

!---------------------------------------------------------------------------------
!
!  CAM Interfaces for hetfrz_classnuc module.
!
!---------------------------------------------------------------------------------

use shr_kind_mod,   only: r8=>shr_kind_r8
use spmd_utils,     only: masterproc
use ppgrid,         only: pcols, pver, begchunk, endchunk
use physconst,      only: rair, cpair, rh2o, rhoh2o, mwh2o, tmelt, pi
use constituents,   only: cnst_get_ind, pcnst
use physics_types,  only: physics_state
use physics_buffer, only: physics_buffer_desc, pbuf_get_index, pbuf_old_tim_idx, pbuf_get_field
use phys_control,   only: phys_getopts, use_hetfrz_classnuc

use physics_buffer, only: pbuf_add_field, dtype_r8, pbuf_old_tim_idx, &
                          pbuf_get_index, pbuf_get_field
use cam_history,    only: addfld, add_default, outfld

use ref_pres,       only: top_lev => trop_cloud_top_lev
use wv_saturation,  only: svp_water, svp_ice

use cam_logfile,    only: iulog
use error_messages, only: handle_errmsg, alloc_err
use cam_abortutils, only: endrun

use hetfrz_classnuc,   only: hetfrz_classnuc_init, hetfrz_classnuc_calc
use oslo_utils, only: CalculateNumberConcentration, calculateNumberMedianRadius
use aerosoldef, only : MODE_IDX_DST_A2, MODE_IDX_DST_A3, MODE_IDX_OMBC_INTMIX_COAT_AIT

use phys_grid,      only: get_rlat_all_p  !jks 061119, this function will return an array with column latitudes

implicit none
private
save

public :: &
   hetfrz_classnuc_oslo_readnl,   &
   hetfrz_classnuc_oslo_register, &
   hetfrz_classnuc_oslo_init,     &
   hetfrz_classnuc_oslo_calc,     &
   hetfrz_classnuc_oslo_save_cbaero

! Namelist variables
logical :: hist_hetfrz_classnuc = .false.

! Vars set via init method.
real(r8) :: mincld      ! minimum allowed cloud fraction

! constituent indices
integer :: &
   cldliq_idx = -1, &
   cldice_idx = -1, &
   numliq_idx = -1, &
   numice_idx = -1

! pbuf indices for fields provided by heterogeneous freezing
integer :: &
   frzimm_idx, &
   frzcnt_idx, &
   frzdep_idx

! pbuf indices for fields needed by heterogeneous freezing
integer :: &
   ast_idx = -1

! specie properties
real(r8) :: specdens_dust
real(r8) :: specdens_so4
real(r8) :: specdens_bc
real(r8) :: specdens_soa
real(r8) :: specdens_pom

! List all species
integer :: ncnst = 0     ! Total number of constituents (mass and number) needed
                         ! by the parameterization (depends on aerosol model used)

integer :: so4_accum     ! sulfate in accumulation mode
integer :: bc_accum      ! black-c in accumulation mode
integer :: pom_accum     ! p-organic in accumulation mode
integer :: soa_accum     ! s-organic in accumulation mode
integer :: dst_accum     ! dust in accumulation mode
integer :: ncl_accum     ! seasalt in accumulation mode
integer :: num_accum     ! number in accumulation mode

integer :: dst_coarse    ! dust in coarse mode
integer :: ncl_coarse    ! seasalt in coarse mode
integer :: so4_coarse    ! sulfate in coarse mode
integer :: num_coarse    ! number in coarse mode

integer :: dst_finedust  ! dust in finedust mode
integer :: so4_finedust  ! sulfate in finedust mode
integer :: num_finedust  ! number in finedust mode

integer :: dst_coardust  ! dust in coardust mode
integer :: so4_coardust  ! sulfate in coardust mode
integer :: num_coardust  ! number in coardust mode

integer :: bc_pcarbon    ! black-c in primary carbon mode
integer :: pom_pcarbon   ! p-organic in primary carbon mode
integer :: num_pcarbon   ! number in primary carbon mode

! Index arrays for looping over all constituents
integer, allocatable :: mode_idx(:)
integer, allocatable :: spec_idx(:)

! Copy of cloud borne aerosols before modification by droplet nucleation
! The basis is converted from mass to volume.
real(r8), allocatable :: aer_cb(:,:,:,:)

! Copy of interstitial aerosols with basis converted from mass to volume.
real(r8), allocatable :: aer(:,:,:,:)

!===============================================================================
contains
!===============================================================================

subroutine hetfrz_classnuc_oslo_readnl(nlfile)

  use namelist_utils,  only: find_group_name
  use units,           only: getunit, freeunit
  use mpishorthand

  character(len=*), intent(in) :: nlfile  ! filepath for file containing namelist input

  ! Local variables
  integer :: unitn, ierr
  character(len=*), parameter :: subname = 'hetfrz_classnuc_cam_readnl'

  namelist /hetfrz_classnuc_nl/ hist_hetfrz_classnuc

  !-----------------------------------------------------------------------------

  if (masterproc) then
     unitn = getunit()
     open( unitn, file=trim(nlfile), status='old' )
     call find_group_name(unitn, 'hetfrz_classnuc_nl', status=ierr)
     if (ierr == 0) then
        read(unitn, hetfrz_classnuc_nl, iostat=ierr)
        if (ierr /= 0) then
           call endrun(subname // ':: ERROR reading namelist')
        end if
     end if
     close(unitn)
     call freeunit(unitn)

  end if

#ifdef SPMD
  ! Broadcast namelist variables
  call mpibcast(hist_hetfrz_classnuc, 1, mpilog, 0, mpicom)
#endif

end subroutine hetfrz_classnuc_oslo_readnl

!================================================================================================

subroutine hetfrz_classnuc_oslo_register()

   if (.not. use_hetfrz_classnuc) return

   ! pbuf fields provided by hetfrz_classnuc
   call pbuf_add_field('FRZIMM', 'physpkg', dtype_r8, (/pcols,pver/), frzimm_idx)
   call pbuf_add_field('FRZCNT', 'physpkg', dtype_r8, (/pcols,pver/), frzcnt_idx)
   call pbuf_add_field('FRZDEP', 'physpkg', dtype_r8, (/pcols,pver/), frzdep_idx)

end subroutine hetfrz_classnuc_oslo_register

!================================================================================================

subroutine hetfrz_classnuc_oslo_init(mincld_in)

   real(r8), intent(in) :: mincld_in

   ! local variables
   logical  :: prog_modal_aero
   integer  :: m, n, nspec
   integer  :: istat

   real(r8) :: sigma_logr_aer

   character(len=32) :: str32
   character(len=*), parameter :: routine = 'hetfrz_classnuc_cam_init'
   !--------------------------------------------------------------------------------------------

   if (.not. use_hetfrz_classnuc) return

   ! This parameterization currently assumes that prognostic modal aerosols are on.  Check...
   call phys_getopts(prog_modal_aero_out=prog_modal_aero)

   mincld = mincld_in

   call cnst_get_ind('CLDLIQ', cldliq_idx)
   call cnst_get_ind('CLDICE', cldice_idx)
   call cnst_get_ind('NUMLIQ', numliq_idx)
   call cnst_get_ind('NUMICE', numice_idx)

   ! pbuf fields used by hetfrz_classnuc
   ast_idx      = pbuf_get_index('AST')

   call addfld('bc_num',        (/ 'lev' /), 'A', '#/cm3', 'total bc number')
   call addfld('dst1_num',      (/ 'lev' /), 'A', '#/cm3', 'total dst1 number')
   call addfld('dst3_num',      (/ 'lev' /), 'A', '#/cm3', 'total dst3 number')
   call addfld('bc_num_scaled',        (/ 'lev' /), 'A', '#/cm3', 'total bc number scaled by inp_mult') ! jks
   call addfld('dst1_num_scaled',      (/ 'lev' /), 'A', '#/cm3', 'total dst1 number scaled by inp_mult') ! jks
   call addfld('dst3_num_scaled',      (/ 'lev' /), 'A', '#/cm3', 'total dst3 number scaled by inp_mult') !jks
   call addfld('bcc_num',       (/ 'lev' /), 'A', '#/cm3', 'coated bc number')
   call addfld('dst1c_num',     (/ 'lev' /), 'A', '#/cm3', 'coated dst1 number')
   call addfld('dst3c_num',     (/ 'lev' /), 'A', '#/cm3', 'coated dst3 number')
   call addfld('bcuc_num',      (/ 'lev' /), 'A', '#/cm3', 'uncoated bc number')
   call addfld('dst1uc_num',    (/ 'lev' /), 'A', '#/cm3', 'uncoated dst1 number')
   call addfld('dst3uc_num',    (/ 'lev' /), 'A', '#/cm3', 'uncoated dst3 number')

   call addfld('bc_a1_num',     (/ 'lev' /), 'A', '#/cm3', 'interstitial bc number')
   call addfld('dst_a1_num',    (/ 'lev' /), 'A', '#/cm3', 'interstitial dst1 number')
   call addfld('dst_a3_num',    (/ 'lev' /), 'A', '#/cm3', 'interstitial dst3 number')
   call addfld('bc_c1_num',     (/ 'lev' /), 'A', '#/cm3', 'cloud borne bc number')
   call addfld('dst_c1_num',    (/ 'lev' /), 'A', '#/cm3', 'cloud borne dst1 number')
   call addfld('dst_c3_num',    (/ 'lev' /), 'A', '#/cm3', 'cloud borne dst3 number')
    
   call addfld('fn_bc_c1_num',  (/ 'lev' /), 'A', '#/cm3', 'cloud borne bc number derived from fn')
   call addfld('fn_dst_c1_num', (/ 'lev' /), 'A', '#/cm3', 'cloud borne dst1 number derived from fn')
   call addfld('fn_dst_c3_num', (/ 'lev' /), 'A', '#/cm3', 'cloud borne dst3 number derived from fn')

   call addfld('na500',         (/ 'lev' /), 'A', '#/cm3', 'interstitial aerosol number with D>500 nm')
   call addfld('totna500',      (/ 'lev' /), 'A', '#/cm3', 'total aerosol number with D>500 nm')

   call addfld('FREQIMM', (/ 'lev' /), 'A', 'fraction', 'Fractional occurance of immersion  freezing')
   call addfld('FREQCNT', (/ 'lev' /), 'A', 'fraction', 'Fractional occurance of contact    freezing')
   call addfld('FREQDEP', (/ 'lev' /), 'A', 'fraction', 'Fractional occurance of deposition freezing')
   call addfld('FREQMIX', (/ 'lev' /), 'A', 'fraction', 'Fractional occurance of mixed-phase clouds' )

   call addfld('DSTFREZIMM', (/ 'lev' /), 'A', 'm-3s-1', 'dust immersion  freezing rate')
   call addfld('DSTFREZCNT', (/ 'lev' /), 'A', 'm-3s-1', 'dust contact    freezing rate')
   call addfld('DSTFREZDEP', (/ 'lev' /), 'A', 'm-3s-1', 'dust deposition freezing rate')

   call addfld('BCFREZIMM', (/ 'lev' /), 'A', 'm-3s-1', 'bc immersion  freezing rate')
   call addfld('BCFREZCNT', (/ 'lev' /), 'A', 'm-3s-1', 'bc contact    freezing rate')
   call addfld('BCFREZDEP', (/ 'lev' /), 'A', 'm-3s-1', 'bc deposition freezing rate')

   call addfld('NIMIX_IMM', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to het immersion freezing in Mixed Clouds')
   call addfld('NIMIX_CNT', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to het contact freezing in Mixed Clouds')
   call addfld('NIMIX_DEP', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to het deposition freezing in Mixed Clouds')

   call addfld('DSTNIDEP', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to dst dep freezing in Mixed Clouds')
   call addfld('DSTNICNT', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to dst cnt freezing in Mixed Clouds')
   call addfld('DSTNIIMM', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to dst imm freezing in Mixed Clouds')

   call addfld('BCNIDEP', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to bc dep freezing in Mixed Clouds')
   call addfld('BCNICNT', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to bc cnt freezing in Mixed Clouds')
   call addfld('BCNIIMM', (/ 'lev' /), 'A', '#/m3', &
               'Activated Ice Number Concentration due to bc imm freezing in Mixed Clouds')

   call addfld('NUMICE10s', (/ 'lev' /), 'A', '#/m3', &
               'Ice Number Concentration due to het freezing in Mixed Clouds during 10-s period')
   call addfld('NUMIMM10sDST', (/ 'lev' /), 'A', '#/m3', &
               'Ice Number Concentration due to imm freezing by dst in Mixed Clouds during 10-s period')
   call addfld('NUMIMM10sBC', (/ 'lev' /), 'A', '#/m3', &
               'Ice Number Concentration due to imm freezing by bc in Mixed Clouds during 10-s period')

   if (hist_hetfrz_classnuc) then

      call add_default('bc_num', 1, ' ')
      call add_default('dst1_num', 1, ' ')
      call add_default('dst3_num', 1, ' ')
      call add_default('bc_num_scaled', 1, ' ') !jks, make sure these fields are included to verify
      call add_default('dst1_num_scaled', 1, ' ') !jks
      call add_default('dst3_num_scaled', 1, ' ') !jks
      call add_default('bcc_num', 1, ' ')
      call add_default('dst1c_num', 1, ' ')
      call add_default('dst3c_num', 1, ' ')
      call add_default('bcuc_num', 1, ' ')
      call add_default('dst1uc_num', 1, ' ')
      call add_default('dst3uc_num', 1, ' ')

      call add_default('bc_a1_num', 1, ' ')
      call add_default('dst_a1_num', 1, ' ')
      call add_default('dst_a3_num', 1, ' ')
      call add_default('bc_c1_num', 1, ' ')
      call add_default('dst_c1_num', 1, ' ')
      call add_default('dst_c3_num', 1, ' ')
    
      call add_default('fn_bc_c1_num', 1, ' ')
      call add_default('fn_dst_c1_num', 1, ' ')
      call add_default('fn_dst_c3_num', 1, ' ')

      call add_default('na500', 1, ' ')
      call add_default('totna500', 1, ' ')

      call add_default('FREQIMM', 1, ' ')
      call add_default('FREQCNT', 1, ' ')
      call add_default('FREQDEP', 1, ' ')
      call add_default('FREQMIX', 1, ' ')

      call add_default('DSTFREZIMM', 1, ' ')
      call add_default('DSTFREZCNT', 1, ' ')
      call add_default('DSTFREZDEP', 1, ' ')

      call add_default('BCFREZIMM', 1, ' ')
      call add_default('BCFREZCNT', 1, ' ')
      call add_default('BCFREZDEP', 1, ' ')

      call add_default('NIMIX_IMM', 1, ' ')
      call add_default('NIMIX_CNT', 1, ' ')  
      call add_default('NIMIX_DEP', 1, ' ')

      call add_default('DSTNIDEP', 1, ' ')
      call add_default('DSTNICNT', 1, ' ')
      call add_default('DSTNIIMM', 1, ' ')

      call add_default('BCNIDEP', 1, ' ')
      call add_default('BCNICNT', 1, ' ')
      call add_default('BCNIIMM', 1, ' ')

      call add_default('NUMICE10s', 1, ' ')
      call add_default('NUMIMM10sDST', 1, ' ')
      call add_default('NUMIMM10sBC', 1, ' ')

   end if

   ! The following code sets indices of the mode specific species used
   ! in the module.  Having a list of the species needed allows us to
   ! allocate temporary space for just those species rather than for all the
   ! CAM species (pcnst) which may be considerably more than needed.
   !
   ! The indices set below are for use with the CAM rad_constituents
   ! interfaces.  Using the rad_constituents interfaces isolates the physics
   ! parameterization which requires constituent information from the chemistry
   ! code which provides that information.

   ! Allocate space for copy of cloud borne aerosols before modification by droplet nucleation.
   allocate(aer_cb(pcols,pver,pcnst,begchunk:endchunk), stat=istat)
   call alloc_err(istat, routine, 'aer_cb', pcols*pver*ncnst*(endchunk-begchunk+1))

   ! Allocate space for copy of interstitial aerosols with modified basis
   allocate(aer(pcols,pver,pcnst,begchunk:endchunk), stat=istat)
   call alloc_err(istat, routine, 'aer', pcols*pver*ncnst*(endchunk-begchunk+1))
   call hetfrz_classnuc_init( &
      rair, cpair, rh2o, rhoh2o, mwh2o, &
      tmelt, pi, iulog)

end subroutine hetfrz_classnuc_oslo_init

!================================================================================================

subroutine hetfrz_classnuc_oslo_calc( &
   state, deltatin, factnum, pbuf    &
   ,numberConcentration, volumeConcentration &
   ,f_acm, f_bcm, f_aqm, f_so4_condm, f_soam &
   ,hygroscopicity, lnsigma, cam, volumeCore, volumeCoat)

   use commondefinitions, only:  nmodes_oslo => nmodes
   use modal_aero_data, only : qqcw_get_field
   use aerosoldef, only : getNumberOfTracersInMode, getTracerIndex
   implicit none

   ! arguments
   type(physics_state), target, intent(in)    :: state
   real(r8),                    intent(in)    :: deltatin       ! time step (s)
   real(r8),                    intent(in)    :: factnum(:,:,:) ! activation fraction for aerosol number
   real(r8),                    intent(in)    :: numberConcentration(pcols,pver,0:nmodes_oslo)
   real(r8),                    intent(in)    :: volumeConcentration(pcols,pver,nmodes_oslo)

   real(r8),intent(in) :: f_acm(pcols,pver, nmodes_oslo)
   real(r8),intent(in) :: f_bcm(pcols,pver, nmodes_oslo)
   real(r8),intent(in) :: f_aqm(pcols, pver, nmodes_oslo)
   real(r8),intent(in) :: f_so4_condm(pcols, pver, nmodes_oslo)            !Needed in "get component fraction"
   real(r8),intent(in) :: f_soam(pcols, pver, nmodes_oslo)

   real(r8),intent(in) :: hygroscopicity(pcols,pver,nmodes_oslo)        ![mol_{aer}/mol_{water}] hygroscopicity
   real(r8),intent(in) :: lnsigma(pcols,pver,nmodes_oslo)              ![-] log(base e) sigma
   real(r8),intent(in) :: cam(pcols,pver,nmodes_oslo)
   real(r8),intent(in) :: volumeCore(pcols,pver,nmodes_oslo)
   real(r8),intent(in) :: volumeCoat(pcols,pver,nmodes_oslo)


   type(physics_buffer_desc),   pointer       :: pbuf(:)
 
   ! local workspace

   ! outputs shared with the microphysics via the pbuf
   real(r8), pointer :: frzimm(:,:)
   real(r8), pointer :: frzcnt(:,:)
   real(r8), pointer :: frzdep(:,:)

   integer :: itim_old
   integer :: i, k

   real(r8) :: rho(pcols,pver)          ! air density (kg m-3)

   real(r8), pointer :: ast(:,:)        

   real(r8) :: lcldm(pcols,pver)

   real(r8), pointer :: ptr2d(:,:)

   real(r8) :: fn(3)
   real(r8) :: awcam(pcols,pver,3)
   real(r8) :: awfacm(pcols,pver,3)
   real(r8) :: hetraer(pcols,pver,3)
   real(r8) :: dstcoat(pcols,pver,3)
   real(r8) :: total_interstitial_aer_num(pcols,pver,3)
   real(r8) :: total_cloudborne_aer_num(pcols,pver,3)
   real(r8) :: total_aer_num(pcols,pver,3)
   real(r8) :: coated_aer_num(pcols,pver,3)
   real(r8) :: uncoated_aer_num(pcols,pver,3)   
   
   ! jks adding dummy variables for hetfrz_classnuc_calc
   real(r8) :: total_interstitial_aer_num_scaled(pcols,pver,3)
   real(r8) :: total_cloudborne_aer_num_scaled(pcols,pver,3)
   real(r8) :: total_aer_num_scaled(pcols,pver,3)
   real(r8) :: coated_aer_num_scaled(pcols,pver,3)
   real(r8) :: uncoated_aer_num_scaled(pcols,pver,3)

   real(r8) :: fn_cloudborne_aer_num(pcols,pver,3)


   real(r8) :: con1, r3lx, supersatice

   real(r8) :: qcic
   real(r8) :: ncic

   real(r8) :: frzbcimm(pcols,pver), frzduimm(pcols,pver)
   real(r8) :: frzbccnt(pcols,pver), frzducnt(pcols,pver)
   real(r8) :: frzbcdep(pcols,pver), frzdudep(pcols,pver)

   real(r8) :: freqimm(pcols,pver), freqcnt(pcols,pver), freqdep(pcols,pver), freqmix(pcols,pver)
   real(r8) :: nnuccc_bc(pcols,pver), nnucct_bc(pcols,pver), nnudep_bc(pcols,pver)
   real(r8) :: nnuccc_dst(pcols,pver), nnucct_dst(pcols,pver), nnudep_dst(pcols,pver)
   real(r8) :: niimm_bc(pcols,pver), nicnt_bc(pcols,pver), nidep_bc(pcols,pver)
   real(r8) :: niimm_dst(pcols,pver), nicnt_dst(pcols,pver), nidep_dst(pcols,pver)
   real(r8) :: numice10s(pcols,pver)
   real(r8) :: numice10s_imm_dst(pcols,pver)
   real(r8) :: numice10s_imm_bc(pcols,pver)

!++oslo aerosol specific
   real(r8) :: qaercwpt(pcols,pver,pcnst) 
   real(r8) :: CloudnumberConcentration(pcols,pver,0:nmodes_oslo)
   real(r8) :: numberMedianRadius(pcols,pver,nmodes_oslo)
!--oslo aerosol specific

   real(r8) :: na500(pcols,pver)
   real(r8) :: tot_na500(pcols,pver)

   ! Declare new objects  ! jks
   real(r8), allocatable :: rlats(:)  ! jks, define as an allocatable because the size ncol is not defined yet
   real(r8)              :: inp_mult  ! jks I think that we just need a single float to do the job here
   real(r8)              :: inp_tag   ! jks I think that we just need a single float to do the job here

   character(128) :: errstring   ! Error status

   integer :: n, m, kk 
   !-------------------------------------------------------------------------------

   associate( &
      lchnk => state%lchnk,             &
      ncol  => state%ncol,              &
      t     => state%t,                 &
      qc    => state%q(:pcols,:pver,cldliq_idx), &
      nc    => state%q(:pcols,:pver,numliq_idx), &
      pmid  => state%pmid               )

   allocate(rlats(ncol)) ! jks, must allocate before referencing because rlats object has no location
   call get_rlat_all_p(lchnk, ncol, rlats) ! jks 191104, get rlats array

   inp_tag = 0.001_r8 ! jks 0.001.0014 this string is to be picked out and replaced with a [0,1] r8
   
   itim_old = pbuf_old_tim_idx()
   call pbuf_get_field(pbuf, ast_idx, ast, start=(/1,1,itim_old/), kount=(/pcols,pver,1/))

   rho(:,:) = 0._r8

   do k = top_lev, pver
      do i = 1, ncol
         rho(i,k) = pmid(i,k)/(rair*t(i,k))
      end do
   end do

   do k = top_lev, pver
      do i = 1, ncol
         lcldm(i,k) = max(ast(i,k), mincld)
      end do
   end do

   ! Convert interstitial and cloud borne aerosols from a mass to a volume basis before
   ! being used in get_aer_num
   do i = 1, pcnst
      aer_cb(:ncol,:,i,lchnk) = aer_cb(:ncol,:,i,lchnk) * rho(:ncol,:)

      ! Check whether constituent is a mass or number mixing ratio
      !if (spec_idx(i) == 0) then
      !   call rad_cnst_get_mode_num(0, mode_idx(i), 'a', state, pbuf, ptr2d)
      !else
      !   call rad_cnst_get_aer_mmr(0, mode_idx(i), spec_idx(i), 'a', state, pbuf, ptr2d)
      !end if
      !aer(:ncol,:,i,lchnk) = ptr2d(:ncol,:) * rho(:ncol,:)
   end do

   ! Init top levels of outputs of get_aer_num
   total_aer_num              = 0._r8
   coated_aer_num             = 0._r8
   uncoated_aer_num           = 0._r8
   total_interstitial_aer_num = 0._r8
   total_cloudborne_aer_num   = 0._r8
   hetraer                    = 0._r8
   awcam                      = 0._r8
   awfacm                     = 0._r8
   dstcoat                    = 0._r8
   na500                      = 0._r8
   tot_na500                  = 0._r8


   !Get estimate of number of aerosols inside clouds
   call calculateNumberConcentration(ncol, aer_cb, rho, CloudnumberConcentration)
   call calculateNumberMedianRadius(numberConcentration, volumeConcentration, lnSigma, numberMedianRadius, ncol)
   !End estimate of number inside clouds

   ! output aerosols as reference information for heterogeneous freezing
   do i = 1, ncol
      ! Set inp multiplier if latitude is in the Arctic jks 061119
      inp_mult = 1.0_r8
      ! shofer remove latitudinal constraint
      ! if (rlats(i)*0.001._r8/3.14159_r8.gt.+66.66667_r8) inp_mult=inp_tag
      inp_mult=inp_tag
      do k = top_lev, pver
         call get_aer_num(numberConcentration(i,k,:), CloudnumberConcentration(i,k,:), rho(i,k),         &    
                     !++ MH_2015/04/10
                     f_acm(i,k,:), f_so4_condm(i,k,:), cam(i,k,:), volumeCore(i,k,:), volumeCoat(i,k,:), &
                     !-- MH_2015/04/10
                     total_aer_num(i,k,:), coated_aer_num(i,k,:), uncoated_aer_num(i,k,:),  &
                     total_interstitial_aer_num(i,k,:), total_cloudborne_aer_num(i,k,:),    &    
                     hetraer(i,k,:), awcam(i,k,:), awfacm(i,k,:), dstcoat(i,k,:),           &    
                     na500(i,k), tot_na500(i,k))

         ! jks set new variables here, could move out of the loop and just do once.
         total_aer_num_scaled(i,k,:) = total_aer_num(i,k,:) * inp_mult
         coated_aer_num_scaled(i,k,:) = coated_aer_num(i,k,:) * inp_mult
         uncoated_aer_num_scaled(i,k,:) = uncoated_aer_num(i,k,:) * inp_mult
         total_interstitial_aer_num_scaled(i,k,:) = total_interstitial_aer_num(i,k,:) *inp_mult
         total_cloudborne_aer_num_scaled(i,k,:) = total_cloudborne_aer_num(i,k,:) * inp_mult

         fn_cloudborne_aer_num(i,k,1) = total_aer_num(i,k,1)*factnum(i,k,MODE_IDX_OMBC_INTMIX_COAT_AIT)  ! bc
         fn_cloudborne_aer_num(i,k,2) = total_aer_num(i,k,2)*factnum(i,k,MODE_IDX_DST_A2) 
         fn_cloudborne_aer_num(i,k,3) = total_aer_num(i,k,3)*factnum(i,k,MODE_IDX_DST_A3) 
      end do
   end do

   call outfld('bc_num',        total_aer_num(:,:,1),    pcols, lchnk)
   call outfld('dst1_num',      total_aer_num(:,:,2),    pcols, lchnk)
   call outfld('dst3_num',      total_aer_num(:,:,3),    pcols, lchnk)

   ! create variables so that the scaling can be checked 120919
   call outfld('bc_num_scaled',        total_aer_num_scaled(:,:,1),    pcols, lchnk) !jks
   call outfld('dst1_num_scaled',      total_aer_num_scaled(:,:,2),    pcols, lchnk) !jks
   call outfld('dst3_num_scaled',      total_aer_num_scaled(:,:,3),    pcols, lchnk) !jks

   call outfld('bcc_num',       coated_aer_num(:,:,1),   pcols, lchnk)
   call outfld('dst1c_num',     coated_aer_num(:,:,2),   pcols, lchnk)
   call outfld('dst3c_num',     coated_aer_num(:,:,3),   pcols, lchnk)

   call outfld('bcuc_num',      uncoated_aer_num(:,:,1), pcols, lchnk)
   call outfld('dst1uc_num',    uncoated_aer_num(:,:,2), pcols, lchnk)
   call outfld('dst3uc_num',    uncoated_aer_num(:,:,3), pcols, lchnk)

   call outfld('bc_a1_num',     total_interstitial_aer_num(:,:,1), pcols, lchnk)
   call outfld('dst_a1_num',    total_interstitial_aer_num(:,:,2), pcols, lchnk)
   call outfld('dst_a3_num',    total_interstitial_aer_num(:,:,3), pcols, lchnk)

   call outfld('bc_c1_num',     total_cloudborne_aer_num(:,:,1),   pcols, lchnk)
   call outfld('dst_c1_num',    total_cloudborne_aer_num(:,:,2),   pcols, lchnk)
   call outfld('dst_c3_num',    total_cloudborne_aer_num(:,:,3),   pcols, lchnk)

   call outfld('fn_bc_c1_num',  fn_cloudborne_aer_num(:,:,1),      pcols, lchnk)
   call outfld('fn_dst_c1_num', fn_cloudborne_aer_num(:,:,2),      pcols, lchnk)
   call outfld('fn_dst_c3_num', fn_cloudborne_aer_num(:,:,3),      pcols, lchnk)
        
   call outfld('na500',         na500,     pcols, lchnk)
   call outfld('totna500',      tot_na500, pcols, lchnk)

   ! frzimm, frzcnt, frzdep are the outputs of this parameterization used by the microphysics
   call pbuf_get_field(pbuf, frzimm_idx, frzimm)
   call pbuf_get_field(pbuf, frzcnt_idx, frzcnt)
   call pbuf_get_field(pbuf, frzdep_idx, frzdep)
    
   frzimm(:ncol,:) = 0._r8
   frzcnt(:ncol,:) = 0._r8
   frzdep(:ncol,:) = 0._r8

   frzbcimm(:ncol,:) = 0._r8
   frzduimm(:ncol,:) = 0._r8
   frzbccnt(:ncol,:) = 0._r8
   frzducnt(:ncol,:) = 0._r8
   frzbcdep(:ncol,:) = 0._r8
   frzdudep(:ncol,:) = 0._r8

   freqimm(:ncol,:) = 0._r8
   freqcnt(:ncol,:) = 0._r8
   freqdep(:ncol,:) = 0._r8
   freqmix(:ncol,:) = 0._r8

   numice10s(:ncol,:)         = 0._r8
   numice10s_imm_dst(:ncol,:) = 0._r8
   numice10s_imm_bc(:ncol,:)  = 0._r8

   nnuccc_bc(:,:) = 0._r8
   nnucct_bc(:,:) = 0._r8
   nnudep_bc(:,:) = 0._r8

   nnuccc_dst(:,:) = 0._r8
   nnucct_dst(:,:) = 0._r8
   nnudep_dst(:,:) = 0._r8

   niimm_bc(:,:) = 0._r8
   nicnt_bc(:,:) = 0._r8
   nidep_bc(:,:) = 0._r8

   niimm_dst(:,:) = 0._r8
   nicnt_dst(:,:) = 0._r8
   nidep_dst(:,:) = 0._r8

   do i = 1, ncol

      do k = top_lev, pver

         if (t(i,k) > 235.15_r8 .and. t(i,k) < 269.15_r8) then
            qcic = min(qc(i,k)/lcldm(i,k), 5.e-3_r8)
            ncic = max(nc(i,k)/lcldm(i,k), 0._r8)

            con1 = 1._r8/(1.333_r8*pi)**0.333_r8
            r3lx = con1*(rho(i,k)*qcic/(rhoh2o*max(ncic*rho(i,k), 1.0e6_r8)))**0.333_r8 ! in m
            r3lx = max(4.e-6_r8, r3lx)
            supersatice = svp_water(t(i,k))/svp_ice(t(i,k))
            fn(1) = factnum(i,k,MODE_IDX_OMBC_INTMIX_COAT_AIT)  ! bc accumulation mode
            fn(2) = factnum(i,k,MODE_IDX_DST_A2)  ! dust_a1 accumulation mode
            fn(3) = factnum(i,k,MODE_IDX_DST_A3) ! dust_a3 coarse mode

            ! jks. Setting the scaled aerosol numbers as arguments instead of the original
            call hetfrz_classnuc_calc( &
               deltatin,  t(i,k),  pmid(i,k),  supersatice,   &
               fn,  r3lx,  ncic*rho(i,k)*1.0e-6_r8,  frzbcimm(i,k),  frzduimm(i,k),   &
               frzbccnt(i,k),  frzducnt(i,k),  frzbcdep(i,k),  frzdudep(i,k),  hetraer(i,k,:), &
               awcam(i,k,:), awfacm(i,k,:), dstcoat(i,k,:), total_aer_num_scaled(i,k,:),  &
               coated_aer_num_scaled(i,k,:), uncoated_aer_num_scaled(i,k,:), total_interstitial_aer_num_scaled(i,k,:), &
               total_cloudborne_aer_num_scaled(i,k,:), errstring)

            call handle_errmsg(errstring, subname="hetfrz_classnuc_calc")

            frzimm(i,k) = frzbcimm(i,k) + frzduimm(i,k)
            frzcnt(i,k) = frzbccnt(i,k) + frzducnt(i,k)
            frzdep(i,k) = frzbcdep(i,k) + frzdudep(i,k)

            if (frzimm(i,k) > 0._r8) freqimm(i,k) = 1._r8
            if (frzcnt(i,k) > 0._r8) freqcnt(i,k) = 1._r8
            if (frzdep(i,k) > 0._r8) freqdep(i,k) = 1._r8
            if ((frzimm(i,k) + frzcnt(i,k) + frzdep(i,k)) > 0._r8) freqmix(i,k) = 1._r8
         else
            frzimm(i,k) = 0._r8
            frzcnt(i,k) = 0._r8
            frzdep(i,k) = 0._r8
         end if

         nnuccc_bc(i,k) = frzbcimm(i,k)*1.0e6_r8*ast(i,k)
         nnucct_bc(i,k) = frzbccnt(i,k)*1.0e6_r8*ast(i,k)
         nnudep_bc(i,k) = frzbcdep(i,k)*1.0e6_r8*ast(i,k)

         nnuccc_dst(i,k) = frzduimm(i,k)*1.0e6_r8*ast(i,k)
         nnucct_dst(i,k) = frzducnt(i,k)*1.0e6_r8*ast(i,k)     
         nnudep_dst(i,k) = frzdudep(i,k)*1.0e6_r8*ast(i,k)

         niimm_bc(i,k) = frzbcimm(i,k)*1.0e6_r8*deltatin
         nicnt_bc(i,k) = frzbccnt(i,k)*1.0e6_r8*deltatin
         nidep_bc(i,k) = frzbcdep(i,k)*1.0e6_r8*deltatin

         niimm_dst(i,k) = frzduimm(i,k)*1.0e6_r8*deltatin
         nicnt_dst(i,k) = frzducnt(i,k)*1.0e6_r8*deltatin
         nidep_dst(i,k) = frzdudep(i,k)*1.0e6_r8*deltatin

         numice10s(i,k) = (frzimm(i,k)+frzcnt(i,k)+frzdep(i,k))*1.0e6_r8*deltatin*(10._r8/deltatin)
         numice10s_imm_dst(i,k) = frzduimm(i,k)*1.0e6_r8*deltatin*(10._r8/deltatin)
         numice10s_imm_bc(i,k) = frzbcimm(i,k)*1.0e6_r8*deltatin*(10._r8/deltatin)
      end do
   end do

   call outfld('FREQIMM', freqimm, pcols, lchnk)
   call outfld('FREQCNT', freqcnt, pcols, lchnk)
   call outfld('FREQDEP', freqdep, pcols, lchnk)
   call outfld('FREQMIX', freqmix, pcols, lchnk)

   call outfld('DSTFREZIMM', nnuccc_dst, pcols, lchnk)
   call outfld('DSTFREZCNT', nnucct_dst, pcols, lchnk)
   call outfld('DSTFREZDEP', nnudep_dst, pcols, lchnk)

   call outfld('BCFREZIMM', nnuccc_bc, pcols, lchnk)
   call outfld('BCFREZCNT', nnucct_bc, pcols, lchnk)
   call outfld('BCFREZDEP', nnudep_bc, pcols, lchnk)

   call outfld('NIMIX_IMM', niimm_bc+niimm_dst, pcols, lchnk)
   call outfld('NIMIX_CNT', nicnt_bc+nicnt_dst, pcols, lchnk)   
   call outfld('NIMIX_DEP', nidep_bc+nidep_dst, pcols, lchnk)

   call outfld('DSTNICNT', nicnt_dst, pcols, lchnk)
   call outfld('DSTNIDEP', nidep_dst, pcols, lchnk)
   call outfld('DSTNIIMM', niimm_dst, pcols, lchnk)

   call outfld('BCNICNT', nicnt_bc, pcols, lchnk)
   call outfld('BCNIDEP', nidep_bc, pcols, lchnk)
   call outfld('BCNIIMM', niimm_bc, pcols, lchnk)

   call outfld('NUMICE10s', numice10s, pcols, lchnk)
   call outfld('NUMIMM10sDST', numice10s_imm_dst, pcols, lchnk)
   call outfld('NUMIMM10sBC', numice10s_imm_bc, pcols, lchnk)

   end associate

end subroutine hetfrz_classnuc_oslo_calc

!====================================================================================================

subroutine hetfrz_classnuc_oslo_save_cbaero(state, pbuf)

    use commondefinitions, only:  nmodes_oslo => nmodes
    use aerosoldef, only: getTracerIndex, getNumberOfTracersInMode
    use modal_aero_data, only: qqcw_get_field

   ! Save the required cloud borne aerosol constituents.
   type(physics_state),         intent(in)    :: state
   type(physics_buffer_desc),   pointer       :: pbuf(:)

   ! local variables
   integer :: i, lchnk, kk, ncol, m, n
   real(r8), pointer :: ptr2d(:,:)
   type qqcw_type
     real(r8), pointer :: fldcw(:,:)
   end type qqcw_type
   type(qqcw_type) :: qqcw(pcnst)
   !-------------------------------------------------------------------------------

   lchnk = state%lchnk
   ncol = state%ncol

   ! loop over the cloud borne constituents required by this module and save
   ! a local copy

   aer_cb(1:ncol,1:pver,:,lchnk) = 0.0_r8
   do m=1,nmodes_oslo
      do n=1,getNumberOfTracersInMode(m)
        kk=getTracerIndex(m,n,.false.)! This gives the tracer index used in the q-array
        qqcw(kk)%fldcw => qqcw_get_field(pbuf,kk,lchnk,.TRUE.)
        if(associated(qqcw(kk)%fldcw))then
         aer_cb(:,:,kk,lchnk) = qqcw(kk)%fldcw
        end if
      end do
   end do

end subroutine hetfrz_classnuc_oslo_save_cbaero

!====================================================================================================

subroutine get_aer_num(qaerpt, qaercwpt, rhoair,           &   ! input
                       f_acm, f_condm,                     &
                       cam, volumeCore, volumeCoat,        &
                       total_aer_num,                      &   ! output
                       coated_aer_num,                     &
                       uncoated_aer_num,                   &
                       total_interstial_aer_num,           &
                       total_cloudborne_aer_num,           &
                       hetraer, awcam, awfacm, dstcoat,    &
                       na500, tot_na500)

!++ wy4.0
!-- wy4.0

    use spmd_utils, only: iam
    use shr_kind_mod,  only: r8 => shr_kind_r8
!    use ppgrid, only : pcols, pver
    use constituents,  only: pcnst
    use commondefinitions, only:  nmodes_oslo => nmodes
    use aerosoldef,    only:MODE_IDX_DST_A2, MODE_IDX_DST_A3, &
                            l_dst_a2, l_dst_a3, l_bc_ai,      &
                            MODE_IDX_OMBC_INTMIX_COAT_AIT, l_bc_ac,         &
                            lifeCycleNumberMedianRadius,      &
                            lifeCycleSigma


    implicit none

    ! input
    real(r8), intent(in) :: qaerpt(0:nmodes_oslo)           ! aerosol number and mass mixing ratios(instertitial)
    real(r8), intent(in) :: qaercwpt(0:nmodes_oslo)         ! cloud borne aerosol number and mass mixing ratios
    real(r8), intent(in) :: rhoair                  ! air density (kg/m3)
    real(r8), intent(in) :: f_acm(nmodes_oslo)
    real(r8), intent(in) :: f_condm(nmodes_oslo)
    real(r8), intent(in) :: cam(nmodes_oslo)
    real(r8), intent(in) :: volumeCoat(nmodes_oslo)
    real(r8), intent(in) :: volumeCore(nmodes_oslo)
    real(r8) :: sigmag_amode(3)
       
    
    ! output
    real(r8), intent(out) :: total_aer_num(3)            ! #/cm^3
    real(r8), intent(out) :: total_interstial_aer_num(3) ! #/cm^3
    real(r8), intent(out) :: total_cloudborne_aer_num(3) ! #/cm^3
    real(r8), intent(out) :: coated_aer_num(3)           ! #/cm^3 
    real(r8), intent(out) :: uncoated_aer_num(3)         ! #/cm^3
    real(r8), intent(out) :: hetraer(3)                  ! BC and Dust mass mean radius [m]
    real(r8), intent(out) :: awcam(3)                    ! modal added mass [mug m-3]
    real(r8), intent(out) :: awfacm(3)                   ! (OC+BC)/(OC+BC+SO4)
    real(r8), intent(out) :: dstcoat(3)                  ! coated fraction
    real(r8), intent(out) :: na500                       ! #/cm^3 interstitial aerosol number with D>500 nm (#/cm^3)
    real(r8), intent(out) :: tot_na500                   ! #/cm^3 total aerosol number with D>500 nm (#/cm^3)
    !local variables
    !------------coated variables--------------------
    real(r8), parameter :: n_so4_monolayers_dust = 1.0_r8 ! number of so4(+nh4) monolayers needed to coat a dust particle
    real(r8), parameter :: dr_so4_monolayers_dust = n_so4_monolayers_dust * 4.76e-10
    real(r8) :: tmp1, tmp2
    
    real(r8) :: bc_num                                    ! bc number in accumulation mode
    real(r8) :: dst1_num, dst3_num                        ! dust number in accumulation and corase mode
    real(r8) :: dst1_num_imm, dst3_num_imm, bc_num_imm
    real(r8) :: fac_volsfc_bc, fac_volsfc_dust_a1, fac_volsfc_dust_a3
    
    real(r8) :: r_bc                         ! model radii of BC modes [m]   
    real(r8) :: r_dust_a1, r_dust_a3         ! model radii of dust modes [m]  
    
    integer :: i
    
   integer  :: num_bc_idx, num_dst1_idx, num_dst3_idx    ! mode indices
    
    num_bc_idx = MODE_IDX_OMBC_INTMIX_COAT_AIT
    num_dst1_idx = MODE_IDX_DST_A2
    num_dst3_idx = MODE_IDX_DST_A3


!*****************************************************************************
!                calculate intersitial aerosol 
!*****************************************************************************

         dst1_num = qaerpt(num_dst1_idx)*1.0e-6_r8    ! #/cm3
         dst3_num = qaerpt(num_dst3_idx)*1.0e-6_r8    ! #/cm3
         bc_num = qaerpt(num_bc_idx)*1.0e-6_r8    ! #/cm3
     

!*****************************************************************************
!                calculate cloud borne aerosol 
!*****************************************************************************

     dst1_num_imm = qaercwpt(num_dst1_idx)*1.0e-6_r8    ! #/cm3
     dst3_num_imm = qaercwpt(num_dst3_idx)*1.0e-6_r8    ! #/cm3
     bc_num_imm = qaercwpt(num_bc_idx)*1.0e-6_r8    ! #/cm3
 
!   calculate mass mean radius
      r_dust_a1 = lifeCycleNumberMedianRadius(num_dst1_idx)
      r_dust_a3 = lifeCycleNumberMedianRadius(num_dst3_idx)
      r_bc = lifeCycleNumberMedianRadius(num_bc_idx)
  
    hetraer(1) = r_bc
    hetraer(2) = r_dust_a1
    hetraer(3) = r_dust_a3


!*****************************************************************************
!                calculate coated fraction 
!*****************************************************************************

! volumeCore and volumeCoat from subroutine calculateHygroscopicity in paramix_progncdnc.f90

    sigmag_amode(1) = lifeCycleSigma(num_bc_idx)
    sigmag_amode(2) = lifeCycleSigma(num_dst1_idx)
    sigmag_amode(3) = lifeCycleSigma(num_dst3_idx)

    fac_volsfc_bc = exp(2.5*(log(sigmag_amode(1))**2))
    fac_volsfc_dust_a1 = exp(2.5*(log(sigmag_amode(2))**2))
    fac_volsfc_dust_a3 = exp(2.5*(log(sigmag_amode(3))**2))

    tmp1 = volumeCoat(num_bc_idx)*(r_bc*2._r8)*fac_volsfc_bc
    tmp2 = max(6.0_r8*dr_so4_monolayers_dust*volumeCore(num_bc_idx), 0.0_r8) ! dr_so4_monolayers_dust = n_so4_monolayers_dust (=1) * 4.67e-10
    dstcoat(1) = tmp1/tmp2

    tmp1 = volumeCoat(num_dst1_idx)*(r_dust_a1*2._r8)*fac_volsfc_dust_a1
    tmp2 = max(6.0_r8*dr_so4_monolayers_dust*volumeCore(num_dst1_idx), 0.0_r8) ! dr_so4_monolayers_dust = n_so4_monolayers_dust (=1) * 4.67e-10
    dstcoat(2) = tmp1/tmp2
    
    tmp1 = volumeCoat(num_dst3_idx)*(r_dust_a3*2._r8)*fac_volsfc_dust_a3
    tmp2 = max(6.0_r8*dr_so4_monolayers_dust*volumeCore(num_dst3_idx), 0.0_r8) ! dr_so4_monolayers_dust = n_so4_monolayers_dust (=1) * 4.67e-10
    dstcoat(3) = tmp1/tmp2
    
    if (dstcoat(1) > 1._r8) dstcoat(1) = 1._r8
    if (dstcoat(1) < 0.001_r8) dstcoat(1) = 0.001_r8
    if (dstcoat(2) > 1._r8) dstcoat(2) = 1._r8
    if (dstcoat(2) < 0.001_r8) dstcoat(2) = 0.001_r8
    if (dstcoat(3) > 1._r8) dstcoat(3) = 1._r8
    if (dstcoat(3) < 0.001_r8) dstcoat(3) = 0.001_r8
 
!*****************************************************************************
!                prepare some variables for water activity 
!*****************************************************************************
! cam ([kg/m3] added mass distributed to modes) from paramix_progncdnc.f90
  
    ! accumulation mode for dust_a1 
    if (qaerpt(num_dst1_idx) > 0._r8) then 
       awcam(2) = cam(num_dst1_idx)*1.e9_r8    ! kg/m3 -> ug/m3
    else
        awcam(2) = 0._r8
    end if
    if (awcam(2) >0._r8) then
        awfacm(2) = f_acm(num_dst1_idx)
    else
        awfacm(2) = 0._r8
    end if
    
    ! accumulation mode for dust_a3
    if (qaerpt(num_dst3_idx) > 0._r8) then 
        awcam(3) = cam(num_dst3_idx)*1.e9_r8    ! kg/m3 -> ug/m3
    else
        awcam(3) = 0._r8
    end if
    if (awcam(3) >0._r8) then
      awfacm(3) = f_acm(num_dst3_idx)
    else 
       awfacm(3) = 0._r8
    end if
        
        
    ! accumulation mode for bc
    if (qaerpt(num_bc_idx) > 0._r8) then 
        awcam(1) = cam(num_bc_idx)*1.e9_r8    ! kg/m3 -> ug/m3
    else
        awcam(1) = 0._r8
    end if
    if (awcam(1) >0._r8) then
        awfacm(1) = f_acm(num_bc_idx) 
    else
        awfacm(1) = 0._r8
    end if


!*****************************************************************************
!                prepare output
!*****************************************************************************

    total_interstial_aer_num(1) = bc_num
    total_interstial_aer_num(2) = dst1_num
    total_interstial_aer_num(3) = dst3_num
 
    total_cloudborne_aer_num(1) = bc_num_imm
    total_cloudborne_aer_num(2) = dst1_num_imm
    total_cloudborne_aer_num(3) = dst3_num_imm
   
    do i = 1, 3
        total_aer_num(i) = total_interstial_aer_num(i)+total_cloudborne_aer_num(i)
        coated_aer_num(i) = total_interstial_aer_num(i)*dstcoat(i)
        uncoated_aer_num(i) = total_interstial_aer_num(i)*(1._r8-dstcoat(i))
    end do


    tot_na500 = total_aer_num(1)*0.0256_r8          & ! scaled for D>0.5 um using Clarke et al., 1997; 2004; 2007: rg=0.1um, sig=1.6
!#ifdef MODAL_AERO
!#if (defined MODAL_AERO_3MODE)
        +total_aer_num(2)*0.488_r8                  &  ! scaled for D>0.5-1 um from 0.1-1 um
!#elif (defined MODAL_AERO_7MODE)
!        +total_aer_num(2)*0.566_r8                  &  ! scaled for D>0.5-2 um from 0.1-2 um
!#endif
        +total_aer_num(3)
!#endif

    na500 = total_interstial_aer_num(1)*0.0256_r8   & ! scaled for D>0.5 um using Clarke et al., 1997; 2004; 2007: rg=0.1um, sig=1.6
!#ifdef MODAL_AERO
!#if (defined MODAL_AERO_3MODE)
        +total_interstial_aer_num(2)*0.488_r8       &  ! scaled for D>0.5-1 um from 0.1-1 um
!#elif (defined MODAL_AERO_7MODE)
!        +total_interstial_aer_num(2)*0.566_r8       &  ! scaled for D>0.5-2 um from 0.1-2 um
!#endif
        +total_interstial_aer_num(3)
!#endif

!-- wy4.0
  
end subroutine get_aer_num

!====================================================================================================

end module hetfrz_classnuc_oslo
