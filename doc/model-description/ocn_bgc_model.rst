.. _ocn_bgc_model:

The ocean BGC model
=======================================

The ocean biogeochemistry (BGC) component **iHAMOCC** (isopycnic coordinate HAMburg Ocean Carbon Cycle model) is an updated version of the ocean biogeochemistry module used in NorESM1. The iHAMOCC is based on the the HAMOCC5.1 model developed in Max-Planck Institute of Meteorology (Maier-Reimer et al., 2005) and was later modified for an isopycnal-coordinate ocean general circulation model (Assmann et al., 2010).

The iHAMOCC prognostically simulates five key ocean biogeochemical cycle processes:

- **1. Inorganic seawater carbon chemistry**

  The carbon chemistry formulation in iHAMOCC is based on the Ocean Carbon cycle Model Intercomparison Project (OCMIP) protocols. It computes the partial pressure of CO2 gas in surface layer (pCO2) based on the temperature, salinity, dissolved inorganic carbon and alkalinity concentrations. The pCO2 is used to estimate the air-sea CO2 fluxes. In addition to surface pCO2, water column pH, carbonate ion, and calcite saturation state are also computed.                                                                                                                         
|  
- **2. NPZD-type ecosystem module**

  In the euphotic layer of the model (top 100 m), the lower trophic ecosystem dynamic is simulated using an NPZD (Nutrient Phytoplankton Zooplankton Detritus) ecosystem module (Six and Maier-Reimer, 1996). One phytoplankton and one zooplankton bulk compartments are simulated together with multiple limiting nutrients (nitrate, phosphate, and dissolved iron), dissolved organic carbon and particulate matters. In addition nutrient, the primary production is also limited by light availability and temperature. A fixed stoichiometry Redfield Ratio is used to govern the fluxes of nutrients and carbon among the different ecosystem compartments.                                                                                                        
|  
- **3. Air-sea gas exchange**

  The air-sea gas exchange formulation according to Wanninkhof (2014) is applied to compute fluxes of CO2, O2, DMS, N2, N2O, CFC-11, CFC-12, and SF6 gases. The fluxes of these gases are computed as a function of surface wind speed, Schmidt number, gas solubility, and partial pressure difference of the respective gases. For DMS, the flux is always from the ocean to the atmosphere.                                                                                                                    
|  
- **4. Vertical fluxes of inorganic and organic particles**

  The particulate matters produced by the biological activity in the upper ocean are transported vertically and remineralized in the water column (Schwinger et al., 2018). For particulate organic carbon, the sinking speed is increased with depth while a constant remineralization rates is used throughout the water column. For biogenic silica (opal), both constant vertical sinking speed and dissolution rate are used. For particulate inorganic carbon (CaCO3), a constant sinking speed is used while the dissolution is formulated as a function of calcite saturation state.                                                                           
|  
- **5. Sediment biogeochemistry**


  A 12-layer sediment module is included in iHAMOCC (Heinze et al., 1999). It collects the sinking particle matters that are not completely dissolved or remineralized in the water column. It includes four solid sediment components (CaCO3, opal, organic carbon, and clay), and five pore water substances (dissolved inorganic carbon, alkalinity, phosphate, oxygen, and silicate). In addition to particle deposition, it simulates fluxes of tracers with the bottom-most ocean layer through pore water chemistry and diffusion.                                                                                                       
  
  

Details on the updates and improvements of the ocean biogeochemical component of NorESM2 are provided in Tjiputra et al. (2020).

References
^^^^^^^^^^
Assmann, K. M., Bentsen, M., Segschneider, J., and Heinze, C.: An isopycnic ocean carbon cycle model, Geosci. Model Dev., 3, 143–167, https://doi.org/10.5194/gmd-3-143-2010, 2010. 

Heinze, C., Maier-Reimer, E., Winguth, A. M. E., and Archer, D.:A global oceanic sediment model for long-term climate studies,Glob. Biogeochem. Cy., 13, 221–250, 1999.

Maier-Reimer, E., Kriest, I., Segschneider, J., and Wetzel, P.: TheHAMburg  Ocean  Carbon  Cycle  Model  HAMOCC5.1  –  Technical Description Release 1.1, Berichte zur Erdsystemforschung,  ISSN  1614–1199,  Max  Planck  Institute  for  Meteorology,Hamburg, Germany, 50 pp., 2005.

Schwinger,  J.,  Goris,  N.,  Tjiputra,  J.  F.,  Kriest,  I.,  Bentsen,  M.,  Bethke,  I.,  Ilicak,  M.,  Assmann,  K.  M.,  and  Heinze,  C.:  Evaluation  ofNorESM-OC (versions 1 and 1.2), the ocean carbon-cycle stand-alone configuration of the Norwegian Earth System Model (NorESM1),Geosci. Model Dev., 9, 2589-2622, https://doi.org/10.5194/gmd-9-2589-2016, 2016.

Six, K. D. and Maier-Reimer, E.: Effects of plankton dynamics onseasonal  carbon  fluxes  in  an  ocean  general  circulation  model,Global Biogeochem. Cy., 10, 559–583, 1996.

Tjiputra, J. F., Schwinger, J., Bentsen, M., Morée, A. L., Gao, S., Bethke, I., Heinze, C., Goris, N., Gupta, A., He, Y., Olivié, D., Seland, Ø., and Schulz, M.: Ocean biogeochemistry in the Norwegian Earth System Model version 2 (NorESM2), Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-347, in press, 2020.

Wanninkhof, R.: Relationship between wind speed and gas exchange over the ocean revisited, Limnol. Oceanogr.: Methods, 12, 351–362,https://doi.org/10.4319/lom.2014.12.351, 2014.
