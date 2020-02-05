.. _model-description:

NorESM2 Model Description
=========================

The Norwegian Earth System Model version 2 (NorESM2; Seland et al., in review for GMD) is the second generation of the coupled Earth System Model developed by the Norwegian Climate Center (NCC), and is the successor of NorESM1 (Bentsen et al., 2013; Iversen et al., 2013; Kirkevåg et al., 2013; Tjiputra et al., 2013) which has been used in the 5th phase of the Coupled Model Intercomparison Project (CMIP5; Taylor et al., 2012), and for evaluation of the difference between a 1.5 and 2 deg. C warmer world than pre-industrial (Graff et al., 2019). NorESM2 is based on the Community Earth System Model CESM2.1 (Danabasoglu et al., 2019). Although large parts of NorESM are similar to CESM, there are several important differences: NorESM uses the isopycnic coordinate Bergen Layered Ocean Model (BLOM; Bentsen et al., in prep.), uses a different aerosol module OsloAero6 (Kirkevåg et al., 2018; Olivié et al., in prep.), contains specific modifications and tunings of the atmosphere component (Toniazzo et al., 2019; Toniazzo et al., in prep.), and contains the iHAMOCC model to describe ocean biogeochemistry (Tjiputra et al., 2019).

Many changes have contributed to the development of NorESM1 into NorESM2. The model has benefited from the evolution of the parent model CCSM4.0 into CESM2.1, comprising the change of the atmosphere component from CAM4 to CAM6, the land component from CLM4 to CLM5, and the sea ice component from CICE4 to CICE5. Also, specific developments have been implemented in the description of aerosols and their coupling to clouds and radiation (Kirkevåg et al., 2018), in addition to harmonizing the implementation of the aerosol scheme with the standard aerosol schemes in CESM. To extend the capabilities of NorESM as an Earth System Model, a strong focus has been put on the interactive description of natural emissions of aerosols and their precursors, and tightening the coupling between the different Earth System components. Finally, the ocean model (Bentsen et al., in prep.) and the ocean biogeochemistry module (Schwinger et al., 2016; Tjiputra et al., 2019) have been further developed.


The atmosphere model, CAM6-Nor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The atmospheric model component of NorESM2 (NorESM2; Seland et al., in review for GMD) is built on the CAM6 version from CESM2.1, but with particulate aerosols and the aerosol-radiation-cloud interaction parameterisation from NorESM1 and NorESM1.2 as described by Kirkevåg et al. (2013, 2018). NorESM2-specific changes to model physics and dynamics which are not aerosol related, are described by Toniazzo et al. (2019) and Toniazzo et al. (in prep.). The latest updates in the aerosol modules (that is, the changes between NorESM1.2 and NorESM2) are described by Olivié et al. (in prep.).

::

The ocean model, BLOM
~~~~~~~~~~~~~~~~~~~~~

The ocean component BLOM (Bentsen et al., in prep.) is based on the version of MICOM used in NorESM1 and shares the use of near-isopycnic interior layers and variable density layers in the surface well-mixed boundary layer.


The ocean biogeochemistry model, iHAMMOC
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ocean biogeochemistry component iHAMOCC (isopycnic coordinate HAMburg Ocean Carbon Cycle model) is an updated version of the ocean biogeochemistry module used in NorESM1. Details on the updates and improvements of the ocean biogeochemical component of NorESM2 are provided in Tjiputra et al. (2019).


The sea-ice model, CICE
~~~~~~~~~~~~~~~~~~~~~~~

The sea ice model component is based upon version 5.1.2 of the CICE sea ice model of Hunke et al. (2015). A NorESM2-
specific change is including the effect of wind drift of snow into ocean following Lecomte et al. (2013), as described in Bentsen
et al. (in prep).

The land model, CLM5
~~~~~~~~~~~~~~~~~~~~~~~

The NorESM2 land model is CLM5 (Lawrence et al., 2019) with one minor modification (Seland et al., in review for GMD). This specific modification was made to the surface water treatment in CLM. The surface water pool is a new feature replacing the wetland land unit in earlier versions of CLM (introduced in CLM4.5). This water pool does not have a frozen state, but is added to the snow-pack when frozen. To avoid water being looped between surface water and snow during alternating cold and warm periods, we remove infiltration excess water as runoff if the temperature of the surface water pool is below freezing. This was done to mitigate a positive snow bias and an artificial snow depth increase found in some Arctic locations during melting conditions.

