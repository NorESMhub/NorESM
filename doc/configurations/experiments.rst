.. _experiments:

Experiments
===========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settings are defined by the so called compsets.

Basic case set up, compilation and job submission with NorESM
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This is a general description/checklist for how to create a new experiment with NorESM. For a quick start guide, see also :ref:`newbie-guide`. The case creation step is explained in more detail below.

- Create a case::

    cd <noresm-base>/cime/scripts
    ./create_newcase --case <path_to_case_dir>/<casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project <project_name> --user-mods-dir <user_mods_dir> --output-root <path_to_run_dir>/<noresm_run_dir> --run-unsupported 
   
  Note!
  
  --walltime <time> can be set in env_batch.xml in the case directory after building the new case and is not necessary to include when building a new case

  --output-root <path_to_run_dir>/<noresm_run_dir> only necessary to include if the noresm_run_dir differ from default <path_to_run_dir>/noresm/ 

  Example of case creation on Fram::

    ./create_newcase --case ../../../cases/test1910_1 --compset N1850 --res f19_tn14 --machine fram --project snic2019-1-2 --user-mods-dir cmip6_noresm_DECK --run-unsupported

  Example of case creation on Tetralith::

    ./create_newcase --case ../../../cases/test1910_1 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out --run-unsupported
    
- Create a clone::
  
    cd <noresm-base>/cime/scripts
    ./create_clone --case <path_to_case_dir>/<casename> --clone <path_to_case_dir>/<casename_of_clone>
  

- Configure case::

    cd <path_to_case_dir>/casename
    ./case.setup


- Add code changes

  Copy your code changes to the folder::

    <path_to_case_dir>/casename>/SourceMods/src.<component>

- Edit namelist::

    <path_to_case_dir>/casename>/user_nl_<component>

- Edit run configuration::

    env_run.xml


- Build model::

    ./case.build

Make sure to include all modifications to user_nl_*, env_*.xml, SourceMods etc. before you build

- Copy restart files to run directory (if the case is a branch or a hybrid experiment) 


- Submit job::

    ./case.submit

Create new case
^^^^^^^^^^^^^^^

To start a new experiment you need to create a case. When creating a case a case folder <path_to_case_dir/casename> will be created that contains all the settings for your experiment

The case creation contains a compset option. A compset is a collection of predefined setting that defines your experiment setup, including which model components that are activated. Some of the available compsets are described below.

