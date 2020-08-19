.. _clm:

Land and river run off
================

CLM5
------

The land model used in NorESM2 is the Community Land Model version 5 (CLM5):
http://www.cesm.ucar.edu/models/clm/


Specific questions about CLM can be addressed Lei Cai, email: leca@norceresearch.no

CLM5 model configurations available in NorESM2
^^^^^^
CLM5 can be run with a prognostic crop model with prognostic vegetation state and active biogeochemistry. 
The global crop model is on in BGC default configuration with 8 temperate and tropical crop types and has the capability to dynamically simulate crop management and crop management change through time. 
The BGC-CROP option is used in all NorESM2 CMIP6 experiments and is activated in the compset by::

  CLM50%BGC-CROP


CLM5 in NorESM2 can also be run with a prescribed satellite vegetation phenology model. This option can be activated in the compset by::

 CLM50%SP

Note that the BGC-CROP option is more expensive than SP (+ca 10-15% CPU time)

CLM5 atmospheric coupling
^^^^^
The current state of the atmospheric component, CAM6-Nor, at a given time step is used to force the land model. The land model then initiates a full set of calculations for surface energy, constituent, momentum, and radiative fluxes. The land model calculations are implemented in two steps:

- 1. The land model proceeds with the calculation of surface energy, constituent, momentum, and radiative fluxes using the snow and soil hydrologic states from the previous time step. 

- 2. The land model then updates the soil and snow hydrology calculations based on these fluxes. These fields are passed to the atmosphere. The albedos sent to the atmosphere are for the solar zenith angle at the next time step but with surface conditions from the current time step.

From CLM5 user guide: https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/tech_note/Ecosystem/CLM50_Tech_Note_Ecosystem.html#atmospheric-coupling


CLM5 surface data
^^^^
Required surface data for each land grid cell include: 

- the glacier, lake, and urban fractions of the grid cell (vegetated and crop occupy the remainder)
- the fractional cover of each plant functional type (PFT), monthly leaf and stem area index and canopy top and bottom heights for each PFT, 
- soil color, soil texture, soil organic matter density, 
- maximum fractional saturated area, slope, elevation, 
- biogenic volatile organic compounds (BVOCs) emissions factors, 
- population density 
- gross domestic production 
- peat area fraction
- peak month of agricultural burning. Optional surface data include crop irrigation and managed crops.

From CLM5 user guide: https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/tech_note/Ecosystem/CLM50_Tech_Note_Ecosystem.html#surface-data:

**Steps to create a complete set of surface data files for CLM**

A technical description on how to create new surface data sets is found here: 
https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/clm_surfdata.pdf


The inital state of CLM5
^^^^^^

The land model needs to read in the inital state from a restart file. This can be customized in user_nl_clm in the case folder ::

  finidat = '<path_to_inputdata>/inputdata/<path_to_file>/CLMFILENAME.clm2.r.YR-01-01-00000.nc'

e.g. Fram @ Sigma2::

 finidat = '/work/shared/noresm/inputdata/cesm2_init/b.e20.B1850.f09_g17.pi_control.all.297/0308-01-01/b.e20.B1850.f09_g17.pi_control.all.297.clm2.r.0308-01-01-00000.nc'

The file used for NorESM2-MM CMIP6 piControl simulation is::

  finidat = N1850_f09_tn14_20190913.clm2.r.1200-01-01-00000.nc
  
The file used for NorESM2-LM CMIP6 piControl simulation is::

  finidat = N1850_f19_tn14_11062019.clm2.r.1600-01-01-00000.nc
  
Information about which file is used as an initial state (in addition to parameter settings and other files used as input) file is in lnd_in. This file can be found in::

  <casefolder>/CaseDocs/lnd_in
  
and in the Run folder::

  <RUN_DIR>/case/run/lnd_in

