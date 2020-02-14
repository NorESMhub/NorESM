Experimets
==========

NorESM is part of the CESM family of earth system models and shares a lot of the configuration options with CESM. Many of the simulation configuration settigns are defined by the so called compsets.

Basic case set up, compilation and job submission with NorESM
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This is a general description/checklist for how to create a new experiment with NorESM. For a quick start guide, see also ref:newbie-guide.rst The case creation step is explained in more detail below.

- Create a case::

    cd <noresm-base>/cime/scripts
    ./create_newcase --case <path_to_case_dir/casename> --walltime <time> --compset <compset_name> --res <resolution> --machine <machine_name> --project snic2019-1-2 --output-root <path_to_run_dir/NorESM> --run-unsupported 

Example of case creation on Tetralith:::

  ./create_newcase --case ../cases/test1910_1 --walltime 24:00:00 --compset N1850 --res f19_tn14 --machine tetralith  --project snic2019-1-2 --output-root /proj/bolinc/users/${USER}/NorESM2/noresm2_out --run-unsupported

- Configure case::

  cd <path_to_case_dir/casename>
  ./case.setup


- Add code changes

Copy your code changes to the folder::

  <path_to_case_dir/casename>/SourceMods/src.<component>


- Build model::

  ./case.build


- Edit namelist::

  <path_to_case_dir/casename>/user_nl_<component>

- Edit run configuration::

  env_run.xml

- Copy restart files to run directory::


- Submit job::

./case.submit

Create new case
^^^^^^^^^^^^^^^

To start a new experiment you need to create a case. When creating a case a case folder <path_to_case_dir/casename> will be created that contains all the settings for your experiment

The case creation contains a compset option. A compset is a collection of predefined setting that defines your experiment setup. Some of the available compsets are described below.

The case folder contains predefined namelist (with namelist settings partly depending on compset option). The default namelist options for the case can be overwritten by changing/adding the new namelist options in the user_nl_<component>

For extra aerosol output add the following configuration option

--user-mods-dir cmip6_noresm_*

cmip6_noresm_DECK  
cmip6_noresm_hifreq  
cmip6_noresm_hifreq_xaer  
cmip6_noresm_xaer  

For more details about the user-mod-dir options, chck this folder::

<noresm_base>/cime_config/usermods_dirs

Compsets
''''''''
Below some compsets are listed. All predefined comsets can be found in::

  <noresm_base>/cime_config/config_compsets.xml


N1850 and N1850frc2 (uses differently organized emission files : FRC2)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Coupled configuration for NorESM for pre-industrial conditions.

NHIST and NHISTfrc2  (uses differently organized emission files : FRC2)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Historical configuration up to year 2015(?)

NSSP126frc2, NSSP245frc2, NSSP370frc2, NSSP585frc2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Future scenario compsets from 2015(?) to 2100(?)

Choosing components
^^^^^^^^^^^^^^^^^^^

Creating your own compset
^^^^^^^^^^^^^^^^^^^^^^^^^

Choosing resolution
'''''''''''''''''''

Model resolution is set when the case is created. Below some common resolutions are listed. A complete list of model grids can be found here:::
  
  <noresm_base>/cime/config/cesm/config_grids.xml

Atmosphere only
^^^^^^^^^^^^^^^
f19_f19 - atm lnd 1.9x2.5
f09_f09 - atm lnd 0.9x1.25

Ocean only
^^^^^^^^^^
Which ocean grid is recommended?

tnx1v1 tripole v1 1-deg grid
tnx1v3 tripole v3 1-deg grid
tn14(?)tripole v4 1-deg grid  tripole ocean grid
tnx2v1 tripole v1 2-deg grid
tx1v1 tripole v1 1-deg grid: testing proxy for high-res tripole ocean grids- do not use for scientific experiments

Coupled
^^^^^^^
Which is the CMIP6 grid?

f09_tn11   - atm lnd 0.9x1.25, ocnice tnx1v1
f09_tn13   - atm lnd 0.9x1.25, ocnice tnx1v3
f09_tn14   - atm lnd 0.9x1.25, ocnice tnx1v4
f09_tn0251 - atm lnd 0.9x1.25, ocnice tnx0.25v1
f09_tn0253 - atm lnd 0.9x1.25, ocnice tnx0.25v3
f19_tn11   - atm lnd 1.9x2.5, ocnice tnx1v1
f19_tn13   - atm lnd 1.9x2.5, ocnice tnx1v3
f19_tn14   - atm lnd 1.9x2.5, ocnice tnx1v4

Choosing simulation period
''''''''''''''''''''''''''

Some comsets only go with certain time periods?

Choosing forcing
''''''''''''''''

Choosing output
'''''''''''''''





































