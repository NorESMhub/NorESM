.. _experiments:

Experiments
===========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settings are defined by the so called compsets.

Basic case set up, compilation and job submission with NorESM
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This is a general description/checklist for how to create a new experiment with NorESM. For a quick start guide, see also :ref:`newbie-guide`. The case creation step is explained in more detail below.

- Create a case::

    cd <noresm-base>/cime/scripts
    ./create_newcase --case <path_to_case_dir>/<casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project <project_name> --user-mods-dir <user_mods_dir> --output-root <path_to_run_dir>/<noresm_run_dir> --run-unsupported 
   
  Note!
  
  **--walltime <time>** can be set in env_batch.xml in the case directory after building the new case and is not necessary to include when creating a new case

  **--output-root <path_to_run_dir>/<noresm_run_dir>** only required if the noresm_run_dir differ from default <path_to_run_dir>/noresm/ 
  
  **--run-unsupported** required if the grid resolution is not supported in the compset (see detailed description below)

  Example of case creation on Fram::

    ./create_newcase --case ../../../cases/test1910_1 --compset N1850 --res f19_tn14 --machine fram --project snic2019-1-2 --user-mods-dir cmip6_noresm_DECK --run-unsupported

  Example of case creation on Tetralith::

    ./create_newcase --case ../../../cases/test1910_1 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out --run-unsupported
    
- Create a clone::
  
    cd <noresm-base>/cime/scripts
    ./create_clone --case <path_to_case_dir>/<casename> --clone <path_to_case_dir>/<casename_of_clone>
  

- Configure case::

    cd <path_to_case_dir>/casename
    ./case.setup


- Add code changes

  Copy your code changes to the folder::

    <path_to_case_dir>/casename>/SourceMods/src.<component>

- Edit namelist::

    <path_to_case_dir>/casename>/user_nl_<component>

- Edit run configuration::

    env_run.xml


- Build model::

    ./case.build

Make sure to include all modifications to user_nl_*, env_*.xml, SourceMods etc. before you build

- Copy restart files to run directory (if the case is a branch or a hybrid experiment) 


- Submit job::

    ./case.submit

Create new case
^^^^^^^^^^^^^^^

To start a new experiment you need to create a case. When creating a case a case folder <path_to_case_dir>/<casename> will be created that contains all the settings for your experiment

The case creation contains a compset option. A compset is a collection of predefined setting that defines your experiment setup, including which model components that are activated. Some of the available compsets are described below.

The case folder contains predefined namelist (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the user_nl_<component>

Several configuration options are available in the usermods directories in <noresm_base>/cime_config/usermods_dirs/  . These folders contain information about output variables and frequencies from clm (land) and cam (atmosphere). In addition one SourceMod is included in SourceMods/src.cam/preprocessorDefinitions.h to define if AEROFFL and AEROCOM are included for extra aerosol diagnostics (for more details about the aerosol diagnostics see )

Remeber that the amount of diagnostics and the output frequency have a huge impact on both the run time and storage. 

--user-mods-dir cmip6_noresm_* ::

  cmip6_noresm_DECK (AEROFFL)    
  cmip6_noresm_hifreq (high frequency output, AEROFFL)    
  cmip6_noresm_hifreq_xaer (high frecuency output, AEROFFL and AEROCOM)   
  cmip6_noresm_xaer (AEROFFLand AEROCOM)    

For more details about the user-mod-dir options, check this folder::

<noresm_base>/cime_config/usermods_dirs


Create a clone case
^^^^^^^^^^^^^^^^^^^
To create clone cases from a control case can be very useful for e.g. sensitivity studies. If you want to make a copy of a case (i.e. identical ./create_newcase command and identical env_*.xml, user_nml_<component> and SourceMods files) that can be done by the use of ./create_clone . You only need to give the casename of the new case and the casename of the case which sholud be cloned (copied). The case will have identical set up (env_*.xml, user_nml_<component> files and SourceMods) as the clone, but these files can of course be modified before building the case.

Compsets
^^^^^^^^
Below some compsets are listed. All predefined compsets for coupled simulations can be found in::

  <noresm_base>/cime_config/config_compsets.xml
  
And predefined compsets for AMIP (atmsophere only) simulations can be found in::  

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  
The compsets starting with N are NorESM coupled configurations. Compsets starting with NF are NorESM AMIP (atmosphere only) configurations.  

**N1850 and N1850frc2 (uses differently organized emission files : FRC2)**  
  Coupled configuration for NorESM for pre-industrial conditions.

**NHIST and NHISTfrc2  (uses differently organized emission files : FRC2)**  
  Historical configuration up to year 2015 (see detailed description below; 'Create your own compsets for AMIP simulations')

**NSSP126frc2, NSSP245frc2, NSSP370frc2, NSSP585frc2**  
  Future scenario compsets from 2015 to 2100
 
**Supported grids**

Most compsets contain a science_support grid which state what grid configurations we support::

<science_support grid="xxx"/> fields

and a case can be created without the option::

  --run-unsupported 

If you want a different grid configuration or the grid configuration is not included in the definition of the compset, the::

  --run-unsupported

option is required when a case is created.

Creating your own compset
^^^^^^^^^^^^^^^^^^^^^^^^^
The essential file to edit for a new coupled NorESM compset is:: 

  <noresm_base>/cime_config/config_compsets.xml
  
and for a new AMIP NorESM compset is:: 

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  

**Coupled simulation** 

This examples shows how to simply add the "N1850frc2" compset to config_compsets.xml . In <noresm_base>/cime_config/config_compsets.xml the N1850frc2 is set as::

  <compset>
    <alias>N1850frc2</alias>
    <lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_MICOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>
  </compset>
 
where 

<alias>COMPSETNAME</alias> 
sets the compsets name used when building a new case. Make sure to use a new and unique compset name. The details of the compset i.e. which models components and component-specific configurations to use are set in 

<lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_MICOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>. It is also possible to just add that line (without the <lname>) when creating a new case. 

'_' seperates between model components::

_<MODEL>
  
and '%' sets the component-specific configuration::

%MODEL_CONFIGURATION

E.g. 

- 1850_CAM60%NORESM%FRC2
   - Forcing and input files read from pre-industrial conditions (1850). If you need a historical run replace 1850 with HIST
   - Build CAM6.0 (the atmosphere model) with NorESM configuration and FRC2 organized emission files
- CLM50%BGC-CROP
   - Build CLM5 (land model) with Biogeochemistry and prognotic crop package 
- CICE%NORESM-CMIP6
   - Build CICE (sea-ice model) with NorESM2-CMIP6 setup 
- MICOM%ECO
   - Build MICOM (ocean model BLOM) including the iHAMOCC
- MOSART
   - Build MOSART (river runoff model) with default configurations
- SGLC_SWAV
   - The SGLC (land-ice) and SWAV (ocean-wave) models are not interactive, but used only to satisy the interface requirements 
- BGC%BDRDDMS
   - ocean biogeochemistry model iHAMOCC run with interactive DMS


**AMIP simulation**

For details about AMIP simulation compsets, please see :ref:`amips`




Building the case
^^^^^^^^^^^^^^^^^^
The case is build by:

::

  ./case.build

::

All user modifications to env_run.xml, env_mach_pes.xml, env_batch.xml must be done before case.build is invoked. This is also the case for the aforementioned user made name lists: i.e. user_nl_cam, user_nl_cice, user_nl_clm, user_nl_micon, user_nl_cpl).


