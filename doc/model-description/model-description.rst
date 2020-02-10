.. _model-description:

NorESM2 Model Description
=========================

The Norwegian Earth System Model version 2 (NorESM2; Seland et al., in review for GMD) is the second generation of the coupled Earth System Model developed by the Norwegian Climate Center (NCC), and is the successor of NorESM1 (Bentsen et al., 2013; Iversen et al., 2013; Kirkevåg et al., 2013; Tjiputra et al., 2013) which has been used in the 5th phase of the Coupled Model Intercomparison Project (CMIP5; Taylor et al., 2012), and for evaluation of the difference between a 1.5 and 2 deg. C warmer world than pre-industrial (Graff et al., 2019). NorESM2 is based on the Community Earth System Model CESM2.1 (Danabasoglu et al., 2019). Although large parts of NorESM are similar to CESM, there are several important differences: NorESM uses the isopycnic coordinate Bergen Layered Ocean Model (BLOM; Bentsen et al., in prep.), uses a different aerosol module OsloAero6 (Kirkevåg et al., 2018; Olivié et al., in prep.), contains specific modifications and tunings of the atmosphere component (Toniazzo et al., 2019; Toniazzo et al., in prep.), and contains the iHAMOCC model to describe ocean biogeochemistry (Tjiputra et al., 2019).

Many changes have contributed to the development of NorESM1 into NorESM2. The model has benefited from the evolution of the parent model CCSM4.0 into CESM2.1, comprising the change of the atmosphere component from CAM4 to CAM6, the land component from CLM4 to CLM5, and the sea ice component from CICE4 to CICE5. Also, specific developments have been implemented in the description of aerosols and their coupling to clouds and radiation (Kirkevåg et al., 2018), in addition to harmonizing the implementation of the aerosol scheme with the standard aerosol schemes in CESM. To extend the capabilities of NorESM as an Earth System Model, a strong focus has been put on the interactive description of natural emissions of aerosols and their precursors, and tightening the coupling between the different Earth System components. Finally, the ocean model (Bentsen et al., in prep.) and the ocean biogeochemistry module (Schwinger et al., 2016; Tjiputra et al., 2019) have been further developed.


The atmosphere model, CAM6-Nor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The atmospheric model component of NorESM2 (NorESM2; Seland et al., in review for GMD) is built on the CAM6 version from CESM2.1, but with particulate aerosols and the aerosol-radiation-cloud interaction parameterisation from NorESM1 and NorESM1.2 as described by Kirkevåg et al. (2013, 2018). NorESM2-specific changes to model physics and dynamics which are not aerosol related, are described by Toniazzo et al. (2019) and Toniazzo et al. (in prep.). The latest updates in the aerosol modules (that is, the changes between NorESM1.2 and NorESM2) are described by Olivié et al. (in prep.).

