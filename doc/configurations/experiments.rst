Experimets
==========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settigns are defined by the so called compsets.

Basic case set up, compilation and job submission with NorESM - Check list
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This is a general description how to create a new experiment with NorESM. For a quick start guide, see also ref:newbie-guide.rst Each step is explained in more detail below.

- 1. Create a case

To start a new experiment you need to create a case. When creating a case a case folder <path_to_case_dir/casename> will be created that contains all the settings for your experiment. The different options will be explained in more detail below. 

Basic case creation:

::

cd <noresm-base>/cime/scripts

./create_newcase --case <path_to_case_dir/casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project snic2019-1-2 --output-root <path_to_run_dir/NorESM> --run-unsupported

::

Example of case creation on Tetralith:

::

./create_newcase --case ../cases/test1910_1 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out --run-unsupported

::

- 2. Configure case


- 3. Add code changes


- 4. Build model


- 5. Edit namelist


- 6. Edit run script


- 7 Copy restart files to run directory


- 8. Submit job

Compsets
''''''''

Choosing components
^^^^^^^^^^^^^^^^^^^

Choosing resolution
'''''''''''''''''''

Choosing simulation period
''''''''''''''''''''''''''

Choosing forcing
''''''''''''''''

Choosing output
'''''''''''''''





































