.. _aerosol:

Extra aerosol diagnostics
==========================


Configuring a run with more aerosol diagnostics in NorESM2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:: 

  &phys_ctl_nl 
    history_aerosol = .true. 
    
::


Two more diagnostics are useful
--------------------------------

 * Enable estimates multiple calls to radiation which are necessary for effective radiative forcing estimates
 * Enable diagnostics for AEROCOM
 
To enable this, take the file cam/src/physics/cam_oslo$ vim preprocessorDefinitions.h and copy it to your SourceMods/src.cam folder

Change both preprocessor definitions to true::

define AEROCOM
define AEROFFL

The AEROCOM-token turns on diagnostics needed for AEROCOM The AEROFFL-token tells the model to do additional radiation-diagnostics for aerosol indirect effect


