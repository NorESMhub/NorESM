.. _input:

Input and forcing data
==============================
WILL BE UPDATED BY dirkjlo@met.no 

The complete input data set is stored on Fram @ Sigma2. For access contact mben@norceresearch.no.

Input data sets
^^^^^^^^^^^^^^^

Solar forcing

GHG concentrations : CO2

Ozone concentrations

Oxidant concentrations : OH, ozone, NO3-radical, HO2.  

Emissions of short-lived species : anthropogenic, biomass burning, continuous outgassing of SO2 by volcanoes 

Water vapour emissions (from methane oxidation)

Stratospheric aerosol

Upper-ocean POM concentrations

Sea-surface temperature

Sea ice cover



Forcing
^^^^^^^^




Aerosol specific input data
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Some of the input data, the look-up tables (LUT) for NorESM specific aerosol optics and size information for calculation of cloud droplet activation, can be modified either for testing purposes or in order to take into account new developments in the aerosol microphysics scheme. Some typical examples of input that may need to be updated are: refractive indices; assumed (log-normal) size parameters at the point of emission or production; assumed hygroscopicities for sub-saturated conditions. Such changes can be made in the offline "sectional" aerosol module AeroTab (as in the example of new refractive indices), or both in AeroTab and in the online aerosol module OsloAero in the CAM6-Nor code (as in the example of assumed size parameters). Many aerosol related model changes may be done without having to touch the AeroTab code and thee LUT at all, such as e.g. the emissions (whether they are prescribed or interactive).  

A user's guide for the AeroTab code, with some additional information about OsloAero code (in CAM6-Nor) which makes use of the AeroTab LUT, can be found at https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf.
This AeroTab presentation https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-slides-updateJan2020.pdf may be useful as a first introduction. For questions about AeroTab, contakt Alf Kirkevåg (alfk at met.no) or Øyvind Seland (oyvinds at met.no).      


Ocean carbon cycle specific input data
^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ocean carbon cycle in NorESM2 (iHAMOCC) requires three input data sets to run: 1) monthly climatological dust deposition based on Mahowald et al. (2005), 2) riverine inputs, which contain annual climatology (nomalized to year 2000) fluxes of organic and inorganic carbon and nutrient constituents based on the Global-NEWS2 model and other datasets (Mayorga et al., 2010; Hartmann, 2009; Chester, 1990), and 3) atmospheric nitrogen deposition, provided through the CMIP6 protocol in monthly deposition fields of wet or dry and oxidized or reduced nitrogen deposition rates, all of which are added to the nitrate pool in the top-most ocean layer.  

By default, these external inputs are activated, but user can choose not to include riverine and nitrogen deposition by setting BLOM_RIVER_NUTRIENTS and BLOM_N_DEPOSITION to FALSE in user namelist (user_bl_blom) file.

These datasets have been prepared for the ocean model (BLOM) grid configuration of ~1 degree resolution. For other resolutions, these files may need to be created and tested. 


References
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Chester, R.: Marine Geochemistry, 1st ed., 702p, Springer, Netherlands, 1990.

Hartmann, J.: Bicarbonate-fluxes and CO2-consumption by chemical weathering on the Japanese Archipelago – Application of a multi-
lithological model framework, Chemical Geology, 265, 237–271, 2009.

Mahowald, N., Baker, A., Bergametti, G., Brooks, N., Duce, R., Jickells, T., Kubilay, N., Prospero, J., and Tegen, I.: Atmospheric global dust cycle and iron inputs to the ocean, Global Biogeochem. Cycles, 19, 4025, https://doi.org/10.1029/2004GB002402, 2005.

Mayorga, E., Seitzinger, S. P., Harrison, J. A., Dumont, E., Beusen, A. H. W., Bouwman, A. F., Fekete, B. M., Kroeze, C., and Van Drecht, G.: Global Nutrient Export from WaterSheds 2 (NEWS 2): Model development and implementation, Environmental Modelling and Software, 25, 837–853, 2010.

Add new inputfiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^