If you want to ensure your case is ready for submission, you can run:

::
  
  ./check_case
  
::

which will:

- Ensure that all of the env xml files are in sync with the locked files
- Create namelists (thus verifying that there will be no problems with namelist generation)
- Ensure that the build is complete

Running this is completely optional: these checks will be done
automatically when running case.submit. However, you can run this if you
want to perform these checks without actually submitting the case.

Submitting the case
^^^^^^^^^^^^^^^^^^^
The case is submitted by:

::

  ./case.submit

::



Resolution
''''''''''

Model resolution is set when the case is created. Below some common resolutions are listed. A complete list of model grids can be found here:::
  
  <noresm_base>/cime/config/cesm/config_grids.xml

Atmospheric grids
^^^^^^^^^^^^^^^^^


| f19_f19 - atm lnd 1.9x2.5  
| f09_f09 - atm lnd 0.9x1.25  
| f09_f09_mg17

Ocean grids
^^^^^^^^^^^
Which ocean grid is recommended?

| tnx1v1 tripole v1 1-deg grid  
| tnx1v3 tripole v3 1-deg grid  
| tn14(?)tripole v4 1-deg grid  tripole ocean grid  
| tnx2v1 tripole v1 2-deg grid  
| tx1v1 tripole v1 1-deg grid: testing proxy for high-res tripole ocean grids- do not use for scientific experiments  

Coupled
^^^^^^^
| f09_tn11   - atm lnd 0.9x1.25, ocnice tnx1v1
| f09_tn13   - atm lnd 0.9x1.25, ocnice tnx1v3
| f09_tn14   - atm lnd 0.9x1.25, ocnice tnx1v4  [CMIP6 grid]
| f09_tn0251 - atm lnd 0.9x1.25, ocnice tnx0.25v1
| f09_tn0253 - atm lnd 0.9x1.25, ocnice tnx0.25v3
| f19_tn11   - atm lnd 1.9x2.5, ocnice tnx1v1
| f19_tn13   - atm lnd 1.9x2.5, ocnice tnx1v3
| f19_tn14   - atm lnd 1.9x2.5, ocnice tnx1v4  [CMIP6 grid]

Simulation period
''''''''''''''''''''''''''

Some compsets only go with certain time periods?

Forcing
''''''''''''''''
Please see :ref:`input`

Choosing output
'''''''''''''''
please see :ref:`output`

Setting up a nudged simulation
''''''''''''''''''''''''''''''

please see :ref:`nudged_simulations`


Setting up a hybrid simulation
''''''''''''''''''''''''''''''

Step by step guide for hybrid simulation/restart.

When the case is created and compiled, edit ``env_run.xml``. Below is an example for restart with CMIP6 historical initial conditions::



    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFDIR" value="path/to/restars">                  # path to restarts
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="TRUE">                            # get refcase from outside rundir

If it is not possible to link directly to restarts, copy the restart files and rpointer files to the run directory. Below is example changes to ``env_run.xml``::


    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # Experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="FALSE">                           # get refcase from outside rundir
