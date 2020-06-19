.. _experiments:

Experiments
===========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settings are defined by the so called compsets.

For a quick-start guide on how to create, configure, build, and submit a NorESM experiment, see the :ref:`newbie-guide`. More details are provided below, for the more advanced users. 


Create and configure a new case
^^^^^^^^^^^^^^^

To start a new experiment you need to create and configure a case. After running the ::

  ./create_newcase

script, a case folder ``<path_to_case_dir>/<casename>`` is created that contains set-up files for your experiment. Then, after running the ::

  ./case.setup

script, several other files and directories needed to build the case are created, including the user user namelists files.

The create_newcase script includes a ``--compset`` option. A compset, or component set, is a collection of predefined setting that defines your experiment set-up, including which model components that should be activated. Some of the available compsets are described below.

The case folder contains predefined namelist (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the ``user_nl_<component>`` file.

Several configuration options are available in the usermods directories in ``<noresm_base>/cime_config/usermods_dirs/``. These folders contain information about output variables and frequencies from clm (land) and cam (atmosphere). In addition one SourceMod is included in ``SourceMods/src.cam/preprocessorDefinitions.h`` to define if AEROFFL and AEROCOM are included for extra aerosol diagnostics (for more details about the aerosol diagnostics see ``??``)

Remember that the amount of diagnostics and the output frequency have a huge impact on both the run time and storage. 

``--user-mods-dir cmip6_noresm_*`` ::

  cmip6_noresm_DECK (AEROFFL)    
  cmip6_noresm_hifreq (high frequency output, AEROFFL)    
  cmip6_noresm_hifreq_xaer (high frecuency output, AEROFFL and AEROCOM)   
  cmip6_noresm_xaer (AEROFFLand AEROCOM)    

For more details about the user-mod-dir options, check this folder ::

<noresm_base>/cime_config/usermods_dirs


The xmlchange and xmlquery scripts
^^^^^^^^^^^

The ``xmlchange`` and ``xmlquery`` scripts are located in your case folder and lets you change or query the contents of variables in the ``evn_*.xml`` files without entering the files. There are two advantages of using ``xmlchange`` to edit the xml files rather than doing by hand: (1) the ``xmlchange`` script checks that the new setting is valid and (2) the change is echoed to the ``CaseStatus`` file, thus automatically documented. To change from the default ``ndays`` to ``nmonths`` ::

  ./xmlchange STOP_OPTION=nmonths
  
It's also possible to change several variables at once, for instance ::

  ./xmlchange STOP_OPTION=nmonths,STOP_N=14

See the header of ``xmlchange`` and ``xmlquery`` for more details and examples.


Create a clone case
^^^^^^^^^^^^^^^^^^^
To create clone cases from a control case can be very useful for e.g. sensitivity studies. If you want to make a copy of a case (i.e. identical ``./create_newcase`` command and identical ``env_*.xml``, ``user_nml_<component>`` and ``SourceMods`` files) that can be done by the use of ``./create_clone``. You only need to give the casename of the new case and the casename of the case which sholud be cloned (copied). The case will have identical set up (``env_*.xml``, ``user_nml_<component>`` files and ``SourceMods``) as the clone, but these files can of course be modified before building the case.


Compsets
^^^^^^^^

Compsets, or component sets, specify which component models will be used in your simulation along with which forcing files, and even which physics options to use. Each compset has a long name (lname) and an alias. For instance ``N1850`` is the alias for the NorESM compset for pre-industrial (1850) conditions. The long name for ``N1850`` is ::
  
  1850_CAM60%NORESM_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS
  
The long name generally follows the notation ::

  TIME_ATM[%phys]_LND[%phys]_ICE[%phys]_OCN[%phys]_ROF[%phys]_GLC[%phys]_WAV[%phys][_ESP%phys][_BGC%phys] 

(see the help section of the file ``<noresm_base>/cime_config/config_compsets.xml`` for details). The compsets can also include information on which grids are scientifcally supported (see below for details). 

All predefined compsets for **coupled simulations** can be found in ::

  <noresm_base>/cime_config/config_compsets.xml

Predefined compsets for **AMIP-type (atmsophere/land-only) simulations** can be found in ::  

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  
Predefined compsets for running the sea-ice model as a stand-alone model cam be found in ::

  <noresm_base>/components/cice/cime_config/config_compsets.xml

Predefined compsets for running the land model as a stand-alone model can be found in ::

  <noresm_base>/components/clm/cime_config/config_compsets.xml
  
Predefined compsets for running the ocean model as a stand-alone model can be found in ::

  <noresm_base>/components/blom/cime_config/config_compsets.xml
  
The compsets starting with N are NorESM coupled configurations. Compsets starting with NF are NorESM AMIP (atmosphere only) configurations. Some examples are given below.

**N1850 and N1850frc2**  
  Coupled configuration for NorESM for pre-industrial (1850) conditions.

**NHIST and NHISTfrc2**
  Historical configuration from 1850 up to year 2015 (see detailed description below; 'Create your own compsets for AMIP simulations')

**NSSP126frc2, NSSP245frc2, NSSP370frc2, NSSP585frc2**  
  Future scenario compsets from 2015 to 2100
  
**NFHISTnorpddmsbc**  
  AMIP simulation with time-evolving prescribed observed values for SSTs and sea ice and upper-ocean DMS values derived from a fully coupled NorESM2 simulation for present-day conditions
  
**frc2 emission files**
  The frc2 option uses differently organized emission files. The frc2 files are located in ::
  
  <PATH_TO_INPUTDATA>/noresm/inputdata/atm/cam/chem/emis/cmip6_emissions_version20190808
  
A new set of emission files have been made to avoid the occurence of random mid-month model crashes. These crashes are related to the reading of emission files, but are still under investigation. To use the newest emission files choose compsets including *frc2* or if you  want to create a new compset add ::

  %FRC2
 
to NORESM2. For a detailed description, see **Creating your own compset** below.

For an overview of the compsets provided for CESM2, please see: http://www.cesm.ucar.edu/models/cesm2/config/compsets.html.


**Supported grids**

Most compsets contain an entries listing which which grid(s) are scientifically supported for that compset ::

<science_support grid="xxx"/> fields

When a compset has a scientifically-supported grid, you can create a new case (with the create_newcase script) without having to use the option ``--run-unsupported``. If the compset does not list any scientifically-supported grids, or if you want to use a grid configuration is not included in the definition of the compset, the ::

  --run-unsupported

option is required when a case is created or the create_newcase script will fail.


Creating your own compset
^^^^^^^^^^^^^^^^^^^^^^^^^
The essential file to edit for a new coupled NorESM compset is :: 

  <noresm_base>/cime_config/config_compsets.xml
  
and for a new AMIP NorESM compset is :: 

  <noresm_base>/components/cam/cime_config/config_compsets.xml
  
  
**Coupled simulation** 

This examples shows how to simply add the "N1850frc2" compset to ``config_compsets.xml``. In ``<noresm_base>/cime_config/config_compsets.xml`` the N1850frc2 is set as ::

  <compset>
    <alias>N1850frc2</alias>
    <lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>
  </compset>
 
where 

``<alias>COMPSETNAME</alias>``
sets the compsets name used when building a new case. Make sure to use a new and unique compset name. The details of the compset i.e. which models components and component-specific configurations to use are set in ::

<lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>

It is also possible to just add that line (without the <lname>) when creating a new case. 

'_' seperates between model components ::

_<MODEL>
  
and '%' sets the component-specific configuration ::

%MODEL_CONFIGURATION

E.g. 

- 1850_CAM60%NORESM%FRC2
   - Forcing and input files read from pre-industrial conditions (1850). If you need a historical run replace 1850 with HIST
   - Build CAM6.0 (the atmosphere model) with NorESM configuration and FRC2 organized emission files
- CLM50%BGC-CROP
   - Build CLM5 (land model) with Biogeochemistry and prognotic crop package 
- CICE%NORESM-CMIP6
   - Build CICE (sea-ice model) with NorESM2-CMIP6 setup 
- BLOM%ECO
   - Build BLOM (ocean model) including iHAMOCC biogeochemistry model
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
The case is built by ::

  ./case.build

All user modifications to ``env_run.xml``, ``env_mach_pes.xml``, ``env_batch.xml`` must be done before ``case.build`` is invoked. This is also the case for the aforementioned user-made namelists: i.e. ``user_nl_cam``, ``user_nl_cice``, ``user_nl_clm``, ``user_nl_blom``, ``user_nl_cpl``). 

