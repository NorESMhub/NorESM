.. _experiment_environment:

Experiment environments
===================================

After creating a case (see :ref:`experiments`) the environment settings can be modified in  the env_*.xml files and the user_nl_<component> files contained in the case folder

The case folder contains:
^^^^^^^^^^^^^^^^^^^^^^^^^

- **README.case:** File detailing your create_newcase usage. This is a good place for you to keep track of runtime problems and changes. The file contains information about e.g. how the case was created, compset details, grid information and which branch, git commit and model code were used for case creation.

- **CaseStatus:** File containing a list of operations done in the current case.

- **Buildconf:** Directory containing scripts to generate component namelists and component and utility libraries (e.g., PIO, MCT). *You should never have to edit the contents of this directory*

- **SourceMods:** Directory where you can place modified source code. In SourceMods there are subfolders for the different models; cam, clm, cice, blom, mosart and so on . If you want to change the code or add subroutines, you place copies of the fortran files here. 

- **user made namelists:** you can place your own namelists for the different models where you can change parameters and model settings and so on (i.e. user\_nl\_cam, user\_nl\_cice, user\_nl\_clm, user\_nl\_blom, user\_nl\_cpl). See details below. 

- **CaseDocs:** here you find the namelists containing all the subroutines and parameters used. These files will be modified after rebuild. The details of parameter values and input files are listed in the <component>_in files. *You should never have to edit the contents of this directory*. If you wish to make changes to the <component>_in files, you change the user_nl_<component> and rebuild.

- **LockedFiles:** Directory that holds copies of files that should not be changed. *You should never edit the contents of this directory*

- **Tools:** Directory containing support utility scripts. 


Machine specific environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The file

::
  
  env_mach_pes.xml
  
::

sets component machine-specific processor layout. The settings are critical to a well-load-balanced simulation. Here you set the number of cpus used for each model component and the coupler (usually land + ice + rof (river run off) = atm = coupler). An example of sunch an env_mach_pes.xml file:

::
  
  <entry id="NTASKS">
      <type>integer</type>
      <values>
        <value compclass="ATM">768</value>
        <value compclass="CPL">768</value>
        <value compclass="OCN">186</value>
        <value compclass="WAV">300</value>
        <value compclass="GLC">768</value>
        <value compclass="ICE">504</value>
        <value compclass="ROF">8</value>
        <value compclass="LND">256</value>
        <value compclass="ESP">1</value>
      </values>
      <desc>number of tasks for each component</desc>
    </entry>


::


Run environment
^^^^^^^^^^^^^^^^
The file

::
  
  env_run.xml
  
::

sets the configuration details for the experiment. E.g. time settings such as length of run, frequency of restart files produced, output of coupler diagnostics, and short-term and long-term restart file archiving. 

NorESM2 specific configuration settings
---------------------------------------
- FLUXSCHEME=1 

  - In the coupled NorESM2 simulations, the flux parameterization used for the transfer of heat, moisture and momen-tum between the ocean and atmosphere is the so-called COARE flux parameterization. This choice is activated by FLUXSCHEME=1 in envrun.xml, and ends up in the driver_in namelist as fluxscheme=1. This parameterisationis different from the standard flux-parameterzation used in CESM, which is activated by FLUXSCHEME=0.
 
- ALBCOSZAVG=.true. 

  - a feature of the coupled NorESM2 simulations, i.e., taking into account the fact that the solar zenith angle used for the calculation of the surface albedo changes over the atmospheric model time step of 30 minutes 

Some common configuration settings
----------------------------------

