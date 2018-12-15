.. _advancednoresm2:

Advanced configuration of NorESM2
==================================                                 

-  NOTE THAT THE COMPSETS MENTIONED IN THIS EXAMPLE ARE NO LONGER
      MAINTAINED! THE GENERAL EXPLANATION AND IDEAS ARE STILL VALID!

Creating a new compset
''''''''''''''''''''''

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

This would only work if the file my_namelist.xml exists as

::

  noresm/models/atm/cam/bld/namelist_files/use_cases/my_namelist.xml

Setting up a case with the new compset and building the model
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

It should now be possible to create a new case directory, which we here
name FAMIPOSLOtst and configure with 1 degree horizontal atmospheric
resolution;

:: 

 ./create_newcase -case ../cases/FAMIPOSLOtst -compset FAMIPOSLO -mach
  hexagon -res f09_f09

and finally set up and compile the model: cd ../cases/FAMIPOSLOtst

::

 ./cesm_setup

 ./FAMIPOSLOtst.build

Why does it work to change config_compsets.xml ?
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

Configure nudging
'''''''''''''''''

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


