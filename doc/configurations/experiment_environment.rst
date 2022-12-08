.. _experiment_environment:

Experiment settings and modifications
======================================

After creating a case (see :ref:`experiments`) and running the case.setup script the case folder is created including a number of different files and folders containing information and settings for your case. The case folder contains:

.. glossary::

  README.case
    File detailing your create_newcase usage. This is a good place for you to keep track of run-time problems and changes. The file contains information about e.g. how the case was created, compset details, grid information and which branch, git commit and model code were used for case creation.

  CaseStatus
    File containing a list of operations done in the current case.

  Buildconf
    Directory containing scripts to generate component namelists and component and utility libraries (e.g., PIO, MCT). *You should never have to edit the contents of this directory*

  SourceMods
    Directory where you can place modified source code. In SourceMods there are sub-folders for the different models; cam, clm, cice, blom, mosart and so on. If you want to change the code or add subroutines, you place copies of the fortran files here. 

  user namelists
    namelists for the different models where you can change parameters and model settings, add output variables. If you use usermods when creating your case, any pre-defined user namelists from the usermods will appear immediately when running the create_newcase script. Otherwise, empty user namelists  will be created with running the case.setup script. There is one namelist for each model component (i.e. user\_nl\_cam, user\_nl\_cice, user\_nl\_clm, user\_nl\_blom, user\_nl\_cpl). Use the user namelists to change the contents of the full namelists in the CaseDocs folder (see below). 

  CaseDocs
    here you find the namelists containing all the inputfiles and parameters used. These files will be modified after rebuild. The details of parameter values and input files are listed in the ``<component>_in`` files. *You should never have to edit the contents of this directory*. If you wish to make changes to the ``<component>_in`` files, you change the ``user_nl_<component>`` and rebuild.

  LockedFiles
    Directory that holds copies of files that should not be changed. *You should never edit the contents of this directory*

  Tools
    Directory containing support utility scripts. 

In addition, the case folder contains different environment files (env_*.xml files) that contain environment settings such as the length of your run, the run type, what restart files to use, etc. Modifications to these files can be made directly using your favorite editor, or using the xmlchange script. Note not all files can be edited at any time, for instance build environment variables should not be edited after a build is invoked (or you have to re-build the model). Check the header of the xml files for guidelines.

Below we review the purpose and some of the most important settings for the environment files you will modify most often:

- ``env_run.xml``: Used to set different configuration details for the experiment such as run type and length. 

- ``env_batch.xml``: Used to set the arguments for the batch job commands.

- ``env_mach_pes.xml``: Used to set the machine-specific processor layout for the different model components

We will not discuss the following files as modifications to these files are not usually required: 

- ``env_mach_specific.xml``: Used to set a number of machine-specific environment variables for building and/or running set in <noresm-base>/cime/config/cesm/machines/config_machines.xml. 

- ``env_build.xml``: Used to set various variables needed when building the model. Should not be modified once the model has been build. 
  
- ``env_case.xml``: Used to set case-specific variables (e.g. model components, model and case root directories) and *cannot be modified after a case has been created.* To make changes, your need to re-run ./create_newcase.sh in <noresm-base>/cime/scripts/  with different options. 

- ``env_archive.xml``: Sets variables needed for the short-term archiving job.


Run environment
^^^^^^^^^^^^^^^^
The file ::
  
  env_run.xml
  

sets the configuration details for the experiment such as the run type, the length of the run, how often restart files should be produced, output of coupler diagnostics, and short-term and long-term restart file archiving.

Some common configuration settings
----------------------------------

