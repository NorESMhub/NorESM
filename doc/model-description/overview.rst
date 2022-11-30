.. _overview:

Overview
=========================

The Norwegian Earth System Model version 2 (NorESM2; Seland et al. 2020) is the second generation of the coupled Earth System Model developed by the Norwegian Climate Center (NCC), and is the successor of NorESM1 (Bentsen et al., 2013; Iversen et al., 2013; Kirkevåg et al., 2013; Tjiputra et al., 2013) which has been used in the 5th phase of the Coupled Model Intercomparison Project (CMIP5; Taylor et al., 2012), and for evaluation of the difference between a 1.5 and 2 deg. C warmer world than pre-industrial (Graff et al., 2019). NorESM2 is based on the Community Earth System Model CESM2.1 (Danabasoglu et al., 2019). Although large parts of NorESM are similar to CESM, there are several important differences: NorESM uses the isopycnic coordinate Bergen Layered Ocean Model (BLOM; Bentsen et al., in prep.), uses a different aerosol module OsloAero6 (Kirkevåg et al., 2018; Olivié et al., in prep.), contains specific modifications and tunings of the atmosphere component (Toniazzo et al., 2019; Toniazzo et al., in prep.), and contains the iHAMOCC model to describe ocean biogeochemistry (Tjiputra et al., 2020). The use of different ocean components results in very different climate sensitivities in NorESM2 and CESM2 (Gjermundsen et al. 2021). 

Many changes have contributed to the development of NorESM1 into NorESM2. The model has benefited from the evolution of the parent model CCSM4.0 into CESM2.1, comprising the change of the atmosphere component from CAM4 to CAM6, the land component from CLM4 to CLM5, and the sea ice component from CICE4 to CICE5. Also, specific developments have been implemented in the description of aerosols and their coupling to clouds and radiation (Kirkevåg et al., 2018), in addition to harmonizing the implementation of the aerosol scheme with the standard aerosol schemes in CESM. To extend the capabilities of NorESM as an Earth System Model, a strong focus has been put on the interactive description of natural emissions of aerosols and their precursors, and tightening the coupling between the different Earth System components. Coupling with the land ice component CISM is under development. Finally, the ocean model (Bentsen et al., in prep.) and the ocean biogeochemistry module (Schwinger et al., 2016; Tjiputra et al., 2020) have been further developed.

References
^^^^^^^^^^
Seland, Ø., Bentsen, M., Olivié, D., Toniazzo, T., Gjermundsen, A., Graff, L. S., Debernard, J. B., Gupta, A. K., He, Y.-C., Kirkevåg, A., Schwinger, J., Tjiputra, J., Aas, K. S., Bethke, I., Fan, Y., Griesfeller, J., Grini, A., Guo, C., Ilicak, M., Karset, I. H. H., Landgren, O., Liakka, J., Moseid, K. O., Nummelin, A., Spensberger, C., Tang, H., Zhang, Z., Heinze, C., Iversen, T., and Schulz, M.: Overview of the Norwegian Earth System Model (NorESM2) and key climate response of CMIP6 DECK, historical, and scenario simulations, Geosci. Model Dev., 13, 6165–6200, https://doi.org/10.5194/gmd-13-6165-2020, 2020.

Tjiputra, J. F., Schwinger, J., Bentsen, M., Morée, A. L., Gao, S., Bethke, I., Heinze, C., Goris, N., Gupta, A., He, Y.-C., Olivié, D., Seland, Ø., and Schulz, M.: Ocean biogeochemistry in the Norwegian Earth System Model version 2 (NorESM2), Geosci. Model Dev., 13, 2393–2431, https://doi.org/10.5194/gmd-13-2393-2020, 2020.

Gjermundsen, A., Nummelin, A., Olivié, D. et al. Shutdown of Southern Ocean convection controls long-term greenhouse gas-induced warming. Nat. Geosci. https://doi.org/10.1038/s41561-021-00825-x, 2021.

Schwinger, J., Goris, N., Tjiputra, J. F., Kriest, I., Bentsen, M., Bethke, I., Ilicak, M., Assmann, K. M., and Heinze, C.: Evaluation of NorESM-OC (versions 1 and 1.2), the ocean carbon-cycle stand-alone configuration of the Norwegian Earth System Model (NorESM1),
Geoscientific Model Development, 9, 2589–2622, https://doi.org/10.5194/gmd-9-2589-2016, 2016.

Graff, L. S., Iversen, T., Bethke, I., Debernard, J. B., Seland, Ø., Bentsen, M., Kirkevåg, A., Li, C., and Olivié, D. J. L.: Arctic amplification under global warming of 1.5 and 2 ◦C in NorESM1-Happi, Earth System Dynamics, 10, 569–598, https://www.earth-syst-dynam.net/10/569/2019/, 2019.

Toniazzo, T., Bentsen, M., Craig, C., Eaton, B., Edwards, J., Goldhaber, J., Jablonowski, C., and Lauritzen, P. J.: Enforcing con-
servation of axial angular momentum in the atmospheric general circulation model CAM6, Geosc. Model Devel. Discussions,
https://doi.org/10.5194/gmd-2019-254, 2019.

Bentsen, M., Bethke, I., Debernard, J. B., Iversen, T., Kirkevåg, A., Seland, Ø., Drange, H., Roelandt, C., Seierstad, I. A., Hoose, C., and Kristjánsson, J. E.: The Norwegian Earth System Model, NorESM1-M – Part 1: Description and basic evaluation of the physical climate,
Geoscientific Model Development, 6, 687–720, https://www.geosci-model-dev.net/6/687/2013/,
2013.

Kirkevåg, A., Iversen, T., Seland, Ø., Hoose, C., Kristjánsson, J. E., Struthers, H., Ekman, A. M. L., Ghan, S., Griesfeller, J., Nilsson, E. D., and Schulz, M.: Aerosol–climate interactions in the Norwegian Earth System Model – NorESM1-M, Geoscientific Model Development, 6, 207–244, https://doi.org/10.5194/gmd-6-207-2013, 2013.

Kirkevåg, A., Grini, A., Olivié, D., Seland, Ø., Alterskjær, K., Hummel, M., Karset, I. H. H., Lewinschal, A., Liu, X., Makkonen, R., Bethke, I., Griesfeller, J., Schulz, M., and Iversen, T.: A production-tagged aerosol module for Earth system models, OsloAero5.3 – extensions and updates for CAM5.3-Oslo, Geoscientific Model Development, 11, 3945–3982, https://doi.org/10.5194/gmd-11-3945-2018, 2018.

Danabasoglu, G., Lamarque, J.-F., Bacmeister, J., Bailey, D. A., DuVivier, A. K., Edwards, J., Emmons, L. K., Fasullo, J., Garcia, R.,
Gettelman, A., Hannay, C., Holland, M. M., Large, W. G., Lawrence, D. M., Lenaerts, J. T. M., Lindsay, K., Lipscomb, W. H., Mills,
M. J., Neale, R., Oleson, K. W., Otto-Bliesner, B., Phillips, A. S., Sacks, W., Tilmes, S., van Kampenhout, L., Vertenstein, M., Bertini, A., Dennis, J., Deser, C., Fischer, C., Fox-Kemper, B., Kay, J. E., Kinnison, D., Kushner, P. J., Long, M. C., Mickelson, S., Moore, J. K., Nienhouse, E., Polvani, L., Rasch, P. J., and Strand, W. G.: The Community Earth System Model version 2 (CESM2), Submitted to J. Adv. Model. Earth Syst., 2019.

