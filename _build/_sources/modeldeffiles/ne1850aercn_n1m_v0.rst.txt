.. _ne1850aercn_n1m_v0:

NE1850AERCN_N1M_v0
==================                  

Slab ocean 1850 control simulation
''''''''''''''''''''''''''''''''''

-   Purpose of simulation:*\*

-   Contact person:*\* Jens Debernard

-    Data owner: \*\* Jens Debernard (jens.debernard@met.no)

-   Revision Number:*\* r167

-    Production computer used:*\* Cray XT3 in Bergen (hexagon)

-    Production date:*\* April-May 2013

-    Ensemble runs:*\* No

-   Storage locations:*\*

-    Storage space:*\* 1

-    Projects:*\* EarthClim

-    Publications:*\*

-    Papers in preparation:*\*

-    Simulation name(s):*\* NE1850AERCN_N1M_v0

-    Compset name used:*\* NE1850AERCN

-    Model type:*\* Prognostic atm, land, ice and slab ocean.

-    Type of run:*\* Branch

-   Simulation period:*\* year 21 - 63

-    Initialisation \*\* Start from 20-year spin-up from
      NAER1850CNOC_f19_g16_06, year 760

-    Resolution:*\* f19_g16= 1.9x2.5 degree atmosphere/land. Bipolar
      ocean/ice grid, ~ 1 degree

-    Greenhouse gases:*\* 1850 fixed value.

-    Emission inventories*\* IPCC AR5 1850 Control,

-    Frequency for output:*\* Monthly.

-    Special considerations: \*\*

-    Tuning parameters which are changed relative to the host model
      CAM4:*\*

rhminl: 0.90 lower RH threshold for formation of low stratiform clouds
(0.91 in CAM4)

critrp: 5.0 mm/day maximum prcipitation rate for suppression of
autoconversion of cloud water (0.5 mm/day in CAM4)

r3lc: 14 um critical mean droplet volume radius for onset of
autoconversion (10 um in CAM4)
