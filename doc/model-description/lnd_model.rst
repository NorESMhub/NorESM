.. _lnd_model:

The land model
===================
The NorESM2 employs the latest version of "Community Land Model" (CLM5; Lawrence et al., 2019) as the land component. In the CLM5, Biogeophysical and biogeochemical processes are simulated for each subgrid land unit, column, and plant functional type (PFT) independently and each subgrid unit maintains its own prognostic variables. The same atmospheric forcing is used to force all subgrid units within a grid cell. The surface variables and fluxes required by the atmosphere are obtained by averaging the subgrid quantities weighted by their fractional areas. The processes simulated include:

1. Surface characterization including land type heterogeneity and ecosystem structure
2. Absorption, reflection, and transmittance of solar radiation
3. Absorption and emission of longwave radiation
4. Momentum, sensible heat (ground and canopy), and latent heat (ground evaporation, canopy evaporation, transpiration) fluxes
5. Heat transfer in soil and snow including phase change
6. Canopy hydrology (interception, throughfall, and drip)
7. Soil hydrology (surface runoff, infiltration, redistribution of water within the column, sub-surface drainage, groundwater)
8. Snow hydrology (snow accumulation and melt, compaction, water transfer between snow layers)
9. Stomatal physiology, photosythetic capacity, and photosynthesis 
10. Plant hydraulics 
11. Lake temperatures and fluxes 
12. Glacier processes 
13. River routing and river flow 
14. Urban energy balance and climate 
15. Vegetation carbon and nitrogen allocation 
16. Vegetation phenology 
17. Plant respiration 
18. Soil and litter carbon decomposition 
19. Fixation and uptake of nitrogen
20. External nitrogen cycling including deposition, denitrification, leaching, and losses due to fire 
21. Plant mortality 
22. Fire ignition, suppression, spread, and emissions, including natural, deforestation, and agricultural fire
23. Methane production, oxidation, and emissions
24. Crop dynamics, irrigation, and fertilization
25. Land cover and land use change including wood harvest
26. Biogenic volatile organic compound emissions
27. Dust mobilization and deposition
28. Carbon isotope fractionation

The above information is available in the CLM5 technical Note. For more information, check http://www.cesm.ucar.edu/models/cesm2/land/

The **CLM5** in the NorESM2 comes with one minor modification (Seland et al., 2020 in review for GMD). This specific modification was made to the surface water treatment in CLM. The surface water pool is a new feature replacing the wetland land unit in earlier versions of CLM (introduced in CLM4.5). This water pool does not have a frozen state, but is added to the snow-pack when frozen. To avoid water being looped between surface water and snow during alternating cold and warm periods, we remove infiltration excess water as runoff if the temperature of the surface water pool is below freezing. This was done to mitigate a positive snow bias and an artificial snow depth increase found in some Arctic locations during melting conditions.

In the NorESM/CTSM repository, the master branch is forked from ECOMP/CTSM, which is the CLM version used in the CESM2, while the branch release-clm5.0.14-Nor (based on the CLM version 5.0.14) stores the CLM version used in the NorESM with the modification above. 


References
^^^^^^^^^^

Lawrence, D. M., Fisher, R. A., Koven,C. D., Oleson, K. W., Swenson, S. C.,Bonan, G., et al. (2019). TheCommunity Land Model version 5:Description of new features,benchmarking, and impact of forcinguncertainty. Journal of Advances inModeling Earth Systems,https://doi.org/10.1029/2018MS001583
