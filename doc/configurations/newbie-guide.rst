.. _newbie-guide:

Newbies guide to running NorESM2
================================            
This page will show you how to set up and run a standard case of NorESM2.

To follow this guide you have already finished the steps explained in "Downloading NorESM2", which means you have a copy of the model on your computer in a folder with a name of your choice. For simplicity we call this folder ``<noresm-base>`` in this guide.


1. Enter the scripts subfolder
------------------------------
::

  cd <noresm-base>/cime/scripts

This is where the script used to create a new case is placed, which is an executable python script.


2. Create a new case
--------------------
The script for creating a new case takes several command line arguments as input to know how to configure your case.
The command line arguments are as follows:

``-case``

defines a casename of your choice and created a folder by that name in <noresm-base>/cases/.

``-mach``

Defines the machine you will run the model on. The model NorESM2 has been configured to be run on a set of different machines which is listed here :ref:`platforms`. If you are running the model on a machine not listed you will need to configure the model beyond this newbie guide. 

``-res``
defines the resolution of your run. See :ref:`experiments` for more details.

``-compset``
defines what compset you will be using. A list of compsets can be found for coupled configurations:

<noresm_base>/cime_config/config_compsets.xml

and for AMIPS (atmosphere and land only with predescribed sea-ice and sea surface temperatures):

<noresm_base>/components/cam/cime_config/config_compsets.xml

a creation of a new case can look like this
:: 
  cd <noresm_base>/cime/scripts/
  ./create_newcase --case ../../cases/$CASENAME --mach $MACHINE --res f19_g16 --compset $COMPSET

3. Configure the case
---------------------
Enter the casefolder in ``<noresm_base>/cases/$CASENAME/``. This is where you can make changes to the configuration either in ``SourceMods/src.$COMP/`` or is the namelists ``user_nl_$COMP`` where $COMP is a component such as ``cam``, but for now we keep the standard configurations and configure by typing 
::

  ./case.setup
  
4. Build the case
-----------------
After your configuration is finished you build the case by typing 
::
  ./case.build

Which may take a while.

5. Submit your case
-------------------
When your case if finished building you are ready to submit and run your case which is done by typing
::
  ./case.submit
  
And you are finished!

