.. _output:

Output and standard results
===================================

NorESM2 output
^^^^^^^^^^^^^^

During a model run, each component (i.e. atm, lnd, ocn, cice, rof) produces its own output datasets consisting of history, restart and output log files. By default, each component periodically writes

- history files (usually monthly) in netCDF format 
   
- writes netCDF or binary restart files in the RUNDIR directory. The history and log files are controlled independently by each component. History output control (i.e. output fields and frequency) is set in the Build-conf/component.buildnml.csh files.
   
- Component history files and restart files are in netCDF format. 
 
- Restart files are used to either restart the model or to serve as initial conditions for other model cases.

For details about how to modify the user namelists to modify the output, please see **User namelists** in :ref:`experiment_environment`. 

Archiving is a phase of the model run where the generated output data is moved from RUNDIR to the archive folder. This job needs its own cpu time which is set in env_batch.xml. 


Atmospheric output for some commonly used configurations of NorESM2
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

In preparation for CMIP6 and the required model output for the various 
MIPs, NorESM2 has been set up with different configurations, all run as 
AMIP using the compset NF2000climo (on 2 degrees) in noresm-dev (2.0: 
commit 7757f2d from October 30'th 2018; 
(2.1: COMMIT 35b90aab from March 25'th 
2019) The given estimates in CPU-time increase are based on 1 month 
simulations, including model initialization, and are therefore low end 
estimates. 

With standard set-up of the model, the monthly output variables (1, 2
and 3 D) are:

:ref:`standard_output`

Adding history_aerosol = .true. to user_nl_cam gives the following
additional 577 variables (+ ca. 13 % CPU-time)

:ref:`history_aerosol_extra_output`

Furthermore including #define AEROFFL to preprocessorDefinitions.h gives
8 additionally variables (+ ca. 5% CPU-time)

:ref:`aeroffl_extra_output`

and when also #define AEROCOM is activated there, we additionally get
the following 149 variables (+ ca. 13% CPU-time)

:ref:`aerocom_extra_output`

Finally, also taking out COSP data (./xmlchange --append
CAM_CONFIG_OPTS='-cosp'), the following 57 output variables (of which 7
are 4 D) are added to the output (+ ca. 10% CPU-time):

:ref:`cosp_extra_output`
