.. _esmvaltool:

Earth System Model eValuation Tool (ESMValTool)
===============================================                                               

About
'''''

ESMValTool extension for NorESM (NorESMValTool) covers

| `` * NorESM cmor-ization tools``
| `` * ESMValTool``
| `` * observational data``
| `` * CMIP5 model data``
| `` * namelists and scripts customised for NorESM ``
| `` * wrapper scripts for easy use``

and is available at

| `` * local: login.nird.sigma2.no:/projects/NS2345K/NorESMValTool``
| `` * web: ``\ ```https://github.com/NorwegianClimateCentre/NorESMValTool.git`` <https://github.com/NorwegianClimateCentre/NorESMValTool.git>`__\ ` <https://github.com/NorwegianClimateCentre/NorESMValTool.git>`__

--------------

Installation
''''''''''''

On Norstore/Nird, run

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/install.sh

.. raw:: html

   </html>

This will create your personal setup in

.. raw:: html

   <html>

$HOME/NorESMValTool

.. raw:: html

   </html>

:

| ``data/       - input and derived data (symbolic link to project area)``
| ``   clim/           - climatologies derived from original input data ``
| ``   cmor/       - cmor output of new experiments  ``
| ``   model/      - CMIP5 model output``
| ``   obs/        - obs. data installed with ESMValTool scripts``
| ``   rawobs/     - obs. data as downloaded from internet ``
| ``   regrid/     - data regridded by ESMValTool``
| ``   work/       - work directory of ESMValTool``
| ``mods/       - source mods for ESMValTool ``
| ``   namelists/      - customised namelists for Norstore/NorESM``
| ``scripts/        - wrapper scripts for cmor and ESMValTool ``
| ``   cmorize     - cmor wrapper script for NorESM output ``
| ``   esmval      - ESMValTool wrapper script``
| ``tools/          - noresm2cmor and ESMValTool reside here``
| ``   noresm2cmor/    - cmorization tools ``
| ``   ESMValTool/     - original ESMValTool installation ``

--------------

CMOR-izing NorESM output
''''''''''''''''''''''''

Syntax
^^^^^^

.. raw:: html

   <html>

$HOME/NorESMValTool/scripts/cmorize case folder start year end year

.. raw:: html

   </html>

NOTE: Cmor-ization on NIRD requires intel's shared libraries. To make
them available, add following line to your ~/.bashrc and log out and in
again

.. raw:: html

   <html>

| 
|  source /opt/intel/compilers_and_libraries/linux/bin/compilervars.sh
  -arch intel64 -platform linux 

.. raw:: html

   </html>

Example
^^^^^^^

.. raw:: html

   <html>

$HOME/NorESMValTool/scripts/cmorize
/projects/NS2345K/www/cmor/sampledata/N20TRAERCN_f19_g16_01 2000 2000

.. raw:: html

   </html>

Output configuration
^^^^^^^^^^^^^^^^^^^^

The output can be customised in

.. raw:: html

   <html>

$HOME/NorESMValTool/tools/noresm2cmor/namelists/noresm2cmor_NorESM_GENERIC_template.nml

.. raw:: html

   </html>

New variables need to be defined in the corresponding GENERIC_\* tables
in

.. raw:: html

   <html>

$HOME/NorESMValTool/tools/noresm2cmor/tools/noresm2cmor/tables

.. raw:: html

   </html>

Output location
^^^^^^^^^^^^^^^

The cmor-ized output is written to the folder

.. raw:: html

   <html>

$HOME/NorESMValTool/data/cmor/case name.start year-end year

.. raw:: html

   </html>

e.g.

.. raw:: html

   <html>

$HOME/NorESMValTool/data/cmor/N20TRAERCN_f19_g16_01.2000-2000

.. raw:: html

   </html>

NOTE: The cmor-ized output is stored in Norstore/Nird's project area.
The path

.. raw:: html

   <html>

$HOME/NorESMValTool/data/cmor

.. raw:: html

   </html>

is a symbolic link to

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/data/cmor

.. raw:: html

   </html>

.

--------------

Running ESMValTool (manually)
'''''''''''''''''''''''''''''

Prepare namelist
^^^^^^^^^^^^^^^^

ESMValTool takes one namelist as input argument. Each namelist contains
instructions for performing a specific diagnostic.

A collection of ported namelists is available in

.. raw:: html

   <html>

 $HOME/NorESMValTool/mods/namelist

.. raw:: html

   </html>

. Path information to observational and simulation data is hardcoded in
the namelists and need to be edited in order to apply ESMValTool on new
simulation output.

More namelists provided by the official ESMValTool repository are
available in

.. raw:: html

   <html>

 $HOME/NorESMValTool/tools/ESMValTool/nml

.. raw:: html

   </html>

.

These namelists cannot be readily used with the ESMValTool on
Norstore/Nird but have to be ported first. The specifications of
observational and model data in the namelists have to be adapted to the
data available in the system. We recommend to first copy the namelist to

.. raw:: html

   <html>

 $HOME/NorESMValTool/mods/namelist

.. raw:: html

   </html>

and edit it there.

Note that in many cases new input data has to be made available first.

Launching ESMValTool
^^^^^^^^^^^^^^^^^^^^

Change directory to

.. raw:: html

   <html>

 $HOME/NorESMValTool/tools/ESMValTool

.. raw:: html

   </html>

.

Execute

.. raw:: html

   <html>

| 
|  ./main.py 

.. raw:: html

   </html>

e.g.

.. raw:: html

   <html>

| 
|  ./main.py ../../mods/namelists/namelist_SouthernOcean_norstore.xml 

.. raw:: html

   </html>

NOTE: ESMValTool requires NCL version 6.4. To make this version
available, add following lines to your ~/.bash_profile and log out and
in again

.. raw:: html

   <html>

| 
| export NCARG_ROOT=/opt/ncl64
| export PATH=/opt/ncl64/bin/:${PATH} 

.. raw:: html

   </html>

--------------

Running ESMValTool (through esmval-wrapper)
'''''''''''''''''''''''''''''''''''''''''''

.. _syntax-1:

Syntax
^^^^^^

.. raw:: html

   <html>

 $HOME/NorESMValTool/scripts/esmval cmor folder ESMValTool namelist

.. raw:: html

   </html>

.. _example-1:

Example
^^^^^^^

