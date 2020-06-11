.. _input:


Input data sets
==============================
The complete input data set is stored on Fram @ Sigma2. For access contact mben@norceresearch.no.

Atmospheric specific input data
^^^^^^^^^^^^^^^

Various external input data sets are used by the atmosphere model.  These data sets often describe "boundary conditions" needed during the integration of the model (solar forcing, GHG concentrations, ozone concentrations, oxidant concentrations, emissions of short-lived species, production rate of H2O from CH4 oxidation, stratospheric aerosol, upper ocean chlorophyl-a concentration, sea-surface temperature and sea-ice concentration).  The boundary conditions can be constant, cyclic (often one annual cycle), or evolve according to a historical or future scenario.

- **Solar forcing** The solar forcing is prescribed following Matthes et al. (2017).

- **GHG concentrations : CO2, CH4, N2O, CFC1-eq, CFC12**  Green-house concentrations are used in the radiative transfer calculations, and the values are taken from Meinshausen et al. (2017).  The prescribed concentrations are assumed to represent the surface concentrations.  Latitudinal and species dependent profiles are used to calculate the concentrations at different altitudes.

- **Ozone concentrations**  Ozone concentration climatologies are used in the radiative transfer calculations.  The ozone climatologies used in NorESM2 have a 5-day frequency, vary in height and latitude, but have no longitudinal dependce.  They are based on simulations with CESM2-WACCM (Danabasoglu et al., 2019).

- **Oxidant concentrations : OH, ozone, NO3-radical, HO2** The oxidant concentrations are used in the description of secondary aerosol formation (sulfate and SOA).  OH, ozone, NO3 and H2O2 (formed by HO2) are relevant for the oxidation of DMS, SO2, isoprene, and monoterpenes.  These climatologies have a monthly frequency, and a 3-dimensional spatial distribution.  They are based on simulations with CESM2-WACCM (Danabasoglu et al., 2019).

- **Emissions of short-lived species : BC, OM and SO2** Emissions of BC, OM and SO2 consists in contributions from anthropogenic sources, biomass burning, and continuous outgassing of SO2 by volcanoes.  The anthropogenic sources (Hoesly et al., 2018) are given as 9 different sectors : emissions of agricultural activity, transport, domestic heating, solvents, waste and shipping are emitted at the surface; emissions from the energy and industrial sectors are emitted between 150 and 350 m height; aircraft emissions can go up to around 15 km.  The biomass burning sources (van Marle et al., 2017) are give as 6 different categories, and emission heights differ among them : 0-100 m for agricultural waste burning and peat burning, 0-1 km for savannah burning and deforestation, 0-2 km for temperate forests, and 0-3 km for Boreal forests (Dentener et al., 2006).  A fixed climatology of continuous tropospheric outgassing of SO2 by volcanoes is also included (Dentener et al., 2006).   Emission inventories provide emission strengths for OC.  For fossil fuel combustions we assumed an OM:OC ratio of 1.4, and for biomass burning of 2.6.  Part of the SO2 (2.5% equivalent S) is emitted as SO4.  Emission fields are provided both on the 1.9x2.5 and 0.9x1.25 horizontal grid.

- **Water vapour emissions (from methane oxidation)** Production of H2O from methane oxidation is prescribed using a climatologies based on simulations with CESM2-WACCM.  This source is especially relevant in the stratosphere.  These climatologies have a monthly frequency, and a 3-dimensional spatial distribution.  They are based on simulations with CESM2-WACCM (Danabasoglu et al., 2019).

- **Stratospheric aerosol**  To describe the impact of volcanic SO2 emissions reaching the stratosphere and forming SO4 aerosol, monthly varying climatologies of stratospheric aerosol properties are used.

- **Upper-ocean POM concentrations**  To describe the emission strength of marine primary organic matter from the ocean, a monthly varying climatology of upper-ocean chlorophyl-a concentration is used.

- **Sea-surface temperature and sea-ice cover**  In atmosphere-only simulations, the sea-surface temperature and sea-ice concentrations are prescribed as monthly varying climatologies.  One can use climatologies that are based on observations (Hurrell et al., 2008), or climatologies derived from fully-coupled NorESM2 simulations.


Aerosol specific input data
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Some of the input data, the look-up tables (LUT) for NorESM specific aerosol optics and size information for calculation of cloud droplet activation, can be modified either for testing purposes or in order to take into account new developments in the aerosol microphysics scheme. Some typical examples of input that may need to be updated are: refractive indices; assumed (log-normal) size parameters at the point of emission or production; assumed hygroscopicities for sub-saturated conditions. Such changes can be made in the offline "sectional" aerosol module AeroTab (as in the example of new refractive indices), or both in AeroTab and in the online aerosol module OsloAero in the CAM6-Nor code (as in the example of assumed size parameters). Many aerosol related model changes may be done without having to touch the AeroTab code and thee LUT at all, such as e.g. the emissions (whether they are prescribed or interactive).  

