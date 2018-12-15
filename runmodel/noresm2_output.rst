.. _noresm2_output:

Atmospheric output for some commonly used configurations of NorESM2
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

In preparation for CMIP6 and the required model output for the various
MIPs, NorESM2 has been set up with different configurations, all run as
AMIP using the compset NF2000climo (on 2 degrees) in noresm-dev (commit
7757f2d8258d5f84e960db12f840afebc69d7856 from October 30'th 2018).

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