User name list modifications
^^^^^^
An example of how you can modify user_nl_clm. This adds four auxilary history files in addition to the standard monthly files. The first two are daily, and the last two are six and three hourly::

      hist_mfilt   = 1,365,30,120,240        
      hist_nhtfrq  = 0,-24,-24,-6,-3        
      hist_fincl2  = 'TSOI', 'TG',   'TV',   'FIRE',   'FSR', 'FSH', 'EFLX_LH_TOT', 'WT'
      hist_fincl3  = 'FSA'
      hist_fincl4  = 'TSOI', 'TG',   'TV',   'FIRE',   'FSR', 'FSH', 'EFLX_LH_TOT', 'WT'
      hist_fincl5  = 'TSOI', 'TG',   'TV',   'FIRE',   'FSR', 'FSH', 'EFLX_LH_TOT', 'WT'
    

If you are not interested in CLM output variables, you can remove any additional history list like hist_fincl2 or hist_fincl3 in user_nl_clm and set reduced output history frequency to every 50 or 100 years depending on your run length. 
For example if STOP_N=50 years, you can set::

 hist_mfilt = 50
 hist_nhtfrq = -8760
 
-8760 means one average value per year, and 50 years in one file.

- The full namelist definitions and defaults in the CLM5: http://www.cesm.ucar.edu/models/cesm2/settings/current/clm5_0_nml.html

Spin up of CLM5 
^^^^^^
A long spin up is required for running NorESM2 with CLM50%BGC-CROP to achive e.g. land carbon balance. Therefore, an off-line spin up of CLM50%BGC-CROP has to be performed in order to save computation time.

**Generating atmospheric forcing data**

Atmospheric forcing data from the coupled NorESM2 simulation are used to run CLM5 stand alone spin up. To output such atmospheric forcing data, the following commands have to be added to user_nl_cpl in the coupled simulation of interest:::

  &seq_infodata_inparm
    histaux_a2x      = .true.  
    histaux_a2x1hr   = .true. 
    histaux_a2x1hri  = .true.
    histaux_a2x3hr   = .true.
    histaux_a2x3hrp = .false.
    histaux_a2x24hr = .true.
    histaux_l2x     = .true.
    histaux_l2x1yrg = .true.
    histaux_r2x     = .true.


**Running CLM stand alone with NorESM2 forcing data**

To use NorESM2 history files as the forcing, CPLHISTForcing mode needs to be activated. In CPLHISTForcing mode, the model is assumed to have 3-hourly for a global grid from a previous simulation (see description above). The data atmophere (datm) forcing is divided into three streams: precipitation, solar, and everything else.

To create a new case for stand alone CLM5 spin up with NorESM2 forcing data, one should choose the same resolution as the coupled simulation (f19_tn14 for NorESM2-LM and f09_tn14 for NorESM2-MM). The compset to use is I1850BgcCropCmip6. For example, to create a new NorESM2-LM case, 

:: 

./create_newcase --case <PAT_TO_CASEFOLDER>/CASENAME --compset N1850BgcCropCmip6 --res f19_tn14 --mach fram --project nn9560k 

::

Using the CPLHIST forcing, the offline spin up needs to be run in two steps:

- **1. Accelerated spinup (300 years):** 

When entering “Accelerated Spinup” mode, soil carbon pools will be
scaled down by a factor ~40, vegetation pools scaled down by ~5
In env_run.xml, include::

./xmlchange RUN_TYPE="startup",STOP_N=400,STOP_OPTION="nyears",REST_N=50
./xmlchange CLM_ACCELERATED_SPINUP="on"
./xmlchange CLM_FORCE_COLDSTART="on"
./xmlchange DATM_MODE=CPLHIST,DATM_PRESAERO=cplhist,DATM_TOPO=cplhist
./xmlchange DATM_CPLHIST_DIR=/cluster/shared/noresm/inputdata/cplhist/N1850_f09_tn14_20190726_751-850
./xmlchange DATM_CPLHIST_CASE=N1850_f09_tn14_20190726
./xmlchange DATM_CPLHIST_YR_ALIGN=751,DATM_CPLHIST_YR_START=751,DATM_CPLHIST_YR_END=850

