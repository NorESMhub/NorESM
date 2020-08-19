.. _nudged_simulations:

Nudged experiments
==================

Step by step guide for setting up a nudged simulation
------------------------------------------------------

Create a new case 
^^^^^^^^^^^^^^^^^^

with a compset that supports nudging e.g. NFHISTnorpddmsbcsdyn, or 
use your own compset and add::

  -offline_dyn 
  
to CAM_CONFIG_OPTS in env_build.xml after creating a case.

Meteorology
^^^^^^^^^^^^^

Modify user_nl_cam include information about the meteorology you want to nudge to

::
  
  &metdata_nl 
    met_filenames_list = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ fileList2001-2015.txt' 
    met_data_file = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ 2014-01-01.nc' 


::

met_filenames_list points to a txt-file that must include all the meteorological nudging data that will be used for the entire simulation. The met_data_file points to the file in this list that includes the starting date of your simulation. The example above shows how to point to ERA-Interim data, created by Inger Helene Hafsahl Karset (https://www.duo.uio.no/handle/ 10852/72779). You can also create your own model produced data (explanation further down in this document). 

Nudging strength
^^^^^^^^^^^^^^^^^^

Modify user_nl_cam to include information about the strength of the nudging::

  met_rlx_time = 6 
  
  
met_rlx_time is the relaxation time scale. If the timestep of the model is 0.5 hrs, a relaxation time scale of 6 corresponds to a nudging strength of 0.5/6 ~ 0.083 = 8.3 %, meaning that 8.3 % of the nudged component (for example the wind) comes from the value in the met_data_file, while 93.7 % will come from the model itself. It is recommended to set met_rlx_time to the same value as the time frequency of the nudging data.

Vertical levels
^^^^^^^^^^^^^^^

Modify user_nl_cam to include information about which levels in the vertical the nudging 
should apply to

::

  met_rlx_bot = 60 
  met_rlx_top = 70 
  met_rlx_bot_bot = 0 
  met_rlx_bot_top = 0 

::

By using the values in the example above, nudging will be applied to all levels in the vertical. If met_rlx_bot_bot and met_rlx_bot_top is set to heights (given in km) above the bottom layer of the model (0 km), met_rlx_time will decrease exponentially from met_rlx_bot_top (where it will have the value of met_rlx_time) to met_rlx_bot_bot (where it will be zero from this level and all the way down to the ground). If you want to dampen or turn off the nudging intensity higher up, the same can be done to met_rlx_bot and met_rlx_top by setting these values to be lower in the atmosphere than the model top. 


Nudging only winds and surface pressure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Modify user_nl_cam if you only want to nudge winds and surface pressure::

  met_nudge_only_uvps = .true.
  
  
This is recommended when looking at aerosol-cloud interactions, especially when nudging to meteorology that is not produced by the model itself (Zhang et al., 2014). 


Appropriate topography
^^^^^^^^^^^^^^^^^^^^^^^^

Modify user_nl_cam to point to an appropriate topography file if nudging to meteorology 
from ERA-Interim or other meteorology that is not produced by the model itself. It is the field named ‘PHIS’ in the topography file that need to correspond to the source of the nudging data. 
&cam_inparm bnd_topo = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ ERA_bnd_topo_noresm2_20191023.nc' 



Correct calender
^^^^^^^^^^^^^^^^

If nudging to reanalysis data, CALENDAR in env_build.xml should be changed from 
NO_LEAP to GREGORIAN. 

Correct start date
^^^^^^^^^^^^^^^^^^^^^

Modify env_run.xml to have the same RUN_STARTDATE as given in the met_data_file. 

Ready-steady-go
^^^^^^^^^^^^^^^^^

You are now ready to setup, build and submit your case. 


How to generate your own nudging inputdata
-----------------------------------------

Create a case
^^^^^^^^^^^^^^^^

Create a case you want to generate data from

Modify user_nl_cam
^^^^^^^^^^^^^^^^^^^^^

Modify user_nl_cam and/or other user namelists to output the preferred nudging data

::

  &camexp
    mfilt = 1, 4, 
    nhtfrq = 0, -6,
    avgflag_pertape='A','I',
    fincl2 ='PS','U','V','T'

::

The example above will output ordinary h0 monthly mean files, one pr month, but also h1-
files with instantaneous values of PS, U, V and T every six hours, four pr file.

Move the nudging data to a preferred folder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Move the nudging data (the h1-files) over to a preferred folder and create a txt-file including
a list of all the nudging data files that later can be pointed to as met_filenames_list:
ls -d -1 $PWD/*.h1.*.nc > fileList.txt

For more information, look into the file where most of the nudging code is found::

  /components/cam/src/NorESM/fv/metdata.F90. 
  
There are also other options for namelist modifications regarding nudging:
http://www.cesm.ucar.edu/models/cesm2/settings/current/cam_nml.html and search for “met_”

