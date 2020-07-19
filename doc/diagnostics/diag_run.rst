.. _diag_run:

****************************
NorESM2 Diagnostics Package
****************************

Introduction
============

The NorESM Diagnostic Package:
  is a NorESM model evaluation tool written with a set of scripts (bash, NCL etc) to provide a general evaluation and quick preview of the model performance with only one command line. This toolpackage works on the original model output and has NorESM-specific diagnostics.

**The tool package consists of:**

* CAM_DIAG: (NCAR's AMWG Diagnostics Package)
* CLM_DIAG: (CESM Land Model Diagnostics Package)
* CICE_DIAG: snow/sea ice volume/area
* HAMOCC_DIAG: time series, climaotology, zonal mean, regional mean
* BLOM_DIAG: time series, climatologies, zonal mean, fluxes, etc

**NorESM diagnostics on GitHub**

The source codes of the NorESM diagnostics packages are developed and maintained in the Git version control repository:
https://github.com/NordicESMhub/noresmdiagnostics.

And the observation dataset and grid files are hosted at:
https://www.noresm.org/diagnostics, with a total size of ~100 GB.

**NorESM diagnostics on NIRD**

The full diagnostic package (including source files and data files) are currently hosted on NIRD: ``/projects/NS2345K/diagnostics/noresmdiagnostics``

Installation
============

Use the preinstalled package
----------------------------

You don't need to install this diagnostic package, but you can call it as a command line directly on NIRD. As a prerequiste, you should have access permission to the NS2345K project on NIRD. There is no need to install the diagnostic packages, but just add the ``diag_run`` to your search path, or add it as an alias in ``$HOME/.bashrc``, 
:: 

  alias diag_run=’/projects/NS2345K/diagnostics/noresmdiagnostics/bin’
  
DO NOT make changes direclty in this preinstalled package.

Clone and run your own copy
---------------------------
If you wanto make some changes of the diagnostic package for your own purpuse or/and want to contribute to the development of it, you can installed it on NIRD under your personal folder or your own project area (i.e., /projects/NSxxxxK). Briefly, there are several steps to install it:

1. Fork the NorESM Diagnostic Package ``Github repository <https://github.com/NordicESMhub/noresmdiagnostics>``_ to your own Github respository. For example, https://github.com/YOU_GITHUB_USERNAME/noresmdiagnostics
2. Change to your preferred location, say DIAGROOT, where you want to install the tool, and ``git clone https://github.com/YOU_GITHUB_USERNAME/noresmdiagnostics``
3. Change to $DIAGROOT/bin, and Link or download all the observation and grid data files.
  - If you are installing the tool on NIRD, you just need to link all the data to your clone by running the script ``linkdata.sh``, given you have access to the /project/NS2345K project
  - If you are not memember of NS2345K or you are installing it on platforms other than NIRD, you should download all the data to your clone by executing ``dloaddata.sh``. If you are not running it on NIRD, you should have CDO, NCO and NCL installed.
4. Make changes to the code/scripts for your purpose. And call ``diag_run`` of your own clone.
5. If you would like to contribute your function enhancements or bug fixes to the original diagnostic package, you should firstly make these changes in a new git branch, and commit the changes to your fork repository, then create an Issue at the `Github repository <https://github.com/NordicESMhub/noresmdiagnostics>`_, and finally make a ``pull`` request to the original Github repository to incorporate your changes.

Run the diagnostic tool
=======================

Each package can be run/configured from the command line using the wrapper script for NorESM diagnosticsprogram ``diag_run``: 

::

  ----------------------------------------------------------------------------- 
  Program:
  /projects/NS2345K/noresm_diagnostics/bin/diag_run
  Version: 2.0
  -------------------------------------------------
  Short description:
  A wrapper script for NorESM diagnostic packages.

  Basic usage:
  diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] # Run model-obs diagnostics
  diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] -c2 [cntl case name] -s2 [cntl case start yr] -e2 [cntl case end yr] # Run model1-model2 diagnostics
  nohup /projects/NS2345K/noresm_diagnostics/bin/diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] &> out & # Run model-obs diagnostics in the background with nohup

  Command-line options:
  -m, --model=MODEL                             Specify the diagnostics package (REQUIRED).
                                                Valid arguments:
                                                  cam    : atmospheric package (AMWG)
                                                  clm    : land package (LMWG)
                                                  cice   : sea-ice package
                                                  blom   : ocean package
                                                  hamocc : biogeochemistry package
                                                  all    : configure all available packages.
  -c, -c1, --case=CASE1, --case1=CASE1          Test case simulation (OPTIONAL).
  -s, -s1, --start_yr=SYR1, --start_yr1=SYR1    Start year of test case climatology (OPTIONAL).
  -e, -e1, --end_yr=EYR1, --end_yr1=EYR1        End year of test case climatology (OPTIONAL).
  -c2, --case2=CASE2                            Control case simulation (OPTIONAL).
  -s2, --start_yr2=SYR2                         Start year of control case climatology (OPTIONAL).
  -e2, --end_yr2=EYR2                           End year of control case climatology (OPTIONAL).
  -i, -i1, --input-dir=DIR, --input-dir1=DIR    Specify the directory where the test case history files are located (OPTIONAL).
                                                Default is --input-dir=/projects/NS2345K/noresm/cases
  -i2, --input-dir2=DIR                         Specify the directory where the control case history files are located (OPTIONAL).
                                                Default is --input-dir=/projects/NS2345K/noresm/cases
  -o, --output-dir=DIR                          Specify the directory where the package(s) the climatology and time-series files should be stored (OPTIONAL).
                                                Default is --output-dir=/projects/NS2345K/noresm_diagnostics/out/$USER
  -p, --passive-mode                            Run the script in passive mode: the diagnostic script will be configured but not executed (OPTIONAL).
  -t, --type=TYPE                               Specify climatology or time series diagnostics (OPTIONAL): valid options are --type=climo and --type=time_series.
                                                Default is to run both. Note that the time series are computed over the entire simulation.
  -w, --web-dir=DIR                             Specify the directory where the html should be published (OPTIONAL).
                                                Default is --web-dir=/projects/NS2345K/www/noresm_diagnostics
  --no-atm                                      Run CLM diagnostics without CAM data. Must be used for offline CLM simulations.
 

