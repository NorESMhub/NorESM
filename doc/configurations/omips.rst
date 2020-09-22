.. _omips:

Ocean and Sea-Ice
==================

BLOM
''''

In NorESM2, the ocean component BLOM/iHAMOCC can be either run fully coupled to the other model components, or in ocean carbon-cycle stand alone configuration. The latter setup follows the CMIP6-OMIP protocol (see below) and is driven by atmospheric input data derived from reanalysis products (called *data-atmosphere*, DATM).


OMIP-type experiments
^^^^^^^^^^^^^^^^^^^^^

The Ocean Model Intercomparison Project (OMIP; Griffies et al., 2016) is an endorsed project in the CMIP6. OMIP provides a protocol for global ocean/sea-ice models forced by a common prescribed atmospheric forcing, and a protocol for ocean diagnostics to be saved as part of CMIP6. OMIP includes a physical component (Griffies et al., 2016) and a biogeochemistry component (Orr et al. 2017).

Prior to OMIP, the framework of the Coordinated Ocean-ice Reference Experiments (CORE) provides ocean and climate modellers with a common protocol for running coupled ocean/sea-ice models with boundary forcing derived from common atmospheric datasets. The CORE forcing dataset was described by Large and Yeager (2004, 2009), which is largely based on the surface-atmospheric fields derived from NCEP/NCAR atmospheric reanalysis . CORE has subsequently evolved into phase 1 of the physical part of OMIP (OMIP-1). The OMIP1/CORE-II experiment forces the ocean through use of the interannually varying atmospheric state of Large and Yeager (2009), along with river runoff data based on Dai et al. (2009).

The Large and Yeager (2009) forcing dataset covers the period from 1948 to 2009, and has not been updated since 2009. Thereafter, Tsujino et al. (2018) developed a surface atmospheric dataset based on the Japanese 55-year atmospheric reanalysis (JRA-55; Kobayashi et al., 2015), referred to as JRA55-do, which has been endorsed under the protocol for phase 2 of OMIP (OMIP-2). Currently, JRA55-do covers the period from 1958 to 2018 with planned continuous annual updates. Comparing to CORE-II, the JRA55-do forcing has an increased temporal frequency (from 6 hours to 3 hours), and a refined horizontal resolution (from 1.875° to 0.5625°).

The readers are referred to Large and Yeager (2009) and Tsujino et al. (2018) for a detailed description of the CORE-II and JRA55-do forcing, respectively, including the bulk formulae used for computing turbulent fluxes for heat and momentum. An evaluation and comparison of the simulated ocean and sea ice mean states and variability from 11 state-of-the-art global ocean/sea-ice models (including NorESM-BLOM), based on OMIP-1/CORE-II and OMIP-2/JRA55-do, is presented by Tsujino et al. (2020).


BLOM OMIP specifics
^^^^^^^^^^^^^^^^^^^

- In the BLOM OMIP simulations, sea surface salinity is restored to monthly climatology with a piston velocity of 50 m per 300 days applied globally for both OMIP-1 and OMIP-2 simulations. The restoring salt flux is normalized so that the global area weighted sum of the restoring flux is zero. 

- A dimensionless parameter 𝛼=1 is used in the estimation of the near-surface wind correction, e.g. **𝛥𝑈** = **𝑈** \ :sub:`atm`\-𝛼 **𝑈** :sub:`ocn`\, to account for the imprint of the ocean currents on the surface wind stress in an ocean/sea-ice model. The OMIP community has not reached a consensus on the way α should be imposed; for a discussion of α and its values among other OMIP models, refer to Tsujino et al. (2020).

- The OMIP-1 and OMIP-2 simulations of BLOM have completed 6 repeating forcing cycles of the forcing periods 1948-2009 and 1958-2018, respectively.

- The OMIP-1/CORE-II experiment is documented by Bentsen et al. (2020, *in prep.*), including a comparison to a previous CORE-II experiment simulated by the CMIP5 version of NorESM1. In addition, a number of common global ocean and sea ice metrics simulated by BLOM (including both OMIP-1 and OMIP-2 experiments) is included and evaluated in the multi-model synthesis paper of Tsujino et al. (2020).


Creating an OMIP case
^^^^^^^^^^^^^^^^^^^^^
General syntax:

::

   cd <noresm-base>/cime/scripts
   ./create_newcase --case <path_to_case_dir>/<casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project <project_name> --user-mods-dir <user_mods_dir> --output-root <path_to_run_dir>/<noresm_run_dir> --run-unsupported 
   
An example for creating the OMIP-1 case:

::

   ./create_newcase --case ../../cases/NOIIAOC20TR_T62_tn14_20190628 --compset NOIIAOC20TR --res T62_tn14 --machine vilje --project nn2345k --run-unsupported
   
An example for creating the OMIP-2 case:

::

   ./create_newcase --case ../../cases/NOIIAJRAOC20TR_TL319_tn14_20190710 --compset NOIIAJRAOC20TR --res TL319_tn14 --machine vilje --project nn2345k --run-unsupported
   

OMIP compsets
^^^^^^^^^^^^^

- OMIP-1/CORE-II:   NOIIAOC20TR
- OMIP-2/JRA55-do:  NOIIAJRAOC20TR


Forcing datasets
^^^^^^^^^^^^^^^^


- **OMIP-1/CORE-II**
  
  Forcing dataset described in detail by Large and Yeager (2009). The forcing files are located in ::
  
  /DIN_LOC_ROOT/ocn/iaf/,
  
  where DIN_LOC_ROOT is the base input data directory, which depends on the machine (on fram it is /cluster/shared/noresm/inputdata/).


- **OMIP-2/JRA55-do**

  Forcing dataset described in detail by Tsujino et al. (2018). The forcing files are located at (on Fram) ::

  /DIN_LOC_ROOT/ocn/jra55/v1.3_noleap/



Modify user namelist for BLOM/iHAMOCC
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Model parameters and adjusting model output can be done in user_nl_blom, which is present in the case directory after ./case.setup has been excecuted. The resolved namelist for BLOM/iHAMOCC is saved in CaseDocs/ocn_in, and specifies a number of physical parameters (such as vertical and horizontal mixing), as well as model output settings and frequencies. Output settings include options for daily (hd/hbgcd), monthly (hm/hbgcm), and yearly (hy/hbgcy) output, where the files containing 'bgc' in their filenames are iHAMOCC output files. Note that the resolved namelist (CaseDocs/ocn_in) should **never** be used to place user defined changes, since this file is re-created (overwritten) every time the model is submitted. User defined namelist changes need to be placed in user_nl_blom, for example
::
  BDMC2 = .15
  NIWGF = .5

Note that it does not matter which namelist group the variables belong (namelist groups must not be specified in user_nl_blom).  BLOM parameters that can be changed via namelist settings are documented in the resolved namelist file (see CaseDocs/ocn_in after running ./preview_namelists or building the case). In iHAMOCC, model parameters are currently hard-coded, i.e. they cannot be changed through namelist settings. To change iHAMOCC model parameters, please see below under 'Code modifications'.

For changing the output in BLOM or iHAMOCC, the example below shows how to change the monthly mean (default) to yearly mean layered ocean temperature. The default setting (as can be seen in CaseDocs/ocn_in after running ./preview_namelists or building the case) is
::

   &DIAPHY
     GLB_FNAMETAG = 'hd','hm','hy',
     GLB_AVEPERIO = 1,  30, 365,
     ...
     LYR_TEMP     = 0,   4,   0,
     ...

which means that the model layered temperature has a monthly mean output with single precision (4-byte;real4), e.g. ::

   0    - variable is not written
   2    - variable is written as int2 with scale factor and offset
   4    - variable is written as real4
   8    - variable is written as real8


If one would like output of yearly mean layered temperature, simply change LYR_TEMP in user_nl_blom to::

   LYR_TEMP     = 0,   0,   4,

Available output variables for BLOM and iHAMOCC are documented in the resolved namelist file (see CaseDocs/ocn_in after running ./preview_namelists or building the case).


Code modification
^^^^^^^^^^^^^^^^^

To make more subtantial modification to the BLOM/iHAMOCC code than what is possible by the use of user_nl_blom, there are two methods:

1. Make a branch from the NorESM2 version (branch or release) you want to modify, checkout this branch in order to make code changes directly in the source code folder.

2. Copy the source code (the fortran file(s) you want to modify) to the SourceMods/src.blom folder in the case directory, and then make the modifications needed before building the model. By the use of this method, you will not change the source code in the <noresm-base> folder.

As mentioned above, if you need to change a model parameter for iHAMOCC you need to modify the source code. All iHAMOCC parameters are defined in the routine beleg_parm.F90.

The BLOM source code is located in::
  
  <noresm-base>/components/blom/

The iHAMOCC source code is located in::

  <noresm-base>/components/blom/hamocc
  

CICE
''''
The sea ice model component is based upon version 5.1.2 of the CICE sea ice model of Hunke et al. (2015). 

