.. _ensemble_runs:

Ensemble runs: how to run several members at once
=========

Running several ensemble members in a single model experiment (case) is possible using the built-in **multi-instance component functionality**. This allows you to run multiple component instances under one model excecutable.  

Setting up an ensemble experiment:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set up an experiment with 5 members, invoke the create_newcase script with the **multi-driver** and the **ninst** arguments, for instance  

:: 

   ./create_newcase --case $HOME/noresm_cases/NAME_OF_MY_AWESOME_ENSEMBLE_EXP --multi-driver --ninst 5 --res f19_f19_mg17 --mach vilje --compset NFHISTnorpddmsbc 
   
::

will create a new case in the folder $HOME/noresm_cases/NAME_OF_MY_AWESOME_ENSEMBLE_EXP with 5 ensemble members, the f19_f19_mg17 resolution, the NFHISTnorpddmsbc compset, and with machine settings for Vilje. 

Sub-headline:
^^^^^^^^^^^^^

List:

- First
  - sub list

- Second
