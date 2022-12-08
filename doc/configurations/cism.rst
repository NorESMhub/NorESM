.. _cism:

Land ice
========

.. note::
  The CISM coupling is under development and not yet a scientifically supported option in NorESM.

This description is equally a work in progress!

CISM
'''''
The current NorESM2 configuration only supports one ice sheet model instance and has only been used with the Greenland ice sheet so far.
Activating the land ice component CISM in NorESM experiments requires some preparatory work that is described here. 

Spin up of CISM 
^^^^^^^^^^^^^^^
Ice sheets have a longer response time compared to most other Earth System components. CISM therefore requires a spinup before it can be coupled into NorESM. We currently spin up CISM in standalone mode with surface mass balance (SMB) forcing coming from an exsiting or preliminary NorESM run.  

**Producing NorESM2 forcing data**

To run the CISM model with NorESM forcing relies on output files from the land model, CLM, to be available. To use NorESM2 history files as the forcing, these lines need to be included in ``user_nl_clm`` ::

  hist_nhtfrq = 0, -24, 0
  hist_mfilt  = 1, 5, 1
  hist_fincl1 = 'FERT_TO_SMINN','NFIX_TO_SMINN','LITFIRE','LITR1C_TO_SOIL1C','LITR2C_TO_SOIL1C','LITR3C_TO_SOIL2C','M_LEAFC_TO_LITTER','M_FROOTC_TO_LITTER','M_LIVESTEMC_TO_LITTER','M_DEADSTEMC_TO_LITTER','M_LIVECROOTC_TO_LITTER','M_DEADCROOTC_TO_LITTER','FIRA', 'FIRE_ICE', 'FSH_ICE', 'EFLX_LH_TOT_ICE', 'QSNOMELT_ICE', 'QSNOFRZ_ICE', 'QSOIL_ICE', 'QICE', 'QICE_MELT', 'FSA', 'FSR_ICE', 'TOPO_COL_ICE', 'FSDS', 'FLDS', 'LWdown', 'RAIN_ICE', 'SNOW_ICE', 'TSA_ICE', 'TG_ICE', 'H2OSNO_ICE', 'ICE_MODEL_FRACTION'
  hist_fincl2 = 'QRUNOFF', 'SOILLIQ', 'SOILICE', 'SOILWATER_10CM', 'TSA', 'TSL', 'GPP', 'AR', 'HR'
  hist_fincl3 = 'FIRA', 'FIRE', 'FSH', 'EFLX_LH_TOT', 'QSNOMELT', 'QSNOFRZ', 'QSOIL', 'QICE', 'QICE_MELT', 'FSA', 'FSR', 'TOPO_COL', 'FSDS', 'FLDS', 'LWdown', 'RAIN', 'SNOW', 'TSA', 'TG', 'H2OSNO'
  hist_dov2xy = .true., .true., .false.

The files required to derive CISM forcing data have the name clm.h2 in the lnd archive. 

**Downscaling NorESM2 data to the ice sheet grid**

A procedure to extract needed variables and downscale the forcing to the ice sheet grid is available in a separate repository (https://github.com/hgoelzer/MEC-downscaling). We typically use a long-term mean (30 years or more) of the downscaled SMB as boundary condition for a spinup. 

**Running CISM standalone with NorESM2 forcing data**

With the SMB available, a standalone ice sheet model initialisation run can be started, where ice sheet model parameters may be optimised and the ice sheet is relaxed to the NorESM SMB forcing. This step is required to avoid unphysical model drift once CISM is coupled with the other NorESM components. 

**Preparing CISM restart files for NorESM**

Restart files from a standalone CISM run are nearly ready for input in NorESM experiments. It is only needed to reset the time variable, rename the file to NorESM standards and to produce an rpointer.glc file. 


Preparing two-way interactions with the atmosphere component 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Incorporating the effect of ice sheet geometry changes on the atmospheric circulation is currently an asynchronous process that requires to automatically update the restart files of the atmospheric component. This is currently done every 5 years, at the end of a run segment. For this to work, a set of scripts needs to be set up that recalculate topography and surface roughness for the atmosphere model. The required global topographic data needs to be provided.

Activating the land ice component
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The land ice component is actviated by setting the cism block entry ``required = True`` in Externals.cfg before compilation. The land ice component code consist of two separate repositories that provide the interface with the climate model (cism-wrapper, see below) and the ice sheet model code itself (CISM, not shown) ::

  [cism]
  tag = wrapper_noresm2.0.2_v1
  protocol = git
  repo_url = https://github.com/NorESMhub/cism-wrapper
  local_path = components/cism
  externals = Externals_CISM.cfg
  required = True

With these code changes, the interface and CISM code are compiled and activated in NorESM. 

