.. _nudged_simulations:

Nudged experiments
==================

Step by step guide for setting up a nudged simulation
------------------------------------------------------

Create a new case 
^^^^^^^^^^^^^^^^^^

with a compset that supports nudging e.g. ``NFHISTnorpddmsbcsdyn``, or 
use your own compset and add::

  -offline_dyn 
  
to ``CAM_CONFIG_OPTS`` in ``env_build.xml`` after creating a case.

.. note:: IMPORTANT NOTE (2022.09.06). 
   In current NorESM and CESM versions, the ``-offline_dyn`` option deactivates CAM's energy fixer because it would interfere with nudging of T (and possibly also Q). This behaviour may change in future versions of NorESM. To re-activate the use of the energy fixer for wind-only nudging, copy the source file ``components/cam/src/physics/cam/check_energy.F90`` to ``SourceMods/src.cam/`` and comment out the line
   
   heat_glob = 0._r8




Meteorology
^^^^^^^^^^^^^

Modify user_nl_cam include information about the meteorology you want to nudge to

::
  
  &metdata_nl 
    met_filenames_list = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ fileList2001-2015.txt' 
    met_data_file = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ 2014-01-01.nc' 


met_filenames_list points to a txt-file that must include all the meteorological nudging data that will be used for the entire simulation. The met_data_file points to the file in this list that includes the starting date of your simulation. The example above shows how to point to ERA-Interim data, created by Inger Helene Hafsahl Karset (https://www.duo.uio.no/handle/10852/72779). You can also create your own model produced data (explanation further down in this document). 

Nudging strength
^^^^^^^^^^^^^^^^^^

Modify ``user_nl_cam`` to include information about the strength of the nudging::

  met_rlx_time = 6 
  
  
``met_rlx_time`` is the relaxation time scale. If the timestep of the model is 0.5 hrs, a relaxation time scale of 6 corresponds to a nudging strength of 0.5/6 ~ 0.083 = 8.3 %, meaning that 8.3 % of the nudged component (for example the wind) comes from the value in the met_data_file, while 93.7 % will come from the model itself. It is recommended to set ``met_rlx_time`` to the same value as the time frequency of the nudging data.

Vertical levels
^^^^^^^^^^^^^^^

Modify ``user_nl_cam`` to include information about which levels in the vertical the nudging 
should apply to

::

  met_rlx_bot = 60 
  met_rlx_top = 70 
  met_rlx_bot_bot = 0 
  met_rlx_bot_top = 0 

By using the values in the example above, nudging will be applied to all levels in the vertical. If ``met_rlx_bot_bot`` and ``met_rlx_bot_top`` is set to heights (given in km) above the bottom layer of the model (0 km), ``met_rlx_time`` will decrease exponentially from ``met_rlx_bot_top`` (where it will have the value of ``met_rlx_time``) to ``met_rlx_bot_bot`` (where it will be zero from this level and all the way down to the ground). If you want to dampen or turn off the nudging intensity higher up, the same can be done to ``met_rlx_bot`` and ``met_rlx_top`` by setting these values to be lower in the atmosphere than the model top. 

Nudging only winds and surface pressure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Modify ``user_nl_cam`` if you only want to nudge winds and surface pressure::

  met_nudge_only_uvps = .true.
  
  
This is recommended when looking at aerosol-cloud interactions, especially when nudging to meteorology that is not produced by the model itself (Zhang et al., 2014). 


Appropriate topography
^^^^^^^^^^^^^^^^^^^^^^^^

Modify ``user_nl_cam`` to point to an appropriate topography file if nudging to meteorology 
from ERA-Interim or other meteorology that is not produced by the model itself. It is the field named ``PHIS`` in the topography file that need to correspond to the source of the nudging data. 
::

    &cam_inparm bnd_topo = '/cluster/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ERA_bnd_topo_noresm2_20191023.nc' 


Correct calender
^^^^^^^^^^^^^^^^

If nudging to reanalysis data, ``CALENDAR`` in ``env_build.xml`` should be changed from ``NO_LEAP`` to ``GREGORIAN``. 

Correct start date
^^^^^^^^^^^^^^^^^^^^^

Modify ``env_run.xml`` to have the same ``RUN_STARTDATE`` as given in the ``met_data_file``. 

Ready-steady-go
^^^^^^^^^^^^^^^^^

You are now ready to setup, build and submit your case. 


How to generate your own nudging inputdata
-------------------------------------------

Create a case
^^^^^^^^^^^^^^^^

Create a case you want to generate data from

Modify user_nl_cam
^^^^^^^^^^^^^^^^^^^^^

Modify ``user_nl_cam`` and/or other user namelists to output the preferred nudging data

::

  &camexp
    mfilt = 1, 4, 
    nhtfrq = 0, -6,
    avgflag_pertape='A','I',
    fincl2 ='PS','U','V','T'


The example above will output ordinary h0 monthly mean files, one pr month, but also h1-files with instantaneous values of PS, U, V and T every six hours, four pr file.

Move the nudging data to a preferred folder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Move the nudging data (the h1-files) over to a preferred folder and create a txt-file including
a list of all the nudging data files that later can be pointed to as ``met_filenames_list``
::
    
  ls -d -1 $PWD/*.h1.*.nc > fileList.txt

For more information, look into the file where most of the nudging code is found
::

  /components/cam/src/NorESM/fv/metdata.F90
  
There are also other options for namelist modifications regarding nudging:
http://www.cesm.ucar.edu/models/cesm2/settings/current/cam_nml.html and search for *met_*

Available meteo fields for nudging
-----------------------------------

0.9x1.25 horizontal resolution, 32 layers (for NorESM2 / CAM6-Nor)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. glossary::

  ERA_f09f09_32L_days
    ::

      Original ERA data :
      Period : 2000-01-01 until 2016-01-31
      Horizontal resolution : f09 (0.9x1.25)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days
      Storage location : fram, betzy
      Contact person :
      Comment :

  AL/ERA_f09f09_32L_days
    ::

      Original ERA data : ERA-Interim
      Period : 2016-01-01 until 2018-12-31
      Horizontal resolution : f09 (0.9x1.25)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/AL/ERA_f09f09_32L_days
      Storage location : fram
      Contact person :
      Comment : Produced on Tetralith (copy of ERAI4NORESM)

  ERAI4NORESM
    ::

      Original ERA data : ERA-Interim
      Period : 2013-01-01 until 2019-08-31
      Horizontal resolution : f09 (0.9x1.25)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V 
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : /proj/bolinc/users/x_geoso/ERAI4NORESM
      Storage location : tetralith
      Contact person : anna@misu.su.se
      Comment : Identical to the data AL/ERA_f09f09_32L_days on Fram

0.9x1.25 horizontal resolution, 30 layers (for NorESM1.2 / CAM5.3-Nor)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. glossary::

  ERA_f09f09_30L_days
    ::

      Original ERA data :
      Period : 2000-01-01 until 2018-03-31
      Horizontal resolution : f09 (0.9x1.25)
      Vertical resolution : L30 (30 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM1.2 / CAM5.3-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/ERA_f09f09_30L_days
      Storage location : fram, betzy, tetralith
      Contact person :
      Comment :

  ERA5_enda_30L
    ::

      Original ERA data : ERA5
      Period : 2002-01-01 until 2018-10-31
      Horizontal resolution : f09 (0.9x1.25)
      Vertical resolution : L30 (30 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM1.2 / CAM5.3-Nor simulations
      Storage directory : /proj/bolinc/shared/data/noresm/inputForNudging/ERA5_enda_30L
      Storage location : tetralith
      Contact person : anna@misu.su.se
      Comment : Created by Lena Frey on Tetralith



1.9x2.5 horizontal resolution, 32 layers (for NorESM2 / CAM6-Nor)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. glossary::

  ERA_f19_tn14
    ::

      Original ERA data :
      Period : 2007-01-01 until 2013-12-31
      Horizontal resolution : f19 (1.9x2.5)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/ERA_f19_tn14
      Storage location : fram, betzy
      Contact person : 
      Comment :

  z_ABG/ERA_f19_tn14
    ::

      Original ERA data :
      Period : 2007-01-01 until 2013-12-31
      Horizontal resolution : f19 (1.9x2.5)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : noresm-only/inputForNudging/z_ABG/ERA_f19_tn14
      Storage location : betzy
      Contact person :
      Comment :

  AZ/ERA_f19_tn14
    ::

      Original ERA data :
      Period : 2007-01-01 until 2013-12-31
      Horizontal resolution : f19 (1.9x2.5)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : noresm-only/inputForNudging/AZ/ERA_f19_tn14
      Storage location : betzy
      Contact person :
      Comment :

  ERA_f19_tn14_SH
    ::

      Original ERA data :
      Period : 2007-01-01 until 2013-12-31
      Horizontal resolution : f19 (1.9x2.5)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : noresm-only/inputForNudging/ERA_f19_tn14_SH
      Storage location : fram
      Contact person :
      Comment :

  SMB/ERA_f19_tn14_gte2014
    ::

      Original ERA data :
      Period : 2014-01-01 until 2019-01-31
      Horizontal resolution : f19 (2.5x1.9)
      Vertical resolution : L32 (32 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM2 / CAM6-Nor simulations
      Storage directory : noresm-only/inputForNudging/SMB/ERA_f19_tn14_gte2014
      Storage location : fram
      Contact person : 
      Comment :

1.9x2.5 horizontal resolution, 30 layers (for NorESM1.2 / CAM5.3-Nor)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. glossary::

  ERA_f19_f19_L30
    ::

      Original ERA data :
      Period : 2000-01-01 until 2010-12-31
      Horizontal resolution : f19 (1.9x2.5)
      Vertical resolution : L30
      Available fields : PS, T, Q, U, V
      Use : for NorESM1.2 / CAM5.3-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/ERA_f19_f19_L30
      Storage location :  fram, betzy
      Contact person :
      Comment :

  ERA_f19_g16
    ::

      Original ERA data : 
      Period : 1999-01-01 until 2004-01-31
      Horizontal resolution : f19 (2.5x1.9)
      Vertical resolution : L30 (30 layers)
      Available fields : PS, T, Q, U, V
      Use : for NorESM1.2 / CAM5.3-Nor simulations
      Storage directory : inputdata/noresm-only/inputForNudging/ERA_f19_g16
      Storage location : fram
      Contact person :
      Comment :
