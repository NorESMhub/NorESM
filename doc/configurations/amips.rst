.. _amips:

Setting up an AMIP simulation:
==============================

Setting up an AMIP simulation
'''''''''''''''''''''''''''''

Step by step guide for AMIP/fixed SST simulation.

Use a NF compset. Default SST and sea ice is ::

  sst_HadOIBl_bc_0.9x1.25_1850_2017_c180507.nc



**AMIP simulation**

This examples shows how to simply add the "NFHIST" compset to config_components.xml. In <noresm_base>/components/cam/cime_config/config_compsets.xml the NFHIST is set as

::
    
  <!-- fSST : evolving NorESM derived ; DMS: evolving NorESM derived -->
  <compset>
    <alias>NFHISTnorbc</alias>
    <lname>HIST_CAM60%NORESM%NORBC_CLM50%BGC-CROP_CICE%PRES_DOCN%DOM_MOSART_SGLC_SWAV</lname>
    <science_support grid="f09_f09_mg17"/>
  </compset>  

::

E.g. 

- HIST_CAM60%NORESM%NORNC
   - Forcing and input files read from historical conditions (1850 - 2015)
   - Build CAM6.0 (the atmosphere model) with NorESM derived boundary conditions i.e. fixed SST files from the coupled CMIP6 simulation (see explonation below).
   - Note for some AMIP compsets CAM60%PTAERO may be used instead of CAM60%NORESM. Don't worry, those are identical.
- CLM50%SP
   - Build CLM5 (land model) with satellite phenology, prescribed vegetation
- CICE%PRES
   - Build CICE (sea-ice model) with prescribed sea-ice
- DOCN%DOM
   - Build data ocean with fixed SSTs. Which SST files to use can be set in user_nl_cice after in the case directory after creating the case if different from the default files. If you want to run with a slab ocean slab: DOCN%SOM
- MOSART
   - Build MOSART (river runoff model) with default configurations
- SGLC_SWAV
   - The SGLC (land-ice) and SWAV (ocean-wave) models are not interactive, but used only to satisy the interface requirements 

**NorESM2 derived boundary conditions for AMIP simulations**

In atmosphere-only simulations, one wants to use boundary conditions as close as possible to the coupled simulations. In NorESM2 atmosphere-only simulations, one therefor uses prescribed boundary conditions for SST, sea-icecover and upper-ocean DMS concentrations (all three fields taken from the fully-coupled simulation), combined within principle the same flux-parameterisation is in the full-coupled simulation. 

For the atmosphere-only simulations to be run, boundary conditions have to be generated to describe the apparentstate of the imaginary underlying ocean. The model needs boundary conditions for sea-surface temperature (SST),sea-ice cover, and upper ocean DMS concentration. Up to now, 4 sets of boundary conditions have been made:

- A pre-industrial climatology (containing 12 months)

  - on 2x2 degree based on a 30-year period of 2x2 degree resolution and piControl(years 1751–1780).  
  - this climatology is used for piClim-control (and all type of perturbations) CMIP6 simulations(these are mostly 30-year long simulations).  
  
- As above but on 1x1 resolution, and based on 1◦x1◦piControl (years 1351-1380).

- A historical climatology 

  - (1849-2015, monthly) on 2x2 degree resolution, based on the period 1850–2014 of historical.  
  - this climatology is used for histSST (and perturbations) CMIP6 simulations (165 year long simulations).  
 
- A scenario ssp3-7.0 climatology

  - (2014–2101, monthly) on 2x2 resolution, based on years 2015-2100 of ssp3-7.0.  
  - this climatology is used for ssp370SST simulations (86 year longsimulations).  
  - the climatologies for piClim-control have been based on a 30-year snapshot of piControl (year 1751–1780 and 1351–1380 as mentioned above).  
  - for comparison of piClim-control and piControl, one should focus on those 30-year periods, due to inter-decadal variability or drifts in piControl  
  
