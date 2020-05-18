.. _ocn_model:

The ocean model
=====================


The ocean component Bergen Layered Ocean Model (**BLOM**; Bentsen et al., 2020, *in prep.*) employs an isopycnic vertical coordinate, with near-isopycnic interior layers and variable density layers in the surface mixed boundary layer. BLOM originates from the Miami Isopycnic Coordinate Ocean Model (MICOM; Bleck and Smith, 1990; Bleck et al., 1992), with largely modified codes compared to the original MICOM (Bentsen, 2013; 2020, *in prep.*). 

- **C-grid discretization**  

  BLOM uses a C-grid discretization with 51 isopycnic layers referenced at 2000 dbar, and a surface mixed layer divided into two non-isopycnic layers. A tripolar grid is used instead of the bipolar grid in CMIP5 version of NorESM1, allowing for approximately a doubling of the model time step. For the CMIP6 configuration of NorESM, the BLOM grid resolution is 1° zonally and 1/4° meridionally at the equator, gradually approaching more isotropic grid cells at higher latitudes. The model bathymetry is found by averaging the S2004 (Marks and Smith, 2006) data points contained in each model grid cell with additional editing of sills and passages to their actual depths. The metric scale factors are edited to the realistic width of the Strait of Gibraltar so that strong velocity shears can be formed, enabling realistic mixing of Mediterranean water entering the Atlantic Ocean.

- **Vertical shear-induced mixing**

  A second-order turbulence closure (k-ε model) is now used for vertical shear-induced mixing, replacing a parameterisation using the local gradient Richardson number according to Large et al. (1994). 

- **Mesoscale eddy-induced transport**

  The parameterisation of mesoscale eddy-induced transport is modified to more faithfully comply with the Gent and McWilliams (1990) formulation. The estimation of diffusivity for eddy-induced transport and isopycnic eddy diffusion of tracers is based on the Eden et al. (2009) implementation of Eden and Greatbatch (2008) with their diagnostic equation for the eddy length scale, but modified to give a spatially smoother and generally reduced diffusivity. The isopycnal eddy diffusivity is set equal to the thickness diffusivity.

- **Mixed layer physics**

  Mixed layer physics have been improved compared to the CMIP5 version of NorESM1, in part to enable sub-diurnal coupling of the ocean. The hourly coupling now used has made it possible to add additional energy sources for upper ocean vertical mixing such as wind work on near-inertial motions and surface turbulent kinetic energy source due to wind stirring to the k-ε model. 

- **Mixing in gravity currents**

  To achieve more realistic mixing in gravity currents, the layer thickness at velocity points has been redefined and realistic channel widths are used (e.g., Strait of Gibraltar). 

- **Absorption of shortwave radiation**

  The penetration profile of shortwave radiation is modified, leading to a shallower absorption in NorESM2 compared to NorESM1. 

- **Salinity dependent seawater freezing temperature**

  With respect to coupling to the sea ice model, BLOM and CICE now use a consistent salinity dependent seawater freezing temperature (Assur, 1958). Selective damping of external inertia–gravity waves in shallow regions is enabled to mitigate an issue with unphysical oceanic variability in high latitude shelf regions, causing excessive sea ice formation due to breakup and ridging in CMIP5 versions of NorESM1. 


References
^^^^^^

*[references to be added..]*
