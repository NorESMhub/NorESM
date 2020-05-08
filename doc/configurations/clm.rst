.. _clm:

Land and river run off
================


CLM5
------

| The land model used in NorESM2 is the Community Land Model version 5 (CLM5):
| http://www.cesm.ucar.edu/models/clm/
| 
| Specific questions about CLM can be addressed Lei Cai, email: leca@norceresearch.no

CLM5 model configurations available in NorESM2
^^^^^^
CLM5 can be run with a prognostic crop model with prognostic vegetation state and active biogeochemistry. 
The global crop model is on in BGC default configuration with 8 temperate and tropical crop types and has the capability to dynamically simulate crop management and crop management change through time. 
The BGC-CROP option is used in all NorESM2 CMIP6 experiments and is activated in the compset by::

  CLM50%BGC-CROP


CLM5 in NorESM2 can also be run with a prescribed satellite vegetation phenology model. This option can be activated in the compset by::

 CLM50%SP

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

To generate forcing data from the coupled simulation to run CLM5 stand alone with NorESM2 forcing, a full couple history needs to be turned on. For producing forcing data, please try adding this to user_nl_cpl in the coupled simulation of interest:

::

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


::

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


  