A user's guide for the AeroTab code, with some additional information about OsloAero code (in CAM6-Nor) which makes use of the AeroTab LUT, can be found at https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf.
This AeroTab presentation https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-slides-updateJan2020.pdf may be useful as a first introduction. For questions about AeroTab, contakt Alf Kirkevåg (alfk at met.no) or Øyvind Seland (oyvinds at met.no).      

Ocean specific input data
^^^^^

In case of a startup run (i.e. if the model is not re-started from a prvious simulation) the ocean is initialized from rest, and the initial ocean temperature and salinity are from the Polar Science Center Hydrographic Climatology (PHC) 3.0, updated from Steele et al. (2001). The initial condition files containing ocean temperature and salinity are located in the directory
::

  /DIN_LOC_ROOT/ocn/blom/inicon/inicon_<gridspec>_<date>.nc,

where DIN_LOC_ROOT is the base input data directory (depends on the machine; on fram it is /cluster/shared/noresm/inputdata), *gridspec* specifies the ocean grid used, and *date* specifies a date tag for the file. The files contains values for layered potential density (sigma), potential temperature (temp), salinity (saln) and layer thickness (dz):
:: 

  dimensions:
          x = 360 ;
          y = 385 ;
          z = 53 ;
  variables:
          double sigma(z, y, x) ;
          double temp(z, y, x) ;
          double saln(z, y, x) ;
          double dz(z, y, x) ;

Boundary conditions for the ocean component (e.g. tidal dissipation, SSS climatologies for OMIP configuration) are located in 
::

   /DIN_LOC_ROOT/ocn/blom/bndcon/,

and grid specific information (grid input file, files defining ocean basins and sections) are located in 
::

   /DIN_LOC_ROOT/ocn/blom/grid/.
   
   
Ocean carbon cycle specific input data
^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ocean carbon cycle in NorESM2 (iHAMOCC) is initialized from gridded observation based data sets for DIC, alkalinity, phosphate, nitrate, oxygen, and silica. These data sets have been provided by CMIP6-OMIP (Orr et al. 2017), and are located in the same directory as the BLOM initial conditions.

Further, iHAMOCC requires three input data sets specifying boundary conditions: 1) monthly climatological dust deposition based on Mahowald et al. (2006), 2) riverine inputs, which contain an annual climatology (normalized to year 2000) of fluxes of organic and inorganic carbon and nutrient constituents based on the Global-NEWS2 model and other datasets (Mayorga et al., 2010; Hartmann, 2009; Chester, 1990), and 3) atmospheric nitrogen deposition, provided through the CMIP6 protocol in monthly deposition fields of wet or dry and oxidized or reduced nitrogen deposition rates, all of which are added to the nitrate pool in the top-most ocean layer.  

By default, these external inputs are activated, but the user can choose not to include riverine and nitrogen deposition by setting BLOM_RIVER_NUTRIENTS and BLOM_N_DEPOSITION to FALSE in in env_run.xml.

While the initial conditions are interpolated by the model (using nearest neighbor interpolation), the boundary condition datasets need to be pre-interpolated to the ocean grid used. These data sets are available for 2, 1, and 1/4 degree resolution (the tnx2v1, tnx1v4, and tnx0.25v4 grids). Note however, that for running CMIP scenario simulations, specific N-deposition data sets are necessary. These might not be available for a given grid, so they may need to be created and tested. 


Adding new inputfiles
^^^^^^^^^^^^^^^^^^^^^^^^^^^
All BLOM/iHAMOCC input file names are specified via namelist (including the full path name). If a user would like to use a different input file, it is recommended to place this file in the user's work directory, and specify the corresponding file name (icluding the full path) as a namelist option in user_nl_blom (see :ref:`omips`).


References
^^^^^^^^^^^^^^^^^^^^^^^^^^^
Chester, R.: Marine Geochemistry, 1st ed., 702p, Springer, Netherlands, 1990.

Danabasoglu, G., Lamarque, J.-F., Bacmeister, J., Bailey, D. A., DuVivier, A. K., Edwards, J., Emmons, L. K., Fasullo, J., Garcia, R., Gettelman, A., Hannay, C., Holland, M. M., Large, W. G., Lawrence, D. M., Lenaerts, J. T. M., Lindsay, K., Lipscomb, W. H., Mills, M. J., Neale, R., Oleson, K. W., Otto-Bliesner, B., Phillips, A. S., Sacks, W., Tilmes, S., van Kampenhout, L., Vertenstein, M., Bertini, A., Dennis, J., Deser, C., Fischer, C., Fox-Kemper, B., Kay, J. E., Kinnison, D., Kushner, P. J., Long, M. C., Mickelson, S., Moore, J. K., Nienhouse, E., Polvani, L., Rasch, P. J., and Strand, W. G.: The Community Earth System Model version 2 (CESM2), Submitted to J. Adv. Model. Earth Syst., 2019.

