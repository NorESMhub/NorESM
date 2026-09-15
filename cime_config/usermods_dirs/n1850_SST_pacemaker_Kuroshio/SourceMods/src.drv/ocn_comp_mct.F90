! ------------------------------------------------------------------------------
! Copyright (C) 2008-2020 Mats Bentsen, Alok Kumar Gupta, Ping-Gin Chiu
!
! This file is part of BLOM.
!
! BLOM is free software: you can redistribute it and/or modify it under the
! terms of the GNU Lesser General Public License as published by the Free
! Software Foundation, either version 3 of the License, or (at your option)
! any later version.
!
! BLOM is distributed in the hope that it will be useful, but WITHOUT ANY
! WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
! FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
! more details.
!
! You should have received a copy of the GNU Lesser General Public License
! along with BLOM. If not, see <https://www.gnu.org/licenses/>.
! ------------------------------------------------------------------------------

module ocn_comp_mct

   ! -------------------------------------------------------------------
   ! BLOM interface module for the cesm cpl7 mct system
   ! -------------------------------------------------------------------

   ! CESM  modules
   use mct_mod
   use esmf, only: ESMF_Clock
   use seq_cdata_mod, only: seq_cdata, seq_cdata_setptrs
   use seq_infodata_mod, only: &
      seq_infodata_type, seq_infodata_getdata, &
      seq_infodata_putdata, seq_infodata_start_type_cont, &
      seq_infodata_start_type_brnch, seq_infodata_start_type_start
   use seq_flds_mod
   use seq_timemgr_mod, only: &
      seq_timemgr_EClockGetData, seq_timemgr_RestartAlarmIsOn, &
      seq_timemgr_EClockDateInSync
   use seq_comm_mct, only: seq_comm_suffix, seq_comm_inst, seq_comm_name
   use shr_file_mod, only: &
      shr_file_getUnit, shr_file_setIO, &
      shr_file_getLogUnit, shr_file_getLogLevel, &
      shr_file_setLogUnit, shr_file_setLogLevel, &
      shr_file_freeUnit
   use shr_cal_mod, only: shr_cal_date2ymd
   use shr_sys_mod, only: shr_sys_abort, shr_sys_flush
   use perf_mod, only: t_startf, t_stopf

   use mod_types, only: r8
   use mod_config, only: inst_index, inst_name, inst_suffix
   use mod_time, only: blom_time, time, time0, &
      date0, date, nday_of_year
   use mod_cesm, only: runid_cesm, runtyp_cesm, ocn_cpl_dt_cesm
   use mod_xc
   use mod_grid, only: So_t
   use blom_cpl_indices
   use netcdf

   implicit none

   public :: ocn_init_mct, ocn_run_mct, ocn_final_mct
   private :: ocn_SetGSMap_mct

   private

   integer, dimension(:), allocatable ::  &
      perm              ! Permutation array to reorder points

   real(r8), dimension(:,:,:), allocatable :: &
      sbuff             ! Accumulated sum of send buffer quantities for
                        ! averaging before being sent
