.. image:: img/NORESM-logo.png
  :width: 150
  :alt: NorESM logo

=============================
  NorESM development branch
=============================

This is the main development branch for the Norwegian Earth System Model
(NorESM), currently in development towards the NorESM3.0 release.

* This branch is for technical testing only! It is not a released version
  and results from it should not be used for scientific analysis.

* The component versions in this branch are defined by the git submodules
  listed in **.gitmodules** (see `Obtaining the full model code`_). Each
  submodule is pinned to a tagged version of the NorESM component, via the
  ``fxtag`` entry, consistent with the NorESM3.0 build system.

* Development tags are named ``noresm3_0_betaNN`` (alpha/beta tags) and
  ``noresm3_0_*`` for releases. All changes between tags, including the
  component versions used, are recorded in the **ChangeLog** file.

NorESM is based on the Community Earth System Model (CESM). Information on
the model, usage and contributing is found in:

* NorESM home page: https://www.noresm.org/
* NorESM3.0 user guide: https://noresm-docs.readthedocs.io/en/noresm3.0/index.html
* Contributing guidelines: `CONTRIBUTING.md <CONTRIBUTING.md>`_
* Code of conduct: `CODE_OF_CONDUCT.md <CODE_OF_CONDUCT.md>`_
* Issues and bug reports: https://github.com/NorESMhub/NorESM/issues
* NorESM user mailing list: https://www.noresm.org/mailman/listinfo/users_noresm.org

For background on the underlying CESM framework, see the CESM web site
(https://www.cesm.ucar.edu) and the CIME documentation
(https://esmci.github.io/cime/).

License
=======

NorESM is copyright of the NorESM developers group and is distributed under
the terms given in **LICENSE.txt**. The parts of the code that originate from
CESM are covered by the CESM license in **LICENSE-CESM.txt**. Some NorESM
components have a different license, e.g. BLOM is licensed under the GNU
Lesser General Public License version 3. See **LICENSE.txt** for details; the
license of each component must be obeyed when using, modifying or sharing it.

.. sectnum::

.. contents::

Model components
================

The model is assembled from the following repositories (checked out as
submodules, see **.gitmodules** for the exact versions):

.. list-table::
   :header-rows: 1

   * - Path
     - Component
     - Repository (NorESMhub)
   * - components/cam
     - Atmosphere (CAM-Nor)
     - CAM
   * - components/clm
     - Land (CTSM, incl. FATES)
     - CTSM
   * - components/blom
     - Ocean and ocean biogeochemistry (BLOM/iHAMOCC)
     - BLOM
   * - components/cice
     - Sea ice (CICE6)
     - NorESM_CICE
   * - components/cism
     - Land ice (CISM)
     - CISM-wrapper
   * - components/mosart
     - River routing (MOSART)
     - MOSART
   * - components/ww3
     - Waves (WW3 interface)
     - WW3_interface
   * - components/cmeps
     - Coupler (CMEPS)
     - CMEPS
   * - components/cdeps
     - Data models (CDEPS)
     - CDEPS

Supporting repositories are ``cime``, ``ccs_config`` (machine and compiler
configuration), ``share``, ``libraries/parallelio`` (PIO) and ``tools/statistical_ensemble_test/pyCECT``.

Software requirements
=====================

Software requirements for installing, building and running NorESM
-----------------------------------------------------------------

Installing, building and running NorESM requires:

* a Unix-like operating system (Linux, OS X, etc.)

* git client version 2.25 or newer (needed by git-fleximod)

* python3 version 3.8 or newer

* perl version 5

* build tools gmake and cmake

* Fortran and C compilers

  * See `Details on Fortran compiler versions`_ below for more information

* LAPACK and BLAS libraries

* a NetCDF library version 4.3 or newer built with the same compiler you
  will use for NorESM

  * a PnetCDF library is optional

* a functioning MPI environment (unless you plan to run on a single core
  with the CIME mpi-serial library)

Details on Fortran compiler versions
------------------------------------
The Fortran compiler must support Fortran 2003 features. However, even
among mainstream Fortran compilers that claim to support Fortran 2003,
we have found numerous bugs. Thus, many compiler versions do *not* build
or run NorESM properly. Supported compilers and machines are defined in the
``ccs_config`` submodule.

More details on porting NorESM
------------------------------

For more details on porting NorESM to a new machine, see
https://esmci.github.io/cime/versions/master/html/users_guide/porting-cime.html
and the NorESM user guide.

Obtaining the full model code
=============================

NorESM is distributed via GitHub. To obtain the code do the following:

#. Clone the repository. ::

      git clone https://github.com/NorESMhub/NorESM.git my_noresm_sandbox

   This will create a directory ``my_noresm_sandbox/`` in your current
   working directory.

#. Go into the newly created repository and select the version you want.
   To see which NorESM tags are available, use **git tag**. The `master`
   branch is checked out by default::

      cd my_noresm_sandbox
      git tag
      git checkout noresm_develop   # or a tag, e.g. noresm3_0_beta30

   (When checking out a tag you will get a message about being in
   'detached HEAD' state. This is normal and expected.)

#. Fetch the components with **git-fleximod**. ::

      ./bin/git-fleximod update

   **git-fleximod** is a package manager that populates the sandbox with
   the relevant versions of each component and the CIME infrastructure,
   as specified in **.gitmodules**.

At this point you have a working version of NorESM.

To see full details of how to set up a case, compile and run, see the
NorESM user guide and the CIME documentation.
