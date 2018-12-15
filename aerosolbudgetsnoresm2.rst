.. _aerosolbudgetsnoresm2:

Configuring a run with more aerosol diagnostics in (NorESM2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In both the default CAM5-aerosol packages (MAM3,MAM7) and the
Oslo-aerosol packages, the budget terms can be taken out using a
variable in the namelist :

 &phys_ctl_nl history_aerosol = .true. /

Two more diagnostics are useful:

| `` * Enable estimates multiple calls to radiation which are necessary for effective radiative forcing estimates``
| `` * Enable diagnostics for AEROCOM``

To enable this, take the file cam/src/physics/cam_oslo$ vim
preprocessorDefinitions.h and copy it to your SourceMods/src.cam folder

Change both preprocessor definitions to true

#. define AEROCOM
#. define AEROFFL

The AEROCOM-token turns on diagnostics needed for AEROCOM The
AEROFFL-token tells the model to do additional radiation-diagnostics for
aerosol indirect effect

Fields produced in monthly average files when running with budgets activated
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Running with budgets activated will produce the following terms in the
monthly output files:

^ Output variable name ^ Meaning ^ Comment ^ \| SF{Tracer} \| Emissions
from surface \| \| \| GS_{Tracer} \| gas phase chemistry \| 3D-emissions
and gas phase washout included in this term \| \| AQ_{Tracer} \| aquous
chemistry \| \| \| {Tracer}_Mixnuc1 \| Activation in clouds and
evaporation of cloud droplets \| \| \| {Tracer}_DDF \| Dry deposition
flux (aerosol tracers) \| \| \| {Tracer}_SFWET \| Wet deposition flux
(aerosol tracers) \| \| \| {Tracer}_condtend \| loss/production in
condensation/nuclation \| (CAM-Oslo only) \| \| {Tracer}_coagTend \|
loss/production in coagulation \| (CAM-Oslo only) \| \| DF_{Tracer} \|
dry deposition flux (gas tracers) \| output with history_aerosol with
CAM-Oslo only\| \| WD_A_{Tracer} \| wet deposititon flux (gas tracers)
\| output with history_aerosol with CAM-Oslo only\| \| {Tracer}_CLXF \|
3D-emissions ("external forcing") \| output with history_aerosol with
CAM-Oslo only\| \| {Tracer}_clcoagTend \| loss of tracer due to
coagulation with cloud droplets \| output with history_aerosol with
CAM-Oslo only\|

Note: Since 3D-emissions and and gas washout rates are included in the
term GS_{Tracer} in the mozart chemistry solver, the individual terms
can be found like this (example for SO2): ncap2 -O -s
GS_ONLY_SO2=GS_SO2-WD_A_SO2-SO2_CLXF infile.nc outfile.nc

More info on SO2 budgets (see
/models/atm/cam/tools/diagnostics/ncl/ModIvsModII/ for scripts with info
on all tracers):

GS_SO2 contains the SO2 budget terms for all that goes on in the
chemistry-routine, which is \\\\ 1) Gas phase chemistry, 2) Wet
deposition, and 3) 3D-emissions.\\\ Gas phase chemistry is both
production from DMS (GS_DMS) and loss through OH (GL_OH) \\\\ For
calculations of net loss, e.g. used to calculate SO2 life-times, we're
interested in the \\\\ loss through OH from the chemistry-term
(GL_OH).\\\ GS_SO2 = GL_OH + SO2_CLXF - WD_A_SO2 - GS_DMS*64/62 \\\\ or
\\\\ GL_OH = GS_SO2 - SO2_CLXF + WD_A_SO2 + GS_DMS*64/62 \\\\

Estimating chemical loss w.r.t. S (instead of SO2 or DMS), for
comparison with CAM4-Oslo numbers:\\\ net chemial loss gas phase =
(GS_SO2/1.998 - SO2_CLXF + WD_A_SO2)/1.998 + GS_DMS/1.938 \\\\ net
chemical loss = net chemial loss gas phase + AQ_SO2/1.998 \\\\

Finally, total net loss (used to calculate life-time = -load/(net loss),
where load = cb_SO2/1.998):\\\ net loss = \\\\ - WD_A_SO2/1.998 ;wet
deposition in kg/m2/sec (positive in output file) \\\\ - DF_SO2/1.998
;dry deposition in kg/m2/sec (positive in output file) \\\\ +
AQ_SO2/1.998 ;wet phase production of SO4 in kg/m2/ses (negative in
output file) \\\\ + (GS_SO2 - SO2_CLXF + WD_A_SO2)/1.998 + GS_DMS/1.938
; net chemical loss gas phase \\\\