!   real(r8), dimension(1-nbdy:idm+nbdy,1-nbdy:jdm+nbdy) :: So_t  
   integer :: &
      lsize, &          ! Size of attribute vector
      jjcpl, &          ! y-dimension of local ocean domain to send/receive
                        ! fields to coupler
      nsend, &          ! Number of fields to be sent to coupler
      nrecv             ! Number of fields to be received from coupler

   real(r8) :: &
      tlast_coupled, &  ! Time since last coupling
      precip_fact       ! Correction factor for precipitation and runoff

   logical :: &
      lsend_precip_fact ! Flag for sending precipitation/runoff factor

   contains


   subroutine ocn_init_mct(EClock, cdata_o, x2o_o, o2x_o, NLFilename)

      ! Input/output arguments

      type(ESMF_Clock)            , intent(inout)    :: EClock
      type(seq_cdata)             , intent(inout) :: cdata_o
      type(mct_aVect)             , intent(inout) :: x2o_o, o2x_o
      character (len=*), optional , intent(in)    :: NLFilename ! Namelist filename
      ! Local variables

      type(mct_gsMap), pointer :: gsMap_ocn
      type(mct_gGrid), pointer :: dom_ocn
      type(seq_infodata_type), pointer :: infodata   ! Input init object
      integer :: OCNID, mpicom_ocn, shrlogunit, shrloglev, &
                 start_ymd, start_tod, start_year, start_day, start_month
      logical :: exists
      character(len=32) :: starttype

      ! Set cdata pointers
      call seq_cdata_setptrs(cdata_o, ID = OCNID, mpicom = mpicom_ocn, &
                             gsMap = gsMap_ocn, dom = dom_ocn, &
                             infodata = infodata)

      ! Set communicator to be used by blom
      mpicom_external = mpicom_ocn

      ! Get file unit
      nfu = shr_file_getUnit()

      ! Get multiple instance data
      inst_name   = seq_comm_name(OCNID)
      inst_index  = seq_comm_inst(OCNID)
      inst_suffix = seq_comm_suffix(OCNID)

      ! ----------------------------------------------------------------
      ! Initialize the model run
      ! ----------------------------------------------------------------

      call blom_cpl_indices_set()

      call seq_infodata_GetData( infodata, case_name = runid_cesm )
   
      call seq_infodata_GetData( infodata, start_type = starttype)

      if     (trim(starttype) == trim(seq_infodata_start_type_start)) then
         runtyp_cesm = "initial"
      elseif (trim(starttype) == trim(seq_infodata_start_type_cont) ) then
         runtyp_cesm = "continue"
      elseif (trim(starttype) == trim(seq_infodata_start_type_brnch)) then
         runtyp_cesm = "branch"
      else
         write (lp,*) 'ocn_comp_mct ERROR: unknown starttype'
         call shr_sys_flush(lp)
         call shr_sys_abort()
      endif

      !-----------------------------------------------------------------
      ! Get coupling time interval
      !-----------------------------------------------------------------

      call seq_timemgr_EClockGetData(EClock, dtime = ocn_cpl_dt_cesm)

      ! ----------------------------------------------------------------
      ! Initialize blom
      ! ----------------------------------------------------------------

      call t_startf('blom_init')
      call blom_init
      call t_stopf('blom_init')

      ! ----------------------------------------------------------------
      ! Reset shr logging to my log file
      ! ----------------------------------------------------------------

      call shr_file_getLogUnit (shrlogunit)
      call shr_file_getLogLevel(shrloglev)
      call shr_file_setLogUnit (lp)

      call shr_sys_flush(lp)

      ! ----------------------------------------------------------------
      ! Check for consistency of BLOM calender information and EClock
      ! ----------------------------------------------------------------

      ! This must be completed!

      if (runtyp_cesm == 'initial') then
         call seq_timemgr_EClockGetData(EClock, &
                                        start_ymd = start_ymd, &
                                        start_tod = start_tod)
         call shr_cal_date2ymd(start_ymd, start_year, start_month, start_day)
         if (mnproc == 1) then
            write (lp,'(a,i8,a2,i5,a2,i4.4,a1,i2.2,a1,i2.2)') &
               ' cesm initial date:           ',start_ymd,': ',start_tod,': ', &
               start_year,'.',start_month,'.',start_day
            call shr_sys_flush(lp)
         endif
      endif

      ! ----------------------------------------------------------------
      ! Initialize MCT attribute vectors and indices
      ! ----------------------------------------------------------------

      call t_startf ('blom_mct_init')

      ! Initialize ocn gsMap

      call ocn_SetGSMap_mct(mpicom_ocn, OCNID, gsMap_ocn)

      ! Initialize mct ocn domain (needs ocn initialization info)

      if (mnproc == 1) then
         write (lp, *) 'blom: ocn_init_mct: lsize', lsize
      endif
   
      call domain_mct(gsMap_ocn, dom_ocn, lsize, perm, jjcpl)
   
      ! Inialize mct attribute vectors

      call mct_aVect_init(x2o_o, rList = seq_flds_x2o_fields, lsize = lsize)
      call mct_aVect_zero(x2o_o)
   
      call mct_aVect_init(o2x_o, rList = seq_flds_o2x_fields, lsize = lsize) 
      call mct_aVect_zero(o2x_o)

      nsend = mct_avect_nRattr(o2x_o)
      nrecv = mct_avect_nRattr(x2o_o)

      !-----------------------------------------------------------------
      ! Send intial state to driver
      !-----------------------------------------------------------------

      call getprecipfact_mct(lsend_precip_fact, precip_fact)
      if ( lsend_precip_fact )  then
         call seq_infodata_PutData( infodata, precip_fact=precip_fact)
      endif
      allocate(sbuff(1-nbdy:idm+nbdy,1-nbdy:jdm+nbdy,nsend))
      tlast_coupled = 0._r8
      call get_So_t()
      call sumsbuff_mct(nsend, sbuff, tlast_coupled)
      call export_mct(o2x_o, lsize, perm, jjcpl, nsend, sbuff, tlast_coupled)
      if (nreg == 2) then
         call seq_infodata_PutData(infodata, ocn_prognostic = .true., &
                                   ocnrof_prognostic = .true., &
                                   ocn_nx = itdm , ocn_ny = jtdm-1)
      else
         call seq_infodata_PutData(infodata, ocn_prognostic = .true., &
                                   ocnrof_prognostic = .true., &
                                   ocn_nx = itdm , ocn_ny = jtdm)
      endif

      call t_stopf('blom_mct_init')


      if (mnproc == 1) then
        write (lp, *) 'blom: completed initialization!'
      endif

      !-----------------------------------------------------------------
      ! Reset shr logging to original values
      !-----------------------------------------------------------------

      call shr_file_setLogUnit (shrlogunit)
      call shr_file_setLogLevel(shrloglev)

      call shr_sys_flush(lp)

   end subroutine ocn_init_mct


   subroutine ocn_run_mct(EClock, cdata_o, x2o_o, o2x_o)

      ! Input/output arguments

      type(ESMF_Clock), intent(inout)    :: EClock
      type(seq_cdata) , intent(inout) :: cdata_o
      type(mct_aVect) , intent(inout) :: x2o_o
      type(mct_aVect) , intent(inout) :: o2x_o

      ! Local variables
      type(seq_infodata_type), pointer :: infodata   ! Input init object
      integer :: shrlogunit, shrloglev, ymd, tod, ymd_sync, tod_sync

      ! ----------------------------------------------------------------
      ! Reset shr logging to my log file
      ! ----------------------------------------------------------------

      call shr_file_getLogUnit (shrlogunit)
      call shr_file_getLogLevel(shrloglev)
      call shr_file_setLogUnit (lp)

      call seq_cdata_setptrs(cdata_o, infodata=infodata)

      !-----------------------------------------------------------------
      ! Advance the model in time over a coupling interval
      !-----------------------------------------------------------------

      blom_loop: do

         if (nint(tlast_coupled) == 0) then
            ! Obtain import state from driver
            call import_mct(x2o_o, lsize, perm, jjcpl)
         endif
      
         ! Advance the model a time step
         call blom_step
         call get_So_t()
         ! Add fields to send buffer sums
         call sumsbuff_mct(nsend, sbuff, tlast_coupled)

         if (nint(ocn_cpl_dt_cesm-tlast_coupled) == 0) then
