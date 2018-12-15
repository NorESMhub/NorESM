.. _lakistudy:

Laki Study
===========          

Model-run description for several simulations with NorESM-M)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

-  Purpose of simulation:*\* Understand climate effects of large
      volcanic eruptions in Northern hemisphere.

-  Contact person:*\* Alf Grini (alf.grini@met.no)

-  Data owner: \*\* Alf Grini (alf.grini@met.no)

-  Revision Number:*\* r196

-  Production computer used:*\* Cray XT3 in Bergen (hexagon)

-  Production date:*\* Spring 2014

-  Ensemble runs:*\* Yes, 20 members

-  Storage locations:*\* NorStore
      (/projects/NS2345K/noresm/cases/KatlaStudy), where
      BF2_VolcanoStart.. is ensemble members with volcano. NoVolcano..
      are ensemble members for no eruption ensemble members.

-  Storage space:*\* 1,6 Tb at NorStore (for each ensemble member)

-  Projects:*\* PEGASOS

-  Publications:*\* None (yet)

-  Papers in preparation:*\*

-  Simulation name(s):*\* N20TRAERCN_f19_g16_0X), where X = ensemble
      member, where X = 1,2,3 for this set-up

-  Compset name used:*\* N20TRAERCN

-  Model type:*\* Fully coupled

-  Type of run:*\* Hybrid/branch

-  Simulation period:*\* Each ensemble member is 4-5 years

-  Initialisation \*\* Start from CMIP5 transient simulation,
      N20TRAERCN_f19_g16_06

-  Resolution:*\* f19_g16= 1.9x2.5 degree atmosphere/land. Dipolar
      ocean/ice grid, ~ 1 degree

-  Emission year(s):*\* 1850-2005 (aerosol and aerosol-precursors)

-  Greenhouse gases:*\* Prescribed concentrations 1850-2005

-  Emission inventories*\* IPCC AR5, see references in `Kirkevåg et
      al.
      (2013) <http://www.geosci-model-dev.net/6/207/2013/gmd-6-207-2013.html>`__

-  Frequency for output:*\* Monthly and selected daily 1850-1949:
      Monthly + daily + 6h +3h as defined by CMIP5: 1950-2005

-  Active/changing forcing agents:*\* Greenhouse gases: Direct and
      indirect (1. & 2.) effects of SO4, POM and BC.

-  Special considerations: \*\* An extension to the normal NorESM-M
      has been created. In the extended version it is possible to
      specify a vulcanic eruption at some lon/lat location and some
      height distribution. The volcano can then have several eruptions
      distributed in time. This is used to simulate the Laki eruption on
      Iceland 1783.

-  Tuning parameters which are changed relative to the host model
      CAM4:*\*

rhminl: 0.90 lower RH threshold for formation of low stratiform clouds
(0.91 in CAM4)

critrp: 5.0 mm/day maximum prcipitation rate for suppression of
autoconversion of cloud water (0.5 mm/day in CAM4)

r3lc: 14 um critical mean droplet volume radius for onset of
autoconversion (10 um in CAM4)
