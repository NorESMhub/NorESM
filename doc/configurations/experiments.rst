.. _experiments:

Experiments
===========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settings are defined by the so-called compsets.

For a quick-start guide on how to create, configure, build, and submit a NorESM experiment, see the :ref:`newbie-guide`. More details are provided below, for the more advanced users. 


Create and configure a new case
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To start a new experiment you need to create and configure a case. After running the ::

  ./create_newcase

script, a case folder ``<path_to_case_dir>/<casename>`` is created that contains set-up files for your experiment. Then, after running the ::

  ./case.setup

script, several other files and directories needed to build the case are created, including the user namelists files. 

The case folder contains predefined namelists (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the ``user_nl_<component>`` file.


The create_newcase script includes a ``--compset`` option. A compset, or component set, is a collection of predefined setting that defines your experiment set-up, including which model components that should be activated. Some of the available compsets are described below.


Compsets
'''''''''''''

Compsets, or component sets, specify which component models will be used in your simulation along with which forcing files, and even which physics options to use. Each compset has a long name (lname) and an alias. For instance ``N1850`` is the alias for the NorESM compset for pre-industrial (1850) conditions. The long name for ``N1850`` is ::
  
  1850_CAM60%NORESM_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS
  
The long name generally follows the notation ::

  TIME_ATM[%phys]_LND[%phys]_ICE[%phys]_OCN[%phys]_ROF[%phys]_GLC[%phys]_WAV[%phys][_ESP%phys][_BGC%phys] 

(see the help section of the file ``<noresm_base>/cime_config/config_compsets.xml`` for details). The compsets can also include information on which grids are scientifically supported (see below for details). 

To find all predefined compsets:

* **coupled simulations** ``<noresm_base>/cime_config/config_compsets.xml``
* **AMIP-type (atmsophere/land-only) simulations** ``<noresm_base>/components/cam/cime_config/config_compsets.xml``
* stand-alone experiments with the sea-ice model  ``<noresm_base>/components/cice/cime_config/config_compsets.xml``
* stand-along experiments with the land model ``<noresm_base>/components/clm/cime_config/config_compsets.xml``
* Stand-alone experiments with the ocean model  ``<noresm_base>/components/blom/cime_config/config_compsets.xml``
  
The compsets starting with N are NorESM coupled configurations. Compsets starting with NF are NorESM AMIP (atmosphere/land-only) configurations. Some examples are:

* **N1850 and N1850frc2**: Coupled configuration for NorESM for pre-industrial (1850) conditions.
* **NHIST and NHISTfrc2**: Historical configuration from 1850 up to year 2015 (see detailed description below; 'Create your own compsets for AMIP simulations')
* **NSSP126frc2, NSSP245frc2, NSSP370frc2, NSSP585frc2**: Future scenario compsets from 2015 to 2100
* **NFHISTnorpddmsbc**: AMIP simulation with time-evolving prescribed observed values for SSTs and sea ice and upper-ocean DMS values derived from a fully coupled NorESM2 simulation for present-day conditions
 
**frc2 compsets**: The frc2 option uses differently organized emission files. The frc2 files are located in ::
  
  <PATH_TO_INPUTDATA>/noresm/inputdata/atm/cam/chem/emis/cmip6_emissions_version20190808
  
The frc2 files were created to avoid the occurence of random mid-month model crashes. These crashes are related to the reading of emission files, but are still under investigation. To make sure that you are using the frc2 files, choose a compsets including *frc2* or if you  want to create a new compset add ::

  %FRC2
 
to NORESM2. For a detailed description, see the section on creating your own compset below.

For an overview of common compsets used for NorESM2 CMIP6 experiments, please see: :ref:`cmip6_compsets`

For an overview of the compsets provided for CESM2, please see: http://www.cesm.ucar.edu/models/cesm2/config/compsets.html.

Emission-driven compsets
''''''''''''''''''''''''
NorESM2 can be run in emission-driven mode for interactive carbon-cycle studies. Currently, this configuration is only supported for the LM-resolution. In order to run NorESM2-LM in emission-driven mode, the biogeochemical physics ``[_BGC]%pys`` is set to  ``%BPRPDMS`` (instead of ``%BDRDDMS``)

There exists some predefined-emission driven compsets which usually ends with **esm** :

* **N1850esm**: Emission driven coupled configuration for NorESM for pre-industrial (1850) conditions
* **NHISTesm**: Emission driven historical configuration from 1850 to year 2014 
* **NSSP585esm**: Emission driven SSP5-8.5 scenario configuration from 2015 to year 2100
* **NSSP534esm**: Emission driven SSP5-3.4 scenario configuration from 2015  to year 2100

With the exception of preindustrial control, running in CO2 emission-driven mode requires time-varying spatial CO2 emissions boundary condition files. 

Creating your own compset
'''''''''''''''''''''''''
The essential file to edit for a new coupled NorESM compset is
::

    <noresm_base>/cime_config/config_compsets.xml
  
and for a new AMIP NorESM compset is
::

    <noresm_base>/components/cam/cime_config/config_compsets.xml
  
  
**Coupled simulation** 

This examples shows how to simply add the "N1850frc2" compset to ``config_compsets.xml``. In ``<noresm_base>/cime_config/config_compsets.xml`` the N1850frc2 is set as ::

  <compset>
    <alias>N1850frc2</alias>
    <lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>
  </compset>
 
where 

* ``<alias>COMPSETNAME</alias>`` sets the compsets name used when building a new case, make sure to use a new and unique name
* '_' is used as a separator between model components: ``_<MODEL>``
* '%' is used to to set components-specific configurations 

So for the N1850frc2 compset, the different parts of the lname have the following meaning:

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

The details of the compset i.e. which models components and component-specific configurations to use are set in ::
    
    <lname>1850_CAM60%NORESM%FRC2_CLM50%BGC-CROP_CICE%NORESM-CMIP6_BLOM%ECO_MOSART_SGLC_SWAV_BGC%BDRDDMS</lname>

It is possible to use the long name (lname) to select a compset then creating a new case.  


**AMIP simulation**

For details about AMIP simulation compsets, please see :ref:`amips`


Resolution and grids
''''''''''''''''''''

The model resolution is set when the case is created (with the ``--res`` option). Below some common resolutions are listed. 

**Atmospheric grids**
::

  f19_f19 - atm lnd 1.9x2.5
  f09_f09 - atm lnd 0.9x1.25  
  f09_f09_mg17


**Ocean grids**
::

  tnx1v4   - tripolar ocn ice 1-degree grid  
  tnx2v1   - tripolar ocn ice 2-degree grid  
  tx0.25v4 - tripolar ocn ice 1/4-degree grid  


**Coupled**
::

  f19_tn14   - atm lnd 1.9x2.5, ocnice tnx1v4  [CMIP6 grid, NorESM2-LM]  
  f09_tn14   - atm lnd 0.9x1.25, ocnice tnx1v4  [CMIP6 grid, NorESM2-MM]  
  f09_tn0254 - atm lnd 0.9x1.25, ocnice tnx0.25v4  


A complete list of model grids can be found here::
  
  <noresm_base>/cime/config/cesm/config_grids.xml


Supported grids
'''''''''''''''

Most compsets contain an entries listing which which grid(s) are scientifically supported for that compset
::

    <science_support grid="xxx"/> fields

When a compset has a scientifically-supported grid, you can create a new case (with the **create_newcase** script) without having to use the option ``--run-unsupported``. If the compset does not list any scientifically-supported grids, or if you want to use a grid configuration is not included in the definition of the compset, the ::

  --run-unsupported

option is required when a case is created or the **create_newcase** script will fail.


User modifications (usermods) 
'''''''''''''''''''''''''''''
Several configuration options are available in the user modification (usermod) directories under ``<noresm_base>/cime_config/usermods_dirs/``. The sets of usermods contain pre-defined user namelists for the atmosphere (cam) and land (clm) components that have been used for specific experiments, such as the CMIP6 DECK experiments. Within the user namelists, the lists of output variables and output frequencies has been modified and/or extended with additional output variables. In addition, the usermodes include one SourceMod (``SourceMods/src.cam/preprocessorDefinitions.h``) which  defines whether AEROFFL and AEROCOM are activated to produce extra aerosol diagnostics (for more details about the aerosol diagnostics see :ref:`aerosol_output`)

The usermods under ``<noresm_base>/cime_config/usermods_dirs/`` include::

  cmip6_noresm_DECK (AEROFFL)    
  cmip6_noresm_hifreq (high frequency output, AEROFFL)    
  cmip6_noresm_hifreq_xaer (high frecuency output, AEROFFL and AEROCOM)   
  cmip6_noresm_keyCLIM (used for KeyCLIM experiments, AEROFFL)
  cmip6_noresm_xaer (AEROFFLand AEROCOM)    
  
To activate the cmip6_noresm_DECK usermod, run the create_newcase script with the option ``--user-mods-dir cmip6_noresm_DECK``. 

Remember that the amount of diagnostics and the output frequency have a huge impact on both the run time and storage. 

For more details, check this folder ::

  <noresm_base>/cime_config/usermods_dirs


Create a clone case
''''''''''''''''''''
The create_clone script in the <noresm_base>/cime/scripts folder allows you to create a clone of an already existing case::

  ./create_clone --clone <full-path-to-experiment-to-be-cloned> --case <full-path-to-cloned-experiment>

Creating a clone case can be very useful if you want to recreate an existing case or if you want to create a perturbed version. The clone will be set up as if it was created with the same create_newcase options as the existing case (except the case name) and will have identical ``env_*.xml``, ``user_nml_<component>`` and ``SourceMods`` files (these files can of course be modified before building the case). 



The xmlchange and xmlquery scripts
''''''''''''''''''''''''''''''''''

The ``xmlchange`` and ``xmlquery`` scripts are located in your case folder and lets you change or query the contents of variables in the ``evn_*.xml`` files without entering the files. There are two advantages of using ``xmlchange`` to edit the xml files rather than doing by hand: (1) the ``xmlchange`` script checks that the new setting is valid and (2) the change is echoed to the ``CaseStatus`` file, thus automatically documented. To change from the default ``ndays`` to ``nmonths`` ::

  ./xmlchange STOP_OPTION=nmonths
  
It's also possible to change several variables at once, for instance ::

  ./xmlchange STOP_OPTION=nmonths,STOP_N=14

See the header of ``xmlchange`` and ``xmlquery`` for more details and examples.


Forcing
''''''''''''''''
Please see :ref:`input`

Choosing output
'''''''''''''''
please see :ref:`output`

Setting up a nudged simulation
''''''''''''''''''''''''''''''
please see :ref:`nudged_simulations`

Building the case
^^^^^^^^^^^^^^^^^^
The case is built by ::

  ./case.build

All user modifications to ``env_run.xml``, ``env_mach_pes.xml``, ``env_batch.xml`` must be done before ``case.build`` is invoked. This is also the case for the aforementioned user-made namelists: i.e. ``user_nl_cam``, ``user_nl_cice``, ``user_nl_clm``, ``user_nl_blom``, ``user_nl_cpl``). 

If you want to ensure your case is ready for submission, you can run ::
  
  ./check_case
  
which will:

- Ensure that all of the ``env_*.xml`` files are in sync with the locked files
- Create namelists (thus verifying that there will be no problems with namelist generation)
- Ensure that the build is complete

Running this is completely optional: these checks will be done
automatically when running **case.submit**. However, you can run this if you
want to perform these checks without actually submitting the case.

As a last step, remember to copy restart files to run directory if you are running a branch run or a hybrid run.


Submitting the case
^^^^^^^^^^^^^^^^^^^
The case is submitted by ::

  ./case.submit