!            call get_So_t(sbuff, ocn_cpl_dt_cesm)
            ! Return export state to driver and exit integration loop
            call export_mct(o2x_o, lsize, perm, jjcpl, nsend, sbuff, &
                            tlast_coupled)
            exit blom_loop
         endif

         if (mnproc == 1) then
            call shr_sys_flush(lp)
         endif

      enddo blom_loop

      call getprecipfact_mct(lsend_precip_fact, precip_fact)
      if ( lsend_precip_fact ) then
         call seq_infodata_PutData( infodata, precip_fact=precip_fact)
      endif

      !-----------------------------------------------------------------
      ! if requested, write restart file
      !-----------------------------------------------------------------

      if (seq_timemgr_RestartAlarmIsOn(EClock)) then
         call restart_wt
      endif

      !-----------------------------------------------------------------
      ! check that internal clock is in sync with master clock
      !-----------------------------------------------------------------

      if (mnproc == 1) then
         call blom_time(ymd, tod)
         if (.not. seq_timemgr_EClockDateInSync(EClock, ymd, tod )) then
            call seq_timemgr_EClockGetData(EClock, curr_ymd=ymd_sync, &
               curr_tod=tod_sync )
            write(lp,*)' blom ymd=',ymd     ,'  blom tod= ',tod
            write(lp,*)' sync ymd=',ymd_sync,'  sync tod= ',tod_sync
            call shr_sys_abort( 'ocn_run_mct'// &
               ":: Internal blom clock not in sync with Sync Clock")
         endif
      endif

      !-----------------------------------------------------------------
      ! Reset shr logging to original values
      !-----------------------------------------------------------------

      call shr_file_setLogUnit (shrlogunit)
      call shr_file_setLogLevel(shrloglev)

   end subroutine ocn_run_mct


   subroutine ocn_final_mct( EClock, cdata_o, x2o_o, o2x_o)

      type(ESMF_Clock)            , intent(inout)    :: EClock
      type(seq_cdata)             , intent(inout) :: cdata_o
      type(mct_aVect)             , intent(inout) :: x2o_o
      type(mct_aVect)             , intent(inout) :: o2x_o

      deallocate(perm)
      deallocate(sbuff)

   end subroutine ocn_final_mct


   subroutine ocn_SetGSMap_mct(mpicom_ocn, OCNID, gsMap_ocn)

      ! Input/output arguments

      integer        , intent(in)    :: mpicom_ocn
      integer        , intent(in)    :: OCNID
      type(mct_gsMap), intent(inout) :: gsMap_ocn

      ! Local variables

      integer, allocatable :: gindex(:)
      integer :: i, j, n, gsize

      ! ----------------------------------------------------------------
      ! Build the BLOM grid numbering for MCT
      ! NOTE:  Numbering scheme is: West to East and South to North
      ! starting at south pole.  Should be the same as what's used
      ! in SCRIP
      ! ----------------------------------------------------------------

      if (nreg == 2 .and. nproc == jpr) then
         jjcpl = jj - 1
      else
         jjcpl = jj
      endif

      lsize = ii*jjcpl

      if (nreg == 2) then
         gsize = itdm*(jtdm-1)
      else
         gsize = itdm*jtdm
      endif

      allocate(gindex(lsize))

      n = 0
      do j = 1, jjcpl
         do i = 1, ii
            n = n + 1
            gindex(n) = (j0 + j - 1)*itdm + i0 + i
         enddo
      enddo

      ! ----------------------------------------------------------------
      ! reorder gindex to be in ascending order.
      !  initialize a permutation array and sort gindex in-place
      ! ----------------------------------------------------------------

      allocate(perm(lsize))

      call mct_indexset(perm)
      call mct_indexsort(lsize, perm, gindex)
      call mct_permute(gindex, perm, lsize)
      call mct_gsMap_init(gsMap_ocn, gindex, mpicom_ocn, OCNID, lsize, gsize)

      deallocate(gindex)

   end subroutine ocn_SetGSMap_mct

   subroutine get_So_t()
      implicit none
      ! Local variables
      integer i, j, l, k, m, n, mm, nn, k1m, k1n
      integer status,ncid,varid,start(3),count(3),stride(3)
      integer   :: nyear0,nyear1   ! model first year
      integer   :: ymd,tod,dimlen
      integer   :: nstrm,nmod,strm_year,nstep_strm
      integer   :: cplhist_year_align=1, &
                   strm_year_start=53, strm_year_end=56
      real(r8), dimension(itdm,jtdm)  :: tmp2d