Looking at the aerosol budgets (CAM-Oslo only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| `` * Go to the directory models/atm/cam/tools/diagnostics/ncl/budgets``
| `` * Change the filename to use in the file budgets.ncl ("myFileName" around line 18). Should be for example yearly average of month-avg file in a run with budgets``
| `` * Run the script budgets.sh to create a pdf-file (output.pdf)``

Making ncl plots of often used aerosol and cloud fields, including ERFs, for two model versions (CAM-Oslo only)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| `` * Make a local copy (on Linux) of the directory models/atm/cam/tools/diagnostics/ncl/ModIvsModII``
| `` * Assuming that you have produced output data from 4 simulations: two different model versions, each with PD and PI emissions, and all run with #define AEROCOM & AEROFFL:   ``
| `` * In ModIvsModII.csh (note: read the header info):``
| `` * - edit model info for the first model (shown to the left in the plots): modelI = CAM4-Oslo or modelI = CAM5-Oslo ?``
| `` * - provide paths and partial file names of the model data (PD and PI) for Model I (CAM4-Oslo or CAM5-Oslo) and Model II (must be CAM5-Oslo)``
| `` * - choose desired plot format (plotf=ps, eps, pdf or png)``
| `` * Run the script: ./ModIvsModII.csh``
| `` * Furthermore, to display the plots in an organized form by use of a web browser (only possible if the chosen plot format is png):    ``
| `` * - download htm template files from ``\ ```ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/htm-templates/`` <ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/htm-templates/>`__
| `` * - edit general model info (only) in ModIvsModII.htm, and manually cut and paste the mass budget numbers from the script output into this file ``
| `` * - copy all png (plots) and htm files to the desired output (common) directory``
| `` * - open ModIvsModII.htm in your browser: hyper-links to all other htm files, including plots, are found here``
| `` * Example: ``\ ```ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/revision610inclSOA-Nudged_1984-12to1985-11_vs_CAM4-Oslo/ModIvsModII.htm`` <ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/revision610inclSOA-Nudged_1984-12to1985-11_vs_CAM4-Oslo/ModIvsModII.htm>`__

Preparing output for AEROCOM analysis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To prepare output so that it is processed automatically by the aerocom
tools, use the script located at \**models/atm/cam/tools/aerocom/*\* in
the svn repository. The script prepares files such that the idl aerocom
tools prepare plots for the aerocom webinterface: `URL link to NorESM on
AeroCom
webinterface <http://aerocom.met.no/cgi-bin/aerocom/surfobs_annualrs.pl?PROJECT=NorESM&MODELLIST=NorESM&FULL=explicit&INFO=nohover&PERFORMANCE=ind&YEARFILTER=ALLYEARS&PSFILTER=ALLVARS&Type0=ZONALOBS&Ref0=AERONETSun&Run0=CAM53-Oslo_r773bNudge_151215AG_PD_DMS_733b&Parameter0=OD550_AER&Station0=WORLD&Year0=an9999&Period0=mALLYEAR>`__

The script requires \_ and as input.

: for a climatological average and run choose 9999 , for nudged
simulations choose the year of the meteorology

\_: is the dataset identifier under which the plots appear on the
AeroCom webinterface \\\\ of the form
NorESM-CAM5_svn{RevisionNumber}_YYMMDD{initials}_Freetext. \\\\ Example:
"NorESM-CAM5_svn1094_151201AG_CMIP6endelig" \\\\ Initials AG: Alf Grini,
AK: Alf Kirkevåg, DO: Dirk Olivie...

The script creates files named like

“aerocom3\_\_\_\_\_\_.nc”

 ⇒ eg NorESM-CAM53 \\\\ ⇒ svn{RevisionNumber}_YYMMDD{initials}_Freetext
\\\\ ⇒ aerocom variable names \\\\ ⇒ “Surface”, “Column”, “ModelLevel”,
“SurfaceAtStations”, “ModelLevelAtStations” \\\ ⇒ eg “2008”, “2010”,
"9999" \\\\ ⇒ “timeinvariant”,”hourly”, “daily”, “monthly”, “sat1000”,
“sat1330”, “sat2200”, “sat0130” \\\\

Note that VerticalCoordinateType is dependent on the variable!! It is
not a question about "vertical coordinate type used in model
simulations"!

The script copies files on norstore into

-  

   -  /projects/NS2345K/CAM-Oslo/DO_AEROCOM/\_/renamed/*\*
