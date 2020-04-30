.. _experiment_environment:

Setting the experiment environments
===================================

After creating a case (see :ref:`experiments`) the environment settings can be modified in  the env_*.xml files contained in the case folder

The case folder:
^^^^^^^^^^^^^^^^

The case folder contains:
  - README.case: File detailing your create_newcase usage. This is a good place for you to keep track of runtime problems and changes.
  - CaseStatus: File containing a list of operations done in the current case.
  - Buildconf: Directory containing scripts to generate component namelists and component and utility libraries (e.g., PIO, MCT). *You should never have to edit the contents of this directory*
  - SourceMods: Directory where you can place modified source code. In SourceMods there are subfolders for the different models; cam, clm, cice, micom, mosart and so on . If you want to change the e.g. code or add subroutines, you place them here. 
  - CaseDocs: here you find the namelists containing all the subroutines and parameters used. These files will be modifiedafter rebuild. *You should never have to edit the contents of this directory*. If you wish to make changes to the namelists you use:
  - user made namelists: you can place your own namelists for the different models where you can change parameters and model settings and so on (i.e. user\_nl\_cam, user\_nl\_cice, user\_nl\_clm, user\_nl\_micon, user\_nl\_cpl)
  - LockedFiles: Directory that holds copies of files that should not be changed. *You should never edit the contents of this directory*
  - Tools: Directory containing support utility scripts. *You should never need to edit the contents of this directory.*

User namelists:
^^^^^^^^^^^^^^^

Code modifications:
^^^^^^^^^^^^^^^^^^^



Machine specific environment:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The file

::
  
  env_mach_pes.xml
  
::

sets component machine-specific processor layout. The settings are critical to a well-load-balanced simulation. Here you set the number of cpus used for each model component (e.g. atm 1024, ocn 154, usually land + ice + rof (river run off) = atm = 1024) and the coupler.

Run environment:
^^^^^^^^^^^^^^^^
The file

::
  
  env_run.xml
  
::

sets the configuration details for the experiment. E.g. time settings such as length of run, frequency of restart files produced, output of coupler diagnostics, and short-term and long-term restart file archiving. 

Some common configuration settings:

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
   
  - Needs to be FALSE when you first begin the run. When you successfully run and get a restart
      file (if the model crashes after the restart file is produced you can set CONTINUE_RUN to TRUE as well), you will need to change CONTINUE_RUN to TRUE for the remainder of your simulation. 
      
- RESUBMIT:

  - If RESUBMIT is greater than 0, then case will automatically resubmit. Enables the model to automatically resubmit a new run. This is very useful for long simulations. E.g. RESUBMIT is set to 2 and the simulation length is set to 20 years (STOP_OPTION is years and STOP_N is 20), the total length of the simulation will be 60 years.
   
- RESUBMIT_SETS_CONTINUE_RUN:
 
  - Needs to be TRUE (default) is the RESUBMIT flag causes a resubmisson of the case
   
- DOUT_S_SAVE_INTERIM_RESTART_FILES:
 
  - Logical to archive all the produced restart files and not just those at the end of the simulation. Default is FALSE.
  

Run and archiving time environment:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The file

::
  
  env_batch.xml
  
::


sets the batch file or job script configurations. You need to specify two jobs; one for running the model (case.run) and one for moving the files from the RUNDIR to the archive directory (case.st_archive). The archiving is usually very fast (less than one hour), but for very large jobs (high resolution or large output) it can take several hours. 

You can edit the xml files directly to change the variable values. Although you can edit this at any time, build environment variables should not be edited after a build is invoked. 

There are also other env_ files which you usually don't need to or can't change:

- env_mach_specific.xml: File used to set a number of machine-specific environment variables for building and/or running set in <noresm-base>/cime/config/cesm/machines/config_machines.xml. 

-  env_case.xml: Sets case specific variables (e.g. model components, model and case root directories) and *cannot be modified after a case has been created.* To make changes, your need to re-run ./create_newcase.sh in <noresm-base>/cime/scripts/  with different options. 


Build and submit the experiment
===============================

Building the case:
^^^^^^^^^^^^^^^^^^^^
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

Submitting the case:
^^^^^^^^^^^^^^^^^^^^
The case is submitted by:

::

  ./case.submit

::
