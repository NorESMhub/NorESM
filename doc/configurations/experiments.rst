Experimets
==========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settigns are defined by the so called compsets.

Basic case set up, compilation and job submission with NorESM
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This is a general description/checklist for how to create a new experiment with NorESM. For a quick start guide, see also ref:newbie-guide.rst The case creation step is explained in more detail below.

- Create a case




  cd <noresm-base>/cime/scripts

  ./create_newcase --case <path_to_case_dir/casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project snic2019-1-2 --output-root <path_to_run_dir/NorESM> --run-unsupported

::


Example of case creation on Tetralith:


::

./create_newcase --case ../cases/test1910_1 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out --run-unsupported

::


- Configure case




cd <path_to_case_dir/casename>
./case.setup

::


- 3 Add code changes

Copy your code changes to the folder


::

<path_to_case_dir/casename>/SourceMods/src.<component>

::


- 4 Build model


::

./case.build

::


- 5 Edit namelist


::

<path_to_case_dir/casename>/user_nl_<component>

::


- 6 Edit run configuration


::

env_run.xml

::



- 7 Copy restart files to run directory


- 8 Submit job


Create new case
^^^^^^^^^^^^^^^

To start a new experiment you need to create a case. When creating a case a case folder <path_to_case_dir/casename> will be created that contains all the settings for your experiment

The case creation contains a compset option. A compset is a collection of predefined setting that defines your experiment setup. SOme of the available compsets are described below.

The case folder contains predefined namelist (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the user_nl_<component>



Compsets
''''''''

N1850
^^^^^
Coupled configuration for NorESM

Choosing components
^^^^^^^^^^^^^^^^^^^

Creating your own compset
^^^^^^^^^^^^^^^^^^^^^^^^^

Choosing resolution
'''''''''''''''''''

Choosing simulation period
''''''''''''''''''''''''''

Choosing forcing
''''''''''''''''

Choosing output
'''''''''''''''





