Note. The casename for the CPLHIT (N1850_f09_tn14_20190726, N1850_f09_tn14_20190726_751-850) and all numbers need to be changed for the simulation of interest. 

In user_nl_clm set output frequency to every 50 or 100 years <= REST_N::
 hist_mfilt = 50
 hist_nhtfrq = -8760

- **2. Normal spinup (1800 years):** 

When exiting Accelerated Spinup and entering normal spinup, the
carbon pools will be scaled up back to normal levels


**Recoupling CLM5 with NorESM2**

NorESM2 can then be run with CLM5 using the restart file from the end of the spinup as the initial file. To do this, modify the set up in user_nl_clm::

  finidat = '<path_to_inputdata>/inputdata/<path_to_file>/CLM_SPINUP_FILENAME.clm2.r.YR-01-01-00000.nc'
 
 
A description of the NorESM2 CLM5 spin up, recoupling and diagnostics can be found here:
https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/NorESM-CLM-memo.pdf

Code modification 
^^^^^^
To make more subtantial modification to the BLOM/iHAMOCC code than what is possible by the use of user_nl_clm, there are two methods:

1. Make a branch from the NorESM2 version (branch or release) you want to modify, checkout this branch in order to make code changes directly in the source code folder.

2. Copy the source code (the fortran file(s) you want to modify) to the SourceMods/src.clm folder in the case directory, and then make the modifications needed before building the model. By the use of this method, you will not change the source code in the <noresm-base> folder.

The CLM5 source code is located in::
  
  <noresm-base>/components/clm/src/


Land-only experiments
^^^^^^

**For land-only simulations**, there is no difference in running the CLM5 in CESM2 and that in NorESM2. For a detailed description on how to set up, modify, build and run CLM5 stand alone experiments, please see
the CLM5.0 users guide: https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/setting-up-and-running-a-case/choosing-a-compset.html (last accessed 7th May 2020)

NorESM2 specific additions
^^^^^^
Remove infiltration excess water as runoff if the temperature of the surface water pool is below freezing.
For details please see :ref:`model-description/lnd_model`

The NorESM2 specific addition can be tuned on/off by a flag in the user_nl_clm in the case folder. Setting::

  reset_snow = .true.
  
will use NorESM2 treatment of the surface water in CLM (see previous description).

Setting::

  reset_snow = .false.
  
will use CESM2 treatment of the surface water in CLM (see previous description).

CLM5 specifics
^^^^^

- There is no information exchange within the CLM model between sub-grid tiles (landunits, columns, plant functional types (PFTs)). 
- Sub-grid tiles only exchange information with the atmosphere. In the current CLM, there is no advection of heat and water at depth. 
- The horizontal resolution of the CLM keeps the same as for the atmosphere (f19, f09). 
- Vertically, there are four soil structures to set in the CLM namelist file. CLM5 model configurations available in NorESM2:

::

  10SL_3.5m    = standard CLM4 and CLM4.5 version
  23SL_3.5m    = more vertical layers for permafrost simulations 
  49SL_10m     = 49 layer soil column, 10m of soil, 5 bedrock layers
  20SL_8.5m    = 20 layer soil column, 8m of soil, 5 bedrock layers

::

By default, 20SL_8.5m is employed.


MOSART
-------------

| The Model for Scale Adaptive River Transport (MOSART) is the default river model for CESM2, CLM5 and NorESM2. For more information please see:  
| http://www.cesm.ucar.edu/models/cesm2/river/
|   
| For a techincal user guide, please see:  
| https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/tech_note/MOSART/CLM50_Tech_Note_MOSART.html  


The methods and syntax for modifying the user namelist and code in MOSART are similar to CLM5, so the previous description can be used. The user namelist for MOSART is user_nl_mosart and source code files should be copied to SourceMods/src.mosart/ in the case folder.

The MOSART source code is located in::
  
  <noresm-base>/components/mosart/src/


  
