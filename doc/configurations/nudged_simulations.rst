.. _nudged_simulations:

Setting up a nudged simulation:
===============================

Step by step guide for nudged simulation.

Nudge to ERA-interim reanalysis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ERA-interim nudging data for the time period 2000-01-01 to 2018-03-31 (f09f09_30L) and 2001-01-01 to 2016-01-31 (f09f09_32L) is available from the NorESM input data repository. This data was prepared by Inger Helene Karset who should be acknowledged when this data is used. The path to the nudging data in the cesm input data folder is typically::

  <cesm_input_data>/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days


Create a new case with a compset that supports nudging e.g. NFHISTnorpddmsbcsdyn.

Example case creation for nudged simulation with NorESM2:
::

  ./create_newcase --case /path/to/cases/<nudged_case_name> --compset NFHISTnorpddmsbcsdyn --res f09_f09_mg17 --mach <machine> --run-unsupported --user-mods-dir cmip6_noresm_fsst_xaer

Edit ``env_run.xml`` to change initial conditions. See below for configuring a hybrid simulation.

Link to the ERA-interim metdata in the user namelist for cam, user_nl_cam. Remember to choose the files corresponding to your resolution (examples below are for f09_f09 and 32 levels in the vertical for NorESM2). Link also to the ERA-topography file: 

::

  user_nl_cam
    &metdata_nl
    met_data_file = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/2001-01-01.nc'
    met_filenames_list = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/fileList2001-2015.txt'
    &cam_inparm
    bnd_topo = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_32L_days/ERA_bnd_topo_noresm2_20191023.nc


If no appropriate ``met_filenames_list`` is available, you can creat one::
  
  ls -d -1 $PWD/<pattern>*.nc > fileList.txt


When looking at aerosol indirect effects, it's recommended to nudge only U, V and PS: 

::

  user_nl_cam
    &metdata_nl
    met_nudge_only_uvps = .true.

Choose relaxation time (hours). Use the same time as dt in met_data_file: 

::

  user_nl_cam
    &metdata_nl
    met_rlx_time = 6



Create the met-data from a NorESM simulation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To produce your own nudging data from a NorESM simulation.

First run the NorESM to produce 6 hourly data. The following namelist settings are needed::

  user_nl_cam 
    &camexp 
    mfilt = 1, 4, nhtfrq = 0, -6, 
    avgflag_pertape='A','I', 
    fincl2 ='PS','U','V','TAUX','TAUY','FSDS','TS','T','Q','PHIS','QFLX','SHFLX'

  user_nl_clm 
    &clmexp 
    hist_mfilt = 1,4 hist_nhtfrq = 0,-6
    hist_avgflag_pertape = 'A','I' hist_fincl2 = 'SNOWDP','H2OSNO','H2OSOI'

**Use the met-data in another run**

(The following instructions are not valid any more? It's CAM5, not CAM6? Which is the new compset for nudged simulations?)

*First create a compset which has the configure-option "-offline_dyn". Check in config_compsets.xml which compsets have this configure-option added. See for example the compset NFAMIPNUDGEPTAERO in https://svn.met.no/NorESM/noresm/branches/featureCAM5-OsloDevelopment_trunk2.0-1/noresm/scripts/ccsm_utils/Case.template/config_compsets.xml*


Then use this compset to create a case. You need the following user-input in the user_nl_cam
:: 

  user_nl_cam
    &metdata_nl
    met_data_file='/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-01-00000.nc'
    met_filenames_list ='/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/fileList.txt'

The  ``met_data_file`` is the first met-data file to read and ``met_filenames_list`` is a list of all files to be read for the nudged simulation. The first lines of the file should look something like this (guess what the rest of the file should look like? 8-o: )

::

  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-01-00000.nc
  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-02-00000.nc
  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-03-00000.nc

This file can be created at the place where you put the metdata with this command:

::

  alfgr@hexagon-4:/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist>
  ls -d -1 $PWD/*.h1.*.nc > fileList.txt