- ``RUN_TYPE``:

  - **startup:** In a startup run (the default), all components are initialized using baseline states. These baseline states are set independently by each component and can include the use of restart files, initial files, external observed data files, or internal initialization (i.e., a cold start). If you want to initialize the model using non-default files, you can do this in the user_nl_<component> files.
  
  - **branch:** In a branch run, all components are initialized using a consistent set of restart files from a previous run (determined by the RUN_REFCASE and RUN_REFDATE variables in env\_run.xml).  The case name is generally changed for a branch run, although it does not have to be. In a branch run, setting RUN_STARTDATE is ignored because the model components obtain the start date from their restart data sets. Therefore, the start date cannot be changed for a branch run. RUN_REFCASE and RUN_REFDATE are required for branch runs. To set up a branch run, locate the restart tar file or restart directory for RUN_REFCASE and RUN_REFDATE from a previous run, then place those files in the RUNDIR directory.
  
  - **hybrid:** Not as strict as branch. In a hybrid run the model is initialized as a startup, BUT uses initialization data sets from a previous case. This is somewhat analogous to a branch run with relaxed restart constraints.  A hybrid run allows users to bring together combinations of initial/restart files from a previous case (specified by RUN\_REFCASE) at a given model output date (specified by RUN\_REFDATE). Unlike a branch run, the starting date of a hybrid run (specified by RUN\_STARTDATE) can be modified relative to the reference case.
 
- ``RUN_REFCASE``:

  - Reference data used for hybrid or branch runs. The name of the reference simulation the model components are initialized from. The restart and rpointer files should be copied to the run directory before the job is submitted. 
 
- ``RUN_REFDATE``:

  - The reference date for branch or hybrid runs. The reference date must match the date of the restart files from the simulation set in ``RUN_REFCASE``
  
- ``RUN_STARTDATE``:

  - Set the date (of your own wish) for the beginning of the simulation. Only used for hybrid runs.
  
- ``STOP_OPTION``: 

  - Sets the run length along with ``STOP_N``. Can choose between e.g.: none, never, nstep, nhours, ndays, nday, nmonths, nyears, date.
  
- ``STOP_N``:

  - Provides a numerical count for ``STOP_OPTION``. E.g. if ``STOP_OPTION`` is set to years and ``STOP_N`` set to 20, the model will run for 20 years.
  
- ``REST_OPTION``:

  - Sets the frequency of model restart files output (same options as ``STOP_OPTION``)
  
- ``REST_N``:
  
  - Provides a numerical count for ``REST_OPTION``. E.g. if ``REST_OPTION`` is set to years and ``STOP_N`` set to 5, the model will produce restart files every 5 years.
  
- ``CONTINUE_RUN``:
   
  - Needs to be ``FALSE`` when you first begin the run. When you successfully run and get restart files (if the model crashes after the restart files are produced you can set ``CONTINUE_RUN`` to ``TRUE`` as well), you will need to change ``CONTINUE_RUN`` to ``TRUE`` for the remainder of your simulation. 
      
- ``RESUBMIT``:

  - If ``RESUBMIT`` is greater than 0, then case will automatically resubmit. Enables the model to automatically resubmit a new run. This is very useful for long simulations. E.g. ``RESUBMIT`` is set to 2 and the simulation length is set to 20 years (``STOP_OPTION`` is years and ``STOP_N`` is 20), the total length of the simulation will be 60 years.
   
- ``RESUBMIT_SETS_CONTINUE_RUN``:
 
  - Needs to be ``TRUE`` (default) for the ``RESUBMIT`` flag to causes a resubmisson of the case
   
- ``DOUT_S_SAVE_INTERIM_RESTART_FILES``:
 
  - Set to ``TRUE`` to archive all restart files that are produced or to ``FALSE`` to only archive restart files that are produced at the end of the run. Default is ``TRUE``.


NorESM2-specific configuration settings
---------------------------------------
- **OCN_FLUX_SCHEME=1**

  - In the coupled NorESM2 simulations, the flux parameterization used for the transfer of heat, moisture and momentum between the ocean and atmosphere is the so-called COARE flux parameterization. This choice is activated by OCN_FLUX_SCHEME=1 in env_run.xml, and ends up in the driver_in namelist as flux_scheme=1. This parameterization is different from the standard flux-parameterization used in CESM, which is activated by OCN_FLUX_SCHEME=0. In env_run.xml:

  ::

     <entry id="OCN_FLUX_SCHEME" value="1">
            <type>integer</type>
            <valid_values>0,1,2</valid_values>
            <desc>
            Default is false and true for N* cpmpsets, controls value of FLUX_SCHEME
          </desc>
          </entry>
        </group>

 

