.. _atm_model:

The atmosphere model
=============================

The atmospheric model component of NorESM2, **CAM6-Nor**, (Seland et al., in review for GMD) is built on the CAM6 version from CESM2.1, but with particulate aerosols and the aerosol-radiation-cloud interaction parameterisation from NorESM1 and NorESM1.2 as described by Kirkevåg et al. (2013, 2018). NorESM2-specific changes to model physics and dynamics which are not aerosol related, are described by Toniazzo et al. (2019) and Toniazzo et al. (in prep.). The latest updates in the aerosol modules (that is, the changes between NorESM1.2 and NorESM2) are described by Olivié et al. (in prep.).

One particular part of the CAM6-Nor which is not described in great detail in any of the most recent papers (2020) is the offline sectional aerosol model AeroTab6. This is based on AeroTab5.3 (Kirkevåg et al., 2018), but uses updated complex refractive indexes for mineral dust for wavelengths below 15 μm, changed according to recent research (for details, see Olivié et al. (in prep.). A user guide for this model code will soon appear under the Configurations chapter.