Initial conditions
^^^^^^^^^^^^^^^^^^

By default, the CICE model is initialized with a 'default', simplified, sea ice field with sea ice in cold regions (air temperature below 0 degree C), north of 70 N and south of 60 S. The sea ice thickness in these regions is horizontal homogeneous, with a uniform snow cover. This behavior is given by the ice_ic variable in the namelist. This can be changed to start without sea ice by setting:

::

  &setup_nml
    ice_ic = "none"

::

in the user_nl_cice in the case folder, or by specifying a restart file which would give the desired sea ice state:

::

  &setup_nml
    ice_ic = "PATH_TO_FILE/NAME_OF_FILE.cice.r.YEAR-01-01-00000.nc"
::

The file used for NorESM2-MM CMIP6 piControl simulation is::

  finidat = N1850_f09_tn14_20190913.cice.r.1200-01-01-00000.nc
  
The file used for NorESM2-LM CMIP6 piControl simulation is::

  finidat = N1850_f19_tn14_11062019.cice.r.1600-01-01-00000.nc
  
Information about which file is used as an initial condition (in addition to parameter settings and other files used as input) file is in ice_in. This file can be found in::

  <casefolder>/CaseDocs/ice_in
  
and in the Run folder::

  <RUN_DIR>/case/run/ice_in
  
