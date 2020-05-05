.. _configurations:

Running NorESM2
===============

A newbies guide to running NorESM2
''''''''''''''''''''''''''''''''
This page will show you how to set up and run a standard case of NorESM2 without any modifications

:ref:`newbie-guide`


Setting up an experiment
''''''''''''''''''''''''

Basic case creation, set up, compilation and job submission with NorESM

:ref:`experiments`

Setting the environment for the experiment
''''''''''''''''''''''''''''''''''''''''''
Set the environment for an experiment with NorESM2. E.g. number of nodes to use, initial conditions, length of simulation, creation of restart files, set run time and archiving time, code changes +++

:ref:`experiment_environment`

Running NorESM2 on different platforms
''''''''''''''''''''''''''''''''''''''

This sections lists the computers where NorESM2 has been installed, including platform specific settings, and instructions for adding new platforms.

:ref:`platforms`


Quality control
'''''''''''''''
:ref:`quality_control`


Atmosphere only (AMIP) simulations
''''''''''''''''''''''''''''''''''
:ref:`amips`

Running ensamble simulations
''''''''''''''''''''''''''''

:ref:`ensemble_runs`


Setting up a nudged simulation
''''''''''''''''''''''''''''''
:ref:`nudged_simulations`

Running with offline aerosols
'''''''''''''''''''''''''''''

Input data and forcing
''''''''''''''''''''''
:ref:`input`



Output data and standard results
''''''''''''''''''''''''''''''''

If your model simulation was successful, you should find the following line in slurm.out (or similar) in your cse folder 

::

  Tue Feb 9 21:41:33 CET 2016 -- CSM EXECUTION BEGINS HERE Wed Feb 10 13:37:56 CET 2016 -- CSM EXECUTION HAS FINISHED  
  (seq_mct_drv): =============== SUCCESSFUL TERMINATION OF CPL7-CCSM =============== 

::

A description of NorESM2 output:

:ref:`output`