::


Description
------------

diag_run is a wrapper script, which is used to run the diagnostics for each NorESM component
(cam, clm, cice, blom, and hamocc). The diagnostic packages can be used to plot model results
with respect to either observations (so-called model-obs diagnostics), or to another simulation
(model1-model2 diagnostics). The diagnostics for the atmosphere (cam), land (clm) and sea-ice
(cice) are based on the NCAR packages, but has undergone some major improvements, particularly
in the climatology and time-series computations. The ocean (blom) and its biogeochemistry
(hamocc) have been developed in-house.

Please note, the ocean component of the NorESM2, BLOM, is an updated version of MICOM. It is named MICOM in NorESM1 for CMIP5 experiments and in NorESM2 for many (but not all) CMIP6 experiments. Therefore, for experiments with MICOM as the ocean component of NorESM, ``-m micom`` can be used in the command line option for ``diag_run``. To compare a simulation with either MICOM or BLOM to the other (model1-model2 diagnostics), you can either use ``-m micom`` or ``-m blom``. Both options should work.  

``diag_run`` has two modes: 

-  an “active-mode”, for which diag_run runs the diagnostic scripts 
-  a “passive-mode”, for which diag_run only configures the scripts. 

In the passive-mode the
diagnostic scripts have to be run manually by the user. By default, diag_run is always in the active-mode, 
but switches into passive-mode if at least one of these two criteria are fulfilled:

1. The user invokes the option -p (see below), or
2. The user does not give enough information needed to run the diagnostics (next subsection).

Active-mode
-------------

