! ------------------------------------------------------------------------------
! Copyright (C) 2020 Mats Bentsen
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

module mod_grid
! ------------------------------------------------------------------------------
! This module contains declaration of grid variables.
! ------------------------------------------------------------------------------

   use mod_types, only: r8
   use mod_constants, only: spval
   use mod_xc, only: idm, jdm, kdm, nbdy, ii, jj, kk

   implicit none

   private

   ! Variable to be set in namelist:
   character(len = 256) :: &
      grfile     ! Name of file containing grid specification.

   real(r8), dimension(1 - nbdy:idm + nbdy, 1 - nbdy:jdm + nbdy, kdm) :: &
      sigmar     ! Reference potential density [g cm-3].

   real(r8), dimension(1 - nbdy:idm + nbdy, 1 - nbdy:jdm + nbdy, 4) :: &
      qclon, &   ! Longitude of q-cell corners [degrees].
      qclat, &   ! Latitude of q-cell corners [degrees].
      pclon, &   ! Longitude of p-cell corners [degrees].
      pclat, &   ! Latitude of p-cell corners [degrees].
      uclon, &   ! Longitude of u-cell corners [degrees].
      uclat, &   ! Latitude of u-cell corners [degrees].
      vclon, &   ! Longitude of v-cell corners [degrees].
      vclat      ! Latitude of v-cell corners [degrees].

   real(r8), dimension(1 - nbdy:idm + nbdy, 1 - nbdy:jdm + nbdy) :: &
      scqx, &    ! Grid size in x-direction centered at q-point [cm].
      scqy, &    ! Grid size in y-direction centered at q-point [cm].
      scpx, &    ! Grid size in x-direction centered at p-point [cm].
      scpy, &    ! Grid size in y-direction centered at p-point [cm].
      scux, &    ! Grid size in x-direction centered at u-point [cm].
      scuy, &    ! Grid size in y-direction centered at u-point [cm].
      scvx, &    ! Grid size in x-direction centered at v-point [cm].
      scvy, &    ! Grid size in y-direction centered at v-point [cm].
      scq2, &    ! Area of grid cell centered at q-point [cm2].
      scp2, &    ! Area of grid cell centered at p-point [cm2].
      scu2, &    ! Area of grid cell centered at u-point [cm2].
      scv2, &    ! Area of grid cell centered at v-point [cm2].
      scq2i, &   ! Multiplicative inverse of scq2 [cm-2].
      scp2i, &   ! Multiplicative inverse of scp2 [cm-2].
      scuxi, &   ! Multiplicative inverse of scux [cm-1].
      scuyi, &   ! Multiplicative inverse of scuy [cm-1].
      scvxi, &   ! Multiplicative inverse of scvx [cm-1].
      scvyi, &   ! Multiplicative inverse of scvy [cm-1].
      qlon, &    ! Longitude of q-point [degrees].
      qlat, &    ! Latitude of q-point [degrees].
      plon, &    ! Longitude of p-point [degrees].
      plat, &    ! Latitude of p-point [degrees].
      ulon, &    ! Longitude of u-point [degrees].
      ulat, &    ! Latitude of u-point [degrees].
      vlon, &    ! Longitude of v-point [degrees].
      vlat, &    ! Latitude of v-point [degrees].
      depths, &  ! Water depth [m].
      corioq, &  ! Coriolis parameter at q-point [s-1].
      coriop, &  ! Coriolis parameter at p-point [s-1].
      betafp, &  ! Derivative of Coriolis parameter with respect to meridional
                 ! distance at p-point [cm-1 s-1].
      angle, &   ! Local angle between x-direction and eastward direction at
                 ! p-points [radians].
      cosang, &  ! Cosine of local angle between x-direction and eastward
                 ! direction at p-points [].
      sinang, &  ! Sine of local angle between x-direction and eastward
                 ! direction at p-points [].
      pcmask, &  ! pacemaker mask
      So_t       ! pacemaker SST

   real(r8) :: &
      area       ! Total grid area [cm2].

   integer :: &
      nwp        ! Number of wet grid cells.

   public :: grfile, sigmar, &
             qclon, qclat, pclon, pclat, uclon, uclat, vclon, vclat, &
             scqx, scqy, scpx, scpy, scux, scuy, scvx, scvy, &
             scq2, scp2, scu2, scv2, scq2i, scp2i, &
             scuxi, scuyi, scvxi, scvyi, &
             qlon, qlat, plon, plat, ulon, ulat, vlon, vlat, &
             depths, corioq, coriop, betafp, angle, cosang, sinang, &
             area, nwp, pcmask, So_t, &
             inivar_grid

contains

   subroutine inivar_grid
   ! ---------------------------------------------------------------------------
   ! Initialize arrays.
   ! ---------------------------------------------------------------------------

      integer :: i, j, k

   !$omp parallel do private(i, k)
      do j = 1 - nbdy, jj + nbdy
         do k = 1, kk
            do i = 1 - nbdy, ii + nbdy
               sigmar(i, j, k) = spval
            enddo
         enddo
         do k = 1, 4
            do i = 1 - nbdy, ii + nbdy
               qclon(i, j, k) = spval
               qclat(i, j, k) = spval
               pclon(i, j, k) = spval
               pclat(i, j, k) = spval
               uclon(i, j, k) = spval
               uclat(i, j, k) = spval
               vclon(i, j, k) = spval
               vclat(i, j, k) = spval
            enddo
         enddo
         do i = 1 - nbdy, ii + nbdy
            scqx(i, j) = spval
            scqy(i, j) = spval
            scpx(i, j) = spval
            scpy(i, j) = spval
            scux(i, j) = spval
            scuy(i, j) = spval
            scvx(i, j) = spval
            scvy(i, j) = spval
            scq2(i, j) = spval
            scp2(i, j) = spval
            scu2(i, j) = spval
            scv2(i, j) = spval
            scq2i(i, j) = spval
            scp2i(i, j) = spval
            scuxi(i, j) = spval
            scuyi(i, j) = spval
            scvxi(i, j) = spval
            scvyi(i, j) = spval
            qlon(i, j) = spval
            qlat(i, j) = spval
            plon(i, j) = spval
            plat(i, j) = spval
            ulon(i, j) = spval
            ulat(i, j) = spval
            vlon(i, j) = spval
            vlat(i, j) = spval
            depths(i, j) = spval
            corioq(i, j) = spval
            coriop(i, j) = spval
            betafp(i, j) = spval
            angle(i, j) = spval
            cosang(i, j) = spval
            sinang(i, j) = spval
            pcmask(i, j) = spval
            So_t(i, j) = spval
         enddo
      enddo
   !$omp end parallel do

   end subroutine inivar_grid

end module mod_grid
