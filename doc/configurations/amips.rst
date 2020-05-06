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


NorESM2-derived boundary conditions for AMIP-style simulations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

While the prescribed values used in atmosphere-only simulations are often based on observations, one might also want to use valies that resemble those from a fully-coupled simulation with NorESM2. To achieve this, it is necessary to use prescribed boundary conditions for SST, sea-ice cover and upper-ocean DMS concentrations (all three fields taken from the fully-coupled simulation). Up to now, 4 sets of boundary conditions have been made:

- a pre-industrial climatology with 2-degree resolution 
   - 2x2 degree resolution in the horizontal
   - contains 12 monthly values
   - based on a 30-year period (years 1751–1780) from the CMIP6 pre-industrial control (piControl) simulation with 2x2 degree resolution (NorESM2-LM).  
   - was used for the CMIP6 simulation piClim-control, and all simulations that are perturbation runs based on piClim-control, with NorESM2-LM (mostly 30-year long simulations) 
  
- a pre-industrial climatology with 1-degree resolution: as above but on 1x1 resolution in the horizontal, and based on years 1351-1380 from the CMIP6 piControl simulation with 1x1 degree resolution (NorESM2-MM)

- the historical period 
   - 2x2 degree resolution in the horizontal
   - contains monthly values for years 1849-20155
   - based on the period 1850–2014 from the CMIP6 historical simulation with 2x2 degree resolution (NorESM2-LM).  
   - was used for the CMIP6 simulation histSST, and all simulations that are perturbation runs based on sstHIST, with NorESM2-LM (165-year long simulations). 
 
- a future period based on SSP3-7.0
   - 2x2 degree resolution in the horizontal
   - contains monthly values for years 2014-2101
   - based on years 2015-2100 frm the CMIP6 SSP3-7.0 simulation with 2-degree resolution (NorESM2-LM).  
   - was used for the CMIP6 simulation ssp370SST, and all simulations that are perturbation runs based on ssp370SST, with NorESM2-LM (86-year longs imulations).  
   - for comparison of piClim-control and piControl, one should focus on the 30-year periods mentioned above (year 1751–1780 and 1351–1380 ) due to inter-decadal variability and/or drifts in piControl  


Another thing that must be kept in mind when doing AMIP-style simulations that should resemble the coupled NorESM2 climate as closely as possible is the choice of flux parameterization used for the transfer of heat, moisture and momentum between the ocean and atmosphere, the so-called COARE flux parameterization. The flux parameterization is controlled by the variable **OCN_FLUX_SCHEME** in the env_run.xml file. The standard choice in CESM is::

  OCN_FLUX_SCHEME=0 

This parameterisation is different from the standard flux parameterization used in NorESM2, which is activated by::

  OCN_FLUX_SCHEME=1.
  
and ends up in the drv_in namelist as::

  flux_scheme=1. 
  
  
  
