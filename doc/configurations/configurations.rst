.. _configurations:

Model Configurations
====================


Running NorESM2 on different platforms
''''''''''''''''''''''''''''''''''''''

This sections lists the computers where NorESM2 has been installed, including platform specific settings, and instructions for adding new platforms.

:ref:`platforms`



Setting up an experiment
''''''''''''''''''''''''

Basic case creation, set up, compilation and job submission with NorESM

:ref:`experiments`

Setting the environment for the experiment
''''''''''''''''''''''''''''''''''''''''''
Set the environment for an experiment with NorESM2. E.g. number of nodes to use, initial conditions, length of simulation, creation of restart files, set run time and archiving time, code changes +++

:ref:`experiment_environment`

Quality control
'''''''''''''''
:ref:`quality_control`


Atmosphere only (AMIP) simulations
''''''''''''''''''''''''''''''''''

Running with offline aerosols
'''''''''''''''''''''''''''''

Input data and forcing
''''''''''''''''''''''
The complete input data set is stored on Fram @ Sigma2. For access to input data contact ???

Some of the input data, the look-up tables (LUT) for NorESM specific aerosol optics and size information for calculation of cloud droplet activation, can be modified either for testing purposes or in order to take into account new developments in the aerosol microphysics scheme. Some typical examples of input that may need to be updated are: refractive indices; assumed (log-normal) size parameters at the point of emission or production; assumed hygroscopicities for sub-saturated conditions. Such changes can be made in the offline "sectional" aerosol module AeroTab (as in the example of new refractive indices), or both in AeroTab and in the online aerosol module OsloAero in the CAM6-Nor code (as in the example of assumed size parameters). Many aerosol related model changes may be done without having to touch the AeroTab code and thee LUT at all, such as e.g. the emissions (whether they are prescribed or interactive).  

A user's guide for the AeroTab code, with some additional information about OsloAero code (in CAM6-Nor) which makes use of the AeroTab LUT, can be found at https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf.
This AeroTab presentation https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-slides-updateJan2020.pdf may be useful as a first introduction. For questions about AeroTab, contakt Alf Kirkevåg (alfk at met.no) or Øyvind Seland (oyvinds at met.no).      


Output data and standard results
''''''''''''''''''''''''''''''''

If your model simulation was successful, you should find the following line in slurm.out (or similar) in your cse folder 

::
Tue Feb 9 21:41:33 CET 2016 -- CSM EXECUTION BEGINS HERE Wed Feb 10 13:37:56 CET 2016 -- CSM EXECUTION HAS FINISHED (seq_mct_drv): =============== SUCCESSFUL TERMINATION OF CPL7-CCSM =============== 
::



.. _noresm2_output:

Atmospheric output for some commonly used configurations of NorESM2
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

In preparation for CMIP6 and the required model output for the various 
MIPs, NorESM2 has been set up with different configurations, all run as 
AMIP using the compset NF2000climo (on 2 degrees) in noresm-dev (2.0: 
commit 7757f2d8258d5f84e960db12f840afebc69d7856 from October 30'th 2018; 
(2.1: COMMIT 35b90aab78c2cceee636539894c9ff9015355f2f from March 25'th 
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