If you want to use diag_run to run the full (climatology and time-series) diagnostics, the minimum
requirement is to specify the options model, case_name, start_yr and end_yr
(-m, -c, -s and -e), e.g.: ::

  diag_run -m cam -c N1850_f19_tn14_191017 -s 21 -e 50
  
This command runs atmospheric model-obs diagnostics of the case N1850_f19_tn14_191017 using
a climatology between model years 21 and 50. It is assumed that the N1850_f19_tn14_191017
history files are located in /projects/NS2345K/noresm/cases. By default, the resulting plots and html will be
stored in ::

  /projects/NS2345K/www/diagnostics/noresmdiagnostics/$USER/N1850_f19_tn14_191017/CAM_DIAG,
  
or, if you specify to store them under a command folder, i.e. with ``-w /projects/NS2345K/www/diagnostics/noresmdiagnostics/common``. It links to links to the following URL: 
http://ns2345k.web.sigma2.no/diagnostics/noresmdiagnostics/common/N1850_f19_tn14_191017/CAM_DIAG/yrs21to50-obs.html.

The climatology and time-series files in /projects/NS2345K/diagnostics/noresmdiagnostics/out/$USER/CAM_DIAG (where $USER is your NIRD username).

If you want to run model1-model2 diagnostics, you also need to specify case_name2, start_yr2 and
end_yr2 (-c2, -s2, -e2) in addition, i.e.: ::

  diag_run -m cam -c N1850_f19_tn14_191017 -s 21 -e 50 -c2 B1850MICOM_f09_tn14_01 -s2 21 -e2 50
  
would be the same as in Example 1 above, except for comparing N1850_f19_tn14_191017 to
B1850MICOM_f09_tn14_01 instead of observations.

In Example 1 and Example 2 the options ``-s`` and ``-e`` (as well as ``-s2``, ``-e2``) refer to the start and end
years of the climatology. The time-series are calculated from all the history files in the case
directory (input_dir). This is always the case unless the user invokes the option ``-t time_series``. If
this option is invoked, start_yr and end_yr refer to the beginning and end of the time series instead
of the climatology, hence:

Example 3: ::

  diag_run -m blom -c N1850_f19_tn14_blom_20200608 -t time_series -s 1 -e 10

would produce blom time-series plots between years 1 and 20. Note that omitting start_yr and
end_yr when the option ``-t time_series`` is invoked computes the time-series over the entire
experiment (all history files in the case directory, input_dir): ::

   diag_run -m cam -c N1850_f19_tn14_191017 -t time_series
   
``diag_run`` uses some template scripts for each of the model components. When diag_run is executed,
these scripts are changed according to the user-specified settings and renamed with a time stamp.
For example, if you run the blom diagnostics, the run script template (``blom_diag_template.sh``)
will be renamed with a time-stamp as *blom_diag_YYMMDD_HHMMSS*.

``diag_run`` also creates a config and output file with the same time stamp
(*config_YYMMDD_HHMMSS* and *out_YYMMDD_HHMMSS*, respectively). The config file
stores information about changes in the diagnostics scripts invoked by the user, and the output file
contains the standard output and error (i.e. what is shown in your terminal during runtime).
When the diagnostics a component is finished the run scripts are copied to: ::

  output_dir/$USER/model_diag/config/case_name/run_scripts
  
and the config and output files to: ::

  output_dir/$USER/model_diag/config/case_name/logs
  
Hence, for Example 1 above, the run scripts are saved in: ::

  /projects/NS2345K/diagnostics/noresmdiagnostics/out/ $USER/CAM_DIAG/config/N1850_f19_tn14_191017/run_scripts
  
