.. _newbie-guide:

Newbies guide
================================    

This guide provides basic instructions on how set up and run a standard NorESM case by excecuting 4 steps:

  - create a new case (the **create_newcase** script)
  - configure case (the **case_setup** script)
  - build case (the **case_build** script)
  - submit case (the **case_submit** script). 
  
It is assumed that you need to have sucsessfully downloaded the model (see :ref:`../access/access`), which means you have a copy of the model on your computer in a folder with a name of your choice. For simplicity we call this folder ``<noresm-base>`` in this guide.


Create a new case
--------------------

The **create_newcase** script is an excecutable python script located in:

::
  <noresm-base>/cime/script
::

The script for creating a new case takes several command line arguments as input to know how to configure your case.
Some of the most important arguments are as follows:

  - ``-case`` defines a casename of your choice and created a folder by that name in <noresm-base>/cases/.

  - ``-mach`` defines the machine you will run the model on. The model NorESM2 has been configured to be run on a set of different machines which is listed here :ref:`platforms`. If you are running the model on a machine not listed you will need to configure the model beyond this newbie guide. 

  - ``-res`` defines the resolution of your run. See :ref:`experiments` for more details.

  - ``-compset`` defines what compset you will be using. A list of compsets for fully-coupled configurations can be found in the file <noresm_base>/cime_config/config_compsets.xml (see :ref:'amips' for compsets for AMIP-type simulations)

To investigate the full list of arguments, enter the <noresm_base>/cmie/scripts folder and run create_newcase with the --help argument:
::
    cd <noresm_base>/cime/scripts/
  ./create_newcase --case ../../cases/$CASENAME --mach $MACHINE --res f19_g16 --compset $COMPSET


To create a new case, enter the scripts directory and run the create_newcase scripts:
:: 
  cd <noresm_base>/cime/scripts/
  ./create_newcase --case ../../cases/$CASENAME --mach $MACHINE --res f19_g16 --compset $COMPSET


Configure the case
---------------------
Enter the casefolder in ``<noresm_base>/cases/$CASENAME/``. This is where you can make changes to the configuration either in ``SourceMods/src.$COMP/`` or is the namelists ``user_nl_$COMP`` where $COMP is a component such as ``cam``, but for now we keep the standard configurations and configure by typing 
::

  ./case.setup
  
Build the case
-----------------
After your configuration is finished you build the case by typing 
::
  ./case.build

Which may take a while.

Submit your case
-------------------
When your case if finished building you are ready to submit and run your case which is done by typing
::
  ./case.submit
  
If your model simulation was successful, you should find the following line in slurm.out (or similar) in your cse folder 

::

  Tue Feb 9 21:41:33 CET 2016 -- CSM EXECUTION BEGINS HERE Wed Feb 10 13:37:56 CET 2016 -- CSM EXECUTION HAS FINISHED  
  (seq_mct_drv): =============== SUCCESSFUL TERMINATION OF CPL7-CCSM =============== 

::


And you are finished!

