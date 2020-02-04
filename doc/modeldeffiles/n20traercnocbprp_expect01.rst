.. _n20traercnocbprp_expect01:

N20TRAERCNOCBPRP_EXPECT01
===========================                         

Model-run description for historical run used in EXPECT
'''''''''''''''''''''''''''''''''''''''''''''''''''''''

-    Purpose of simulation:*\* Historical run for expect model version

-    Contact person:*\* Jerry Tjiputra <jerry.tjiputra@uni.no>

-    Data owner: \*\* Jerry Tjiputra <jerry.tjiputra@uni.no>

-   Revision Number:*\* 249,
      https://svn.met.no/NorESM/noresm/branches/projectEXPECT_cmip5-r143-1

-    Production computer used:*\* Cray XT3 in Bergen (hexagon)

-   Production date:*\* Spring 2014

-    Ensemble runs:*\* No

-    Storage locations:*\* NorStore
      (/projects/NS2345K/noresm/cases/N20TRAERCNOCBPRP_EXPECT01 )

-    Storage space:*\* ??

-    Projects:*\* EXPECT

-   Publications:*\*

-    Papers in preparation:*\*

-    Simulation name(s):*\* N20TRAERCNOCBPRP_EXPECT01

-   Compset name used:*\* N20TRAERCNOCBPRP

-    Model type:*\* Fully coupled

-    Type of run:*\* Hybrid

-    Simulation period:*\* 1850-2005

-    Initialisation \*\* Started as hybrid run from
      N1850BPRPCNOC_f19_g16_spin_02 with restart files from
      "0501-01-01". This date maps to 1850-01-01 in this run.

-    Resolution:*\* f19_g16= 1.9x2.5 degree atmosphere/land. Dipolar
      ocean/ice grid, ~ 1 degree

-    Emission year(s):*\* 1850-2005

-    Greenhouse gases:*\* Interactive CO2

-    Emission inventories*\* N/A

-    Frequency for output:*\* Monthly and selected daily

-    Active/changing forcing agents:*\* Greenhouse gases: Direct and
      indirect (1. & 2.) effects of SO4, POM and BC.

-    Special considerations: \*\* Note that the number of cores used
      for historical runs was changed in revision 249. Earlier
      historical runs were too slow. A "bug" in was fixed. Do svn diff
      -r 249:246 to see the changes in
      noresm/scripts/ccsm_utils/Machines/config_pes.xml. Earlier version
      will not give bit identical results to this run even using same
      compset.

-    Tuning parameters which are changed relative to the host model
      NorESM-CMIP5-branch:*\*

`` * rhminl:  0.9005      lower RH threshold for formation of low stratiform clouds (0.91 in CAM4) ``
