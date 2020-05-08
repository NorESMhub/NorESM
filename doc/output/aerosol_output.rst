.. _aerosol_output:

Extra aerosol diagnostics
==========================


Configuring a run with more aerosol diagnostics in NorESM2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To run NorESM2 with more aerosol diagnostics add to user_nl_cam:

:: 

  &phys_ctl_nl 
    history_aerosol = .true. 
    
::


Adding history_aerosol = .true. to user_nl_cam gives 
additional 577 variables (+ ca. 13 % CPU-time).
Please see an overview of additional output varibales:
:ref:`history_aerosol_extra_output`

Decomposition of aerosol direct, semidirect, and indirect radiative forcing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For effective radiative forcing estimates, multiple calls to the radiation code are necessary (see Ghan et al. 2012 for a detailed explanation).
To enable this, copy preprocessorDefinitions.h in ::

  <noresm_base>/components/cam/src/physics/cam_oslo/preprocessorDefinitions.h

to the SourceMods/src.cam folder in your case directory

Change preprocessor definition to true, i.e. replace::
 
  #undef AEROFFL
  
with::

  #define AEROFFL

The AEROFFL-token tells the model to do additional radiation-diagnostics for aerosol indirect effect. Including #define AEROFFL to preprocessorDefinitions.h gives 8 additionally variables (+ ca. 5% CPU-time)
Please see an overview of the additional output variables: :ref:`aeroffl_extra_output`


Enable diagnostics for AEROCOM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
NorESM2  can be set up to take out additional aerosol output for use in AeroCom or other studies where there is a need for extensive aerosol diagnostics. To enable this, copy preprocessorDefinitions.h in ::

  <noresm_base>/components/cam/src/physics/cam_oslo/preprocessorDefinitions.h


to the SourceMods/src.cam folder in your case directory

Change preprocessor definition to true, i.e. replace::
 
  #undef AEROCOM
  
with::
 
  #define AEROCOM


The AEROCOM-token turns on diagnostics needed for AEROCOM. If #define AEROCOM is activated, we additionally get 149 variables (+ ca. 13% CPU-time). Please see an overview of the additional output variables:
:ref:`aerocom_extra_output`


**The model may be run with any combination of these options: with AEROFFL only, with AEROCOM only, or with AEROFFL and AEROCOM activated at the same time.**


References
^^^^^^ 

Ghan, S.J., X. Liu, R.C. Easter, R. Zaveri, P.J. Rasch, J. Yoon, and B. Eaton, 2012: Toward a Minimal Representation of Aerosols in Climate Models: Comparative Decomposition of Aerosol Direct, Semidirect, and Indirect Radiative Forcing. J. Climate, 25, 6461–6476, https://doi.org/10.1175/JCLI-D-11-00650.1
