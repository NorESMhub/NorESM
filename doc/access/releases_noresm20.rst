.. _releases_noresm20:

Released versions of NorESM2.0
==============================

NorESM2.0.6
++++++++++++

* Repository: NorESMhub/NorESM
* Tag: release-noresm2.0.6
* Commit: 
* Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the six former releases.

This release contains:
----------------------
* **updated NorESM2 documentation**
* addition of **extra compsets** : new SSP5-3.4 compsets and emission driven SSP compsets (affects CAM-Nor, CLM and NorESM)
* CAM-Nor 
        (1) technical (non answer-changing) modifications in CAM-Nor : correction in CCN and COSP diagnostics;
        (2) correction in H2O emission file link for f09 for the extended (year 2100-2300) SSP1-2.6 and SSP5-8.5 compsets;
        (3) addition for the above-mentioned extra compsets.
* CLM
        (1) addition for the above-mentioned extra compsets.
* CIME
        (1) modification in archiving script noresm2netcdf4.sh : uses ncks instead of nccopy;
        (2) other small modifications.
* CISM
        (1) link to cism-wrapper repository on NorESMhub (instead of ESCOMP)
        (2) added CISM support, Greenland enabled compsets and usermod
* BLOM
        (1) include option for hybrid vertical coordinates;
        (2) include option for sediment spinup;
        (3) include support for NUOPC driver;
        (4) iHAMOCC source code structure : completed conversion to free-source format and explicit use statements for all imported variables;
        (5) modifications in model structure.  The hybrid vertical coordinate formulation relies on an external package CVmix, which is included as a git submodule. When building NorESM, the external dependency should be declared for BLOM in the Externals.cfg file : externals = Externals_BLOM.cfg;
        (6) changes in model diagnostics in BLOM. Starting from commit 9e6bd6b, which introduced hybrid vertical coordinates, model output changed for the following 4 fields: wflx (vertical mass flux), wflx2 (vertical mass flux squared), bfsq (buoyancy frequency squared) and bfsqlvl (buoyancy frequency squared (constant depth levels));
        (7) changes in model diagnostics in BLOM. Pull request #205 included a correction on the variable dp_trc : this variable is supposed to be in unit Pa = kg m-1 s-2 but is wrongly output in unit g cm-1 s-2;
        (8) changes in model diagnostics in iHAMOCC.  Pull request #202 changed the definition of the variable KWCO2, with the original definition retained in a new variable KWCO2KHM.

How to obtain this version:
---------------------------
::

    git clone https://github.com/NorESMhub/NorESM.git
    cd NorESM
    git tag --list (this should give you a list of the existing tags or releases)
    git checkout release-noresm2.0.6
    ./manage_externals/checkout_externals



NorESM2.0.5
++++++++++++

* Repository: NorESMhub/NorESM
* Tag: release-noresm2.0.5
* Commit: 133cc12
* Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the five former releases. 

This release contains:
----------------------
* **updated NorESM2 documentation**, including an overview of NorESM2 releases, updated information about the CLM5.0 model component, and expansion of the FAQ section
* technical (non answer-changing) modifications in CAM-Nor (to guarantee automatic download of AeroTab files for PTAERO compsets)
* technical (non answer-changing) modifications in CTSM/CLM (modification to avoid problems with some compilers, changes related to NorCPM, and updated README.md)

How to obtain this version:
---------------------------
::

    git clone https://github.com/NorESMhub/NorESM.git
    cd NorESM
    git tag --list (this should give you a list of the existing tags or releases)
    git checkout release-noresm2.0.5
    ./manage_externals/checkout_externals


NorESM2.0.4
++++++++++++

* Repository: NorESMhub/NorESM 
* Tag: release-noresm2.0.4 
* Commit: d8c5cec 
* Released by: DirkOlivie

This release is identical to release-noresm2.0.3 except for an additional modification in CIME related to Fram machine and the `--pecount` option for betzy. We therefore repeat here the information mentioned in release-noresm2.0.3.

**Version of code which can be used to reproduce the CMIP6 results of NorESM2.** This release builds on the four former releases.

This release contains:
------------------------
* modified setting for machine Fram : minor changes due to removal of preproc queue (this is the only change compared to release-noresm2.0.3)
* settings to run on the machine Betzy
* automatic copying of the case directory to the archive directory
* updated documentation
* modifications in the ocean component BLOM (see a list of main changes below)

Notable changes of BLOM v1.1.0 compared to v1.0.0 that has impact on BLOM operation as a component of NorESM
-------------------------------------------------------------------------------------------------------------
* Added NorESM multiple instance support
* Corrected time-smoothing of forcing fields received through the coupler so it works for any coupling interval.
* Corrected the generation of BLOM/iHAMOCC input data list.
* Added handling of N-deposition files for N2000 compsets.
* Major restructuring of code to replace header files and common blocks with Fortran modules.
* Added new pe-layout for OMIP1 compsets with iHAMOCC using the tnx2 grid.
* Added support for tripolar ocean grid with 1/8 deg resolution along equator (tnx0.125v4).

How to obtain this version:
---------------------------
::

    git clone https://github.com/NorESMhub/NorESM.git
    cd NorESM
    git tag --list (this should give you a list of the existing tags or releases)
    git checkout release-noresm2.0.4
    ./manage_externals/checkout_externals


NorESM2.0.3
++++++++++++

* Repository: NorESMhub/NorESM
* Tag: release-noresm2.0.3 
* Commit: ac97bf2 
* Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the three former releases.

This release contains:
----------------------
* settings to run on the machine Betzy
* automatic copying of the case directory to the archive directory
* updated documentation
* modifications in the ocean component BLOM (see a list of main changes below)

Notable changes of BLOM v1.1.0 compared to v1.0.0 that has impact on BLOM operation as a component of NorESM:
--------------------------------------------------------------------------------------------------------------
* Added NorESM multiple instance support.
* Corrected time-smoothing of forcing fields received through the coupler so it works for any coupling interval.
* Corrected the generation of BLOM/iHAMOCC input data list.
* Added handling of N-deposition files for N2000 compsets.
* Major restructuring of code to replace header files and common blocks with Fortran modules.
* Added new pe-layout for OMIP1 compsets with iHAMOCC using the tnx2 grid.
* Added support for tripolar ocean grid with 1/8 deg resolution along equator (tnx0.125v4).

How to obtain this version
--------------------------
::

   git clone https://github.com/NorESMhub/NorESM.git
   cd NorESM
   git tag --list (this should give you a list of the existing tags or releases)
   git checkout release-noresm2.0.3
   ./manage_externals/checkout_externals


NorESM2.0.2
++++++++++++
* Repository: NorESMhub/NorESM 
* Tag: release-noresm2.0.2 
* Commit: 6581d10 
* Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. This release builds on the two former releases.

This release contains:
----------------------
* updated documentation
* bug fixes such that model runs without intermittent crashes on certain machines (nebula, tetralith)
* automatic download of NorESM-specific inputdata from noresm.org/inputdata
* indication of which grids are supported for individual compsets
* modification in the inputdata structure of BLOM
* extra usermods_dir for keyCLIM simulations and extra compsets for covid simulations

Additional features:
--------------------
* restart files for some compsets can now be found on noresm.org/restart

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
* Repository: NorESMhub/NorESM
* Tag: release-noresm2.0.1 
* Commit: 21b9758 
* Released by: DirkOlivie

Version of code which can be used to **reproduce the CMIP6 results of NorESM2**. Code is now split over several repositories. Licenses have been added.