!      real(r8), dimension(1-nbdy:idm+nbdy,1-nbdy:jdm+nbdy), &
!                intent(inout)      :: So_t
      character(len=100)        :: filepath,filename,dimname
!      integer, intent(in)       :: ocn_cpl_dt_cesm

      if (mnproc == 1) then
          nyear0=date0%year
          nyear1=date%year
          if (nyear0.ne.cplhist_year_align) then
             write(*,*) 'So_t year is not aligned to model year'
          endif
          nstrm=strm_year_end-strm_year_start+1
          nmod=mod(nyear1-nyear0,nstrm)
          strm_year=strm_year_start+nmod
          call blom_time(ymd,tod)       ! tod = nint(mod(nstep, nstep_in_day)*baclin)
          nstep_strm=int(time)-int(time0)-481434  !-int(nstep_strm/3650)*3650
          start=(/nstep_strm,1,1/)
          count=(/1,itdm,jtdm/)
          stride=(/1,1,1/)
          write(lp,*) start,count,stride
          write(lp,*) 'time:',time,'time0',time0
          !
          filepath='/cluster/work/users/hra063/So_t/SST_new_mx_yr_36_50_orig.nc'
          !
          status=nf90_open(trim(filepath),nf90_nowrite,ncid)
          if (status.ne.nf90_noerr) then
            write(lp,'(4a)') 'nf90_open: sst_mx_orig.nc', &
                             nf90_strerror(status)
            call xchalt('(get_So_t)')
                   stop '(get_So_t)'
          endif

          status=nf90_inq_varid(ncid,'sst',varid)
          if (status.ne.nf90_noerr) then
            write(lp,'(4a)') 'nf90_inq_varid: So_t', &
                             nf90_strerror(status)
            call xchalt('(get_So_t)')
                   stop '(get_So_t)'
          endif
          !
          if (nstep_strm.eq.1) then
              status=nf90_inquire_dimension(ncid, 1, dimname, dimlen)
              write(lp,*) 'dim 1 name, size:',dimname,dimlen
              status=nf90_inquire_dimension(ncid, 2, dimname, dimlen)
              write(lp,*) 'dim 2 name, size:',dimname,dimlen
              status=nf90_inquire_dimension(ncid, 3, dimname, dimlen)
              write(lp,*) 'dim 3 name, size:',dimname,dimlen
          endif
          !
          status=nf90_get_var(ncid,varid,tmp2d,start,count)
          if (status.ne.nf90_noerr) then
            write(lp,'(4a)') 'nf90_get_var: ','So_t',': ', &
                             nf90_strerror(status)
            call xchalt('(get_So_t)')
                   stop '(get_So_t)'
          endif
          ! CLOSE