The case folder contains predefined namelist (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the user_nl_<component>

For extra aerosol output add the following configuration option

--user-mods-dir cmip6_noresm_*


| cmip6_noresm_DECK  
| cmip6_noresm_hifreq  
| cmip6_noresm_hifreq_xaer  
| cmip6_noresm_xaer  

For more details about the user-mod-dir options, chck this folder::

<noresm_base>/cime_config/usermods_dirs


Create a clone case
^^^^^^^^^^^^^^^^^^^
To create clone cases from a control case can be very useful for e.g. sensitivity studies. If you want to make a copy of a case (i.e. identical ./create_newcase command and identical env_*.xml, user_nml_<component> and SourceMods files) that can be done by the use of ./create_clone . You only need to give the casename of the new case and the casename of the case which sholud be cloned (copied). The case will have identical set up (env_*.xml, user_nml_<component> files and SourceMods) as the clone, but these files can of course be modified before building the case.

Compsets
^^^^^^^^
Below some compsets are listed. All predefined compsets for coupled simulations can be found in::

  <noresm_base>/cime_config/config_compsets.xml
  
And predefined compsets for AMIP/atmsophere only simulations can be found in::  

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  
The compsets starting with N are NorESM coupled configurations. Compsets starting with NF are NorESM AMIP/atmosphere only configurations.  

**N1850 and N1850frc2 (uses differently organized emission files : FRC2)**
Coupled configuration for NorESM for pre-industrial conditions.

**NHIST and NHISTfrc2  (uses differently organized emission files : FRC2)**

Historical configuration up to year 2015(?)

**NSSP126frc2, NSSP245frc2, NSSP370frc2, NSSP585frc2**


Future scenario compsets from 2015(?) to 2100(?)
 
  
  
Creating your own compset
^^^^^^^^^^^^^^^^^^^^^^^^^

-  NOTE THAT THE COMPSETS MENTIONED IN THIS EXAMPLE ARE NO LONGER
      MAINTAINED! THE GENERAL EXPLANATION AND IDEAS ARE STILL VALID!

The essential file to edit is
~/noresm/scripts/ccsm_utils/Case.template/config_compsets.xml

This examples shows how to simply add a to the "F_AMIP_CAM5" compset:

Under " ", add

 AMIP_CAM5%OSLO_CLM40%SP_CICE%PRES_DOCN%DOM_RTM_SGLC_SWAV

The "CAM5%OSLO" options have to be defined, so a line like this is
needed:

 -phys cam5 -cam_oslo aerlife

The compset needs a description, we also need the line cam 5 physcs and
oslo aerosols

We could also define a specific use-case (namelist) for our compset.
This would need a line like:

::

  my_namelist 

::

This would only work if the file my_namelist.xml exists as

::

  noresm/models/atm/cam/bld/namelist_files/use_cases/my_namelist.xml
::
  
**(I don't understand what this describes) Why does it work to change config_compsets.xml ?**


In NorESM there are 3 new config-options for CAM:

| `` * -cam-oslo aerlife (turns on transport of oslo tracers)``
| `` * -cam-oslo dirind  (also turns on interaction with radiation)``
| `` * -cam-oslo warmclouds (also turns on interaction with warm clouds)``

They change number of tracers and turn on different preprocessor flags
in in a perl script called "configure", see:
models/atm/cam/bld/configure

To understand the implementation do: svn diff -r 202
models/atm/cam/bld/configure

The new oslo-options also need to be defined, see
models/atm/cam/bld/config_files/definition.xml

To see how these new options were added, do: svn diff -r 202
models/atm/cam/bld/config_files/definition.xml


Resolution
''''''''''

Model resolution is set when the case is created. Below some common resolutions are listed. A complete list of model grids can be found here:::
  
  <noresm_base>/cime/config/cesm/config_grids.xml

Atmospheric grids
^^^^^^^^^^^^^^^^^


| f19_f19 - atm lnd 1.9x2.5  
| f09_f09 - atm lnd 0.9x1.25  
| f09_f09_mg17

Ocean grids
^^^^^^^^^^^
Which ocean grid is recommended?

| tnx1v1 tripole v1 1-deg grid  
| tnx1v3 tripole v3 1-deg grid  
| tn14(?)tripole v4 1-deg grid  tripole ocean grid  
| tnx2v1 tripole v1 2-deg grid  
| tx1v1 tripole v1 1-deg grid: testing proxy for high-res tripole ocean grids- do not use for scientific experiments  

Coupled
^^^^^^^
Which is the CMIP6 grid?

| f09_tn11   - atm lnd 0.9x1.25, ocnice tnx1v1
| f09_tn13   - atm lnd 0.9x1.25, ocnice tnx1v3
| f09_tn14   - atm lnd 0.9x1.25, ocnice tnx1v4  CMIP6 grid?
| f09_tn0251 - atm lnd 0.9x1.25, ocnice tnx0.25v1
| f09_tn0253 - atm lnd 0.9x1.25, ocnice tnx0.25v3
| f19_tn11   - atm lnd 1.9x2.5, ocnice tnx1v1
| f19_tn13   - atm lnd 1.9x2.5, ocnice tnx1v3
| f19_tn14   - atm lnd 1.9x2.5, ocnice tnx1v4

Simulation period
''''''''''''''''''''''''''

Some compsets only go with certain time periods?

Forcing
''''''''''''''''

Choosing output
'''''''''''''''

More informatin can be found in 


Setting up an AMIP simulation
'''''''''''''''''''''''''''''

Step by step guide for AMIP/fixed SST simulation.

Use a NF compset. Default SST and sea ice is ::

  sst_HadOIBl_bc_0.9x1.25_1850_2017_c180507.nc


Setting up a nudged simulation
''''''''''''''''''''''''''''''

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





Setting up a hybrid simulation
''''''''''''''''''''''''''''''

Step by step guide for hybrid simulation/restart.

When the case is created and compiled, edit ``env_run.xml``. Below is an example for restart with CMIP6 historical initial conditions::



    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFDIR" value="path/to/restars">                  # path to restarts
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="TRUE">                            # get refcase from outside rundir

If it is not possible to link directly to restarts, copy the restart files and rpointer files to the run directory. Below is example changes to ``env_run.xml``::


    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # Experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="FALSE">                           # get refcase from outside rundir