and the config and out files in: ::

  /projects/NS2345K/diagnostics/noresmdiagnostics/out/$USER/CAM_DIAG/config/N1850_f19_tn14_191017/logs

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

  [nird@login0 ~]$ /projects/NS2345K/diagnostics/noresmdiagnostics/diag_run -m clm
  -------------------------------------------------
  Program:
  /projects/NS2345K/noresm_diagnostics/bin/diag_run
  Version: 2.0
  -------------------------------------------------
  -CHANGING DIAGNOSTICS DIRECTORY to
  /projects/NS2345K/diagnostics/noresmdiagnostics/out/xxx/CLM_DIAG in lnd_template.csh
  -CHANGING ROOT DIRECTORY FOR CODE AND DATA to
  /projects/NS2345K/diagnostics/noresmdiagnostics/packages/CLM_DIAG in lnd_template.csh
  -CHANGING INPUT DIR 1 to /projects/NS2345K/noresm/cases in lnd_template.csh
  -CHANGING publish_html_root to /projects/NS2345K/www/diagnostics/noresmdiagnosticss in
  lnd_template.csh
  -SETTING UP TIME-SERIES DIAGNOSTICS FOR ENTIRE EXPERIMENT
  CLM DIAGNOSTICS SUCCESSFULLY CONFIGURED in
  /projects/NS2345K/diagnostics/noresmdiagnostics/out/xxx/CLM_DIAG
  -------------------------------------------------
  lnd_template.csh IS NOT RUNNING: NOT ALL REQUIRED VARIABLES HAVE BEEN CONFIGURED
  (see /projects/NS2345K/diagnostics/noresmdiagnostics/out/xxx/CLM_DIAG/config.log).
  -------------------------------------------------
  -------------------------------------------------
  TOTAL diag_run RUNTIME: 0m2s
  -CLM diagnostics: 0m2s
  -------------------------------------------------
  DONE: fr. 20. april 15:37:42 +0200 2018

::

The (semi-configured) run script has then been copied to
/projects/NS2345K/diagnostics/noresmdiagnostics/out/<username>/CLM_DIAG/lnd_template.csh,
and all information about the configuration is contained in
/projects/NS2345K/diagnostics/noresmdiagnostics/out/<username>/CLM_DIAG/config.log

Options
-------
diag_run options (flags) typically come in both short (single-letter) and long forms. A complete
description of all options is given below in alphabetical order of the short option letter. When
invoked without options, diag_run prints a table containing all options along with some examples
(see also below). ::

  -c case_name (-c1, --case, --case1)
  
Name of the test case experiment that you want to run diagnostics for. This option is required if you
want to use diag_run in active-mode. ::

  -c2 case_name2 (--case2)
 
Name of the control case experiment. This option is required if you want to run model1-model2
diagnostics in active-mode. ::

  -e end_year (-e1,--end_yr,--end_yr1)
  
If –type=time_series, this option refers to the end year of time-series for case_name. Otherwise, it
refers to the end year of climatology. This option is optional if –type=time_series, but required for
active-mode diagnostics if –type=climo or if type is not invoked. ::

  -e2 end_year (--end_yr2)
  
If –type=time_series, this option refers to the end year of time-series for case_name2. Otherwise, it
refers to the end year of climatology. This option is optional if –type=time_series, but required for
active-mode model1-model2 diagnostics if –type=climo or if type is not invoked. ::

  -i input_dir (-i1, --input-dir, --input-dir1)
  
Name of the root directory of the monthly history files for case_name. For example, if your blom
history files are located in /this/is/a/directory/case1/ocn/hist, this option should be set to
input_dir=/this/is/a/directory. Default is input_dir=/projects/NS2345K/noresm/cases . ::

  -i2 input-dir2 (--input-dir2)
  
Name of the root directory of the monthly history files for case_name2. Also here, default is
input_dir2=/projects/NS2345K/noresm/cases . ::

  -m model (--model)

Name of the model you want to run the diagnostics for. Valid options are cam, clm, cice, blom,
hamocc and all. This is the only option that is required for both the active and passive mode. If you
invoke the “all” option, the cam, clm, cice, blom and hamocc diagnostics will be run
subsequently. It is also possible to combine different models as you wish within this option: for
example, if you only want to run cam and clm diagnostics, you can simply add the names of those
models and separate them with a comma (-m cam,clm). ::

  --no-atm
  
