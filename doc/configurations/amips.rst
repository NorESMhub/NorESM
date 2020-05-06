.. _amips:

AMIP (atmosphere-only) simulations:
===================================

Setting up an AMIP simulation
''''''''''''''''''''''''''''''
Atmospheric Model Intercomparison Project (AMIP) style runs are runs in which the **atmosphere and land components are active while values for sea surface temperatures and sea ice are prescribed** (that is, read from a file). The sea-ice model CICE then runs in a simplified mode and computes surface fluxes, snow depth, albedo, and surface temperatures using 1D thermodynamics without conserving energy. The sea-ice thickness is assumed to be 2 m in the Northern Hemisphere and 1 m in the Southern Hemisphere. 

The AMIP simulation is created in the same manner as a coupled simulation, but using compsets starting with NF. 

AMIP compsets
'''''''''''''

Compsets starting with NF are NorESM AMIP (atmosphere/land-only) configurations.  Predefined compsets for AMIP simulations can be found in::  

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  

Creating your own compset for AMIP simulations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The essential file to edit for a new AMIP NorESM compset is:: 

  <noresm_base>/components/cam/cime_config/config_compsets.xml

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
   - Build CAM6.0 (the atmosphere model) with NorESM specific additions and NorESM derived boundary conditions  (for the boundary conditions, please see explonation below).
   - Note for some AMIP compsets CAM60%PTAERO may be used instead of CAM60%NORESM. Don't worry, those are identical.
- CLM50%SP
   - Build CLM5 (land model) with satellite phenology, prescribed vegetation
- CICE%PRES
   - Build CICE (sea-ice model) with prescribed sea-ice
- DOCN%DOM
   - Build data ocean with fixed SSTs. If you want to run with a slab ocean slab: DOCN%SOM
- MOSART
   - Build MOSART (river runoff model) with default configurations
- SGLC_SWAV
   - The SGLC (land-ice) and SWAV (ocean-wave) models are not interactive, but used only to satisfy the interface requirements 

To use different prescribed fields for SSTs and sea-ice cover than the default, change the value of the variable **SSTICE_DATA_FILENAME** in the **evn_run.xml** file to the full path of a different file that complies to the requirements of the CICE and the data-ocean model.

NorESM2-derived boundary conditions for AMIP simulations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In the coupled NorESM2 simulations, the flux parameterization used for the transfer of heat, moisture and momentum between the ocean and atmosphere is the so-called COARE flux parameterization. This choice is activated by::

  OCN_FLUX_SCHEME=1 

in env_run.xml, and ends up in the drv_in namelist as::

  flux_scheme=1. 

This parameterisationis different from the standard flux-parameterzation used in CESM, which is activated by::

  OCN_FLUX_SCHEME=0.
  
In atmosphere-only simulations, one wants to use boundary conditions as close as possible to the coupled simulations. In NorESM2 atmosphere-only simulations, one therefore uses prescribed boundary conditions for SST, sea-ice cover and upper-ocean DMS concentrations (all three fields taken from the fully-coupled simulation), combined within principle the same flux-parameterisation is in the fully-coupled simulation.


For the atmosphere-only simulations to be run, boundary conditions have to be generated to describe the apparent state of the imaginary underlying ocean. The model needs boundary conditions for sea-surface temperature (SST), sea-ice cover, and upper-ocean DMS concentration. Up to now, 4 sets of boundary conditions have been made:

- A pre-industrial climatology (containing 12 months)

  - on 2x2 degree based on a 30-year period of 2x2 degree resolution and piControl (years 1751–1780).  
  - this climatology is used for piClim-control (and all type of perturbations) CMIP6 simulations (these are mostly 30-year long simulations).  
  
- As above but on 1x1 resolution, and based on 1◦x1◦piControl (years 1351-1380).

- A historical climatology 

  - (1849-2015, monthly) on 2x2 degree resolution, based on the period 1850–2014 of historical.  
  - this climatology is used for histSST (and perturbations) CMIP6 simulations (165 year long simulations).  
 
- A scenario ssp3-7.0 climatology

  - (2014–2101, monthly) on 2x2 resolution, based on years 2015-2100 of ssp3-7.0.  
  - this climatology is used for ssp370SST simulations (86 year longsimulations).  
  - the climatologies for piClim-control have been based on a 30-year snapshot of piControl (year 1751–1780 and 1351–1380 as mentioned above).  
  - for comparison of piClim-control and piControl, one should focus on those 30-year periods, due to inter-decadal variability or drifts in piControl  
  
  
  