- RUN_TYPE:

  - **startup:** In a startup run (the default), all components are initialized using baseline states. These baseline states are set independently by each component and can include the use of restart files, initial files, external observed data files, or internal initialization (i.e., a cold start). Settings of initial files to be read are set in the user_nl_<component>
  
  - **branch:** In a branch run, all components are initialized using a consistent set of restart files from a previous run (determined by the RUN_REFCASE and RUN_REFDATE variables in env\_run.xml).  The case name is generally changed for a branch run, although it does not have to be. In a branch run, setting RUN_STARTDATE is ignored because the model components obtain the start date from their restart datasets. Therefore, the start date cannot be changed for a branch run. RUN_REFCASE and RUN_REFDATE are required for branch runs. To set up a branch run, locate the restart tar file or restart directory for RUN_REFCASE and RUN_REFDATE from a previous run, then place those files in the RUNDIR directory.
  
  - **hybrid:** Not as strict as branch. In a hybrid run the model is initialized as a startup, BUT uses initialization datasets from a previous case. This is somewhat analogous to a branch run with relaxed restart constraints.  A hybrid run allows users to bring together combinations of initial/restart files from a previous case (specified by RUN\_REFCASE) at a given model output date (specified by RUN\_REFDATE). Unlike a branch run, the starting date of a hybrid run (specified by RUN\_STARTDATE) can be modified relative to the reference case.
 
- RUN_REFCASE:

  - Reference data used for hybrid or branch runs. The name of the reference simulation the model components are initialized from. The restart and rpointer files should be copied to the run directory before the job is submitted 
 
- RUN_REFDATE:

  - The reference date of the restart files from the simulation set in RUN_REFCASE
  
- RUN_STARTDATE:

  - Set the date (of your own wish) for the beginning of the simulation
  
- STOP_OPTION: 

  - Sets the run length along with STOP_N. Can choose between e.g.: none, never, nstep, nhours, ndays,nday,nmonths ,nyears, date.
  
- STOP_N:

  - Provides a numerical count for $STOP_OPTION. E.g. if STOP_OPTION is set to years and STOP_N set to 20, the model will run for 20 years.
  
- REST_OPTION:

  - Sets the frequency of model restart files output (same options as STOP_OPTION)
  
- REST_N:
  
  - Provides a numerical count for $REST_OPTION. E.g. if REST_OPTION is set to years and STOP_N set to 5, the model will produce restart files every 5 years.
  
- CONTINUE_RUN:
   
  - Needs to be FALSE when you first begin the run. When you successfully run and get a restart file (if the model crashes after the restart file is produced you can set CONTINUE_RUN to TRUE as well), you will need to change CONTINUE_RUN to TRUE for the remainder of your simulation. 
      
- RESUBMIT:

  - If RESUBMIT is greater than 0, then case will automatically resubmit. Enables the model to automatically resubmit a new run. This is very useful for long simulations. E.g. RESUBMIT is set to 2 and the simulation length is set to 20 years (STOP_OPTION is years and STOP_N is 20), the total length of the simulation will be 60 years.
   
- RESUBMIT_SETS_CONTINUE_RUN:
 
  - Needs to be TRUE (default) is the RESUBMIT flag causes a resubmisson of the case
   
- DOUT_S_SAVE_INTERIM_RESTART_FILES:
 
  - Logical to archive all the produced restart files and not just those at the end of the simulation. Default is FALSE.
  
Setting up a hybrid simulation
^^^^^
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


User namelists
^^^^^^^^^^^^^^


Frequency of output
-------------------

There are plenty of default output variables which are automatically written,

The variables specified in the namelists will be written as output automatically, but if you need to customize the output fields you can eddit the user_nl_<component> lists

E.g. if you eddit user_nl_cam and add the following lines at the end of the file::

            avgflag_pertape = ’A’,’I’
            nhtfrq = 0 ,-6
            mfilt = 1 , 30
            ndens = 2 , 2
            fincl1 = ’FSN200’,’FSN200C’,’FLN200’,
            ’FLN200C’,’QFLX’,’PRECTMX:X’,’TREFMXAV:X’,’TREFMNAV:M’,
            ’TSMN:M’,’TSMX:X’
            fincl2 = ’T’,’Z3’,’U’,’V’,’PSL’,’PS’,’TS’,’PHIS’

