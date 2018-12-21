.. _modeldiagnostics:

Model Diagnostic Tools
=======================                      

This page links to tools used for the NorESM model evaluation.

NorESM Diagnostic Packages
''''''''''''''''''''''''''

Output from the latest NCAR diagnostic pages can be found on nird here:

via the web: http://ns2345k.web.sigma2.no/noresm_diagnostics/

via the filesystem on nird here:
/projects/NS2345K/www/noresm_diagnostics/

The diagnostics packages are currently available on NIRD. Each package
can be run/configured from the command line using the program diag_run:

::

  --------------

  Program: /projects/NS2345K/noresm_diagnostics/bin/diag_run Version: 5.1

  --------------

  Short description: A wrapper script for NorESM diagnostic packages.

  Basic usage: 
    diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] # Run model-obs diagnostics 
    diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] -c2 [cntl case name] -s2 [cntl case start yr] -e2 [cntl case end yr] # Run model1-model2 diagnostics 
   nohup /projects/NS2345K/noresm_diagnostics/bin/diag_run -m [model] -c [test case name] -s [test case start yr] -e [test case end yr] &> out & # Run model-obs diagnostics in the background with nohup

  Command-line options: 
    -m, --model=MODEL Specify the diagnostics package (REQUIRED).
          Valid arguments:
	        cam    : atmospheric package (AMWG)
		clm    : land package (LMWG)
		cice   : sea-ice package
		micom  : ocean package
		hamocc : biogeochemistry package
		all    : configure all available packages.
    -c, -c1, --case=CASE1, --case1=CASE1       Test case simulation (OPTIONAL).
    -s, -s1, --start_yr=SYR1, --start_yr1=SYR1 Start year of test case climatology (OPTIONAL). 
    -e, -e1, --end_yr=EYR1, --end_yr1=EYR1     End year of test case climatology (OPTIONAL).
    -c2, --case2=CASE2                         Control case simulation (OPTIONAL). 
    -s2, --start_yr2=SYR2                      Start year of control case climatology (OPTIONAL). 
    -e2, --end_yr2=EYR2                        End year of control case climatology (OPTIONAL). 
    -i, -i1, --input-dir=DIR, --input-dir1=DIR Specify the directory where the test case history files are located (OPTIONAL).
                                               Default is --input-dir=/projects/NS2345K/noresm/cases
    -i2, --input-dir2=DIR                      Specify the directory where the control case history files are located (OPTIONAL).
                                               Default is --input-dir=/projects/NS2345K/noresm/cases
    -o, --output-dir=DIR                       Specify the directory where the package(s) the climatology and time-series files should be stored (OPTIONAL).
                                               Default is --output-dir=/projects/NS2345K/noresm_diagnostics/out/$USER
    -p, --passive-mode                         Run the script in passive mode: the diagnostic script
                                               will be configured but not executed (OPTIONAL).
    -t, --type=TYPE                            Specify climatology or time series diagnostics (OPTIONAL): 
                                               valid types are --type=climo and --type=time_series.
					       Default is to run both. Note that the time 
					       series are computed over the entire simulation.
    -w, --web-dir=DIR                          Specify the directory where the html should be published (OPTIONAL).
                                               Default is --web-dir=/projects/NS2345K/www/noresm_diagnostics
    --no-atm Run CLM diagnostics without CAM data. Must be used for offline CLM simulations.
    Examples: 
      diag_run -m all -c N1850_f19_tn11_exp1 -s 21 -e 50 # model-obs diagnostics of case=N1850_f19_tn11_exp1 (climatology between yrs 21 and 50) for all model components. 
      diag_run -m cam -c N1850_f19_tn11_exp1 -s 21 -e 50 -w /path/to/my/html # model-obs diagnostics in CAM, publish the html in /path/to/my/html. 
      diag_run -m micom -c N1850_f19_tn11_exp1 -t time_series # model-obs time-series diagnostics in MICOM for all years represented in the model output directory (/projects/NS2345K/noresm/cases/N1850_f19_tn11_exp1/ocn/hist/). 
      diag_run -m cice -c N1850_f19_tn11_exp1 -s 21 -e 50 -p # configure (but do not run) model-obs diagnostics for CICE. 
      diag_run -m clm -c N1850_f19_tn11_exp1 -s 21 -e 50 -i /input/directory1 -c2 N1850_f19_tn11_exp2 -s2 21 -e2 50 -i2 /input/directory2 # model1-model2 diagnostics for CLM with user-specified history file directories
      diag_run -m micom -c N1850_f19_tn11_exp1 -s 21 -e 50 -t climo # model-obs climatology diagnostics (no time series) for MICOM: 
      diag_run -m cam -o /my/dir # install CAM diagnostics in /my/dir with minimal configuration. 
      diag_run -m micom,hamocc -c N1850OC_f19_tn11_exp1 -s 21 -e 50 # model-obs diagnostics for MICOM and HAMOCC. 
      diag_run -m clm -c N1850_f19_tn11_clmexp1 -s 71 -e 100 --no-atm # model-obs time-series diagnostics for an offline (uncoupled) CLM simulation. 
      diag_run -m hamocc -c N1850OC_f19_tn11_exp1 -s 31 -e 100 -t time_series # model-obs time-series diagnostics in HAMOCC between yrs 31 and 100. 
      

