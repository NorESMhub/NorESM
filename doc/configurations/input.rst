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


Add new inputfiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^
