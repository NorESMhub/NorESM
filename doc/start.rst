.. _start:


Introduction
=============


NorESM2 User's Guide
^^^^^^^^^^^^^^^^^^^^

This guide instructs both novice and experienced users on building and running NorESM2 for various experiment set ups. The chapters attempt to provide relatively detailed information about how to make, set up, build, run and modify experiments using NorESM2.


NorESM2
^^^^^^^^
The Norwegian Earth System Model version 2 (NorESM2) is an coupled Earth System Model developed by the Norwegian Climate  Consortium (NCC). NorESM2 is based on the second version of the Community Earth System Model, CESM2 (http://www.cesm.ucar.edu/models/cesm2/), developed and operated at the National Center for Atmospheric Research (NCAR), Boulder, US. 

The NorESM specific development is led by the Norwegian Meteorological Institute and NORCE Norwegian Research Centre AS. Other partners involved are the University of Oslo (UiO), CICERO, Nansen Environmental and Remote Sensing Center (NERSC) and the University of Bergen (UiB). 

**NorESM2 specific additions to CESM2 includes (but is not limited to):**

- Atmosphere model : CAM6-Nor replaces standard CAM

  - Atmospheric chemistry/aerosol/cloud module: OsloAero6  (Kirkevåg et al. GMD, 2018)
  - Atmospheric dynamics/physics: Improved conservation of energy and angular momentum (Toniazzo et al. GMD, 2020)
  - Parameterization of turbulent air-sea fluxes (see :ref:`amips` for mode details)
  
- Sea-ice model:

  - Wind drift of snow
- Ocean model : Isopycnic coordinate model BLOM (see :ref:`omips` for mode details)
- Ocean biogeochemical model : iHAMOCC (see :ref:`omips` for mode details)

For a short description of the model components, please see :ref:`model-description`


**NorESM2 exists in three versions:**
 
- NorESM2-MM
   
  - 1 degree resolution for all model components
  - CO2 concentration driven
   
- NorESM2-MM
 
  - 2 degree resolution for the atmosphere and land components
  - 1 degree resolution for the ocean and sea-ice components
  - CO2 concentration driven
 
- NorESM2-LME
    
  - 2 degree resolution for the atmosphere and land components
  - 1 degree resolution for the ocean and sea-ice components
  - CO2 emission driven, used for interactive carbon-cycle studies
   
 
| NorESM2 contributes to the 6th phase of the Coupled Model Intercomparison Project (CMIP6).
| https://www.wcrp-climate.org/wgcm-cmip/wgcm-cmip6
| 
| Scientific documentation in the GMD – Special issue "The Norwegian Earth System Model: NorESM"  
| http://www.geosci-model-dev.net/special_issue20.html  
| 
| 
| NorESM1 Documentation is found here:  
| https://noresm-docs.readthedocs.io/en/noresm1/



CMIP6 archive of NorESM results
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
For a detailed overview on how and where to access NorESM data please see :ref:`data`



.. bibliography:: references_noresm.bib
   :cited:
   :style: unsrt
