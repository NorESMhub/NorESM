.. _standard_output:


Standard output
===================================

During a model run, each component (i.e. atm, lnd, ocn, cice, rof) produces its own output datasets consisting of history, restart and output log files. By default, each component periodically writes

- history files (usually monthly) in netCDF format 
   
- writes netCDF or binary restart files in the RUNDIR directory. The history and log files are controlled independently by each component. History output control (i.e. output fields and frequency) is set in the Build-conf/component.buildnml.csh files.
   
- Component history files and restart files are in netCDF format. 
 
- Restart files are used to either restart the model or to serve as initial conditions for other model cases.

For details about how to modify the user namelists in order to change the output, please see **User namelists** in :ref:`experiment_environment`. 

Archiving is a phase of the model run where the generated output data is moved from RUNDIR to the archive folder. This job needs its own cpu time which is set in env_batch.xml. 


**Standard output for the model components in NorESM2**

Lists of output from standard set-up model configurations:

- **CAM6-Nor** (atmosphere): :ref:`cam_standard_out`

- **CLM5** (land): :ref:`clm_standard_out`

- **MOSART** (river run off): :ref:`mosart_standard_out`

- **CICE** (sea-ice): :ref:`cice_standard_out`

- **BLOM** (ocean): :ref:`blom_standard_out`

- **iHAMOCC** (ocean biogeochemistry): :ref:`hamocc_standard_out`


