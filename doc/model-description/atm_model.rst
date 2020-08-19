.. _atm_model:

The atmosphere model
=============================

The atmospheric model component of NorESM2, **CAM6-Nor**, (Seland et al., in review for GMD) is built on the CAM6 version from CESM2.1, but with particulate aerosols and the aerosol-radiation-cloud interaction parameterisation from NorESM1 and NorESM1.2 as described by Kirkevåg et al. (2013, 2018). NorESM2-specific changes to model physics and dynamics which are not aerosol related, are described by Toniazzo et al. (2019) and Toniazzo et al. (in prep.). The latest updates in the aerosol modules (that is, the changes between NorESM1.2 and NorESM2) are described by Olivié et al. (in prep.).

One particular part of the CAM6-Nor which is not described in great detail in any of the most recent papers (2020) is the offline sectional aerosol model AeroTab6. This is based on AeroTab5.3 (Kirkevåg et al., 2018), but uses updated complex refractive indexes for mineral dust for wavelengths below 15 μm, changed according to recent research (for details, see Olivié et al. (in prep.). A user guide for this model code is found here: https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf, see also the chapter about aerosol specific input data in Sect 5.3 of https://noresm-docs.readthedocs.io/en/noresm2/configurations/input.html.



 
References
^^^^^^^^^^
Seland, Ø., Bentsen, M., Seland Graff, L., Olivié, D., Toniazzo, T., Gjermundsen, A., Debernard, J. B., Gupta, A. K., He, Y., Kirkevåg, A., Schwinger, J., Tjiputra, J., Schancke Aas, K., Bethke, I., Fan, Y., Griesfeller, J., Grini, A., Guo, C., Ilicak, M., Hafsahl Karset, I. H., Landgren, O., Liakka, J., Onsum Moseid, K., Nummelin, A., Spensberger, C., Tang, H., Zhang, Z., Heinze, C., Iverson, T., and Schulz, M.: The Norwegian Earth System Model, NorESM2 – Evaluation of theCMIP6 DECK and historical simulations, Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-378, in review, 2020.

Toniazzo, T., Bentsen, M., Craig, C., Eaton, B. E., Edwards, J., Goldhaber, S., Jablonowski, C., and Lauritzen, P. H.: Enforcing conservation of axial angular momentum in the atmospheric general circulation model CAM6, Geosci. Model Dev., 13, 685–705, https://doi.org/10.5194/gmd-13-685-2020, 2020.

Kirkevåg, A., Grini, A., Olivié, D., Seland, Ø., Alterskjær, K., Hummel, M., Karset, I. H. H., Lewinschal, A., Liu, X., Makkonen, R., Bethke, I., Griesfeller, J., Schulz, M., and Iversen, T.: A production-tagged aerosol module for Earth system models, OsloAero5.3 – extensions and updates for CAM5.3-Oslo, Geosci. Model Dev., 11, 3945–3982, https://doi.org/10.5194/gmd-11-3945-2018, 2018.
