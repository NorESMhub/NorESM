.. _omips:

Ocean and Sea-Ice
==================

WILL BE UPDATED BY chgu@norceresearch.no 

BLOM
'''''''

Initial conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^

In the OMIP-type experiments, the ocean was initialized from rest, and the initial ocean temperature and salinity were from the Polar Science Center Hydrographic Climatology (PHC) 3.0, updated from Steele et al. (2001). **[note by CG: the following needs to be checked by ocean BGC people]** For initialization of the ocean biogeochemical fields, we use the climatological fields from the World Ocean Atlas (WOA; i.e., for oxygen, nitrate, silicate, and phosphate; Garcia et al., 2010a, b) and the Global Ocean Data Analysis Project (GLODAP; i.e., for alkalinity and pre-industrial dissolved inorganic carbon; Key et al., 2004).


The initial condition file containing ocean temperature and salinity for the one-degree OMIP experiments is located at (on Fram) ::

  /cluster/shared/noresm/inputdata/ocn/micom/tnx1v4/20170601/inicon.nc
  
The file contains values for layered potential density (sigma: sigma2 - 1000), potential temperature (temp), salinity (saln) and thickness (dz):

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
::




OMIP-type experiments
^^^^^^^^^^^^^^^^^^^^^^^^^^


The Ocean Model Intercomparison Project (OMIP; Griffies et al., 2016) is an endorsed project in the CMIP6. OMIP provides a protocol for global ocean/sea-ice models forced by a common prescribed atmospheric forcing, and a protocol for ocean diagnostics to be saved as part of CMIP6. OMIP includes a physical component (Griffies et al., 2016) and a biogeochemistry component (Orr et al. 2017).

Prior to OMIP, the framework of the Coordinated Ocean-ice Reference Experiments (CORE) provides ocean and climate modellers with a common protocol for running coupled ocean/sea-ice models with boundary forcing derived from common atmospheric datasets. The CORE forcing dataset was described by Large and Yeager (2004, 2009), which is largely based on the surface-atmospheric fields derived from NCEP/NCAR atmospheric reanalysis . CORE has subsequently evolved into phase 1 of the physical part of OMIP (OMIP-1). The OMIP1/CORE-II experiment forces the ocean through use of the interannually varying atmospheric state of Large and Yeager (2009), along with river runoff data based on Dai et al. (2009).

The Large and Yeager (2009) forcing dataset covers the period from 1948 to 2009, and has not been updated since 2009. Thereafter, Tsujino et al. (2018) developed a surface atmospheric dataset based on the Japanese 55-year atmospheric reanalysis (JRA-55; Kobayashi et al., 2015), referred to as JRA55-do, which has been endorsed under the protocol for phase 2 of OMIP (OMIP-2). Currently, JRA55-do covers the period from 1958 to 2018 with planned continuous annual updates. Comparing to CORE-II, the JRA55-do forcing has an increased temporal frequency (from 6 hours to 3 hours), and a refined horizontal resolution (from 1.875° to 0.5625°).

The readers are referred to Large and Yeager (2009) and Tsujino et al. (2018) for a detailed description of the CORE-II and JRA55-do forcing, respectively, including the bulk formulae used for computing turbulent fluxes for heat and momentum. An evaluation and comparison of the simulated ocean and sea ice mean states and variability from 11 state-of-the-art global ocean/sea-ice models (including NorESM-BLOM), based on OMIP-1/CORE-II and OMIP-2/JRA55-do, is presented by Tsujino et al. (2020).



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
^^^^^^^^^^^^^


- **OMIP-1/CORE-II**
  
  Forcing dataset described in detail by Large and Yeager (2009). The forcing files are located at (on Fram) ::
  
  /cluster/shared/noresm/inputdata/ocn/iaf/


- **OMIP-2/JRA55-do**

  Forcing dataset described in detail by Tsujino et al. (2018). The forcing files are located at (on Fram) ::

  /cluster/shared/noresm/inputdata/ocn/jra55/v1.3_noleap/



Modify user name lists for BLOM
^^^^^^^^^^^^^^^^^^^^^^^^^^
How do you set the initial condition file in user_nl_blom??? And what can you set in user_nl_blom? How do you modify the output? and the output frequency? PLEASE EXPLAIN
Note that BLOM uses a different sytax than the rest. In user_nl_blom::

  set BDMC2   = .15
  set NIWGF = .5

you need to include **set** before the name of the variable and it does not matter what namelist group the variable belong.


Code modification
^^^^^^

If you want to make more subtantial changes to the codes than what is possible by the use of user_nl_blom, you need to copy the source code (the fortran file you want to modify) to the SourceMods/src.blom folder in the case directory, then make the modifications needed before building the model. **Do not change the source code in the <noresm-base> folder!**

The BLOM source code is located in::
  
  <noresm-base>/components/blom/??/
  
iHAMOCC
''''''''

Initial conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^

Modify user name lists for iHAMOCC
^^^^^^^^^^^^^^^^^^^^^^^^^^
For iHAMOCC you can only set output options via user_nl_blom. Changes of parameter values need to be done as described in the **Code modification**.

Code modification
^^^^^^

If you want to make more subtantial changes to the codes than what is possible by the use of user_nl_blom, you need to copy the source code (the fortran file you want to modify) to the SourceMods/src.blom folder in the case directory, then make the modifications needed before building the model. **Do not change the source code in the <noresm-base> folder!**

The iHAMOCC source code is located in::
  
  <noresm-base>/components/blom/hamocc/


CICE
''''''
The sea ice model component is based upon version 5.1.2 of the CICE sea ice model of Hunke et al. (2015). 

Initial conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^

The CICE model is initialized from ?

::

   /cluster/shared/noresm/inputdata/ice/cice/SOME_FILE??

::

The inital state file can be set in user_nl_cice in the case folder :

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
  
NorESM2 specific addions
^^^^^^^^^^^^^^^^^^^^^^^^^^
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

will reset the NorESM2 specific addition and the effect of wind drift of snow into ocean will not be included. 

Modify user name lists for CICE
^^^^^^^^^^^^^^^^^^^^^^^^^^
Syntax - same as cam? or same as blom?

An example of how you can modify user_nl_cice. PLEASE EXPLAIN!
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

Code modification
^^^^^^

If you want to make more subtantial changes to the codes than what is possible by the use of user_nl_cice, you need to copy the source code (the fortran file you want to modify) to the SourceMods/src.cice folder in the case directory, then make the modifications needed before building the model. **Do not change the source code in the <noresm-base> folder!**

The CICE source code is located in::
  
  <noresm-base>/components/cice/src/
  
and what about::

  components/micom/icedyn/ ??



CICE User Guide:
https://cice-consortium-cice.readthedocs.io/en/master/user_guide/


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