- **COSZ_AVG=.true.** 

  - A feature of the coupled NorESM2 simulations, i.e., taking into account the fact that the solar zenith angle used for the calculation of the surface albedo changes over the atmospheric model time step of 30 minutes. In env_run.xml:

  ::

     <entry id="COSZ_AVG" value=".true.">
            <type>char</type>
            <valid_values>.true.,.false.</valid_values>
            <desc>
            Default is false and true for N* cpmpsets, controls value of ALB_COSZ_AVG
          </desc>
          </entry>


Setting up a hybrid simulation
---------------------------------
Step by step guide for setting up an  hybrid (restart) simulation.

When the case is created and compiled, edit ``env_run.xml``. Below is an example for restart with CMIP6 historical initial conditions::


    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFDIR" value="<full-path-to-restart-file-directory>">                  # path to restarts
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="TRUE">                            # get refcase from outside rundir

If it is not possible to link directly to restarts, copy the restart files and rpointer files to the run directory. In this case it is not necessary to set ``RUN_REFDIR`` and ``GET_REFCASE`` can be set to ``FALSE``, e.g.::

    <entry id="RUN_TYPE" value="hybrid">
    <entry id="RUN_REFCASE" value="NHISTfrc2_f09_tn14_20191025">     # Experiment name for restart files
    <entry id="RUN_REFDATE" value="2015-01-01">                      # date of restart files
    <entry id="RUN_STARTDATE" value="2015-01-01">                    # date in simulation
    <entry id="GET_REFCASE" value="FALSE">                           # get refcase from outside rundir



Batch job environment
^^^^^^^^^^^^^^^^^^^^^
The file ::
  
  env_batch.xml
  

sets the arguments to the batch job commands. There are two jobs; one for running the model (``case.run``) and one for moving the files from the ``RUNDIR`` to the archive directory (``case.st_archive``). The archiving is usually very fast (less than one hour), but for very large jobs (high resolution or large output) it can take several hours. 

Some of the most commonly modified configuration settings are those related to the walltime for the two jobs.

Machine-specific environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The file ::
  
  env_mach_pes.xml
  

sets the component machine-specific processor layout. The settings are critical to a well-load-balanced simulation. Here you set the number of cpus or tasks (``NTASKS``) used for each model component and the coupler (usually land + ice + rof (river run off) = atm = coupler). An example of the NTASKS-settings from an ``env_mach_pes.xml`` file could be:

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


Note that positive values are used for setting the number of tasks whereas negative values can be used to set the number of nodes instead.

The ``env_mach_pes.xml`` file will usually be created with default values based on the machine you specify (with the --mach option) when you create the case with the create_newcase script.

For more information, see description in the header for the ``env_mach_pex.xml`` file.

User namelists
^^^^^^^^^^^^^^


Output frequency
-------------------

In NorESM a number of monthly output variables are automatically written to the output/history files (see :ref:`standard_output`). Output variables and/or output frequencies (daily, 6-hourly, etc) that are not outputted by default can be added using the user namelists.

For instance, if you edit user_nl_cam and add the following lines at the end of the file::

            avgflag_pertape = ’A’,’I’
            nhtfrq = 0 ,-6
            mfilt = 1 , 30
            ndens = 2 , 2
            fincl1 = ’FSN200’,’FSN200C’,’FLN200’,
            ’FLN200C’,’QFLX’,’PRECTMX:X’,’TREFMXAV:X’,’TREFMNAV:M’,
            ’TSMN:M’,’TSMX:X’
            fincl2 = ’T’,’Z3’,’U’,’V’,’PSL’,’PS’,’TS’,’PHIS’

- ``avgflag_pertape``

  Sets the averaging flag for all variables in a particular history file series. Options are: Average (A), Instantaneous (I), Maximum (X), and Minimum (M). The default behavior is the use the same averaging flag for all variables in each particular history file series, but this can be overridden (more information below). 
  