!          status=nf90_close(ncid)
!          if (status.ne.nf90_noerr) then
!            write(lp,'(4a)') 'nf90_close: ',trim(filename),': ', &
!                             nf90_strerror(status)
!            call xchalt('(get_So_t)')
!                   stop '(get_So_t)'
!          endif
      endif
      call xcaput(tmp2d,So_t,1)
      if (mnproc == 1) then
        write(lp,*) So_t(250,260)
      endif
      !if (mnproc == 1) then
          !do j = 1, jtdm
            !do i = 1, itdm
                !write(lp,*)  'tmp2d(',i,j,'):',tmp2d(i,j)
            !enddo
          !enddo
          !!write(lp,*)  'tmp2d()',shape(So_t2)
      !endif
      !(i0,j0)=(52,30)
      !(i,j)=
!      do j = 1, jj
!         do l = 1, isp(j)
!         do i = max(1,ifp(j,l)), min(ii,ilp(j,l))
!             sbuff(i,j,index_o2x_So_t) = &
!                (1._r8-pcmask(i,j))*sbuff(i,j,index_o2x_So_t) + pcmask(i,j)*So_t(i,j)*ocn_cpl_dt_cesm
!             !sbuff(i,j,index_o2x_So_t) = So_t(i,j)*ocn_cpl_dt_cesm
!         enddo


   end subroutine get_So_t


end module ocn_comp_mct