Dentener, F., Kinne, S., Bond, T., Boucher, O., Cofala, J., Generoso, S., Ginoux, P., Gong, S., Hoelzemann, J. J., Ito, A., Marelli, L., Penner, J. E., Putaud, J.-P., Textor, C., Schulz, M., van der Werf, G. R., and Wilson, J.: Emissions of primary aerosol and precursor gases in the years 2000 and 1750 prescribed data-sets for AeroCom, Atmospheric Chemistry and Physics, 6, 4321–4344, https://doi.org/10.5194/acp-6-4321-2006, 2006.

Hartmann, J.: Bicarbonate-fluxes and CO2-consumption by chemical weathering on the Japanese Archipelago – Application of a multi-
lithological model framework, Chemical Geology, 265, 237–271, 2009.

Hoesly, R. M., Smith, S. J., Feng, L., Klimont, Z., Janssens-Maenhout, G., Pitkanen, T., Seibert, J. J., Vu, L., Andres, R. J., Bolt, R. M., Bond, T. C., Dawidowski, L., Kholod, N., Kurokawa, J.-I., Li, M., Liu, L., Lu, Z., Moura, M. C. P., O’Rourke, P. R., and Zhang, Q.: Historical (1750–2014) anthropogenic emissions of reactive gases and aerosols from the Community Emissions Data System (CEDS), Geoscientific Model Development, 11, 369–408, https://doi.org/10.5194/gmd-11-369-2018, 2018.

Hurrell, J.W., J.J. Hack, D. Shea, J.M. Caron, and J. Rosinski: A New Sea Surface Temperature and Sea Ice Boundary Dataset for the Community Atmosphere Model. J. Climate, 21, 5145–5153, https://doi.org/10.1175/2008JCLI2292.1, 2008.

Mahowald, N., Baker, A., Bergametti, G., Brooks, N., Duce, R., Jickells, T., Kubilay, N., Prospero, J., and Tegen, I.: Atmospheric global dust cycle and iron inputs to the ocean, Global Biogeochem. Cycles, 19, 4025, https://doi.org/10.1029/2004GB002402, 2005.

Matthes, K., Funke, B., Andersson, M. E., Barnard, L., Beer, J., Charbonneau, P., Clilverd, M. A., Dudok de Wit, T., Haberreiter, M., Hendry, A., Jackman, C. H., Kretzschmar, M., Kruschke, T., Kunze, M., Langematz, U., Marsh, D. R., Maycock, A. C., Misios, S., Rodger, C. J., Scaife, A. A., Seppälä, A., Shangguan, M., Sinnhuber, M., Tourpali, K., Usoskin, I., van de Kamp, M., Verronen, P. T., and Versick, S.: Solar forcing for CMIP6 (v3.2), Geoscientific Model Development, 10, 2247–2302, https://doi.org/10.5194/gmd-10-2247-2017, 2017.

Mayorga, E., Seitzinger, S. P., Harrison, J. A., Dumont, E., Beusen, A. H. W., Bouwman, A. F., Fekete, B. M., Kroeze, C., and Van Drecht, G.: Global Nutrient Export from WaterSheds 2 (NEWS 2): Model development and implementation, Environmental Modelling and Software, 25, 837–853, 2010.

Meinshausen, M., Vogel, E., Nauels, A., Lorbacher, K., Meinshausen, N., Etheridge, D. M., Fraser, P. J., Montzka, S. A., Rayner, P. J., Trudinger, C. M., Krummel, P. B., Beyerle, U., Canadell, J. G., Daniel, J. S., Enting, I. G., Law, R. M., Lunder, C. R., O’Doherty, S., Prinn, R. G., Reimann, S., Rubino, M., Velders, G. J. M., Vollmer, M. K., Wang, R. H. J., and Weiss, R.: Historical greenhouse gas concentrations for climate modelling (CMIP6), Geoscientific Model Development, 10, 2057–2116, https://doi.org/10.5194/gmd-10-2057-2017, 2017.

Orr, J. C., Najjar, R. G., Aumont, O., Bopp, L., Bullister, J. L., Danabasoglu, G., Doney, S. C., Dunne, J. P., Dutay, J.-C., Graven, H., Griffies, S. M., John, J. G., Joos, F., Levin, I., Lindsay, K., Matear, R. J., McKinley, G. A., Mouchet, A., Oschlies, A., Romanou, A., Schlitzer, R., Tagliabue, A., Tanhua, T., and Yool, A.: Biogeochemical protocols and diagnostics for the CMIP6 Ocean Model Intercomparison Project (OMIP), Geosci. Model Dev., 10, 2169–2199, https://doi.org/10.5194/gmd-10-2169-2017, 2017. 
 
van Marle, M. J. E., Kloster, S., Magi, B. I., Marlon, J. R., Daniau, A.-L., Field, R. D., Arneth, A., Forrest, M., Hantson, S., Kehrwald, N. M., Knorr, W., Lasslop, G., Li, F., Mangeon, S., Yue, C., Kaiser, J. W., and van der Werf, G. R.: Historic global biomass burning emissions for CMIP6 (BB4CMIP) based on merging satellite observations with proxies and fire models (1750–2015), Geoscientific Model Development, 10, 3329–3357, https://doi.org/10.5194/gmd-10-3329-2017, 2017.

