.. _newbie-guide:

Newbies guide to running NorESM
================================            
This page will show you how to set up and run a standard case of NorESM2.

To follow this guide you have already finished the steps explained in "How to get access", which means you have a copy of the model on your computer in a folder with a name of your choice. For simplicity we call this folder $NorESM2 in this guide.


1. Enter the scripts subfolder
::

  cd $NorESM2/cime/scripts

This is where the script used to create a new case is placed, which is an executable python script.

2. Create a new case

The script "create_newcase" takes several command line arguments as input to know how to configure your case.
:: 

  ./create_newcase -case ../cases/$CASENAME -mach $MACHINE -res
  f19_g16 -compset $COMPSET

