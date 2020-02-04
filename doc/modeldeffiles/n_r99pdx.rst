.. _n_r99pdx:

N_r99PDX
=========        

Model-run description for three simulations with NorESM1-M
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

-  Purpose of simulation:*\* Estimate the effect of BC on global and
      Arctic climate

-  Contact person:*\* Alf Kirkevåg (alf.kirkevag@met.no)

-  Data owner:*\* Alf Kirkevåg (alf.kirkevag@met.no)

-  Revision Number:*\* r99

-  Production computer used:*\* Cray XT in Bergen (hexagon)

-  Production date:*\* October - November 2010

-  Storage locations:*\* NorStore
      (/norstore_osl/projects/NS2345K/noresm/cases/N_r99PDX), where X =
      yr116, noBCyr116, noBCdepyr116

-  Storage space:*\* 1500 Gb at NorStore

-  Projects:*\* EarthClim/ACCESS

-  Publications:*\*

-  Papers in preparation:*\* Sand et al. (submitted)

-  Simulation name(s):*\* N_r99PDX, where X = yr116, noBCyr116,
      noBCdepyr116

-  Compset name used:*\* NAER2000

-  Model type:*\* Fully coupled

-  Type of run:*\* Initial

-  Simulation period:*\* 92 years

-  Spin-up period:*\* 116 years

-  Initialisation:*\*

-  Ensemble runs:*\* No

-  Resolution:*\* f19_g19 = 1.8x2.5

-  Emission year(s):*\* 2000 (aerosols and precursors), but BC
      emissions set to 0 for X = noBCyr116. For X = noBCdepyr116 BC
      emissions are for year 2000, but deposition of BC on snow and
      sea-ice is set to 0.

-  Emission inventories*\* IPCC AR5, see references in `Kirkevåg et
      al.
      (2013) <http://www.geosci-model-dev.net/6/207/2013/gmd-6-207-2013.html>`__

-  Greenhouse gases:*\* Prescribed concentrations (2000?)

-  Frequency for output:*\* Monthly (for atm, ocn and lnd)

-  Active/changing forcing agents:*\* Direct and indirect (1. & 2.)
      effects by anthropogenic SO4, POM and BC. The effects of all BC is
      found from the difference between the experiments N_r99yr116 and
      N_r99noBCyr116, and the effect of BC deposited on snow and sea-ice
      is found from the difference between N_r99yr116 and
      N_r99noBCdepyr116.

-  Special considerations:*\*

-  Tuning parameters which are changed relative to the host model
      CCSM4:*\*

rhminl: 0.90 lower RH threshold for formation of low stratiform clouds
(0.91 in CAM4)

critrp: 5.0 mm/day maximum prcipitation rate for suppression of
autoconversion of cloud water (0.5 mm/day in CAM4)

r3lc: 14 um critical mean droplet volume radius for onset of
autoconversion (10 um in CAM4)

R_snw: 500 um grain size of cold snow overlaying sea-ice (250 um in
CICE4)
