.. _aerocoma2noresm_r128:

aerocomA2noresm_r128_X
=======================                      

Model-run description for the full set of AeroCom A2 simulations with CAM4-Oslo (NorESM1-M)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

- Purpose of simulation:*\* Model documentation and validation for
      PD conditions, participation in AeroCom Phase 2 and IPCC AR5

-  Contact person:*\* Alf Kirkevåg (alf.kirkevag@met.no)

-  Data owner:*\* Alf Kirkevåg (alf.kirkevag@met.no)

-  Revision Number:*\* r128

-  Production computer used:*\* Cray XT3 in Bergen (hexagon)

-  Production date:*\* August 2010

-  Ensemble runs:*\* No

-  Storage locations:*\* NorStore
      (/norstore_osl/projects/NS2345K/noresm/cases/aerocomA2noresm_r128/)

aerocom-users (/metno/aerocom/users/aerocom1/CAM4-Oslo-Vcmip5.A2.CTRL)


-  Storage space:*\* 289 Gb at NorStore, 6 Gb at MET Norway
      (/vol/fou)

-  Projects:*\* NorClim/EarthClim and AeroCom

-  Publications:*\* `Kirkevåg et al.
      (2013) <http://www.geosci-model-dev.net/6/207/2013/gmd-6-207-2013.html>`__,
      `Myhre et al.
      (2013) <http://www.atmos-chem-phys.net/13/1853/2013/acp-13-1853-2013.html>`__,
      `Samset et al.
      (2013) <http://www.atmos-chem-phys.net/13/2423/2013/acp-13-2423-2013.html>`__,
      `Jiao et al.
      (2014) <http://www.atmos-chem-phys.net/14/2399/2014/acp-14-2399-2014.html>`__,
      `Tsigaridis et al.
      (2014) <http://www.atmos-chem-phys.net/14/10845/2014/acp-14-10845-2014.html>`__,
      `Samset et al.
      (2014) <http://www.atmos-chem-phys.net/14/12465/2014/acp-14-12465-2014.html>`__

-  Papers in preparation:*\* Kipling et al. (in prep.), Koffi et al.
      (in prep).

-  Simulation name(s):*\* aerocomA2noresm_r128_X, where X = 2006
      (AeroCom-A2.CTRL), 1850 (AeroCom-A2.PRE), ZERO (AeroCom-A2.ZERO),
      2006preSO4, 2006preffBC, 2006preffOC and 2006prebbBCOC

-  Compset name used:*\* NFAEROCOM1850 for X=1850, NFAEROCOM2006 for
      the other experiments

-  Model type:*\* Stand-alone cam (atmosphere) default with
      prescribed ocn/ice (ocean and sea-ice)

-  Type of run:*\* Initial

-  Simulation period:*\* 5 years

-  Spin-up period:*\* 2 years

-  Initialisation:*\*

-  Resolution:*\* f19_g16 = 1.8x2.5

-  Emission year(s):*\* 2006 (AeroCom-A2.CTRL), 1850
      (AeroCom-A2.PRE), 2006 but with aerosol extiction set to 0
      (AeroCom-A2.ZERO). For X = 2006preY all emissions are for year
      2006, except that 1850 emissions are used for: SO2 and SO4 in the
      Y = SO4 experiment, fossil fuel BC / OC in the Y = ffBC / ffOC
      experiment, and biomass BC and OC in the Y = bbBCOC experiment.

-  Emission inventories:*\* IPCC AR5 for 1850, AeroCom Phase II for
      2006, see references in Kirkevåg et al. (2013)

-  Greenhouse gases:*\* Prescribed concentrations

-  Frequency for output:*\* Monthly

-  Active/changing forcing agents:*\* Direct and indirect (1. & 2.)
      effects by anthropogenic SO4, POM and BC (for X = 2006 - 1850), or
      by all aerosols (2006 - ZERO, only direct effect), or by
      anthropogenic SO4 (2006 - 2006preSO4), ff BC (2006 - 2006preffBC),
      ff OC (2006 - 2006preffOC), or anthropogenic bb BC & OC (2006 -
      2006prebbBCOC)

-  Special considerations:*\*

-  Tuning parameters which are changed relative to the host model
      CAM4:*\*

rhminl: 0.90 lower RH threshold for formation of low stratiform clouds
(0.91 in CAM4)

critrp: 5.0 mm/day maximum prcipitation rate for suppression of
autoconversion of cloud water (0.5 mm/day in CAM4)

r3lc: 14 um critical mean droplet volume radius for onset of
autoconversion (10 um in CAM4)