This option, which takes no argument, skips the usage of CAM history files in the CLM
diagnostics. This option is necessary for offline CLM simulations. ::

  -o output_dir (--output_dir)
  
Root directory where you want to store the output from the diagnostics (i.e. the climatology and
time-series files). For example, if you set output_dir=/just/another/directory, the climatology and
time-series files from the blom diagnostics will be stored in::

  /just/another/directory/BLOM_DIAG/. 
  
Default is::

  output_dir=/projects/NS2345K/diagnostics/noresmdiagnostics/out/$USER
  
where $USER is your user name on NIRD. ::

  -p, --passive-mode
  
This option, which takes no argument, forces diag_run into passive-mode. This means, even if you
have given sufficient information to run in active-mode, the diagnostic scripts will not be executed. ::

 -s start_year (-s1,--start_yr,--start_yr1)
 
If –type=time_series, this option refers to the start year of time-series for case_name. Otherwise, it
refers to the start year of climatology. This option is optional if –type=time_series, but required for
active-mode diagnostics if –type=climo or if type is not invoked. ::

  -s2 start_year2 (--start_yr2)
  
If –type=time_series, this option refers to the start year of time-series for case_name2. Otherwise, it
refers to the start year of climatology. This option is optional if –type=time_series, but required for
active-mode model1-model2 diagnostics if –type=climo or if type is not invoked. ::

  -t type (--type)
  
Specifies if you only run climatology or time-series diagnostics: valid options are --type=climo and
--type=time_series. Default is to run both. ::

  -w webdir (--web-dir)
  
Specifies the directory where the html should be stored. This directory should preferably be linked
to a web server so that one can look at the results with a web browser. Default is::

  --web-dir=/projects/NS2345K/www/diagnostics/noresmdiagnostics/
  

Examples
--------

Model-obs diagnostics of case=N1850_f19_tn11_exp1 (climatology between yrs 21 and 50) for all
model components: ::

  diag_run -m all -c N1850_f19_tn11_exp1 -s 21 -e 50
  
  
Model-obs diagnostics in CAM, publish the html in /path/to/my/html: ::

  diag_run -m cam -c N1850_f19_tn11_exp1 -s 21 -e 50 -w /path/to/my/html
  
  
Model-obs time-series diagnostics in BLOM for all years the model output directory
(/projects/NS2345K/noresm/cases/N1850_f19_tn14_blom_20200608/ocn/hist/): ::

  diag_run -m blom -c N1850_f19_tn14_blom_20200608 -t time_series
  
  
Configure (but do not run) model-obs diagnostics for CICE: ::

  diag_run -m cice -c N1850_f19_tn11_exp1 -s 21 -e 50 -p
  
Model1-model2 diagnostics for CLM with user-specified history file directories: ::

  diag_run -m clm -c N1850_f19_tn11_exp1 -s 21 -e 50 -i /input/directory1 -c2
  
  
N1850_f19_tn11_exp2 -s2 21 -e2 50 -i2 /input/directory2
Model-obs climatology diagnostics (no time series) for BLOM: ::

  diag_run -m blom -c N1850_f19_tn14_blom_20200608 -s 1 -e 10 -t climo
  
Install CAM diagnostics in /my/dir with minimal configuration: ::

  diag_run -m cam -o /my/dir
  
Model-obs diagnostics for BLOM and HAMOCC: ::

  diag_run -m blom,hamocc -c N1850_f19_tn14_blom_20200608 -s 1 -e 10
  
Model-obs time-series diagnostics for an offline (uncoupled) CLM simulation: ::

  diag_run -m clm -c N1850_f19_tn11_clmexp1 -s 71 -e 100 --no-atm
  
Model-obs time-series diagnostics in HAMOCC between yrs 31 and 100: ::

  diag_run -m hamocc -c N1850OC_f19_tn11_exp1 -s 31 -e 100 -t time_series
  



move the tool package to /projects/NS2345K/diagnostics/noresmdiagnostics

move the observational data and grid data to: /projects/NS2345K/www/diagnostics/inputdata/, and add tools to link or download the data
