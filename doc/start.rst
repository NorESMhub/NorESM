.. _start:


Introduction
=============

NorESM2 User's Guide
^^^^^^^^^^^^^^^^^^^^

This guide instructs both novice and experienced users on building and running NorESM2 for various experiment set ups. The chapters attempt to provide relatively detailed information on how to make, set up, build, run and modify experiments using NorESM2.


NorESM2
^^^^^^^^
The Norwegian Earth System Model version 2 (NorESM2) is an coupled Earth System Model developed by the Norwegian Climate  Consortium (NCC). NorESM2 is based on the second version of the Community Earth System Model, CESM2 (http://www.cesm.ucar.edu/models/cesm2/), developed and operated at the National Center for Atmospheric Research (NCAR), Boulder, US. 

The NorESM specific development is led by the Norwegian Meteorological Institute and NORCE Norwegian Research Centre AS. Other partners involved are the University of Oslo (UiO), CICERO, Nansen Environmental and Remote Sensing Center (NERSC) and the University of Bergen (UiB). 

NorESM2 specific additions to CESM2 includes (but is not limited to):
++++++++++++++++++

- Atmosphere model : CAM6-Nor replaces standard CAM

  - Atmospheric chemistry/aerosol/cloud module: OsloAero6  (Kirkevåg et al. GMD, 2018)
  - Atmospheric dynamics/physics: Improved conservation of energy and angular momentum (Toniazzo et al. GMD, 2020)
  - Parameterization of turbulent air-sea fluxes (see :ref:`amips` for more details)
  
- Sea-ice model:

  - Wind drift of snow
- Ocean model : Isopycnic coordinate model BLOM 
- Ocean biogeochemical model : iHAMOCC

  - HAMburg Ocean Carbon Cycle model (HAMOCC) adopted for use with the isopycnic ocean model BLOM and further developed (Tjiputra et al. GMD, 2020)

For a short description of the model components, please see :ref:`model-description`

Ocean model component in NorESM2:
'''''''''''''''''''''''''''''''''
BLOM/iHAMOCC replaces MICOM/HAMOCC as the combined physical and biogeochemical ocean model component in NorESM2. BLOM/iHAMOCC is publically available soure code licensed under a LGPLv3 license, but is otherwise a direct descendant of the MICOM/HAMOCC model component. New applications of NorESM2 will only use BLOM/iHAMOCC, but older data sets may still refer to MICOM/HAMOCC.


NorESM2 exists in three versions:
++++++++++++++++

- **NorESM2-MM**
   
  - 1 degree resolution for all model components
   
- **NorESM2-LM**
 
  - 2 degree resolution for the atmosphere and land components
  - 1 degree resolution for the ocean and sea-ice components
  - CO2 concentration driven (default)
  
- **NorESM2-MH**
 
  - 1 degree resolution for the atmosphere and land components
  - 0.25 degree resolution for the ocean and sea-ice components

   
NorESM2 can be run in emission driven mode for interactive carbon-cycle
studies. Currently, this configuration is only supported for the
LM-resolution

| NorESM2 contributes to the 6th phase of the Coupled Model Intercomparison Project (CMIP6):   
| https://www.wcrp-climate.org/wgcm-cmip/wgcm-cmip6   
| 
| Scientific documentation in the GMD – Special issue "The Norwegian Earth System Model: NorESM":     
| http://www.geosci-model-dev.net/special_issue20.html     
| 
| NorESM1 Documentation is found here: https://noresm-docs.readthedocs.io/en/noresm1/  




References
^^^^^^
Seland, Ø., Bentsen, M., Seland Graff, L., Olivié, D., Toniazzo, T., Gjermundsen, A., Debernard, J. B., Gupta, A. K., He, Y., Kirkevåg, A., Schwinger, J., Tjiputra, J., Schancke Aas, K., Bethke, I., Fan, Y., Griesfeller, J., Grini, A., Guo, C., Ilicak, M., Hafsahl Karset, I. H., Landgren, O., Liakka, J., Onsum Moseid, K., Nummelin, A., Spensberger, C., Tang, H., Zhang, Z., Heinze, C., Iverson, T., and Schulz, M.: The Norwegian Earth System Model, NorESM2 – Evaluation of theCMIP6 DECK and historical simulations, Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-378, in review, 2020.

Tjiputra, J. F., Schwinger, J., Bentsen, M., Morée, A. L., Gao, S., Bethke, I., Heinze, C., Goris, N., Gupta, A., He, Y.-C., Olivié, D., Seland, Ø., and Schulz, M.: Ocean biogeochemistry in the Norwegian Earth System Model version 2 (NorESM2), Geosci. Model Dev., 13, 2393–2431, https://doi.org/10.5194/gmd-13-2393-2020, 2020.

Toniazzo, T., Bentsen, M., Craig, C., Eaton, B. E., Edwards, J., Goldhaber, S., Jablonowski, C., and Lauritzen, P. H.: Enforcing conservation of axial angular momentum in the atmospheric general circulation model CAM6, Geosci. Model Dev., 13, 685–705, https://doi.org/10.5194/gmd-13-685-2020, 2020.

Kirkevåg, A., Grini, A., Olivié, D., Seland, Ø., Alterskjær, K., Hummel, M., Karset, I. H. H., Lewinschal, A., Liu, X., Makkonen, R., Bethke, I., Griesfeller, J., Schulz, M., and Iversen, T.: A production-tagged aerosol module for Earth system models, OsloAero5.3 – extensions and updates for CAM5.3-Oslo, Geosci. Model Dev., 11, 3945–3982, https://doi.org/10.5194/gmd-11-3945-2018, 2018.

.. bibliography:: references_noresm.bib
   :cited:
   :style: unsrt