.. raw:: html

   <html>

 $HOME/NorESMValTool/scripts/esmval
$HOME/NorESMValTool/data/cmor/N20TRAERCN_f19_g16_01.2000-2000
$HOME/NorESMValTool/mods/namelist/namelist_MyDiag.xml

.. raw:: html

   </html>

{{ :noresm:MyDiag_MyVar.png?300 \|}}

How it works
^^^^^^^^^^^^

The

.. raw:: html

   <html>

esmval

.. raw:: html

   </html>

script replaces

.. raw:: html

   <html>

MODELTAG

.. raw:: html

   </html>

with the path to the cmorized output in the customised ESMValTool
namelist that has been selected (e.g.,

.. raw:: html

   <html>

$HOME/NorESMValTool/mods/namelists/namelist_MyDiag.xml

.. raw:: html

   </html>

).

It then calls ESMValTool main script

.. raw:: html

   <html>

main.py

.. raw:: html

   </html>

with updated namelist as argument.

NOTE: If called outside of wrapper script,

.. raw:: html

   <html>

main.py

.. raw:: html

   </html>

requires the modules python2/2.7 and ncl on Norstore and must be run
from

.. raw:: html

   <html>

$HOME/NorESMValTool/tools/ESMValTool

.. raw:: html

   </html>

.. _output-location-1:

Output location
^^^^^^^^^^^^^^^

Plots are stored in home directory in

.. raw:: html

   <html>

$HOME/NorESMValTool/plots/

.. raw:: html

   </html>

Regridded input data and derived climatologies are stored in project
area in

.. raw:: html

   <html>

/norstore_osl/projects/NS2345K/NorESMValTool/data

.. raw:: html

   </html>

--------------