- avgflag_pertape

  Sets the averaging flag for all variables on a particular history file series. Default is to use default averaging flags for each variable. Average (A), Instantaneous (I), Maximum (X), and Minimum (M). 
  
- nhtfrq

  Array of write frequencies for each history files series.
  
  - nhtfrq = 0, the file will be a monthly average. Only the first file series may be a monthly average. 
  - nhtfrq > 0, frequency is input as number of timesteps.
  - nhtfrq < 0, frequency is input as number of hours.

- mfilt

  Array of number of time samples to write to each history file series (a time sample is the history output from a given timestep)
  
- nden

  Array specifying output format for each history file series. Valid values are 1 or 2. '1' implies output real values are 8-byte and '2' implies output real values are 4-byte. Default: 2
   
- fincl1

  List of fields to add to the primary history file. 
 
- fincl2

  List of fields to add to the auxiliary history file. 


For a detailed description of NorESM2 output, please see :ref:`output`


Parameter settings
------------------
If you need to change some variable values or activate/deactive flags, that can also be done in user_nl_<component>. The syntax is::

  &namelist_group
    namelist_var = new_namelist_value

E.g for a quadrupling of the atmospheric CO2 concentration

::

  &chem_surfvals_nl
    co2vmr         =    1137.28e-6

::

Note that BLOM uses a different sytax than the rest. In user_nl_blom::

  set BDMC2    = .15
  set NIWGF = .5

you need to include **set** before the name of the variable and it does not matter what namelist group the valiable belong.


Input data
-----------
All active and data components use input data sets. A local disk needs DIN_LOC_ROOT to be populated with input data in order to run NorESM. You can make links to the input data sets in the user_nl_<components>. 
Input data is handled by the build process as follows:

- The buildnml scripts in Buildconf/ create listings of required component input datasets in the Buildconf/<component>.input_data_list files
  
- ./case.build checks for the presence of the required input data files in the root directory DIN_LOC_ROOT. If all required data sets are found on local disk, then the build can proceed.
  
- If any of the required input data sets are not found, the build script will abort and the files that are missing will be listed. At this point, you must obtain the required data from the input data server using check_input_data with the -export option. 


Aerosol diagnostics
^^^^^^^^^^

The model can be set up to take out AeroCom-specific output, effective forcing estimates, and other additional aerosol output. See :ref:`aerosol_output` for details. 

COSP
^^^^^^^
NorESM2 can be run with the CFMIP Observation Simulator Package (COSP) to calculates model cloud diagnostics that can be directly compared with satellite observations from ISCCP, CloudSat, CALIOP, MISR, and MODIS. Please see :ref:`cosp_out` for details.


Code modifications
^^^^^^^^^^^^^^^^^^^
If you want to make more subtantial changes to the codes than what is possible by the use of user_nl_<component>, you need to copy the source code (the fortran file you want to modify) to the SourceMods/src.<component> folder in the case directory, then make the modifications needed before building the model. Make sure that you use the source code from the same commit as you used to create the case (for commit details see README.case in the case folder). **Do not change the source code in the <noresm-base> folder!**  


Run and archiving time environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The file

::
  
  env_batch.xml
  
::


sets the batch file or job script configurations. You need to specify two jobs; one for running the model (case.run) and one for moving the files from the RUNDIR to the archive directory (case.st_archive). The archiving is usually very fast (less than one hour), but for very large jobs (high resolution or large output) it can take several hours. 

You can edit the xml files directly to change the variable values. Although you can edit this at any time, build environment variables should not be edited after a build is invoked. 

There are also other env_ files which you usually don't need to or can't change:

- env_mach_specific.xml: File used to set a number of machine-specific environment variables for building and/or running set in <noresm-base>/cime/config/cesm/machines/config_machines.xml. 

-  env_case.xml: Sets case specific variables (e.g. model components, model and case root directories) and *cannot be modified after a case has been created.* To make changes, your need to re-run ./create_newcase.sh in <noresm-base>/cime/scripts/  with different options. 


