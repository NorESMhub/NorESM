.. _n20traercn:

N20TRAERCN_X
=============            

Model-run description for three simulations with NorESM1-M (UNDER CONSTRUCTION)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

-   Purpose of simulation:*\* Transient run for describing climate
      change in the 20th century (1850-2005)

-  Contact person:*\* Øyvind Seland (oyvind.seland@met.no)

-  Data owner: \*\* Mats Bentsen (mats.bentsen@uni.no)

-  Revision Number:*\* r112

-  Production computer used:*\* Cray XT3 in Bergen (hexagon)

-  Production date:*\* November - March 2010 /2011

-  Ensemble runs:*\* Yes, 3 members

-  Storage locations:*\* NorStore
      (/projects/NS2345K/noresm/cases/N20TRAERCN_f19_g16_0X), where X =
      ensemble member, X=1,2,3 for this particular set-up

-   Storage space:*\* 1,6 Tb at NorStore (for each ensemble member)

-   Projects:*\* EarthClim

-   Publications:*\* Bentsen, M., I. Bethke, J. B. Debernard, T.
      Iversen, A. Kirkevåg, Ø. Seland, H. Drange, C. Roelandt, I. A.
      Seierstad, C. Hoose, and J. E. Kristjansson (2012): The Norwegian
      Earth System Model, NorESM1-M. Part 1: Description and basic
      evaluation, Geosci. Model Dev., 6, 687-720,
      doi:10.5194/gmd-6-687-2013

-    Papers in preparation:*\*

-    Simulation name(s):*\* N20TRAERCN_f19_g16_0X), where X = ensemble
      member, where X = 1,2,3 for this set-up

-    Compset name used:*\* N20TRAERCN

-    Model type:*\* Fully coupled

-   Type of run:*\* Hybrid

-    Simulation period:*\* 156 years

-    Initialisation \*\* Start from CMIP5 control simulation. Ensemble
      member 1: NAER1850CNOC_f19_g16_05, year 700. 2:
      NAER1850CNOC_f19_g16_06, year 730, 3: NAER1850CNOC_f19_g16_06,
      year 760

-    Resolution:*\* f19_g16= 1.9x2.5 degree atmosphere/land. Dipolar
      ocean/ice grid, ~ 1 degree

-    Emission year(s):*\* 1850-2005 (aerosol and aerosol-precursors)

-    Greenhouse gases:*\* Prescribed concentrations 1850-2005

-    Emission inventories*\* IPCC AR5, see references in `Kirkevåg et
      al.
      (2013) <http://www.geosci-model-dev.net/6/207/2013/gmd-6-207-2013.html>`__

-    Frequency for output:*\* Monthly and selected daily 1850-1949:
      Monthly + daily + 6h +3h as defined by CMIP5: 1950-2005

-    Active/changing forcing agents:*\* Greenhouse gases: Direct and
      indirect (1. & 2.) effects of SO4, POM and BC.

-    Special considerations: \*\* An extension of the historical
      simulation to 2012 is done by using RCP8.5 scenario; There is a
      bug in the column burden for aerosols. The column burden has to be
      recalculated using concentrations. This was corrected before the
      RCP scenarios (revision 118); The CMIP 5 files for these
      simulations can be found at
      /projects/NS9034K/CMIP5/output1/NCC/NorESM1-M/historical.

-    Tuning parameters which are changed relative to the host model
      CAM4:*\*

rhminl: 0.90 lower RH threshold for formation of low stratiform clouds
(0.91 in CAM4)

critrp: 5.0 mm/day maximum prcipitation rate for suppression of
autoconversion of cloud water (0.5 mm/day in CAM4)

r3lc: 14 um critical mean droplet volume radius for onset of
autoconversion (10 um in CAM4)