- ``nhtfrq``

  Array of write frequencies for each history files series.
  
  - nhtfrq = 0, the file will be a monthly average. Only the first file series may be a monthly average. 
  - nhtfrq > 0, frequency is input as number of time steps.
  - nhtfrq < 0, frequency is input as number of hours.

- ``mfilt``

  Array of number of time samples to write to each history file series (a time sample is the history output from a given time step)
  
- ``nden``

  Array specifying output format for each history file series. Valid values are 1 or 2. '1' implies output real values are 8-byte and '2' implies output real values are 4-byte. Default: 2
   
- ``fincl1``

  List of fields to add to the primary history file. Note in the above example the default averaging behavior for the file is overridden for some variables by adding a ":" followed by an averaging option.
 
- ``fincl2``

  List of fields to add to the auxiliary history file. 


For a detailed description of NorESM2 output, please see :ref:`output`


Parameter settings
-------------------
If you need to change some variable values or activate/deactivate flags, that can also be done in ``user_nl_<component>``. The syntax is::

  &namelist_group
    namelist_var = new_namelist_value

E.g for a quadrupling of the atmospheric CO2 concentration ::

  &chem_surfvals_nl
    co2vmr         =    1137.28e-6


Note that BLOM uses a different syntax than the rest. In user_nl_blom::

  set BDMC2 = .15
  set NIWGF = .5
  set SRF_ANO3 = 0, 2, 2

you need to include **set** before the name of the variable and it does not matter what namelist group the variable belong. Input entries in ``user_nl_blom`` are case-insensitive (for model developers: variable names defined in the BLOM ``buildnml`` file should be capitalized to allow replacement values from ``user_nl_blom``).


Input data
-----------
All active model components and data components use input data sets. Wherever you are running the model, you need to store the input locally under ``DIN_LOC_ROOT`` in order to run NorESM. If you want to use non-default input data, you can set the path to the file you want to use in the relevant ``user_nl_<components>``.

Input data is handled by the build process as follows:

- The ``buildnml`` scripts in Buildconf/ create listings of required component input data sets in the ``Buildconf/<component>.input_data_list`` files
  
- The ``case.build`` scripts checks for the presence of the required input data files in the root directory ``DIN_LOC_ROOT``. If all required data sets are found on local disk, then the build can proceed.
  
- If any of the required input data sets are not found, the build script will abort and the files that are missing will be listed. At this point, you must obtain the required data from the input data server using ``check_input_data`` with the ``-export`` option. 


Aerosol diagnostics
^^^^^^^^^^^^^^^^^^^^
The model can be set up to output AeroCom-specific variables, effective forcing estimates, and other additional aerosol output. See :ref:`aerosol_output` for details. 

COSP
^^^^^^^
NorESM2 can be run with the CFMIP Observation Simulator Package (COSP) to calculates model cloud diagnostics that can be directly compared with satellite observations from ISCCP, CloudSat, CALIOP, MISR, and MODIS. Please see :ref:`cosp_out` for details.


Code modifications
^^^^^^^^^^^^^^^^^^^
Sometimes you will want to make changes that go beyond what is possible from just changing the user namelists, and you will need to modify the source code itself (i.e. the fortran files). One way of doing this is to use the SourceMods folder in the case directory. The SourceMods folder contains sub-directories for all model component. Make a copy of the fortran file(s) you want to modify in the relevant sub-folder and modify the file(s) as needed before building the model. When compiling, the model will prioritize the modified file located under the SourceMods folder over the default version of the file located in the model source code under <noresm-base>.

Another option is to make a new branch for your code modifications following the procedure outlined in :ref:`gitbestpractice`. This has several advantages to using SourceMods, including that your changes are more easily visible for others (in your NorESM fork on GitHub), making them easy to share, and that the changes can more easily be considered for inclusion in the main NorESM repository on GitHub. 

In either case, make sure that you use the source code from the same commit as you used to create the case (for commit details see README.case in the case folder).
