.. _nrcp85bprpex_mpi_20100_lwf1:

nrcp85bprpex_mpi_20100_lwf1
============================                           

Model-run description for spin-up used in EXPECT
''''''''''''''''''''''''''''''''''''''''''''''''


-  Purpose of simulation:*\* Stratospheric aerosol injection using
      aerosol data from Ulrike Niemeier (ECHAM simulation)


-  Contact person:*\* Alf Grini <alf.grini@met.no>


-  Data owner: \*\* Alf Grini <alf.grini@met.no>


-  Revision Number:*\* 405,
      https://svn.met.no/NorESM/noresm/branches/projectEXPECT_cmip5-r143-1


-  Production computer used:*\* Cray XT3 in Bergen (hexagon)


-  Production date:*\* Autumn 2015


-  Ensemble runs:*\* Yes


-  Storage locations:*\* NorStore
      (/projects/NS9033K/alfgr/EXPECT/NRCP85BPRPEX_MPI_20100_LWF1_X),
      where X = ensemble member, X=2,4,5 for this particular set-up, An
      additional member: NRCP85BPRPEX_MPI_20100_LWF1 also exists, but
      has missing data (high resolution time data are missing)


-  Storage space:*\* 1.5 Tb at NorStore (for each ensemble member)


-  Projects:*\* EXPECT


-  Publications:*\*


-  Papers in preparation:*\*


-  Simulation name(s):*\* NRCP85BPRPEX_MPI_20100_LWF1


-  Compset name used:*\* NRCP85BPRPEX


-  Model type:*\* Fully coupled


-  Type of run:*\* hybrid


-  Simulation period:*\* 96 years (2005-2100)


-  Initialisation \*\* Start from N20TRAERCNOCBPRP_EXPECT01
      historical simulation in EXPECT project.


-  Resolution:*\* f19_g16= 1.9x2.5 degree atmosphere/land. Dipolar
      ocean/ice grid, ~ 1 degree


-  Emission year(s):*\* RCP8.5


-  Greenhouse gases:*\* Interactive CO2


-  Emission inventories*\* N/A


-  Frequency for output:*\* Monthly and selected daily


-  Active/changing forcing agents:*\* Greenhouse gases: Direct and
      indirect (1. & 2.) effects of SO4, POM and BC.


-  Special considerations: \*\* Ensemble members are created through
      small perturbations (~1.e-4) degrees in initial temperature in the
      same historical run. We did not have several historical runs when
      the members were created, so they only have 15 years to diverge
      before CE starts in 2020.

There were a lot of confusion about LW effect of the ECHAM aerosols
before doing this run. The files in
noresm/models/atm/cam/tools/StratEchamReader2 in the code repository
must be copied to SourceMods/src.cam before doing the runs. The name of
the input files are hardcoded in MPIaerosols.F90


-  Tuning parameters which are changed relative to the host model
      NorESM-CMIP5-branch:*\*

`` * rhminl:  0.9005      lower RH threshold for formation of low stratiform clouds (0.91 in CAM4) ``