:download:`A comprehensive technical summary of diag_run (pdf) <presentations/diag_run_documentation.pdf>`

Report any problems, comments or suggestions to Yanchun He: yanchun.he@nersc.no

Recent updates
~~~~~~~~~~~~~~

- 29.08.10. Update to v5.1: update NCO/NCL versions to support efficient process of compressed netcdf-4 files.
- 29.06.18. Update to v5.0: new fields to HAMOCC and MICOM diagnostics; minor fixes to other issues.
- 20.04.18. Update to v4.3: added new fields to HAMOCC diagnostics.
- 19.04.18. Update to v4.2: included ability to do time-series diagnostics between two user-specified years.
- 18.04.18. Update to v4.1: improved climatology and time-series calculations in CLM, and introduction of the ``--no-atm`` option to enable diagnostics for offline CLM simulations.
- 09.04.18. Update to v4.0: included the HAMOCC diagnostics package.
- 23.02.18. Update to v3.1: added monthly MLD, seasonal SST/SSS and annual meridional heat/salinity fluxes to the MICOM diagnostics.
- 17.01.18. Update to v3.0: the first version of MICOM diagnostics has been included.
- 28.11.17. Update to v2.0: included a set of time series plots in CAM diagnostics, along with an html interface, which can be accessed from the index page (sets.htm). 

Using diag_run with cron
~~~~~~~~~~~~~~~~~~~~~~~~

If you want to use diag_run with crontab, you first need to load
$HOME/.bash_profile, i.e.:

::

  #--------------
  # Min Hour Day Month Weekday Command(s)
  #--------------

  50 09 23 11 \* . $HOME/.bash_profile; /projects/NS2345K/noresm_diagnostics/bin/diag_run -m cam,cice -c N18_f19_tn11_080617 -s 21 -e 50 -o /scratch/$USER/noresm_diagnostics2 -w \
  /projects/NS2345K/www/test -t time_series >& /scratch/$USER/cron_out

Other tips
~~~~~~~~~~

It is useful to add diag_run as an alias in $HOME/.bashrc, so that you
do not need to write out the whole path every time you run it: alias

:: 

  diag_run='/projects/NS2345K/noresm_diagnostics/bin/diag_run'

NorESM diagnostics on GitHub
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The NorESM diagnostics packages and diag_run are included in the Git
version control repository: https://github.com/johiak/NoresmDiagnostics

Aerosol and Chemistry, Clouds and Forcing Diagnostics
                                                     

In both the default CAM5-aerosol packages (MAM3,MAM7) and the
Oslo-aerosol packages, the budget terms can be taken out using a
variable in the namelist :