If you want to ensure your case is ready for submission, you can run ::
  
  ./check_case
  
which will:

- Ensure that all of the env xml files are in sync with the locked files
- Create namelists (thus verifying that there will be no problems with namelist generation)
- Ensure that the build is complete

Running this is completely optional: these checks will be done
automatically when running case.submit. However, you can run this if you
want to perform these checks without actually submitting the case.

As a last step, remember to copy restart files to run directory if you are running a branch run or a hybrid run.


Submitting the case
^^^^^^^^^^^^^^^^^^^
The case is submitted by ::

  ./case.submit


Resolution
''''''''''

Model resolution is set when the case is created. Below some common resolutions are listed. A complete list of model grids can be found here:
::
  
  <noresm_base>/cime/config/cesm/config_grids.xml


Atmospheric grids
^^^^^^^^^^^^^^^^^
::

  f19_f19 - atm lnd 1.9x2.5
  f09_f09 - atm lnd 0.9x1.25  
  f09_f09_mg17


Ocean grids
^^^^^^^^^^^
Currently, BLOM supports three resolutions, nominal 2,1, and 1/4 degrees in a tripolar grid configuration:
::

  tnx1v4   - tripolar ocn ice 1-degree grid  
  tnx2v1   - tripolar ocn ice 2-degree grid  
  tx0.25v4 - tripolar ocn ice 1/4-degree grid  


Coupled
^^^^^^^
::

  f19_tn14   - atm lnd 1.9x2.5, ocnice tnx1v4  [CMIP6 grid, NorESM2-LM]  
  f09_tn14   - atm lnd 0.9x1.25, ocnice tnx1v4  [CMIP6 grid, NorESM2-MM]  
  f09_tn0254 - atm lnd 0.9x1.25, ocnice tnx0.25v4  



Forcing
''''''''''''''''
Please see :ref:`input`

Choosing output
'''''''''''''''
please see :ref:`output`

Setting up a nudged simulation
''''''''''''''''''''''''''''''
please see :ref:`nudged_simulations`