One particular part of the CAM6-Nor which is not described in great detail in any of the most recent papers (2020) is the offline sectional aerosol model AeroTab6. This is based on AeroTab5.3 (Kirkevåg et al., 2018), but uses updated complex refractive indexes for mineral dust for wavelengths below 15 μm, changed according to recent research (for details, see Olivié et al. (in prep.). A user guide for this model code will soon appear under the Configurations chapter.

::

The ocean model, BLOM
~~~~~~~~~~~~~~~~~~~~~

The ocean component BLOM (Bentsen et al., in prep.) is based on the version of MICOM used in NorESM1 and shares the use of near-isopycnic interior layers and variable density layers in the surface well-mixed boundary layer.

::

The ocean biogeochemistry model, iHAMMOC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ocean biogeochemistry component iHAMOCC (isopycnic coordinate HAMburg Ocean Carbon Cycle model) is an updated version of the ocean biogeochemistry module used in NorESM1. Details on the updates and improvements of the ocean biogeochemical component of NorESM2 are provided in Tjiputra et al. (2019).

::

The sea-ice model, CICE
~~~~~~~~~~~~~~~~~~~~~~~

The sea ice model component is based upon version 5.1.2 of the CICE sea ice model of Hunke et al. (2015). A NorESM2-
specific change is including the effect of wind drift of snow into ocean following Lecomte et al. (2013), as described in Bentsen
et al. (in prep).

::

The land model, CLM5
~~~~~~~~~~~~~~~~~~~~~~~

The NorESM2 land model is CLM5 (Lawrence et al., 2019) with one minor modification (Seland et al., in review for GMD). This specific modification was made to the surface water treatment in CLM. The surface water pool is a new feature replacing the wetland land unit in earlier versions of CLM (introduced in CLM4.5). This water pool does not have a frozen state, but is added to the snow-pack when frozen. To avoid water being looped between surface water and snow during alternating cold and warm periods, we remove infiltration excess water as runoff if the temperature of the surface water pool is below freezing. This was done to mitigate a positive snow bias and an artificial snow depth increase found in some Arctic locations during melting conditions.

::

The coupler, CIME
~~~~~~~~~~~~~~~~~

The state and flux exchanges between model components and software infrastructure for configuring, building and execution of model experiments is handled by the CESM2 coupler Common Infrastructure for Modeling the Earth (CIME; Danabasoglu et al., 2019). Among the common utility functions CIME provides is the  estimation of solar zenith angle. In NorESM2, this utility function is modified with associated changes in atmosphere, land and sea ice components, ensuring that all albedo calculations use zenith angle averaged over the components time-step instead of instantaneous angles.

References
~~~~~~~~~~~

Bentsen, M., Bethke, I., Debernard, J. B., Iversen, T., Kirkevåg, A., Seland, Ø., Drange, H., Roelandt, C., Seierstad, I. A., Hoose, C., and Kristjánsson, J. E.: The Norwegian Earth System Model, NorESM1-M – Part 1: Description and basic evaluation of the physical climate,
Geoscientific Model Development, 6, 687–720, https://www.geosci-model-dev.net/6/687/2013/,
2013.

Danabasoglu, G., Lamarque, J.-F., Bacmeister, J., Bailey, D. A., DuVivier, A. K., Edwards, J., Emmons, L. K., Fasullo, J., Garcia, R.,
Gettelman, A., Hannay, C., Holland, M. M., Large, W. G., Lawrence, D. M., Lenaerts, J. T. M., Lindsay, K., Lipscomb, W. H., Mills,
M. J., Neale, R., Oleson, K. W., Otto-Bliesner, B., Phillips, A. S., Sacks, W., Tilmes, S., van Kampenhout, L., Vertenstein, M., Bertini, A., Dennis, J., Deser, C., Fischer, C., Fox-Kemper, B., Kay, J. E., Kinnison, D., Kushner, P. J., Long, M. C., Mickelson, S., Moore, J. K., Nienhouse, E., Polvani, L., Rasch, P. J., and Strand, W. G.: The Community Earth System Model version 2 (CESM2), Submitted to J. Adv. Model. Earth Syst., 2019.

Graff, L. S., Iversen, T., Bethke, I., Debernard, J. B., Seland, Ø., Bentsen, M., Kirkevåg, A., Li, C., and Olivié, D. J. L.: Arctic amplification under global warming of 1.5 and 2 ◦C in NorESM1-Happi, Earth System Dynamics, 10, 569–598, https://www.earth-syst-dynam.net/10/569/2019/, 2019.

Hunke, E. C., Lipscomb, W. H., Turner, A. K., Jeffery, N., and Elliott, S.: CICE: the Los Alamos Sea Ice Model Documentation and
Software User’s Manual Version 5.1, Tech. Rep. LA-CC-06-012, Los Alamos National Laboratory, Los Alamos, New Mexico, USA,
https://github.com/CICE-Consortium/CICE-svn-trunk/releases/tag/cice-5.1.2, 2015.

Iversen, T., Bentsen, M., Bethke, I., Debernard, J. B., Kirkevåg, A., Seland, Ø., Drange, H., Kristjansson, J. E., Medhaug, I., Sand, M., and Seierstad, I. A.: The Norwegian Earth System Model, NorESM1-M – Part 2: Climate response and scenario projections, Geoscientific
Model Development, 6, 389–415, https://doi.org/10.5194/gmd-6-389-2013, 2013.

Kirkevåg, A., Iversen, T., Seland, Ø., Hoose, C., Kristjánsson, J. E., Struthers, H., Ekman, A. M. L., Ghan, S., Griesfeller, J., Nilsson, E. D., and Schulz, M.: Aerosol–climate interactions in the Norwegian Earth System Model – NorESM1-M, Geoscientific Model Development, 6, 207–244, https://doi.org/10.5194/gmd-6-207-2013, 2013.

Kirkevåg, A., Grini, A., Olivié, D., Seland, Ø., Alterskjær, K., Hummel, M., Karset, I. H. H., Lewinschal, A., Liu, X., Makkonen, R., Bethke, I., Griesfeller, J., Schulz, M., and Iversen, T.: A production-tagged aerosol module for Earth system models, OsloAero5.3 – extensions and updates for CAM5.3-Oslo, Geoscientific Model Development, 11, 3945–3982, https://doi.org/10.5194/gmd-11-3945-2018, 2018.

Lawrence, D. M., Fisher, R. A., Koven, C. D., Oleson, K. W., Swenson, S. C., Bonan, G., Collier, N., Ghimire, B., van Kampenhout, L.,
Kennedy, D., Kluzek, E., Lawrence, P. J., Li, F., Li, H., Lombardozzi, D., Riley, W. J., Sacks, W. J., Shi, M., Vertenstein, M., Wieder,
W. R., Xu, C., Ali, A. A., Badger, A. M., Bisht, G., van den Broeke, M., Brunke, M. A., Burns, S. P., Buzan, J., Clark, M., Craig,
A., Dahlin, K., Drewniak, B., Fisher, J. B., Flanner, M., Fox, A. M., Gentine, P., Hoffman, F., Keppel-Aleks, G., Knox, R., Kumar, S.,
Lenaerts, J., Leung, L. R., Lipscomb, W. H., Lu, Y., Pandey, A., Pelletier, J. D., Perket, J., Randerson, J. T., Ricciuto, D. M., Sanderson, B. M., Slater, A., Subin, Z. M., Tang, J., Thomas, R. Q., Val Martin, M., and Zeng, X.: The Community Land Model Version 5:
Description of New Features, Benchmarking, and Impact of Forcing Uncertainty, Journal of Advances in Modeling Earth Systems, n/a,
https://doi.org/10.1029/2018MS001583, 2019.

Lecomte, O., Fichefet, T., Vancoppenolle, M., Domine, F., Massonnet, F., Mathiot, P., Morin, S., and Barriat, P. Y.: On the formu-
lation of snow thermal conductivity in large-scale sea ice models, Journal of Advances in Modeling Earth Systems, 5, 542–557,
https://doi.org/10.1002/jame.20039, 2013.

Schwinger, J., Goris, N., Tjiputra, J. F., Kriest, I., Bentsen, M., Bethke, I., Ilicak, M., Assmann, K. M., and Heinze, C.: Evaluation of NorESM-OC (versions 1 and 1.2), the ocean carbon-cycle stand-alone configuration of the Norwegian Earth System Model (NorESM1),
Geoscientific Model Development, 9, 2589–2622, https://doi.org/10.5194/gmd-9-2589-2016, 2016.

Seland, Ø., Bentsen, M., Seland Graff, L., Olivié, D., Toniazzo, T., Gjermundsen, A., Debernard, J. B., Gupta, A. K., He, Y., Kirkevåg, A., Schwinger, J., Tjiputra, J., Schancke Aas, K., Bethke, I., Fan, Y., Griesfeller, J., Grini, A., Guo, C., Ilicak, M., Hafsahl Karset, I. H., Landgren, O., Liakka, J., Onsum Moseid, K., Nummelin, A., Spensberger, C., Tang, H., Zhang, Z., Heinze, C., Iverson, T., and Schulz, M.: The Norwegian Earth System Model, NorESM2 – Evaluation of theCMIP6 DECK and historical simulations, Geosci. Model Dev. Discuss., https://www.geosci-model-dev-discuss.net/gmd-2019-378/, 2020.

Tjiputra, J. F., Schwinger, J., Bentsen, M., Morée, A. L., Gao, S., Bethke, I., Heinze, C., Goris, N., Gupta, A., He, Y., Olivié, D., Seland, Ø., and Schulz, M.: Ocean biogeochemistry in the Norwegian Earth System Model version 2 (NorESM2), Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-347, in review, 2020.

Toniazzo, T., Bentsen, M., Craig, C., Eaton, B., Edwards, J., Goldhaber, J., Jablonowski, C., and Lauritzen, P. J.: Enforcing con-
servation of axial angular momentum in the atmospheric general circulation model CAM6, Geosc. Model Devel. Discussions,
https://doi.org/10.5194/gmd-2019-254, 2019.