Portrait diagrams
'''''''''''''''''

The portrait diagram is one ESMValTool's key features, but unfortunately
also the most complex diagnostic performance-wise. A dedicated wrapper
script has therefore been created on NIRD in order to make the creation
of portrait diagrams as easy as possible. The script performs all the
necessary steps, including CMORization.

For setup and user instructions, see

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/portrait_diagram/README

.. raw:: html

   </html>

PerfmetricsGroundObs
~~~~~~~~~~~~~~~~~~~~

An 'extension' to the portrait diagram diagnostic allowing the use of
ground based (non-gridded) observations has also been created.

For setup and user instructions, see

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/PerfmetricsGroundObs/README

.. raw:: html

   </html>

--------------

Installing additional input data
''''''''''''''''''''''''''''''''

Before starting
^^^^^^^^^^^^^^^

Run

.. raw:: html

   <html>

"umask u=rxw,g=rxw,o=rx"

.. raw:: html

   </html>

. This will ensure that newly created folders and files can be modified
by members of the NorESM project.

If you do not already have a personal ESGF account, then create one at
e.g. https://esgf-data.dkrz.de (Safari does not work properly, while
Firefox just works fine) and sign up for the group CMIP5_Research.

CMIP5 model output
^^^^^^^^^^^^^^^^^^

Where to store
~~~~~~~~~~~~~~

Additional CMIP5 model output should be stored in
$HOME/NorESMValTool/data/model/CMIP5 (which is a symbolic link to the
project folder /projects/NS2345K/NorESMValTool/data/model/CMIP5). Each
model has its own sub-folder that matches the models acronym.

Step 1: generate download script
--------------------------------

Modify the variable entry in this template and then paste everything
into the address field of your browser:
```http://esgf-data.dkrz.de/esg-search/wget`` <http://esgf-data.dkrz.de/esg-search/wget>`__\ ``?``
``download_structure=realm,experiment,variable,time_frequency,model,ensemble``
``&project=CMIP5`` ``&experiment=historical`` ``&time_frequency=mon``
``&variable=ua`` ``&limit=10000`` ``&distrib=true`` ``&replica=true``

The browser will generate a wget-script and try to store it on your
local computer. This particular example will prepare a download script
for monthly ua output of all available models for the CMIP5 historical
experiment.

Alternatively, one can use the ESGF portal functionality to generate the
download script.

Step 2: copy download script to Norstore/Nird and start download
----------------------------------------------------------------

Use the scp command to copy the wget-script into

.. raw:: html

   <html>

login.nird.sigma2.no:/projects/NS2345K/NorESMValTool/data/model/CMIP5/download/

.. raw:: html

   </html>

.

Log on to login.nird.sigma2.no and cd to

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/data/model/CMIP5/download/

.. raw:: html

   </html>

.

Fix execution permission of wget script with "chmod +x wget*". Run
command

.. raw:: html

   <html>

"umask u=rxw,g=rxw,o=rx"

.. raw:: html

   </html>

, which will ensure that the permissions of the downloaded data will be
correct.

Execute wget-script with "-n" (i.e. dummy download option) option to
update certificates to ~/.esg/ directory. The script will then prompt
for your ESGF OpenID and password. Once done, you will be able to run
the download script without prompts for username/password.

Run download script in background with "nohup wget-XXX.sh >&
wget-XXX.log &" (replace XXX to match the name of your download script).

Step 3: move download output files
----------------------------------

Use the mv command to move the output of model YYY to folder

.. raw:: html

   <html>

$HOME/NorESMValTool/data/model/CMIP5/YYY

.. raw:: html

   </html>

(replace YYY with actual model name).

Step 4: document downloaded output on wiki page
-----------------------------------------------

At the bottom of this page are three tables that list the ESMValTool
input data that is available on NorStore. Always update these tables
after installing new model/observation data.

Observation data
^^^^^^^^^^^^^^^^

Detailed instructions for the installation of observational data are
provided in section 6.2.2 of the `ESMValTool user
guide <https://www.esmvaltool.org/download/ESMValTool_Users_Guide.pdf>`__.

Observational products that are served through the `Earth System
Grid <https://esgf-data.dkrz.de>`__ (use Firefox if Safari does not
work) via the projects obs4mips and ana4mips follow the CMIP format
standard and can be readily downloaded to sub-folders in

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/data/obs

.. raw:: html

   </html>

. In principal, the download scripts can be generated in the same manner
as for the model output (see previous section), with the one difference
that the project specifier "CMIP5" has to be changed to "obs4mips" or
"ana4mips". Alternatively, one can use the ESGF portal functionality to
generate the download script.

Observational products that do not follow the CMIP standard should
instead be stored in sub-folders in

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/data/rawobs

.. raw:: html

   </html>

. In the next step, the dataset has to be reformatted using the
corresponding conversion script (one for each dataset) in

.. raw:: html

   <html>

$HOME/NorESMValTool/tools/ESMValTool/reformat_scripts/obs

.. raw:: html

   </html>

.

The reformat scripts provided by ESMValTool are sometimes outdated and
do not always work out of the box. Hence it is likely that minor
modifications are required to make them working.

Next, change directory to

.. raw:: html

   <html>

$HOME/NorESMValTool/tools/ESMValTool/

.. raw:: html

   </html>

and execute

.. raw:: html

   <html>

 "python main.py reformat_scripts/obs/script.ncl"

.. raw:: html

   </html>

, where

.. raw:: html

   <html>

script.ncl

.. raw:: html

   </html>

should be replaced with the name of the reformatting script.

Make sure to run

.. raw:: html

   <html>

"umask u=rxw,g=rxw,o=rx"

.. raw:: html

   </html>

before downloading and reformatting.

Always update the tables at the bottom of the wiki page after installing
new observation data.

NIRD compatible namelists
'''''''''''''''''''''''''

A number of namelists that reproduce a selection of figures from the
`GMD paper <http://www.geosci-model-dev.net/9/1747/2016>`__ (Eyring et
al. 2016) have been ported to NIRD and are 'ready to run'. These
namelists, with corresponding GMD figures, can be found in the table
below. Some of the namelists also produce additional figures related to
the GMD figures - these are listed under "By-products" in the table
below. The NIRD compatible namelists are all labeled \*_nird.xml, and
can be found in

.. raw:: html

   <html>

/projects/NS2345K/NorESMValTool/mods/namelists/

.. raw:: html

   </html>

See above under "Running ESMValTool" for launching instructions.

^ GMD figure ^ Namelist ^ By-products ^ Notes ^ ^ Figure 2 \|
namelist_perfmetrics_CMIP5_nird.xml \| \| \| ^ Figure 3 \|
namelist_perfmetrics_CMIP5_fig3_nird.xml \| tas: annual climatologies,
indiviual models - reference \| \| ^ Figure 4 \|
namelist_flato13ipcc_nird.xml \| \| \| ^ Figure 5 \|
namelist_SAMonsoon_nird.xml \| Mean intensity, global mean \| \| ^
Figure 6 \| namelist_SAMonsoon_nird.xml \| \| \| ^ Figure 7 \|
namelist_WAMonsoon_nird.xml \| \| \| ^ Figure 8 \|
namelist_CVDP_fig8_nird.xml \| PDO timeseries \| \| ^ Figure 9 \|
namelist_CVDP_fig9_nird.xml \| \| \| ^ Figure 11 \|
namelist_DiurnalCycle_box_pr_nird.xml \| \| \| ^ Figure 12 \|
namelist_flato13ipcc_nird.xml \| \| \| ^ Figure 13 \|
namelist_williams09climdyn_CREM_nird.xml \| \| \| ^ Figure 14 \|
namelist_SouthernOcean_nird.xml \| Models and observations individually
\| Figures 14 (d) and (e) need model output (but should work) \| ^
Figure 15 \| namelist_SouthernHemisphere_nird.xml \| Same figure for
rlds, rlut, rsut and surface latent/sensible heat fluxes \| Install
'basemap' and 'pyproj' python modules \| ^ Figure 16 \|
namelist_TropicalVariability_nird.xml \| Same figure for Atlantic and
Indian ocean, scatter plots for individual models \| \| ^ Figure 17 \|
namelist_SeaIce_nird.xml \| Sea ice area \| \| ^ Figure 18 \|
namelist_Evapotranspiration_nird.xml \| Individual model mean (all
months individually) \| \| ^ Figure 19 \| namelist_runoff_et_nird.xml \|
Bias of ET, bias of ET coefficient, bias of precip, bias of runoff \|
Install 'cdo-1.3.0' python module (does not work with latest version!)
\| ^ Figure 22 \| namelist_GlobalOcean_nird.xml \| mean, mean-diff,
stddev-diff \| \| ^ Figure 24 \| namelist_righi15gmd_tropo3_nird.xml \|
Individual models - AURA-MLS-OMI, Trop. Col. Ozone annual cycle
(individual models) \| \| ^ Figure 25 \| namelist_eyring13jgr_nird.xml
\| \| \| ^ Figure 26a \| namelist_wensel14jgr_nird.xml \| Figure 1, 2a,
2b, 3 and 4 from Wenzel et al. 2014 \| \|

^ Other figures ^ Namelist ^ Notes ^ ^ Aerosol optical depth (maps and
scatter plots) \| namelist_aerosol_CMIP5_nird.xml \| \| ^ Near surface
temperature trend \| namelist_CVDP_tas_trend_nird.xml \|

--------------

Resources
'''''''''

