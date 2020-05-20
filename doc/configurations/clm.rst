.. _clm:

Land and river run off
================


CLM5
------

| The land model used in NorESM2 is the Community Land Model version 5 (CLM5):
| http://www.cesm.ucar.edu/models/clm/
| 
| Specific questions about CLM can be addressed Lei Cai, email: leca@norceresearch.no

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

All fields are aggregated to the model’s grid from high-resolution input datasets ( Table 2.2.6) that are obtained from a variety of sources described below.

From CLM5 user guide: https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/tech_note/Ecosystem/CLM50_Tech_Note_Ecosystem.html#surface-data:

CLM5 model configurations available in NorESM2
^^^^^^
CLM5 can be run with a prognostic crop model with prognostic vegetation state and active biogeochemistry. 
The global crop model is on in BGC default configuration with 8 temperate and tropical crop types and has the capability to dynamically simulate crop management and crop management change through time. 
The BGC-CROP option is used in all NorESM2 CMIP6 experiments and is activated in the compset by::

  CLM50%BGC-CROP


CLM5 in NorESM2 can also be run with a prescribed satellite vegetation phenology model. This option can be activated in the compset by::

 CLM50%SP

Note that the BGC-CROP option is more expensive than SP (+ca 10-15% CPU time)

The inital state 
^^^^^^

The land model needs to read in the inital state from a restart file set in user_nl_clm in the case folder ::

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


Spin up of CLM5 
^^^^^^
A long spin up of CLM5 is necessary to achive e.g. land carbon balance. Such a spin up can be done partly uncoupled from NorESM2 in order to save computation time.

**Forcing data**

To generate forcing data from the coupled simulation to run CLM5 stand alone with NorESM2 forcing, a full couple history needs to be turned on. For producing forcing data, please try adding this to user_nl_cpl in the coupled simulation of interest:::

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


To create a new case for stand alone CLM5 spin up with NorESM2 forcing data, one should choose the same resolution as the coupled simulation (f19_tn14 for NorESM2-LM and f09_tn14 for NorESM2-MM). The compset to use is I1850BgcCropCmip6. For example, to create a new NorESM2-LM case, 

:: 

./create_newcase --case <PAT_TO_CASEFOLDER>/CASENAME --compset N1850BgcCropCmip6 --res f19_tn14 --mach fram --project nn9560k 

::

To use NorESM2 history files as the forcing, CPLHISTForcing mode needs to be activated. In CPLHISTForcing mode, the model is assumed to have 3-hourly for a global grid from a previous simulation. The data atmophere (datm) forcing is divided into three streams: precipitation, solar, and everything else. The time-stamps for Coupler history files is at the end of the interval, so ``offset`` in the datm.streams files needs to be set in order to adjust the time-stamps to what it needs to be for the tintalgo settings. 

For precipitation ``tintalgo`` is set to ``nearest`` so the ``offset`` is set to ``-5400`` seconds so that the ending time-step is adjusted by an hour and half to the middle of the interval. 
For solar ``tintalgo`` is set to ``coszen`` so the ``offset`` is set to ``-10800`` seconds so that the ending time-step is adjust by three hours to the beginning of the interval. 
For everything else ``tintalgo`` is set to ``linear`` so the ``offset`` is set to ``-5400`` seconds so that the ending time-step is adjusted by an hour and half to the middle of the interval.

The link to forcing data is set also by editing datm.streams files.

**Recoupling**

NorESM2 can then be recoupled to the spun up land experiment by the use of restart files. I.e. in the fully coupled case set the restartfile from the CLM5 stand alone spin up experiment in user_nl_clm::

  finidat = '<path_to_inputdata>/inputdata/<path_to_file>/CLM_SPINUP_FILENAME.clm2.r.YR-01-01-00000.nc'
 
 
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

Code modification
^^^^^^

If you want to make more subtantial changes to the codes than what is possible by the use of user_nl_clm, you need to copy the source code (the fortran file you want to modify) to the SourceMods/src.clm folder in the case directory, then make the modifications needed before building the model. **Do not change the source code in the <noresm-base> folder!**

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


  
