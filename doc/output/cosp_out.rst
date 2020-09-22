.. _cosp_out:

COSP output
''''''''''
The CFMIP Observation Simulator Package (COSP) is an integrated part of the Community Atmosphere Model (CAM) and hence NorESM2. COSP calculates model cloud diagnostics that can be directly compared with satellite observations from ISCCP, CloudSat, CALIOP, MISR, and MODIS. The use of COSP facilitates "apples-to-apples" comparison of observed cloud data and model-simulated clouds, but an increase the run time of an experiment is expected (+ ca. 10% CPU-time). 

To activate cosp, run xmlchange in the case folder (before building the model)::

  ./xmlchange --append CAM_CONFIG_OPTS='-cosp'
  
or you can add -cosp to CAM_CONFIG_OPTS in  env_build.xml  (before building the model)::

  <entry id="CAM_CONFIG_OPTS" value="-phys cam6 -co2_cycle -chem trop_mam_oslo -cosp">
  
To the user_nl_cam, add::

 &cospsimulator_nl
   docosp         = .true.
   cosp_amwg      = .true.

Taking out COSP data, the following 57 output variables (of which 7 are 4 D) are added to the output (+ ca. 10% CPU-time): :ref:`cosp_extra_output`
  
| For a detailed description of COSP, please see
| https://climatedataguide.ucar.edu/climate-data/cosp-cloud-feedback-model-intercomparison-project-cfmip-observation-simulator-package




 