| `` * login.nird.sigma2.no:/projects/NS2345K/NorESMValTool/README``
| `` * login.nird.sigma2.no:/projects/NS2345K/noresm2cmor/README``
| `` * ESMValTool home page: ``\ ```www.esmvaltool.org`` <http://www.esmvaltool.org>`__
| `` * ESMValTool user guide: ``\ ```https://github.com/ESMValGroup/ESMValTool/raw/master/doc/ESMValTool_Users_Guide.pdf`` <https://github.com/ESMValGroup/ESMValTool/raw/master/doc/ESMValTool_Users_Guide.pdf>`__
| `` * GMD paper (Eyring et al. 2016): ``\ ```www.geosci-model-dev.net/9/1747/2016`` <http://www.geosci-model-dev.net/9/1747/2016>`__
| `` * ``\ 
| `` * {{ :noresm:ESMValTool_EVA.pdf | ESMValTool: Implementation and use (08 Sep 2017 - Kristian Ingvaldsen}}``

--------------

Available data on NorStore
''''''''''''''''''''''''''

A detailed description of all supported datasets is presented in table
S9 in section 6.6.2 (page 28) of the `ESMValTool user
guide <https://github.com/ESMValGroup/ESMValTool/raw/master/doc/ESMValTool_Users_Guide.pdf>`__.

^ Observation product ^ Variables (on Norstore) ^ ^ ACCESS \| \| ^
ACCESS-2 \| \| ^ AERONET \| od550aer \| ^ AIRS \| hus, ta \| ^ Asmi11 \|
\| ^ AURA-MLS-OMI \| tropoz \| ^ AURA-TES \| tro3 \| ^ BDBP \| \| ^
CARSNET \| \| ^ CASTNET \| sconcso4, sconcno3, sconcnh4, sconcna,
sconccl\| ^ CERES \| rlds, rlut, rlutcs, rsds, rsus, rsuscs, rsut,
rsutcs \| ^ CFSR \| \| ^ CIRRUS \| \| ^ CLARA-A2 \| \| ^ CloudSat \| \|
^ CMAP \| pr \| ^ CONCERT \| \| ^ CR_AVE \| \| ^ CRU \| pr, tas \| ^ DC3
\| \| ^ Dong08-ARGO \| mlotst \| ^ EANET \| \| ^ EMEP \| sconcnh4,
sconccl, sconcno3, sconcpm10, sconcpm2p5, sconcna, sconcso4 \| ^ Emmons
\| \| ^ ERA-40 \| \| ^ ERA-Interim \| psl, clivi, clwvi, evspsbl, hfds,
hfls, hfss, pr, ps, rlns, rsns, sftlf, tas, wfpe, hus, ta, ua, va, zg,
tauu, tauv, tos \| ^ ERA-Interim-fluxes \| \| ^ ESACCI-AEROSOL \|
abs550aer, od550aer, od550lt1aer, od870aer \| ^ ESACCI-CLOUD \| clt,
cltStderr\| ^ ESACCI-GHG \| xco2 \| ^ ESACCI-LANDCOVER \| \| ^
ESACCI-OZONE \| toz, tozStderr \| ^ ESACCI-SIC \| sic, sicStderr \| ^
ESACCI-SOILMOISTURE \| \| ^ ESACCI-SST \| ts, tsStderr\| ^ ESRL \| co2
\| ^ ETH-SOM-FFN \| spco2\| ^ GCP \| co2flux \| ^ GLOBALVIEW \|
vmrco_alt, vmrco_asc, vmrco_ask, vmrco_azr, vmrco_bkt, vmrco_bme,
vmrco_bmw, vmrco_brw, vmrco_bsc, vmrco_cba, vmrco_cgo, vmrco_chr,
vmrco_cmo, vmrco_eic, vmrco_gmi, vmrco_goz, vmrco_hba, vmrco_hpb,
vmrco_hun, vmrco_ice, vmrco_itn, vmrco_izo, vmrco_key, vmrco_kum,
vmrco_kzd, vmrco_kzm, vmrco_lef, vmrco_mbc, vmrco_mhd, vmrco_mid,
vmrco_mkn, vmrco_mlo, vmrco_nwr, vmrco_pal, vmrco_psa, vmrco_pta,
vmrco_rpb, vmrco_sey, vmrco_shm, vmrco_smo, vmrco_spo, vmrco_stm,
vmrco_sum, vmrco_syo, vmrco_tap, vmrco_tdf, vmrco_thd, vmrco_uta,
vmrco_uum, vmrco_wis, vmrco_wlg, vmrco_zep \| ^ GPCC \| pr \| ^ GPCP-1DD
\| pr \| ^ GPCP-SG \| pr \| ^ GTO-ECV \| \| ^ HadCRUT \| tas \| ^
HadISST \| ts, sic\| ^ HALOE \| vmrh2o\| ^ HIPPO \| \| ^ HWSD \| \| ^
IFS-Cy31r2 \| \| ^ IMPROVE \| \| ^ INCA \| \| ^ ISCCP \| \| ^
ISCPP-FD-SRF \| \| ^ JMA-TRANSCOM \| \| ^ LACE \| \| ^ LAI3g \| \| ^
LandFlux-EVAL \| et, et-sd \| ^ MERRA \| pr \| ^ MISR \| od550aer,
od550aerNobs, od550aerStdv \| ^ MSL \| \| ^ MODIS-CFMIP \| \| ^
MODIS_L3_C6 \| clivi, clt, clwvi, od550aer \| ^ MTE \| \| ^ NCEP \| clt,
hus, pr, rlut, ta, tas, ua, va, zg \| ^ NDP \| \| ^ NIWA \| toz\| ^ NOA
interpolated OLD \| \| ^ NSDIC \| sic \| ^ PATMOS \| \| ^ Putaud \| \| ^
SALTRACE \| \| ^ SeaWIFS \| chl \| ^ SOCAT \| spco2 \| ^ SRB \| \| ^
SSMI-MERIS \| \| ^ takahashi14 \| talk \| ^ TC4 \| \| ^ TES \| \| ^
Texas \| \| ^ Tilmes \| \| ^ TOMS \| \| ^ TRMM-3B42 \| pr \| ^ TRMM-L3
\| pr \| ^ UCN-Pacific \| \| ^ UWisc \| \| ^ WHOI-OAFlux \| hfls, hfss,
huss, sfcWind, ts \| ^ WOA09 \| so, to, sos, tos \| ^ woa2005 \| o2\|

^ CMIP5 models ^ Variables (on Norstore) ^ ^ ACCESS1-0 \| clt, hus,
od550aer, od870aer, pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic,
ta, tas, tos, ts, ua, va, zg \| ^ ACCESS1-3 \| clt, hus, od550aer,
od970aer, pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas,
tos, ts, ua, va, zg \| ^ bcc-csm1-1 \| clt, hus, pr, ps, rlut, rlutcs,
rsut, rsutcs, sic, ta, tas, tos, tro3, ts, ua, va, zg \| ^ bcc-csm1-1-m
\| clt, hus, pr, ps, rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos,
tro3, ts, ua, va, zg \| ^ BNU-ESM \| hus, od550aer, pr, ps, rlut,
rlutcs, rsut, rsutcs, sic, spco2, ta, tas, tro3, ts, ua, va, zg \| ^
CanAM4 \| albisccp, cltisccp, pctisccp, pr, rlut, rlutcs, rsut, rsutcs,
snc, sic \| ^ CanCM4 \| pr, rlut, ta, tas, ua, va, zg \| ^ CanESM2 \|
clt, fgco2, hfls, hus, mstfmyz, nbp, pr, ps, rlds, rlut, rlutcs, rsds,
rsut, rsutcs, sftlf, sic, ta, tas, tos, tro3, ts ua, va, zg \| ^ CCSM4
\| clt, hus, mstfmyz, pr, ps, rlut, rlutcs, rsut, rsutcs, sic, ta, tas,
tos, tro3, ts, ua, va, zg \| ^ CESM1-BGC \| clt, fgco2, hus, nbp, pr,
ps, rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos, ts, va, ua, zg \| ^
CESM1-CAM5 \| clt, hus, mstfmyz, od550aer, pr, ps, rlut, rlutcs, rsut,
rsutcs, sic, ta, tas, tos, ts, ua, va, zg \| ^ CESM1-FASTCHEM \| clt,
hus, mstfmyz, pr, ps, rlut, rlutcs, rsut, rsutcs, ta, tas, tro3, ts, ua,
va, zg\| ^ CESM1-WACCM \| clt, hus, msftmyz, pr, ps, rlut, rlutcs, rsut,
rsutcs, ta, tas, tro3, ts, ua, va, zg \| ^ CMCC-CM \| clt, hus, pr, ps,
rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos, ts, ua, va, zg \| ^
CMCC-CMS \| clt, hus, pr, ps, rlut, rlutcs, rsut, sic, ta, tas, tos, ts,
ua, va, zg \| ^ CMCC-CESM \| hus, pr, rlut, rlutcs, rsut, rsutcs, ta,
tas, ua, va, zg \| ^ CNRM-CM5 \| albisccp, clt, cltisccp, hfls, hus,
mstfmyz, pctisccp, pr, ps, rlut, rlutcs, rsut, rsutcs, sftlf, sic, snc,
ta, tas, tro3, ts, ua, va, zg \| ^ CSIRO-Mk3-6-0 \| abs550aer, clt,
hfls, hus, od550aer, od550lt1aer, od870aer, pr, ps, rlut, rlutcs, rsut,
rsutcs, sftlf, sconcso4, sic, ta, tas, tos, tro3, ts, ua, va, zg \| ^
EC-EARTH \| hfls, hus, pr, rlut, sftlf, sic, ta, tas, ts, ua, va, zg \|
^ FGOALS-g2 \| clt, hus, msftmyz, pr, ps, rlut, rlutcs, rsut, rsutcs,
sic, ta, tas, tos, tro3, ts, ua, va, zg \| ^ FIO-ESM \| clt, hus, pr,
ps, rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos, ts, ua, va, zg\| ^
GFDL-CM3 \| abs550aer, hus, od550aer, od550lt1aer, od870aer, pr, ps,
rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas, tro3, ua, va, zg \|
^ GFDL-ESM2G \| abs550aer, clt, hus, od550aer, od550lt1aer, od870aer,
pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas, tos, tro3,
ts, ua, va, zg \| ^ GFDL-ESM2M \| abs550aer, clt, fgco2, hfls, hus, nbp,
od550aer, od550lt1aer, od870aer, pr, ps, rlut, rlutcs, rsut, rsutcs,
sconcso4, sftlf, sic, spco2, ta, tas, tos, tro3, ts, ua, va, zg \| ^
GFDL-HIRAM-C180 \| pr \| ^ GISS-E2-H \| abs550aer, clt, hus, od550aer,
od550lt1aer, pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas,
tos, tro3, ts, ua, va, zg \| ^ GISS-E2-H-CC \| clt, pr, ps, rlut,
rlutcs, rsut, rsutcs, sic, tas, tos, ts \| ^ GISS-E2-R \| abs550aer,
clt, hus, od550aer, od550lt1aer, pr, ps, rlut, rlutcs, rsut, rsutcs,
sconcso4, sic, ta, tas, tos, tro3, ts, ua, va, zg \| ^ GISS-E2-R-CC \|
clt, pr, ps, rlut, rlutcs, rsut, rsutcs, sic, tos, tas, ts \| ^ HadCM3
\| abs550aer, clt, pr, rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos,
ts, ua, va, zg \| ^ HadGEM2-A \| pr \| ^ HadGEM2-AO \| clt, hus, pr, ps,
rlut, rlutcs, rsut, rsutcs, sic, ta, tas, tos, ts, ua, va, zg \| ^
HadGEM2-CC \| clt, hus, od550aer, od870aer, pr, ps, rlut, rlutcs, rsut,
rsutcs, sconcso4, sic, ta, tas, tos, ts, ua, va, zg \| ^ HadGEM2-ES \|
clt, fgco2, hfls, hus, nbp, od550aer, od870aer, pr, ps, rlut, rlutcs,
rsut, rsutcs, sftlf, sic, spco2, ta, tas, tos, ts, ua, va, zg \| ^
inmcm4 \| clt, hus, mstfmyz, pr, ps, rlut, rlutcs, rsut, rsutcs, sic,
spco2, ta, tas, tos, ts, ua, va, zg \| ^ IPSL-CM5A-LR \| abs550aer, clt,
fgco2, hfls, hus, nbp, od550aer, od550lt1aer, pr, ps, rlut, rlutcs,
rsut, rsutcs, sconcso4, sftlf, sic, ta, tas, tos, tro3, ts, ua, va, zg
\| ^ IPSL-CM5A-MR \| abs550aer, clt, hus, od550aer, od550lt1aer, pr, ps,
rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas, tos, tro3, ts, ua,
va, zg \| ^ IPSL-CM5B-LR \| abs550aer, clt, hus, od550aer, od550lt1aer,
pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas, tos, tro3,
ts, ua, va, zg \| ^ MIROC4h \| clt, hus, od550aer, pr, ps, rlut, rlutcs,
rsut, rsutcs, sconcso4, ta, tas, tro3, ua, va, zg \| ^ MIROC5 \|
abs550aer, albisccp, clt, cltisccp, hfls, hus, od550aer, od550lt1aer,
od870aer, pctisccp, pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sftlf,
sic, snc, ta, tas, tos, tro3, ts, ua, va, zg \| ^ MIROC-ESM \|
abs550aer, clt, fgco2, hus, nbp, od550aer, od550lt1aer, od870aer, pr,
ps, rlut, rlutcs, rsut, rsutcs, sconcso4, sic, ta, tas, tos, tro3, ts,
ua, va, zg \| ^ MIROC-ESM-CHEM \| abs550aer, clt, hus, od550aer,
od550lt1aer, od870aer, pr, ps, rlut, rlutcs, rsut, rsutcs, sconcso4,
sic, ta, tas, tro3, tos, ts, ua, va, zg \| ^ MPI-ESM-LR \| albisccp,
clt, cltisccp, fgco2, hfls, hus, mstfmyz, nbp, pctisccp, pr, ps, rlut,
rlutcs, rsut, rsutcs, sftlf, sic, snc, ta, tas, tos, tro3, ts, ua, va,
zg\| ^ MPI-ESM-MR \| clt, hus, msftmyz, pr, ps, rlut, rlutcs, rsut,
rsutcs, sic, ta, tas, tos, tro3, ts, ua, va, zg \| ^ MPI-ESM-P \| clt,
hus, msftmyz, pr, ps, rlut, rlutcs, rsut, rsutcs, ta, tas, tro3, ts, ua,
va, zg\| ^ MRI-CGCM3 \| abs550aer, albisccp, clt, cltisccp, hus,
od550aer, od550lt1aer, od870aer, pctisccp, pr, ps, rlut, rlutcs, rsut,
rsutcs, sconcso4, sic, snc, ta, tas, tos, ts, ua, va, zg \| ^ MRI-ESM1
\| abs550aer, clt, hus, od550lt1aer, od870aer, pr, ps, rlut, rlutcs,
rsut, rsutcs, sconcso4, sic, ta, tas, tro3, ts, ua, va, zg \| ^
NorESM1-M \| abs550aer, clt, evspsbl, hfls, hus, mlotst, mrro, msftmyz,
nbp, od550aer, pr, ps, rlds, rlut, rlutcs, rsds, rsut, rsutcs, sconcso4,
sftlf, sic, sos, ta, tas, tos, ts, ua, va, zg \| ^ NorESM1-ME \|
abs550aer, clt, fgco2, hfls, hus, mstfmyz, nbp, od550aer, pr, ps, rlut,
rlutcs, rsut, rsutcs, sconcso4, sftlf, sic, spco2, ta, tas, tos, ts, ua,
va, zg \|

A list of supported variables with explanation is presented in table S8
in section 3.3 (page 17) of the `ESMValTool user
guide <https://github.com/ESMValGroup/ESMValTool/raw/master/doc/ESMValTool_Users_Guide.pdf>`__.

^ Variables ^ Observation products (on Norstore) ^ CMIP5 models (on
Norstore) ^ ^ abs550aer \| ESACCI-AEROSOL \| CSIRO-Mk3-6-0, GFDL-CM3,
GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-R, IPSL-CM5A-LR,
IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC5, MIROC-ESM, MIROC-ESM-CHEM,
MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ albisccp \| \| CanAM4 \|
^ baresoilFrac \| \| \| ^ chl \| SeaWIFS \| \| ^ clivi \| ERA-Interim,
MODIS_L3_C6 \| \| ^ cl \| \| \| ^ clt \| ESACCI-CLOUD, MODIS_L3_C6, NCEP
\| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, CanESM2, CCSM4,
CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM, CMCC-CM, CMCC-CMS,
CNRM-CM5, CSIRO-Mk3-6-0, FGOALS-g2, FIO-ESM, GFDL-ESM2G, GFDL-ESM2M,
GISS-E2-H, GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO,
HadGEM2-CC, HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR,
IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR,
MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1, NorESM1-M NorESM1-ME \| ^
cltisccp \| \| CanAM4 \| ^ cltStderr \| ESACCI-CLOUD \| \| ^ clwvi \|
ERA-Interim \| \| ^ co2 \| ESRL \| \| ^ co2flux \| GCP \| \| ^ conccnd10
\| \| \| ^ conccnd5 \| \| \| ^ conccnmode \| \| \| ^ conccnSTPd120 \| \|
\| ^ conccnSTPd14 \| \| \| ^ conccnSTPd3 \| \| \| ^ conccnSTPd5 \| \| \|
^ conccnSTPmode \| \| \| ^ cropFrac \| \| \| ^ cSoil \| \| \| ^ cumnbp
\| \| \| ^ cVeg \| \| \| ^ diamcnmode \| \| \| ^ dos \| \| \| ^
dosStderr \| \| \| ^ et \| LandFlux-EVAL \| \| ^ et-sd \| LandFlux-EVAL
\| \| ^ evspsbl \| ERA-Interim \| NorESM1-M \| ^ fgco2 \| \| CanESM2,
CESM1-BGC, GFDL-ESM2M, HadGEM2-ES, IPSL-CM5A-LR, MIROC-ESM, MPI-ESM-LR,
NorESM1-ME \| ^ grassFrac \| \| \| ^ grassNcropFrac \| \| \| ^ gpp \| \|
\| ^ hfds \| ERA-Interim \| \| ^ hfls \| ERA-Interim, WHOI-OAFlux \|
CanESM2, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH, GFDL-ESM2M, HadGEM2-ES,
IPSL-CM5A-LR, MIROC5, MPI-ESM-LR, Nor-ESM1-M, NorESM1-ME \| ^ hfss \|
ERA-Interim, WHOI-OAFlux \| \| ^ hus \| AIRS, ERA-Interim, NCEP \|
ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanESM2, CCSM4,
CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM, CMCC-CESM, CMCC-CM,
CMCC-CMS, CSIRO-Mk3-6-0, EC-EARTH, FGOALS-g2, FIO-ESM, GFDL-CM3,
GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-R, HadGEM2-AO, HadGEM2-CC,
HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h,
MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P,
MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ huss \| WHOI-OAFlux\| \|
^ intpp \| \| \| ^ ita \| \| \| ^ iwpStderr \| \| \| ^ lai \| \| \| ^
LW_CRE \| \| \| ^ lwp \| \| \| ^ lwpStderr \| \| \| ^ mlotst \|
Dong08-ARGO \| NorESM1-M\| ^ mmraer \| \| \| ^ mmrbcfree \| \| \| ^
mmrbc \| \| \| ^ mrro \| \| NorESM1-M\| ^ mrso \| \| \| ^ msftmyz \| \|
CanESM2, CCSM4, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM, CNRM-CM5,
FGOALS-g2, inmcm4, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, NorESM1-M,
NorESM1-ME \| ^ MyVar \| \| \| ^ nbp \| \| CanESM2, CESM1-BGC,
GFDL-ESM2M, HadGEM2-ES, IPSL-CM5A-LR, MIROC-ESM, MPI-ESM-LR, NorESM1-M,
NorESM1-ME \| ^ NET_CRE \| \| \| ^ o2 \| woa2005 \| \| ^ o2_onelev \| \|
\| ^ od550aer \| AERONET, ESACCI-AEROSOL, MISR, MODIS_L3_C6 \|
ACCESS1-0, ACCESS1-3, BNU-ESM, CESM1-CAM5, CSIRO-Mk3-5-0, GFDL-CM3,
GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-R, HadGEM2-CC, HadGEM2-ES,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME \| ^
od550aerNobs \| MISR \| \| ^ od550aerStderr \| \| \| ^ od550aerStdv \|
MISR \| \| ^ od550lt1aer \| ESACCI-AEROSOL \| CSIRO-Mk3-6-0, GFDL-CM3,
GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-R, IPSL-CM5A-LR,
IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC5, MIROC-ESM, MIROC-ESM-CHEM,
MRI-CGCM3, MRI-ESM1 \| ^ od870aer \| ESACCI-AEROSOL \| ACCESS1-0,
ACCESS1-3, CSIRO-Mk3-6-0, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, HadGEM2-CC,
HadGEM2-ES, MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MRI-CGCM3, MRI-ESM1 \| ^
pastureFrac \| \| \| ^ pctisccp \| \| CanAM4 \| ^ pr-mmday \| \| \| ^
pr-mmh \| \| \| ^ pr \| CMAP, CRU, ERA-Interim, GPCC, GPCP-1DD, GPCP-SG,
MERRA, NCEP, TRMM-3B42 \| ACCESS1-0, ACCESS1-3, bcc-csm1-1,
bcc-csm1-1-m, BNU-ESM, CanCM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5,
CESM1-FASTCHEM, CESM1-WACCM, CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5,
CSIRO-Mk3-6-0, EC-EARTH, FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G,
GFDL-ESM2M, GFDL-HIRAM-C180, GISS-E2-H, GISS-E2-H-CC, GISS-E2-R,
GISS-E2-R-CC, HadCM3, HadGEM-AO, HadGEM2-CC, HadGEM2-ES, inmcm4,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1,
NorESM1-M, NorESM1-ME \| ^ prStderr \| \| \| ^ prw \| \| \| ^ prwStderr
\| \| \| ^ ps \| ERA-Interim \| ACCESS1-0, ACCESS1-3, bcc-csm1-1,
bcc-csm1-1-m, BNU-ESM, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5,
CESM1-FASTCHEM, CESM1-WACCM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0,
FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H,
GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO, HadGEM2-CC,
HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h,
MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P,
MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME\| ^ psl \| ERA-Interim \| \|
^ rldscs \| \| \| ^ rlds \| CERES \| CanESM2, NorESM1-M \| ^ rlns \|
ERA-Interim \| \| ^ rlus \| \| \| ^ rlutcs \| CERES \| ACCESS1-0,
ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanAM4, CanESM2, CCSM4,
CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM, CMCC-CESM, CMCC-CM,
CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, FGOALS-g2, FIO-ESM, GFDL-CM3,
GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-H-CC, GISS-E2-R,
GISS-E2-R-CC, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES, inmcm4,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1,
NorESM1-M, NorESM1-ME \| ^ rlut \| CERES, NCEP \| ACCESS1-0, ACCESS1-3,
bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanAM4, CanCM4, CanESM2, CCSM4,
CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM, CMCC-CESM, CMCC-CM,
CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH, FGOALS-g2, FIO-ESM,
GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-H-CC, GISS-E2-R,
GISS-E2-R-CC, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES, inmcm4,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1,
NorESM1-M, NorESM1-ME \| ^ rsdscs \| \| \| ^ rsds \| CERES \| CanESM2,
NorESM1-M \| ^ rsns \| ERA-Interim \| \| ^ rsuscs \| CERES \| \| ^ rsus
\| CERES \| \| ^ rsutcs \| CERES \| ACCESS1-0, ACCESS1-3, bcc-csm1-1,
bcc-csm1-1-m, BNU-ESM, CanAM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5,
CESM1-FASTCHEM, CESM1-WACCM, CMCC-CESM, CMCC-CM, CNRM-CM5,
CSIRO-Mk3-6-0, FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M,
GISS-E2-H, GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO,
HadGEM2-CC, HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR,
IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR,
MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME\| ^
rsut \| CERES \| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m,
BNU-ESM, CanAM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM,
CESM1-WACCM, CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0,
FGOALS-g2, FIO-ESM, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-H-CC,
GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO HadGEM2-CC, HadGEM2-ES,
inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5,
MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3,
MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ sconcbc \| \| \| ^ sconccl \|
CASTNET, EMEP \| \| ^ sconcna \| CASTNET, EMEP \| \| ^ sconcnh4 \|
CASTNET, EMEP\| \| ^ sconcno3 \|CASTNET, EMEP \| \| ^ sconcoa \| \| \| ^
sconcpm10 \| EMEP\| \| ^ sconcpm2p5 \|EMEP \| \| ^ sconcso4 \|CASTNET,
EMEP \| ACCESS1-0, ACCESS1-3, CSIRO-Mk3-6-0, GFDL-CM3, GFDL-ESM2G,
GFDL-ESM2M, GISS-E2-H, GISS-E2-R, HadGEM2-CC, IPSL-CM5A-LR,
IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM, MIROC-ESM-CHEM,
MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ sfcWind \| WHOI-OAFlux
\| \| ^ sftlf \| ERA-Interim \| CanESM2, CNRM-CM5, CSIRO-Mk3-6-0,
EC-EARTH, GFDL-ESM2M, HadGEM2-ES, IPSL-CM5A-LR, MIROC5, MPI-ESM-LR,
NorESM1-M, NorESM1-ME \| ^ shrubFrac \| \| \| ^ shrubNtreeFrac \| \| \|
^ sic \| ESACCI-SIC, HadISST, NSIDC \| ACCESS1-0, ACCESS1-3, bcc-csm1-1,
bcc-csm1-1-m, BNU-ESM, CanAM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5,
CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH, FGOALS-g2,
FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-H-CC,
GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM-AO, HadGEM2-CC, HadGEM2-ES,
inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MRI-CGCM3, MRI-ESM1, NorESM1-M,
NorESM1-ME \| ^ sicStderr \| ESACCI-SIC \| \| ^ sit \| \| \| ^ sm \| \|
\| ^ smStderr \| \| \| ^ snc \| \| CanAM4 \| ^ snd \| \| \| ^ snw \| \|
\| ^ so \| WOA09 \| \| ^ sos \| WOA09 \| NorESM1-M \| ^ spco2 \|
ETH-SOM-FFN, SOCAT\| BNU-ESM, GFDL-ESM2M, HadGEM2-ES, inmcm4, NorESM1-ME
\| ^ SW_CRE \| \| \| ^ talk \| takahashi14\| \| ^ ta \| AIRS,
ERA-Interim, NCEP \| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m,
BNU-ESM, CanCM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM,
CESM1-WACCM, CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0,
EC-EARTH, FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M,
GISS-E2-H, GISS-E2-R, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES,
inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5,
MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3,
MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ tas \| CRU, ERA-Interim, HadCRUT,
NCEP \| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanCM4,
CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM,
CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH,
FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H,
GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO, HadGEM2-CC,
HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h,
MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P,
MRI-CGCM3, MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ tauu \| ERA-Interim \|
\| ^ tauv \| ERA-Interim \| \| ^ tauw \| \| \| ^ theta-850 \| \| \| ^
theta \| \| \| ^ to \| WOA09 \| \| ^ tos \| ERA-Interim, WOA09 \|
ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, CanESM2, CCSM4,
CESM1-BGC, CESM1-CAM5, CMCC-CM, CMCC-CMS, CSIRO-Mk3-6-0, GFOALS-g2,
GFDL-ESM2G, GISS-E2H, GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3,
HadGEM2-CC, HadGEM2-ES, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR,
MIROC5, MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MRI-CGCM3,
NorESM1-M\| ^ total_column \| \| \| ^ toz \| ESACCI-AEROSOL, NIWA \| \|
^ tozStderr \| ESACCI-AEROSOL\| \| ^ treeFrac \| \| \| ^ tro3 \|
AURA-TES \|bcc-csm1-1, bcc-csm1-1-m, BNU_ESM, CanESM2, CCSM4,
CESM1-FASTCHEM, CESM1-WACCM, CNRM-CM5, CSIRO-Mk3-6-0, FGAOLS-g2,
GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H, GISS-E2-R, IPSL-CM5A-LR,
IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM, MIROC-ESM-CHEM,
MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-ESM1 \| ^ tro3_NHext \| \| \| ^
tro3prof \| \| \| ^ tro3_SHext \| \| \| ^ tro3_Trop \| \| \| ^
tropospheric_column \| \| \| ^ tropoz \| AURA-MLS-OMI \| \| ^ ts
\|ESACCI-SST, HadISST, WHOI-OAFlux \|ACCESS1-0, ACCESS1-3, bcc-csm1-1,
bcc-csm1-1-m, BNU-ESM, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5,
CESM1-FASTCHEM, CESM1-WACCM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0,
EC-EARTH, FGOALS-g2, FIO-ESM, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H,
GISS-E2-H-CC, GISS-E2-R, GISS-E2-R-CC, HadCM3, HadGEM2-AO, HadGEM2-CC,
HadGEM2-ES, inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC5,
MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3,
MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ tsStderr \| ESACCI-SST \| \| ^
ua-1000 \| \| \| ^ ua-200-850 \| \| \| ^ ua-200 \| \| \| ^ ua-700 \| \|
\| ^ ua-850 \| \| \| ^ ua-925 \| \| \| ^ ua \| ERA-Interim, NCEP \|
ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanCM4,
CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM,
CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH,
FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H,
GISS-E2-R, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES, inmcm4,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1
NorESM1-M, NorESM1-ME \| ^ uo \| \| \| ^ va-200-850 \| \| \| ^ va-200 \|
\| \| ^ va-700 \| \| \| ^ va-850 \| \| \| ^ va-925 \| \| \| ^ va \|
ERA-Interim, NCEP \| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m,
BNU-ESM, CanCM4, CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM,
CESM1-WACCM, CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0,
EC-EARTH, FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M,
GISS-E2-H, GISS-E2-R, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES,
inmcm4, IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5,
MIROC-ESM, MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3,
MRI-ESM1, NorESM1-M, NorESM1-ME \| ^ vmrc2h4 \| \| \| ^ vmrc2h6 \| \| \|
^ vmrc3h6 \| \| \| ^ vmrc3h8 \| \| \| ^ vmrch3coch3 \| \| \| ^ vmrco_alt
\| \| \| ^ vmrco_azr \| \| \| ^ vmrco_chr \| \| \| ^ vmrco_eic \| \| \|
^ vmrco_gmi \| \| \| ^ vmrco_hpb \| \| \| ^ vmrco_lef \| \| \| ^
vmrco_mlo \| \| \| ^ vmrco \| \| \| ^ vmrco_nwr \| \| \| ^ vmrh2o \|
HALOE \| \| ^ vmrnox \| \| \| ^ vo \| \| \| ^ wfpe \| ERA-Interim \| \|
^ xco2 \| ESACCI-GHG \| \| ^ xco2Stderr \| \| \| ^ zg \| ERA-Interim,
NCEP \| ACCESS1-0, ACCESS1-3, bcc-csm1-1, bcc-csm1-1-m, BNU-ESM, CanCM4,
CanESM2, CCSM4, CESM1-BGC, CESM1-CAM5, CESM1-FASTCHEM, CESM1-WACCM,
CMCC-CESM, CMCC-CM, CMCC-CMS, CNRM-CM5, CSIRO-Mk3-6-0, EC-EARTH,
FGOALS-g2, FIO-ESM, GFDL-CM3, GFDL-ESM2G, GFDL-ESM2M, GISS-E2-H,
GISS-E2-R, HadCM3, HadGEM2-AO, HadGEM2-CC, HadGEM2-ES, inmcm4,
IPSL-CM5A-LR, IPSL-CM5A-MR, IPSL-CM5B-LR, MIROC4h, MIROC5, MIROC-ESM,
MIROC-ESM-CHEM, MPI-ESM-LR, MPI-ESM-MR, MPI-ESM-P, MRI-CGCM3, MRI-ESM1
NorESM1-M, NorESM1-ME \|