This information is also written to the ice.log.* file generated during the run.   
  
NorESM2 specific addition
^^^^^^^^^^^^^^^^^^^^^^^^^
A NorESM2-specific change is including the effect of wind drift of snow into ocean following Lecomte et al. (2013)
This change can be tuned on/off in the user_nl_cice in the case folder. Default is::

  &snowphys_nml
    blowingsnow = "lecomte2013"
    ksno = 0.3
    rhos = 330.0


and will use NorESM2 treatment of wind drift of snow. Setting

::
 
 &snowphys_nml
  blowingsnow = "none"

::

will reset the NorESM2 specific addition and the effect of wind drift of snow into ocean will not be included. It is also possible to change the snow density ``rhos`` and the snow thermal conductivity ``ksno``. Be aware that this will influence the overall tuning of the coupled model. 

Modify user name lists for CICE
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Output from the model is changed by controlling the user_nl_cice file in your casefolder. By default, the file typically looks like this: 
::

   histfreq = 'm','d','x','x','x'
   histfreq_n = 1,1,1,1,1
   f_CMIP = 'mdxxx'
   f_hi ="mxxxx"
   f_hs="mxxxx"
   f_fswdn="mxxxx"
   f_fswabs="mxxxx"
   f_congel="mxxxx"
   f_frazil="mxxxx"
   f_meltt="mxxxx"
   f_melts="mxxxx"
   f_meltb="mxxxx"
   f_meltl="mxxxx"
   f_fswthru="mxxxx"
   f_dvidtt="mxxxx"
   f_dvidtd="mxxxx"
   f_daidtt="mxxxx"
   f_daidtd="mxxxx"
   f_apond_ai="mxxxx"
   f_hpond_ai="mxxxx"
   f_apeff_ai="mxxxx"
   f_snowfrac="mxxxx"
   f_aicen="mxxxx"
   f_snowfracn="mxxxx"

::

where the ``f_*`` flags are used to change the writing of specific variables, and the ``histfreq`` and ``histfreq_n`` variables are used to specify type of history files written, and their frequency. The ``f_CMIP`` flag activates the specific SIMIP/CMIP variables used the CMIP6 runs. By default, the model writes extensive output with a monthly frequency, and more limited at daily basis. 

