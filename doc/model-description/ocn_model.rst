.. _ocn_model:

The ocean model
=====================


The ocean component Bergen Layered Ocean Model (**BLOM**; Bentsen et al., 2020, *in prep.*) employs an isopycnic vertical coordinate, with near-isopycnic interior layers and variable density layers in the surface mixed boundary layer. BLOM originates from the Miami Isopycnic Coordinate Ocean Model (MICOM; Bleck and Smith, 1990; Bleck et al., 1992), with largely modified codes compared to the original MICOM (Bentsen, 2013; 2020, *in prep.*). 

- **C-grid discretization:**
  BLOM uses a C-grid discretization with 51 isopycnic layers referenced at 2000 dbar, and a surface mixed layer divided into two non-isopycnic layers. A tripolar grid is used instead of the bipolar grid in CMIP5 version of NorESM1, allowing for approximately a doubling of the model time step. For the CMIP6 configuration of NorESM, the BLOM grid resolution is 1° zonally and 1/4° meridionally at the equator, gradually approaching more isotropic grid cells at higher latitudes. The model bathymetry is found by averaging the S2004 (Marks and Smith, 2006) data points contained in each model grid cell with additional editing of sills and passages to their actual depths. The metric scale factors are edited to the realistic width of the Strait of Gibraltar so that strong velocity shears can be formed, enabling realistic mixing of Mediterranean water entering the Atlantic Ocean.                                                                                                  
  


- **Vertical shear-induced mixing:**   
  A second-order turbulence closure (k-ε model) is now used for vertical shear-induced mixing, replacing a parameterisation using the local gradient Richardson number according to Large et al. (1994).                                          
  


- **Mesoscale eddy-induced transport:**   
  The parameterisation of mesoscale eddy-induced transport is modified to more faithfully comply with the Gent and McWilliams (1990) formulation. The estimation of diffusivity for eddy-induced transport and isopycnic eddy diffusion of tracers is based on the Eden et al. (2009) implementation of Eden and Greatbatch (2008) with their diagnostic equation for the eddy length scale, but modified to give a spatially smoother and generally reduced diffusivity. The isopycnal eddy diffusivity is set equal to the thickness diffusivity.                                                                                                                                                                                                          



- **Mixed layer physics:** 
  Mixed layer physics have been improved compared to the CMIP5 version of NorESM1, in part to enable sub-diurnal coupling of the ocean. The hourly coupling now used has made it possible to add additional energy sources for upper ocean vertical mixing such as wind work on near-inertial motions and surface turbulent kinetic energy source due to wind stirring to the k-ε model.
                                                                                                                              
                                                                                                                             

- **Mixing in gravity currents:**
  To achieve more realistic mixing in gravity currents, the layer thickness at velocity points has been redefined and realistic channel widths are used (e.g., Strait of Gibraltar).                                                                 
  


- **Absorption of shortwave radiation:**  
  The penetration profile of shortwave radiation is modified, leading to a shallower absorption in NorESM2 compared to NorESM1.                                                                                                                  


  
- **Salinity dependent seawater freezing temperature:**
  With respect to coupling to the sea ice model, BLOM and CICE now use a consistent salinity dependent seawater freezing temperature (Assur, 1958). Selective damping of external inertia–gravity waves in shallow regions is enabled to mitigate an issue with unphysical oceanic variability in high latitude shelf regions, causing excessive sea ice formation due to breakup and ridging in CMIP5 versions of NorESM1.                                                
  



References
^^^^^^
Assur, A.: “Composition of Sea Ice and its Tensile Strength,” pp. 106–138, in Arctic Sea Ice, U.S. National Academy of Sciences-National Research Council Pub. 598, 1958.

Bentsen, M., Bethke, I., Debernard, J. B., Iversen, T., Kirkevåg, A., Seland, Ø., Drange, H., Roelandt, C., Seierstad, I. A., Hoose, C., and Kristjánsson, J. E.: The Norwegian Earth System Model, NorESM1-M – Part 1: Description and basic evaluation of the physical climate, Geosci. Model Dev., 6, 687–720, https://doi.org/10.5194/gmd-6-687-2013, 2013.

Bleck, R., Smith, L. T.: A wind‐driven isopycnic coordinate model of the north and equatorial Atlantic Ocean: 1. Model development and supporting experiments. J. Geophys. Res., 95C, 3273–3285, https://doi.org/10.1029/JC095iC03p03273, 1990.

Bleck, R., Rooth, C., Hu, D., and Smith, L. T.: Salinity-driven Thermocline Transients in a Wind- and Thermohaline-forced Isopycnic Coordinate Model of the North Atlantic. J. Phys. Oceanogr., 22, 1486–1505, https://doi.org/10.1175/1520-0485(1992)0222.0.CO;2, 1992.

Eden, C. and Greatbatch, R. J.: Towards a mesoscale eddy closure, Ocean Model., 20, 223–239, https://doi.org/10.1016/j.ocemod.2007.09.002, 2008.

Eden, C., Jochum, M., and Danabasoglu, G.: Effects of different closures for thickness diffusivity, Ocean Model., 26, 47–59, https://doi.org/10.1016/j.ocemod.2008.08.004, 2009.

Gent, P. R., and Mcwilliams, J. C.: Isopycnal Mixing in Ocean Circulation Models. J. Phys. Oceanogr., 20, 150–155, https://doi.org/10.1175/1520-0485(1990)020<0150:IMIOCM>2.0.CO;2, 1990.

Large, W. G., McWilliams, J. C., and Doney, S. C.: Oceanic vertical mixing: a review and a model with a nonlocal boundary layer parameterization, Rev. Geophys., 32, 363–403, 1994.

Marks, K. and Smith, W.: An evaluation of publicly available global bathymetry grids, Mar. Geophys. Res., 27, 19–34, https://doi.org/10.1007/s11001-005-2095-4, 2006.

