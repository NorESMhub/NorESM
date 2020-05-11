.. _omips:

Ocean and Sea-Ice
==================

WILL BE UPDATED BY chgu@norceresearch.no 

BLOM
'''''''

Initial conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^
The BLOM model is initialized from inicon.nc
e.g. on Fram @ Simga2 ::

  /cluster/shared/noresm/inputdata/ocn/micom/tnx1v4/20170601/inicon.nc
  
The file contains values for thickness (sigma: density - 1000), temperature (temp), salinity (saln) and depth (dz):

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

Where are these values taken from? WOA? If so, which version?




OMIP-type experiments
^^^^^^^^^^^^^^^^^^^^^^^^^^


Oceanic Model Intercomparison Project (OMIP) style runs are runs in which the ocean and sea-ice components are active while values for atmospheric near surface air temperature, wind stress ++??, land?? are prescribed (that is, read from a file). 


Creating an OMPI case
^^^^^^^^^^^^^^^^^^^^^
PLEASE change the compset description below!
::

   cd <noresm-base>/cime/scripts
   ./create_newcase --case <path_to_case_dir>/<casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project <project_name> --user-mods-dir <user_mods_dir> --output-root <path_to_run_dir>/<noresm_run_dir> --run-unsupported 
   

::


OMIP compsets
^^^^^^^^^^^^^


Forcing sets
^^^^^^^^^^^^^


- **CORE-II forcing**
  

- **JRA-55**


Modify user name lists for BLOM
^^^^^^^^^^^^^^^^^^^^^^^^^^
How do you set the initial condition file in user_nl_blom??? And what can you set in user_nl_blom? PLEASE EXPLAIN
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
Hunke, E. C., et al. "CICE: The Los Alamos Sea ice Model Documentation and Software User’s Manual Version 5 (Tech. Rep. LA-CC-06–012)." Los Alamos, NM: Los Alamos National Laboratory (2015).

Hunke, Elizabeth, Lipscomb, William, Jones, Philip, Turner, Adrian, Jeffery, Nicole, and Elliott, Scott. CICE, The Los Alamos Sea Ice Model. Computer software. https://www.osti.gov//servlets/purl/1364126. 

Lecomte, O., T. Fichefet, M. Vancoppenolle, F. Domine, F. Massonnet, P. Mathiot, S. Morin, and P.Y. Barriat (2013), On theformulation of snow thermal conductivity in large-scale sea ice models, J. Adv. Model. Earth Syst., 5, 542–557, doi:10.1002/jame.20039
