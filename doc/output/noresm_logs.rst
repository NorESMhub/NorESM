.. _noresm_logs:

NorESM log files
================

The coupled NorESM system produce several log files during the build and run process that provide insight about how the model is performing, what resources are being used, what external files the model reads and writes, and potential problems that may occur during building and running of the model.


Main NorESM log files
---------------------

These files will appear in the case directory during the build and run process.

CaseStatus
   Logs date and time for case setup, build, job submission and job completion. Useful for quick lookup of model run state.

README.case
   Log for case creation script (``create_newcase``) 

software_environment.txt
   System environment (modules) loaded during case build.

logs/run_environment.txt.<jobid>.<timestamp>
   System environment (modules) loaded during model run.

<casename>
   Log for job execution, CPU, memory and disk usage.

timing/cesm_timing.<casename>.<jobid>.<timestamp>
   Timing profile for NorESM coupled model system and for individual model components.

timing/cesm_timing_stats.<jobid>.<timestamp>
   Timing statistics for some NorESM model routines, in particular for the model coupler.


NorESM build logs
-----------------

These files are found under the directory ``<workdir>/noresm/<casename>/bld/``.

cesm.bldlog.<timestamp>.gz
   Build the coupled model executable ``cesm.exe``.

<component>.bldlog.<timestamp>.gz
   Build log for individual model components.


NorESM run logs
---------------

These files are found under the directory ``<workdir>/archive/<casename>/logs/``.

cesm.log.<jobid>.<timestamp>.gz
   Run log for coupled model system.

<component>.log.<jobid>.<timestamp>.gz
   Run log for individual model components.


Other case logs
---------------

This file is found under the directory ``<workdir>/archive/<casename>/``.

archive.log.<timestamp>
   Log for short term archiving of model output.

case.log
   Log for archiving of case directory.
