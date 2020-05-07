.. _omips:

OMIP-type experiments
==========================================

WILL BE UPDATED BY chgu@norceresearch.no 

Oceanic Model Intercomparison Project (OMIP) style runs are runs in which the ocean and sea-ice components are active while values for atmospheric near surface air temperature, wind stress ++??, land?? are prescribed (that is, read from a file). 

Setting up an OMIP simulation
''''''''''''''''''''''''''''''

Creating an OMPI case
^^^^^^^^^^^^^^^^^^^^^

::

   cd <noresm-base>/cime/scripts
   ./create_newcase --case <path_to_case_dir>/<casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project <project_name> --user-mods-dir <user_mods_dir> --output-root <path_to_run_dir>/<noresm_run_dir> --run-unsupported 
   

::


OMIP compsets
^^^^^^^^^^^^^


Forcing sets
'''''''''''''


- **CORE-II forcing**
  

- **JRA-55**


Modify user name lists for BLOM and CICE
''''''''''''''''''''''''''''''''''''''''