Configuring a run with more aerosol diagnostics in (NorESM2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

 &phys_ctl_nl 
 history_aerosol = .true. 
 /

Two more diagnostics are useful:

- Enable estimates multiple calls to radiation which are necessary for effective radiative forcing estimates
- Enable diagnostics for AEROCOM

To enable this, take the file cam/src/physics/cam_oslo$ vim
preprocessorDefinitions.h and copy it to your SourceMods/src.cam folder

Change both preprocessor definitions to true

::

  #define AEROCOM
  #define AEROFFL

The AEROCOM-token turns on diagnostics needed for AEROCOM The
AEROFFL-token tells the model to do additional radiation-diagnostics for
aerosol indirect effect

Tracer Budget terms
'''''''''''''''''''

Fields produced in monthly average files when running with budgets activated
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running with budgets activated will produce the following terms in the
monthly output files:

+---------------------+------------------------------+-------------------------------+
|Output variable name | Meaning                      | Comment                       | 
+=====================+==============================+===============================+
| SF{Tracer}          | Emissions from surface       |                               | 
| GS_{Tracer}         | gas phase chemistry          | 3D-emissions and gas phase    |
|                     |                              |washout included in this term  | 
+---------------------+------------------------------+-------------------------------+
| AQ_{Tracer}         | aquous chemistry             |                               | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_Mixnuc1    | Activation in clouds and     |                               |
|                     | evaporation of cloud droplets|                               | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_DDF        | Dry deposition flux (aerosol |                               |
|                     | tracers)                     |                               |
+---------------------+------------------------------+-------------------------------+
| {Tracer}_SFWET      | Wet deposition flux (aerosol |                               |
|                     | tracers)                     |                               | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_condtend   | loss/production in           |                               |
|                     | condensation/nuclation       | (CAM-Oslo only)               | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_coagTend   |loss/production in coagulation| (CAM-Oslo only)               | 
+---------------------+------------------------------+-------------------------------+
| DF_{Tracer}         |dry deposition flux (gas      |                               |
|                     | tracers)                     | output with history_aerosol   |
|                     |                              | with CAM-Oslo only            | 
+---------------------+------------------------------+-------------------------------+
| WD_A_{Tracer}       | wet deposititon flux (gas    |                               |
|                     | tracers)                     | output with history_aerosol   |
|                     |                              | with CAM-Oslo only            | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_CLXF       | 3D-emissions ("external      |                               |
|                     | forcing")                    | output with history_aerosol   |
|                     |                              | with CAM-Oslo only            | 
+---------------------+------------------------------+-------------------------------+
| {Tracer}_clcoagTend | loss of tracer due to        |                               |
|                     | coagulation with cloud       |                               |
|                     | droplets                     | output with history_aerosol   |
|                     |                              | with CAM-Oslo only            |
+---------------------+------------------------------+-------------------------------+

Note: Since 3D-emissions and and gas washout rates are included in the
term GS_{Tracer} in the mozart chemistry solver, the individual terms
can be found like this (example for SO2): 

:: 

  ncap2 -O -s GS_ONLY_SO2=GS_SO2-WD_A_SO2-SO2_CLXF infile.nc outfile.nc

More info on SO2 budgets (see
/models/atm/cam/tools/diagnostics/ncl/ModIvsModII/ for scripts with info
on all tracers):

GS_SO2 contains the SO2 budget terms for all that goes on in the
chemistry-routine, which is 

1. Gas phase chemistry, 

2. Wet deposition, and 

3. 3D-emissions.

Gas phase chemistry is both
production from DMS (GS_DMS) and loss through OH (GL_OH) 

For calculations of net loss, e.g. used to calculate SO2 life-times, we're
interested in the loss through OH from the chemistry-term (GL_OH).

::

  GS_SO2 = GL_OH + SO2_CLXF - WD_A_SO2 - GS_DMS*64/62 

or

::

  GL_OH = GS_SO2 - SO2_CLXF + WD_A_SO2 + GS_DMS*64/62 

Estimating chemical loss w.r.t. S (instead of SO2 or DMS), for
comparison with CAM4-Oslo numbers:

::

  net chemial loss gas phase = (GS_SO2/1.998 - SO2_CLXF + WD_A_SO2)/1.998 + GS_DMS/1.938
  net chemical loss = net chemial loss gas phase + AQ_SO2/1.998

Finally, total net loss (used to calculate life-time = -load/(net loss),
where load = cb_SO2/1.998):

::

  net loss = 
    - WD_A_SO2/1.998 ;wet deposition in kg/m2/sec (positive in output file) 
    - DF_SO2/1.998 ;dry deposition in kg/m2/sec (positive in output file)
    + AQ_SO2/1.998 ;wet phase production of SO4 in kg/m2/ses (negative in output file) 
    + (GS_SO2 - SO2_CLXF + WD_A_SO2)/1.998 + GS_DMS/1.938 ; net chemical loss gas phase 

Looking at the aerosol budgets (CAM-Oslo only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Go to the directory models/atm/cam/tools/diagnostics/ncl/budgets
- Change the filename to use in the file budgets.ncl ("myFileName" around line 18). Should be for example yearly average of month-avg file in a run with budgets
- Run the script budgets.sh to create a pdf-file (output.pdf)

NCL Model Version Comparison package (Alf K)
''''''''''''''''''''''''''''''''''''''''''''

Making ncl plots of often used aerosol and cloud fields, including ERFs, for two model versions (CAM-Oslo only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Make a local copy (on Linux) of the directory models/atm/cam/tools/diagnostics/ncl/ModIvsModII
- Assuming that you have produced output data from 4 simulations: two different model versions, each with PD and PI emissions, and all run with ``#define AEROCOM & AEROFFL``:   
- In ModIvsModII.csh (note: read the header info):
    - edit model info for the first model (shown to the left in the plots): modelI = CAM4-Oslo or modelI = CAM5-Oslo ?
    - provide paths and partial file names of the model data (PD and PI) for Model I (CAM4-Oslo or CAM5-Oslo) and Model II (must be CAM5-Oslo)
    - choose desired plot format (plotf=ps, eps, pdf or png)
-  Run the script: ./ModIvsModII.csh
- Furthermore, to display the plots in an organized form by use of a web browser (only possible if the chosen plot format is png):
    - download htm template files from 
      ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/htm-templates/ 
    - edit general model info (only) in ModIvsModII.htm, and manually cut and paste the mass budget numbers from the script output into this file 
    - copy all png (plots) and htm files to the desired output (common) directory
    - open ModIvsModII.htm in your browser: hyper-links to all other htm files, including plots, are found here
- Example:  ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/revision610inclSOA-Nudged_1984-12to1985-11_vs_CAM4-Oslo/ModIvsModII.htm

Cloud water mass and number analysis (budgets)
''''''''''''''''''''''''''''''''''''''''''''''

Configuring a run with more cloud diagnostics in NorESM2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To switch on extra output for cloud diagnostics (mass and number
tendencies for liquid water and mass) change the following namelist
variable:

::

 &phys_ctl_nl history_budget = .true. /

A python script for plotting the mass and number budgets for the cloud
microphysics can be found under:

models/atm/cam/tools/diagnostics/ncl/cloudBudgets

in the same branch. Copy the script to your local computer or lustre and
edit the script to read the correct input file(s) (instructions inside
the script). Run the script by typing:

::

 python scriptname.py

in your terminal.

Automatic AEROCOM analysis
''''''''''''''''''''''''''

To prepare output so that it is processed automatically by the aerocom
tools, use the script located at **models/atm/cam/tools/aerocom/** in
the svn repository. The script prepares files such that the idl aerocom
tools prepare plots for the aerocom webinterface: 
`URL link to NorESM on AeroCom webinterface <http://aerocom.met.no/cgi-bin/aerocom/surfobs_annualrs.pl?PROJECT=NorESM&MODELLIST=NorESM-development&FULL=explicit&INFO=nohover&PERFORMANCE=ind&YEARFILTER=ALLYEARS&PSFILTER=ALLVARS&Type0=ZONALOBS&Ref0=AERONETSun&Run0=CAM53-Oslo_r773bNudge_151215AG_PD_DMS_733b&Parameter0=OD550_AER&Station0=WORLD&Year0=an9999&Period0=mALLYEAR>`__

The script requires <ModelName>_<ExperimentName> and <Period> as input. 

- <Period>: for a climatological average and run choose 9999 , for nudged simulations choose the year of the meteorology 
- <ModelName>_<ExperimentName>: is the dataset identifier under which the plots appear on the AeroCom webinterface in the required format NorESM-CAM5_svn{RevisionNumber}_YYMMDD{initials}_Freetext. 

*Example:*

"**NorESM-CAM5_svn1094_151201AG_CMIP6endelig**" 

Initials AG: Alf Grini, AK: Alf Kirkevåg, DO: Dirk Olivie...

Where the date YYMMDD corresponds to the time when the AeroCom data
preparation script has been executed.

The script creates files named like 

::

  aerocom3_<ModelName>_<ExperimentName>_<VariableName>_<VerticalCoordinateType>_<Period>_<Frequency>.nc 

- <ModelName> ⇒ eg NorESM-CAM53 
- <ExperimentName> ⇒ svn{RevisionNumber}_YYMMDD{initials}_Freetext 
- <VariableName> ⇒ aerocom variable names 
- <VerticalCoordinateType> ⇒ “Surface”, “Column”, “ModelLevel”, “SurfaceAtStations”, “ModelLevelAtStations” 
- <Period> ⇒ eg “2008”, “2010”, “9999” 
- <Frequency> ⇒ “timeinvariant”,”hourly”, “daily”, “monthly”, “sat1000”, “sat1330”, “sat2200”, “sat0130” 

Note that VerticalCoordinateType is dependent on the variable!! It is not a question about “vertical coordinate type used in model simulations”! 

The script copies files on norstore into ``/projects/NS2345K/CAM-Oslo/DO_AEROCOM/<ModelName>_<ExperimentName>/renamed/`` 

ESMval CIS JASMIN platform and tools
''''''''''''''''''''''''''''''''''''
                                    

- ESMVALtool http://www.geosci-model-dev-discuss.net/8/7541/2015/gmdd-8-7541-2015-discussion.html
- cis tools http://www.cistools.net
- JASMIN http://www.jasmin.ac.uk/services/jasmin-analysis-platform/

Post analysis and workup of CAM diagnostics output tables
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''                                                         

A tool for post analysis of (multiple) CAM diagnostics ASCII tables can
be found in the following repository:

GitHub https://github.com/jgliss/noresm_diag_postproc

To get started, please follow the instructions in repository README
(displayed in repository). Currently, the main analysis tool is a
jupyter IPython notebook called

**analysis_tool.ipynb**

(https://github.com/jgliss/noresm_diag_postproc/blob/master/analysis_tool.ipynb)

which includes more detailed instructions about setup and options.

Use the notebook

https://github.com/jgliss/noresm_diag_postproc/blob/master/download_tables.ipynb

to download local copies of result tables using a list of URL's.


**Short summary:**

The notebook reads multiple diagnostics files (runs) into one long table
and creates heatmap plots of *Bias, RMSE and RMSE relative error* for
a subset of variables (rows -> y-axis of heatmap) vs. the individual
runs (columns -> xaxis).


**NOTE:** 
In the current version, you need to download all tables that you are interested in as csv or ascii into one directory, that is specified in the header of the notebook.

Variable groups can be defined in this config file:

::

  https://github.com/jgliss/noresm_diag_postproc/blob/master/config/var_groups.ini

**NOTE:** 
If you add groups to this file in your local copy of the repository, please consider sending the updated to jonasg@met.no or to submit a pull request, so that the remote repository remains up to date.


**Troubleshooting**

If you run into problems, please raise an issue in the repository or contact jonasg@met.no
