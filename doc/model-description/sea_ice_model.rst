.. _cea_ice_model:

The sea-ice model
======================

The sea ice model component is based upon version 5.1.2 of the **CICE** sea ice model of Hunke et al. (2015). A NorESM2-specific change is including the effect of wind drift of snow into ocean following Lecomte et al. (2013), as described in Bentsen et al. (in prep). The NorESM version is also equipped with the possibility to modify snow density and snow thermal conductivity in the namelist. 




For more detailed documentation about the CICE model, please see:  http://www.cesm.ucar.edu/models/cesm2/sea-ice/
 
 
Main features of the CICE configuration in NorESM2 and differences from NorESM1
--------------------------------------------------------------------------------

1. Same horizontal tripolar grid as the ocean model (BLOM)
2. The discretization of the sea ice thickness distribution uses 5 thickness categories.
#. EVP dynamics
#. 8 sea ice layers and 3 snow layers in the vertical 
#. Mushy layer thermodynamics with prognostic internal energy and salinity within the sea ice (Turner and Hunke, 2015).
#. Delta-Eddington shortwave radiation 
#. Melt ponds are allowed to form on undeformed ice (Hunke et al 2013). 
#. Freezing point of sea water is salinity dependent and based on Assur (1958). The treatment is consistent between the internal mushy-layer thermodynamics, the sea ice - ocean interface, and open water sea ice growth (calculated in the ocean component). 




References
^^^^^^^^^^

Assur, A.. Composition of sea ice and its tensile strength. In Arctic sea ice; conference held at Easton, Maryland, February 24–27, 1958, volume 598, pages 106–138. Publs. Natl. Res. Coun. Wash., Washington, D.C., 1958.

Hunke, E. C., D. A. Hebert, and O. Lecomte. Level-ice melt ponds in the Los Alamos sea ice model, CICE. Ocean Modelling, 71:26–42, 2013. URL: http://dx.doi.org/10.1016/j.ocemod.2012.11.008.

Hunke, E. C., et al. "CICE: The Los Alamos Sea ice Model Documentation and Software User’s Manual Version 5 (Tech. Rep. LA-CC-06–012)." Los Alamos, NM: Los Alamos National Laboratory (2015).

Hunke, Elizabeth, Lipscomb, William, Jones, Philip, Turner, Adrian, Jeffery, Nicole, and Elliott, Scott. CICE, The Los Alamos Sea Ice Model. Computer software. https://www.osti.gov//servlets/purl/1364126. 

Lecomte, O., T. Fichefet, M. Vancoppenolle, F. Domine, F. Massonnet, P. Mathiot, S. Morin, and P.Y. Barriat (2013), On theformulation of snow thermal conductivity in large-scale sea ice models, J. Adv. Model. Earth Syst., 5, 542–557, doi:10.1002/jame.20039

Turner, A. K. and E. C. Hunke. Impacts of a mushy-layer thermodynamic approach in global sea-ice simulations using the CICE sea-ice model. J. Geophys. Res. Oceans, 120:1253–1275, 2015. URL: http://dx.doi.org/10.1002/2014JC010358.


