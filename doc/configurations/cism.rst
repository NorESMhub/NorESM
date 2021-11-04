.. _cism:

Land ice
======

**Note! The CISM coupling is under development and not yet a scientifically supported option in NorESM.**

This description is equally a work in progress!

CISM
''''
Activating the land ice component CISM in NorESM experiments requires some preparatory work that is described here. 

Spin up of CISM 
^^^^^^
Ice sheets have a longer response time compared to most other Earth System components. CISM therefore requires a spinup before it can be coupled into NorESM. We currently spin up CISM in standalone mode with surface mass balance forcing coming from an exsiting or preliminary NorESM run.  

**Running CISM stand alone with NorESM2 forcing data**

The CISM model uses forcing files from the land model, CLM. To use NorESM2 history files as the forcing, these lines need to be included in `user_nl_clm` ::

  hist_nhtfrq = 0, -24, 0
  hist_mfilt  = 1, 5, 1
  hist_fincl1 = 'FERT_TO_SMINN','NFIX_TO_SMINN','LITFIRE','LITR1C_TO_SOIL1C','LITR2C_TO_SOIL1C','LITR3C_TO_SOIL2C','M_LEAFC_TO_LITTER','M_FROOTC_TO_LITTER','M_LIVESTEMC_TO_LITTER','M_DEADSTEMC_TO_LITTER','M_LIVECROOTC_TO_LITTER','M_DEADCROOTC_TO_LITTER','FIRA', 'FIRE_ICE', 'FSH_ICE', 'EFLX_LH_TOT_ICE', 'QSNOMELT_ICE', 'QSNOFRZ_ICE', 'QSOIL_ICE', 'QICE', 'QICE_MELT', 'FSA', 'FSR_ICE', 'TOPO_COL_ICE', 'FSDS', 'FLDS', 'LWdown', 'RAIN_ICE', 'SNOW_ICE', 'TSA_ICE', 'TG_ICE', 'H2OSNO_ICE', 'ICE_MODEL_FRACTION'
  hist_fincl2 = 'QRUNOFF', 'SOILLIQ', 'SOILICE', 'SOILWATER_10CM', 'TSA', 'TSL', 'GPP', 'AR', 'HR'
  hist_fincl3 = 'FIRA', 'FIRE', 'FSH', 'EFLX_LH_TOT', 'QSNOMELT', 'QSNOFRZ', 'QSOIL', 'QICE', 'QICE_MELT', 'FSA', 'FSR', 'TOPO_COL', 'FSDS', 'FLDS', 'LWdown', 'RAIN', 'SNOW', 'TSA', 'TG', 'H2OSNO'
  hist_dov2xy = .true., .true., .false.

