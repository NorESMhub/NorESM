.. _cmip6_volcanic_forcing:

CMIP6 volcanic forcing
========================                      

Code and installation
'''''''''''''''''''''

The CMIP6 volcanic forcing implementation has been committed to the
noresm (CESM1.2) repository and the noresm-dev (CESM2_beta) repository.
The changes can be viewed here: \\\\
https://github.com/metno/noresm/commit/59d2b4c4714c0df41141a10d79fd329b27b8aed6
\\\\
https://github.com/metno/noresm-dev/commit/bbec72fa49ed57ab70d5052b8b4c0162eeb6ab88

SourceMods are available on FRAM/NIRD: \\\\

::

  /nird/projects/fram/nn2345k/ingo/CMIP6/Forcing/Volc/SourceMods_noresm_cesm1.2


  /nird/projects/fram/nn2345k/ingo/CMIP6/Forcing/Volc/SourceMods_noresm_cesm2beta6


The folder

::

  SourceMods_noresm_cesm2beta6


also contains a modified version of CAM's


::

  build-namelist

script that needs to be installed in

::

  components/cam/bld/


Configuration of user namelists
'''''''''''''''''''''''''''''''

For some compsets the below specifications are applied automatically.
Still, you can specify the same settings in your

::

 user_nl_cam

in your case directory.

CESM1.2 - climatological background forcing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Specify following in your

::

 user_nl_cam


to activate the use of CMIP6 compliant volcanic background forcing: !
Users should add all user specific namelist changes below in the form of
! namelist_var = new_namelist_value

::

  prescribed_volcaero_datapath           = '/cluster/shared/noresm/inputdata/atm/cam/volc'
  prescribed_volcaero_file               = 'CMIP_CAM6_radiation_average_v3_reformatted.nc'
  prescribed_volcaero_cycle_yr           = 1850
  prescribed_volcaero_type               = 'CYCLICAL'
  rad_climate            = 'A:Q:H2O', 'N:O2:O2', 'N:CO2:CO2', 'N:ozone:O3', 'N:N2O:N2O', 'N:CH4:CH4', 'N:CFC11:CFC11', 'N:CFC12:CFC12'
  fincl1 = 'AODVVOLC', 'ABSVVOLC' 

Note that

::

 rad_climate


is specified here because CAM's

::

  build-namelist


script will otherwise add an extra entry that was needed by the CMIP5
volcanic forcing implementation.

CESM1.2 - transient forcing
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Specify following in your

::

 user_nl_cam


to activate the use of CMIP6 compliant transient (1850-2014) volcanic
forcing: ! Users should add all user specific namelist changes below in
the form of ! namelist_var = new_namelist_value

::

  prescribed_volcaero_datapath           = '/cluster/shared/noresm/inputdata/atm/cam/volc'
  prescribed_volcaero_file               = 'CMIP_CAM6_radiation_v3_reformatted.nc'
  rad_climate            = 'A:Q:H2O', 'N:O2:O2', 'N:CO2:CO2', 'N:ozone:O3', 'N:N2O:N2O', 'N:CH4:CH4', 'N:CFC11:CFC11', 'N:CFC12:CFC12'
  fincl1 = 'AODVVOLC', 'ABSVVOLC' 

CESM2_beta - climatological background & transient
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The

::

 user_nl_cam

namelist settings are the same as for CESM1.2, except that following
extra line needs to be added:

::

  prescribed_strataero_file              = ' '

This will deactivate the use of NCAR's alternative CMIP6 volcanic
forcing.

CAM's original

::

  build-namelist


script does not properly recognise the deactivation and will issue an
error that both

::

  prescribed_strataero_file


and

::

  prescribed_volcaero_file


are set.

As a workaround, replace

::

  components/cam/bld/build-namelist


in your model tree with the modified version


::
  /nird/projects/fram/nn2345k/ingo/CMIP6/Forcing/Volc/SourceMods_noresm_cesm2beta6/build-namelist


Writing the volcanic forcing to the history output for verification
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The complete set of optical parameters of the volcanic forcing can be
written to CAM-OSLO's monthly history output by adding following in the
case's

::

 user_nl_cam

::

  fincl1 = 'ext_sun1','ext_sun2','ext_sun3','ext_sun4','ext_sun5','ext_sun6','ext_sun7','ext_sun8','ext_sun9','ext_sun10','ext_sun11','ext_sun12','ext_sun13','ext_sun14','omega_sun1','omega_sun2','omega_sun3','omega_sun4','omega_sun5','omega_sun6','omega_sun7','omega_sun8','omega_sun9','omega_sun10','omega_sun11','omega_sun12','omega_sun13','omega_sun14','g_sun1','g_sun2','g_sun3','g_sun4','g_sun5','g_sun6','g_sun7','g_sun8','g_sun9','g_sun10','g_sun11','g_sun12','g_sun13','g_sun14','ext_earth1','ext_earth2','ext_earth3','ext_earth4','ext_earth5','ext_earth6','ext_earth7','ext_earth8','ext_earth9','ext_earth10','ext_earth11','ext_earth12','ext_earth13','ext_earth14','ext_earth15','ext_earth16','omega_earth1','omega_earth2','omega_earth3','omega_earth4','omega_earth5','omega_earth6','omega_earth7','omega_earth8','omega_earth9','omega_earth10','omega_earth11','omega_earth12','omega_earth13','omega_earth14','omega_earth15','omega_earth16','g_earth1','g_earth2','g_earth3','g_earth4','g_earth5','g_earth6','g_earth7','g_earth8','g_earth9','g_earth10','g_earth11','g_earth12','g_earth13','g_earth14','g_earth15','g_earth16'

Note that each variable corresponds to a single band, that values are
masked below the model's tropopause and that all values are interpolated
online from altitude to pressure. The output can be compared to the
original input data which is stored in

::

  CMIP_CAM6_radiation_average_v3.nc


and


::

  CMIP_CAM6_radiation_v3.nc


in

::

  /cluster/shared/noresm/inputdata/atm/cam/volc


on FRAM.