The easiest way to turn of daily output from CICE is to put
::

   histfreq = 'm','x','x','x','x'

:: 

in the user_nl_cice file. 

High-frequency output can be achieved by manipulating the  ``histfreq`` and ``histfreq_n`` variables, together with the specific variable should be at higher frequency. To use 3-hourly output of the sea ice velocity from the model set
::
   histfreq = 'm','d','h','x','x'
   histfreq_n = 1,1,3,1,1
   f_siu = 'm,d,h,x,x'
   f_siv = 'm,d,h,x,x'
::

Be aware that the model writes one file per time step. Therefore, this should be done for short runs, only, and the high-frequency output should be collected together in one (or a few) larger files after the model run, e.g. by using the ``ncrcat`` command. 



Code modification
^^^^^^^^^^^^^^^^^
To make more subtantial modification to the code than what is possible by the use of user_nl_cice, there are two methods:

1. Make a branch from the NorESM2 version (branch or release) you want to modify, checkout this branch in order to make code changes directly in the source code folder.

2. Copy the source code (the fortran file(s) you want to modify) to the SourceMods/src.cice folder in the case directory, and then make the modifications needed before building the model. By the use of this method, you will not change the source code in the <noresm-base> folder.

The CICE source code is located in::
  
  <noresm-base>/components/cice/src/
  

More information is found in the CESM-CICE User Guide:
https://cesmcice.readthedocs.io/en/latest/


References
^^^^^^^^^^

Dai, A., Qian, T., Trenberth, K. E., and Milliman, J. D.: Changes in continental freshwater discharge from 1948 to 2004, J. Climate, 22, 2773–2792, https://doi.org/10.1175/2008JCLI2592.1, 2009.

Griffies et al., Coordinated Ocean-ice Reference Experiments (COREs), Ocean Model., 26, 1–46, doi:10.1016/j.ocemod.2008.08.007, 2009.

Griffies et al., OMIP contribution to CMIP6: experimental and diagnostic protocol for the physical component of the Ocean Model Intercomparison Project, Geosci. Model Dev., 9, 3231–3296, https://doi.org/10.5194/gmd-9-3231-2016, 2016.

Hunke, E. C., et al. "CICE: The Los Alamos Sea ice Model Documentation and Software User’s Manual Version 5 (Tech. Rep. LA-CC-06–012)." Los Alamos, NM: Los Alamos National Laboratory (2015).

Hunke, Elizabeth, Lipscomb, William, Jones, Philip, Turner, Adrian, Jeffery, Nicole, and Elliott, Scott. CICE, The Los Alamos Sea Ice Model. Computer software. https://www.osti.gov//servlets/purl/1364126. 

Large, W. and S. Yeager, 2004: Diurnal to decadal global forcing for ocean and sea-ice models: the datasets and flux climatologies. NCAR Technical Note: NCAR/TN-460+STR, CGD Division of the National Centre for Atmospheric Research.

Large, W.G. and S.G. Yeager. 2009: The global climatology of an interannually varying air-sea flux data set. Climate Dynamics, 33, 341-364, doi:10.1007/s00382-008-0441-3.

Lecomte, O., T. Fichefet, M. Vancoppenolle, F. Domine, F. Massonnet, P. Mathiot, S. Morin, and P.Y. Barriat (2013), On theformulation of snow thermal conductivity in large-scale sea ice models, J. Adv. Model. Earth Syst., 5, 542–557, doi:10.1002/jame.20039

Orr et al., Biogeochemical protocols and diagnostics for the CMIP6 Ocean Model Intercomparison Project (OMIP), Geosci. Model Dev., 10, 2169–2199, https://doi.org/10.5194/gmd-10-2169-2017, 2017.

Steele, M., Morley, R., and Ermold, W.: PHC: A Global Ocean Hydrography with a High-Quality Arctic Ocean, J. Climate, 14, 2079–2087, 2001.

Tsujino et al., Evaluation of global ocean–sea-ice model simulations based on the experimental protocols of the Ocean Model Intercomparison Project phase 2 (OMIP-2), Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-363, in review, 2020.


