.. _diag_run:

NorESM2 specific diagnostics
============================

The diagnostics packages are currently available on NIRD. Each package can be run/configured from the command line using the program diag_run

Location
--------

At the moment diag_run is only available on NIRD:
/projects/NS2345K/noresm_diagnostics/bin/diag_run

Description
-----------
diag_run is a wrapper script, which is used to run the diagnostics for each NorESM component
(cam, clm, cice, micom, and hamocc). The diagnostic packages can be used to plot model results
with respect to either observations (so-called model-obs diagnostics), or to another simulation
(model1-model2 diagnostics). The diagnostics for the atmosphere (cam), land (clm) and sea-ice
(cice) are based on the NCAR packages, but has undergone some major improvements, particularly
in the climatology and time-series computations. The ocean (micom) and its biogeochemistry
(hamocc) have been developed in-house.
diag_run has two modes: 
- (i) an “active-mode”, for which diag_run runs the diagnostic scripts 
- (ii) a “passive-mode”, for which diag_run only configures the scripts. 

In the passive-mode the
diagnostic scripts have to be run manually by the user. By default, diag_run is always in the active-mode, 
but switches into passive-mode if at least one of these two criteria are fulfilled:

- 1. The user invokes the option -p (see below), or
- 2. The user does not give enough information needed to run the diagnostics (next subsection).


Passive-mode
-------------
Another important property of diag_run is that it will only run the diagnostics if sufficient
information has been provided by the user; otherwise it switches into passive-mode. diag_run will
then configure the diagnostics scripts as much as possible (based on the information provided by the
user), and also add information to the config file about which variables are still required to be
modified by the user in order to run the diagnostic script. This option is particularly useful if you
want to do some development work on the diagnostics scripts, or if you want to change any
variables in the diagnostics scripts that are not included as an option in diag_run. Hence, if you run
the following command::

  diag_run -m clm


the following will appear on the screen:

::
  [johiak@tos-spw08 ~]$ /projects/NS2345K/noresm_diagnostics/diag_run -m clm
  -------------------------------------------------
  Program:
  /projects/NS2345K/noresm_diagnostics/bin/diag_run
  Version: 4.3
  -------------------------------------------------
  -CHANGING DIAGNOSTICS DIRECTORY to
  /projects/NS2345K/noresm_diagnostics/out/johiak/CLM_DIAG in lnd_template.csh
  -CHANGING ROOT DIRECTORY FOR CODE AND DATA to
  /projects/NS2345K/noresm_diagnostics/packages/CLM_DIAG in lnd_template.csh
  -CHANGING INPUT DIR 1 to /projects/NS2345K/noresm/cases in lnd_template.csh
  -CHANGING publish_html_root to /projects/NS2345K/www/noresm_diagnostics in
  lnd_template.csh
  -SETTING UP TIME-SERIES DIAGNOSTICS FOR ENTIRE EXPERIMENT
  CLM DIAGNOSTICS SUCCESSFULLY CONFIGURED in
  /projects/NS2345K/noresm_diagnostics/out/johiak/CLM_DIAG
  -------------------------------------------------
  lnd_template.csh IS NOT RUNNING: NOT ALL REQUIRED VARIABLES HAVE BEEN CONFIGURED
  (see /projects/NS2345K/noresm_diagnostics/out/johiak/CLM_DIAG/config.log).
  -------------------------------------------------
  -------------------------------------------------
  TOTAL diag_run RUNTIME: 0m2s
  -CLM diagnostics: 0m2s
  -------------------------------------------------
  DONE: fr. 20. april 15:37:42 +0200 2018

::

The (semi-configured) run script has then been copied to
/projects/NS2345K/noresm_diagnostics/out/<username>/CLM_DIAG/lnd_template.csh,
and all information about the configuration is contained in
/projects/NS2345K/noresm_diagnostics/out/<username>/CLM_DIAG/config.log


Add to .bashrc
--------------
It is useful to add diag_run as an alias in $HOME/.bashrc, 
so that you do not need to write out the whole path every time you run it:: 

  alias diag_run=’/projects/NS2345K/noresm_diagnostics/bin/diag_run’

NorESM diagnostics on GitHub
----------------------------

The NorESM diagnostics packages and diag_run are included in the Git version control repository:
https://github.com/johiak/NoresmDiagnostics

Aerosol and Chemistry, Clouds and Forcing Diagnostics
In both the default CAM5-aerosol packages (MAM3,MAM7) and the Oslo-aerosol packages, the budget terms can be taken out using a variable in the namelist :

Contact person: 
