.. _releases_noresm20:

Released versions of NorESM2.0
==============================


NorESM2.0.5
++++++++++++


NorESM2.0.4
++++++++++++

- Repository: NorESMhub/NorESM 
- Tag: release-noresm2.0.4 
- Commit: d8c5cec 
- Released by: DirkOlivie

This release is identical to release-noresm2.0.3 except for an additional modification in CIME related to Fram machine and the `--pecount` option for betzy. We therefore repeat here the information mentioned in release-noresm2.0.3.

**Version of code which can be used to reproduce the CMIP6 results of NorESM2.** This release builds on the four former releases.

This release contains:
------------------------
- modified setting for machine Fram : minor changes due to removal of preproc queue (this is the only change compared to release-noresm2.0.3)
- settings to run on the machine Betzy
- automatic copying of the case directory to the archive directory
- updated documentation
- modifications in the ocean component BLOM (see a list of main changes below)

Notable changes of BLOM v1.1.0 compared to v1.0.0 that has impact on BLOM operation as a component of NorESM
-----------------
- Added NorESM multiple instance support
- Corrected time-smoothing of forcing fields received through the coupler so it works for any coupling interval.
- Corrected the generation of BLOM/iHAMOCC input data list.
- Added handling of N-deposition files for N2000 compsets.
- Major restructuring of code to replace header files and common blocks with Fortran modules.
- Added new pe-layout for OMIP1 compsets with iHAMOCC using the tnx2 grid.
- Added support for tripolar ocean grid with 1/8 deg resolution along equator (tnx0.125v4).

How to obtain this version:
---------------------
::

    git clone https://github.com/NorESMhub/NorESM.git
    cd NorESM
    git tag --list (this should give you a list of the existing tags or releases)
    git checkout release-noresm2.0.4
    ./manage_externals/checkout_externals

::

NorESM2.0.3
++++++++++++

- Repository: NorESMhub/NorESM
- Tag: release-noresm2.0.3 
- Commit: ac97bf2 
- Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the three former releases.

This release contains:
------------
- settings to run on the machine Betzy
- automatic copying of the case directory to the archive directory
- updated documentation
- modifications in the ocean component BLOM (see a list of main changes below)

Notable changes of BLOM v1.1.0 compared to v1.0.0 that has impact on BLOM operation as a component of NorESM:
------------------------------------
- Added NorESM multiple instance support.
- Corrected time-smoothing of forcing fields received through the coupler so it works for any coupling interval.
- Corrected the generation of BLOM/iHAMOCC input data list.
- Added handling of N-deposition files for N2000 compsets.
- Major restructuring of code to replace header files and common blocks with Fortran modules.
- Added new pe-layout for OMIP1 compsets with iHAMOCC using the tnx2 grid.
- Added support for tripolar ocean grid with 1/8 deg resolution along equator (tnx0.125v4).

How to obtain this version
--------------
::

   git clone https://github.com/NorESMhub/NorESM.git
   cd NorESM
   git tag --list (this should give you a list of the existing tags or releases)
   git checkout release-noresm2.0.3
   ./manage_externals/checkout_externals
   
::

NorESM2.0.2
++++++++++++
- Repository: NorESMhub/NorESM 
- Tag: release-noresm2.0.2 
- Commit: 6581d10 
- Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the two former releases.

This release contains:
------------
- updated documentation
- bug fixes such that model runs without intermittent crashes on certain machines (nebula, tetralith)
- automatic download of NorESM-specific inputdata from noresm.org/inputdata
- indication of which grids are supported for individual compsets
- modification in the inputdata structure of BLOM
- extra usermods_dir for keyCLIM simulations and extra compsets for covid simulations

Additional features:
---------
- restart files for some compsets can now be found on noresm.org/restart

Notice
-------
1. automatic download of inputdata from noresm.org to certain machines (e.g. nebula) might not work completely as expected. This can partially be solved by or :
 (i) change the listed order of servers in cime/config/cesm/config_inputdata.xml : move the cesm-inputdata server before the noresm.org server; or
 (ii) run ./check_inputdata twice; or
 (iii) submit the job twice (./case_submit).
 
2. reproducing CMIP6 results
 (i) on vilje and fram for atmosphere-only compsets (like NF1850norbc, NFHISTnorpibc, ...) : this can be obtained by commenting out in cam/src/chemistry/mozart/chemistry.F90 line 1310 : ncldwtr(:,:) = 0._r8
 (ii) on vilje and fram for fully-coupled simulations (like N1850, NSSP245frc2, ...) : we have kept the -init=zero,arrays compiler settings for CAM on fram and vilje
 (iii) one should use the same number of processor as in the original simulation

3. it is possible that some NorESM-specific inputdata is missing on noresm.org/inputdata. If that happens, please make an issue, and we will try to upload the missing data.


NorESM2.0.1
++++++++++++
- Repository: NorESMhub/NorESM
- Tag: release-noresm2.0.1 
- Commit: 21b9758 
- Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. Code is now split over several repositories. Licenses have been added.




