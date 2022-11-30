.. _newbie-guide:

Newbies guide
================================    

This guide provides basic instructions on how set up and run a standard NorESM case by executing 4 steps:

  - create a new case (the **create_newcase** script)
  - configure case (the **case.setup** script)
  - build case (the **case.build** script)
  - submit case (the **case.submit** script). 
  
It is assumed that you have sucsessfully downloaded the model (see :ref:`download_code`), which means you have a copy of the model on your computer in a folder with a name of your choice. For simplicity we call this folder ``<noresm-base>`` in this guide.


Create a new case
--------------------

The **create_newcase** script is an executable python script located in:
::

  <noresm-base>/cime/scripts/

The script for creating a new case takes several command line arguments as input to know how to configure your case.
Some of the most important arguments are as follows:

  - ``--case`` defines a casename of your choice and creates a folder by that name. The argument respects absolute and relative paths (e.g. ``--case ~/NorESM/cases/<casename>``). It is good parctice to make a case folder named ``cases`` where your NorESM cases are stored, e.g. ``mkdir NorESM/cases/`` in your home directory

  - ``--mach`` defines the machine you will run the model on. The model NorESM2 has been configured to be run on a set of different machines (see list at :ref:`platforms`). If you are running the model on a machine not listed you will need to configure the model beyond this newbie guide. 

  - ``--res`` defines the resolution of your run. See :ref:`experiments` for more details.

  - ``--compset`` defines what compset you will be using. A list of compsets for fully-coupled configurations can be found in the file *<noresm_base>/cime_config/config_compsets.xml* (see :ref:`amips` for compsets for AMIP-type simulations)

To investigate the full list of arguments, enter the *<noresm_base>/cime/scripts/* folder and run **create_newcase** with the ``--help`` argument: 
::
    
    cd <noresm_base>/cime/scripts/
    ./create_newcase --help

  
To create a new case, enter the scripts directory and run the **create_newcase** scripts: 
::
    
    cd <noresm_base>/cime/scripts/
    ./create_newcase --case <casepath>/<casename> --mach <machine> --res f19_tn14 --compset <compset>

You have now created the case folder *<casepath>/<casename>*! Go to the case folder to start configuring your experiment.

More advanced examples
++++++++++++++++++++++
The following example creates the case *N1850_f19_tn14_test01* on the machine Fram:
::

    ./create_newcase --case ~/NorESM/cases/N1850_f19_tn14_test01 --compset N1850 --res f19_tn14 --machine fram --project snic2019-1-2 --user-mods-dir cmip6_noresm_DECK 

Here we store the case with the casename *N1850_f19_tn14_test01* in a subdirectory ``NorESM/cases/`` in the home directory on fram. We use the *N1850* compset, which configures the case as a 1850 pre-industrial control simulation.  The argument ``--project`` should correspond to the id of the project used in the batch system accounting on Fram. The argument ``--user-mods-dir`` provides the path to a folder containing files that will further configure your case (like user namelists, shell scripts with xmlchange commands or SourceMods). The default location for this folder is under *<noresm_base>/cime_config/usermods_dirs/*.

The following example creates a case (also called *N1850_f19_tn14_test01*), but on the machine Tetralith:
::

    ./create_newcase --case ~/NorESM/cases/N1850_f19_tn14_test01 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out
    
Note that here we use the argument ``--output-root``, which is only required if the *noresm_run_dir* (the running directory of the mode) differs from default running directory *<path_to_run_dir>/noresm/*. 

Configure the case
---------------------
The case folder *<casepath>/<casename>/* is where you configure your case by changing enviroment files (such as the *<casepath>/<casename>/env_run.xml* file; see :ref:`experiment_environment`), changing the user namelists for the different model components (files named ``user_nl_<component>`` where <component> is a model component such as ``cam``), or even add your own code changes to ``SourceMods/src.<component>/``. But for now we stick to the standard out-of-the-box set up and configure the case as follows:
::

  cd <casepath>/<casename>
  ./case.setup
  

Build the case
-----------------
After your configuration is finished you can start bulding your case by invoking the case.build script from your case folder: 
::

  ./case.build

Which may take a while.

Submit your case
-------------------
When your case has finished building you are ready to submit and run your case. This is done by invoking the case.submit script from your case folder:
::

  ./case.submit
  
If your model simulation was successful, you should find the following line in slurm.out (or similar) in your case folder 

::

  Tue Feb 9 21:41:33 CET 2016 -- CSM EXECUTION BEGINS HERE Wed Feb 10 13:37:56 CET 2016 -- CSM EXECUTION HAS FINISHED  
  (seq_mct_drv): =============== SUCCESSFUL TERMINATION OF CPL7-CCSM =============== 


And you are finished!
