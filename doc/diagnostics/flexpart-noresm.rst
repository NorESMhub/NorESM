FLEXPART NORESM
.. _diag_run:

****************************
NorESM2 Diagnostics Package
****************************

Introduction
============

The NorESM Diagnostic Package:
  is a NorESM model evaluation tool written with a set of scripts and command utilities (bash/cshrc, NCO, CDO and NCL etc) to provide a general evaluation and quick preview of the model performance with only one command line. This tool package works on the original model output and has NorESM-specific diagnostics.

**The tool package consists of:**

* **CAM_DIAG**: (Based on NCAR's `AMWG Diagnostics Package <http://www.cesm.ucar.edu/working_groups/Atmosphere/amwg-diagnostics-package/>`_)
* **CLM_DIAG**: (Based on CLM `Land Model Diagnostics Package <http://www.cesm.ucar.edu/models/cesm1.2/clm/clm_diagpackage.html>`_)
* **CICE_DIAG**: snow/sea ice volume/area
* **HAMOCC_DIAG**: time series, climaotology, zonal mean, regional mean
* **BLOM_DIAG**: time series, climatologies, zonal mean, fluxes, etc

(See more on the `Major changes to the NCAR's Diagnostics Package`_ at the bottom)

Installation
============

The source codes of the NorESM diagnostics packages are developed and maintained on the Github:
https://github.com/NordicESMhub/noresmdiagnostics.

And the observation dataset and grid files are hosted at:
