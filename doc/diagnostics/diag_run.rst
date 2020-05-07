.. _diag_run:

NorESM2 specific diagnostics
============================

The diagnostics packages are currently available on NIRD. Each package can be run/configured from the command line using the program diag_run

Location
--------

At the moment diag_run is only available on NIRD:
/projects/NS2345K/noresm_diagnostics/bin/diag_run

Description
------------

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


Options
-------
diag_run options (flags) typically come in both short (single-letter) and long forms. A complete
description of all options is given below in alphabetical order of the short option letter. When
invoked without options, diag_run prints a table containing all options along with some examples
(see also below).::

  -c case_name (-c1, --case, --case1)
  
Name of the test case experiment that you want to run diagnostics for. This option is required if you
want to use diag_run in active-mode.::

  -c2 case_name2 (--case2)
 
Name of the control case experiment. This option is required if you want to run model1-model2
diagnostics in active-mode.::

  -e end_year (-e1,--end_yr,--end_yr1)
  
If –type=time_series, this option refers to the end year of time-series for case_name. Otherwise, it
refers to the end year of climatology. This option is optional if –type=time_series, but required for
active-mode diagnostics if –type=climo or if type is not invoked.::

  -e2 end_year (--end_yr2)
  
If –type=time_series, this option refers to the end year of time-series for case_name2. Otherwise, it
refers to the end year of climatology. This option is optional if –type=time_series, but required for
active-mode model1-model2 diagnostics if –type=climo or if type is not invoked.::

  -i input_dir (-i1, --input-dir, --input-dir1)
  
Name of the root directory of the monthly history files for case_name. For example, if your micom
history files are located in /this/is/a/directory/case1/ocn/hist, this option should be set to
input_dir=/this/is/a/directory. Default is input_dir=/projects/NS2345K/noresm/cases ::

  -i2 input-dir2 (--input-dir2)
  
Name of the root directory of the monthly history files for case_name2. Also here, default is
input_dir2=/projects/NS2345K/noresm/cases ::

  -m model (--model)

Name of the model you want to run the diagnostics for. Valid options are cam, clm, cice, micom,
hamocc and all. This is the only option that is required for both the active and passive mode. If you
invoke the “all” option, the cam, clm, cice, micom and hamocc diagnostics will be run
subsequently. It is also possible to combine different models as you wish within this option: for
example, if you only want to run cam and clm diagnostics, you can simply add the names of those
models and separate them with a comma (-m cam,clm)::

  --no-atm
  
This option, which takes no argument, skips the usage of CAM history files in the CLM
diagnostics. This option is necessary for offline CLM simulations.::

  -o output_dir (--output_dir)
  
Root directory where you want to store the output from the diagnostics (i.e. the climatology and
time-series files). For example, if you set output_dir=/just/another/directory, the climatology and
time-series files from the micom diagnostics will be stored in::

  /just/another/directory/MICOM_DIAG/. 
  
Default is::

  output_dir=/projects/NS2345K/noresm_diagnostics/out/$USER
  
where $USER is your user name on NIRD.::

  -p, --passive-mode
  
This option, which takes no argument, forces diag_run into passive-mode. This means, even if you
have given sufficient information to run in active-mode, the diagnostic scripts will not be executed.::

 -s start_year (-s1,--start_yr,--start_yr1)
 
If –type=time_series, this option refers to the start year of time-series for case_name. Otherwise, it
refers to the start year of climatology. This option is optional if –type=time_series, but required for
active-mode diagnostics if –type=climo or if type is not invoked.::

  -s2 start_year2 (--start_yr2)
  
If –type=time_series, this option refers to the start year of time-series for case_name2. Otherwise, it
refers to the start year of climatology. This option is optional if –type=time_series, but required for
active-mode model1-model2 diagnostics if –type=climo or if type is not invoked.::

  -t type (--type)
  
Specifies if you only run climatology or time-series diagnostics: valid options are --type=climo and
--type=time_series. Default is to run both.::

  -w webdir (--web-dir)
  
Specifies the directory where the html should be stored. This directory should preferably be linked
to a web server so that one can look at the results with a web browser. Default is::

  --web-dir=/projects/NS2345K/www/noresm_diagnostics/.

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
