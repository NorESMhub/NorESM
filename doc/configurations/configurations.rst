.. _configurations:

Model Configurations
====================

Running NorESM2 on different platforms
''''''''''''''''''''''''''''''''''''''

Below is a list of platforms where NorESM2 has been installed, including platform specific intructions. 

Vilje @ Sigma2
^^^^^^^^^^^^^^
Add instructions here

Fram @ Sigma2
^^^^^^^^^^^^^
Add instructions here

Nebula @ NSC
^^^^^^^^^^^^
Add instructions here

Tetralith @ NSC
^^^^^^^^^^^^^^^

Configuration files for Tetralith are not yet distributed with the code. Configuration and input files for running NorESM2 are stored in the following folder on Tetralith:

::
/proj/cesm_input-data/tetralith_config_noresm2
::

Apply for membership in PROJECT for access to the folder.

Copy the files in the above folder to:

::
cd <noresm-base>/cesm2.1.0/cime/config/cesm/machines/
cp /proj/cesm_input-data/tetralith_config_noresm2/* .
::

Input data is stored /proj/cesm_input-data/. Apply for access 

Before configring and compiling the model, clear your environment and load the following modules:


::
module purge 
module load buildenv-intel/2018.u1-bare 
module load netCDF/4.4.1.1-HDF5-1.8.19-nsc1-intel-2018a-eb 
module load HDF5/1.8.19-nsc1-intel-2018a-eb 
module load PnetCDF/1.8.1-nsc1-intel-2018a-eb
::

Create a new case:

::
./create_newcase –case ../cases/<casename> -mach triolith –res <resolution> -compset <compset_name> -pecount M -ccsm_out <NorESM_ouput_folder>
::


General configuration
'''''''''''''''''''''
For quick start, check the newbie's guide to rinning NorESM2


Compsets
''''''''

Creating new compsets
^^^^^^^^^^^^^^^^^^^^^
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
  
(I don't understand what this describes) Why does it work to change config_compsets.xml ?
''''''''''''''''''''''''''''''''''''''''''''''''

In NorESM there are 3 new config-options for CAM:

| `` * -cam-oslo aerlife (turns on transport of oslo tracers)``
| `` * -cam-oslo dirind  (also turns on interaction with radiation)``
| `` * -cam-oslo warmclouds (also turns on interaction with warm clouds)``

They change number of tracers and turn on different preprocessor flags
in in a perl script called "configure", see:
models/atm/cam/bld/configure

To understand the implementation do: svn diff -r 202
models/atm/cam/bld/configure

The new oslo-options also need to be defined, see
models/atm/cam/bld/config_files/definition.xml

To see how these new options were added, do: svn diff -r 202
models/atm/cam/bld/config_files/definition.xml
 

Nudged simulations
''''''''''''''''''

Create the met-data
^^^^^^^^^^^^^^^^^^^

First run the model to produce 6 hourly data. The following namelists
are needed:

 user_nl_cam &camexp mfilt = 1, 4, nhtfrq = 0, -6, avgflag_pertape
='A','I', fincl2 =
'PS','U','V','TAUX','TAUY','FSDS','TS','T','Q','PHIS','QFLX','SHFLX'

 user_nl_clm &clmexp hist_mfilt = 1,4 hist_nhtfrq = 0,-6
hist_avgflag_pertape = 'A','I' hist_fincl2 = 'SNOWDP','H2OSNO','H2OSOI'

Use the met-data in another run
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

First create a compset which has the configure-option "-offline_dyn".
Check in config_compsets.xml which compsets have this configure-option
added. See for example the compset NFAMIPNUDGEPTAERO in
https://svn.met.no/NorESM/noresm/branches/featureCAM5-OsloDevelopment_trunk2.0-1/noresm/scripts/ccsm_utils/Case.template/config_compsets.xml

Then use this compset to create a case. You need the following
user-input (for example in your user_nl_cam)

:: 

  &metdata_nl
  met_data_file='/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-01-00000.nc'
  met_filenames_list =
  '/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/fileList.txt'

This info can be added directly in a use_case which you associate with
the compset created (see e.g. 2000_cam5_oslonudge.xml)

where met_data_file is the first met-data file to read, and
met_filenames_list is a list of the following met-data. The first lines
of the file should look something like this (guess what the rest of the
file should look like? 8-o: )

::

  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-01-00000.nc
  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-02-00000.nc
  /work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist/FAMIPC5NudgeOut.cam.h1.1979-01-03-00000.nc

This file can be created at the place where you put the metdata with
this command:

::

  alfgr@hexagon-4:/work/shared/noresm/inputForNudging/FAMIPC5NudgeOut/atm/hist>
  ls -d -1 $PWD/*.h1.*.nc > fileList.txt

Namelist options
^^^^^^^^^^^^^^^^

When looking at aerosol indirect effects, it's recommended to nudge only
U, V and PS: &metdata_nl

::

  met_nudge_only_uvps = .true.

Choose relaxation time (hours). Use the same time as dt in
met_data_file: &metdata_nl

::

  met_rlx_time = 6

Nudge to ERA-interim reanalysis
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Link to ERA-interim metdata instead of model produced metdata. Remember
to choose the files corresponding to your resolution (examples below are
for f09_f09 and 32 levels in the vertical): &metdata_nl

::

  met_data_file = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_30L_days/2001-01-01.nc'
  met_filenames_list = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_30L_days/fileList2001-2015.txt'

Add also the ERA-topography (no matter which fields you are nudging):

:: 

  &cam_inparm

  bnd_topo = '/work/shared/noresm/inputdata/noresm-only/inputForNudging/ERA_f09f09_30L_days/ERA_bnd_topo.nc'



Atmosphere only (AMIP) simulations
''''''''''''''''''''''''''''''''''

Running with offline aerosols
'''''''''''''''''''''''''''''

Input data and forcing
''''''''''''''''''''''
The complete input data set is stored on Fram @ Sigma2. For access to input data contact ???

Some of the input data, the look-up tables (LUT) for NorESM specific aerosol optics and size information for calculation of cloud droplet activation, can be modified either for testing purposes or in order to take into account new developments in the aerosol microphysics scheme. Some typical examples of input that may need to be updated are: refractive indices; assumed (log-normal) size parameters at the point of emission or production; assumed hygroscopicities for sub-saturated conditions. Such changes can be made in the offline "sectional" aerosol module AeroTab (as in the example of new refractive indices), or both in AeroTab and in the online aerosol module OsloAero in the CAM6-Nor code (as in the example of assumed size parameters). Many aerosol related model changes may be done without having to touch the AeroTab code and thee LUT at all, such as e.g. the emissions (whether they are prescribed or interactive).  

A user guide for the AeroTab code, as well as the corresponding CAM6-Nor (OsloAero) code which is using the AeroTab LUT, will soon be available here. Until then, this presentation can be used as a first introduction (LINK). For questions about AeroTab, contakt Alf Kirkevåg (alfk at met.no) or Øyvind Seland (oyvinds at met.no).      


Output data and standard results
''''''''''''''''''''''''''''''''

If your model simulation was successful, you should find the following line in slurm.out (or similar) in your cse folder 

::
Tue Feb 9 21:41:33 CET 2016 -- CSM EXECUTION BEGINS HERE Wed Feb 10 13:37:56 CET 2016 -- CSM EXECUTION HAS FINISHED (seq_mct_drv): =============== SUCCESSFUL TERMINATION OF CPL7-CCSM =============== 
::



.. _noresm2_output:

Atmospheric output for some commonly used configurations of NorESM2
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

In preparation for CMIP6 and the required model output for the various 
MIPs, NorESM2 has been set up with different configurations, all run as 
AMIP using the compset NF2000climo (on 2 degrees) in noresm-dev (2.0: 
commit 7757f2d8258d5f84e960db12f840afebc69d7856 from October 30'th 2018; 
(2.1: COMMIT 35b90aab78c2cceee636539894c9ff9015355f2f from March 25'th 
2019) The given estimates in CPU-time increase are based on 1 month 
simulations, including model initialization, and are therefore low end 
estimates. 

With standard set-up of the model, the monthly output variables (1, 2
and 3 D) are:

:ref:`standard_output`

Adding history_aerosol = .true. to user_nl_cam gives the following
additional 577 variables (+ ca. 13 % CPU-time)

:ref:`history_aerosol_extra_output`

Furthermore including #define AEROFFL to preprocessorDefinitions.h gives
8 additionally variables (+ ca. 5% CPU-time)

:ref:`aeroffl_extra_output`

and when also #define AEROCOM is activated there, we additionally get
the following 149 variables (+ ca. 13% CPU-time)

:ref:`aerocom_extra_output`

Finally, also taking out COSP data (./xmlchange --append
CAM_CONFIG_OPTS='-cosp'), the following 57 output variables (of which 7
are 4 D) are added to the output (+ ca. 10% CPU-time):

:ref:`cosp_extra_output`
