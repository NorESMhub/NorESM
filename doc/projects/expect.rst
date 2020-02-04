.. _expect:

Expect project
''''''''''''''

Project definitions
~~~~~~~~~~~~~~~~~~~

| `` - What model resolution will be used?``
| ``   * 2 degree (is already validated and has control simulation done)``
| `` - A common model branch is created based on the CMIP5-version of the carbon cycle model but there are some differences``
| ``   * Please use the branch ``\ ```https://svn.met.no/NorESM/noresm/branches/projectEXPECT_cmip5-r143-1`` <https://svn.met.no/NorESM/noresm/branches/projectEXPECT_cmip5-r143-1>`__\ `` (https://wiki.met.no/noresm/svnbestpractice#how_should_i_name_the_branch).``
| ``   * > git:``
| `` *  Hexagon account: **nn9182k**. New account for the period 2016.2, 2017.1: ``

.. raw:: html

   <html>

nn9448k

.. raw:: html

   </html>

.

| `` *  NIRD (previously Norstore) account: **NS9033K**. I.e. data located at login.nird.sigma2.no:/projects/NS9033K/``
| `` *  Acknowledge RCN Grant Number: **229760/E10**.``
| `` * Public website: ``\ ```http://expected.bitbucket.io/`` <http://expected.bitbucket.io/>`__

Open questions in the project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| `` - How do we want to branch off the realisations? ``
| `` - Do we want / can we computationally (CPU-hours and storage space) afford 3 realisations for each of the key experiments? >> 3 realisations will be done for Tier 1 / core experiments.``
| `` - What years do we want to do Climate Engineering? >> 2020 to 2100.``
| `` - How many years do we want to run after Climate Engineering is switched off ('termination effect')? >> 50 years for now.``

Description of model reference version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The model reference is based on the NorESM1-ME version, which is the
same version used in CMIP5, with minor adjustments. The set up adopted
in the EXPECT project is based on a fully-interactive climate carbon
cycle coupling. The atmospheric CO2 concentration is spatially and
temporally varying and is prognostically simulated according to the
sources and sinks from land and ocean CO2 fluxes.

`` * Tjiputra, J. F., Roelandt, C., Bentsen, M., Lawrence, D. M., Lorentzen, T., Schwinger, J., Seland, Ø., and Heinze, C.: Evaluation of the carbon cycle components in the Norwegian Earth System Model (NorESM), Geosci. Model Dev., 6, 301-325, ``\ ```doi:10.5194/gmd-6-301-2013`` <doi:10.5194/gmd-6-301-2013>`__\ ``, 2013.``

Presentations from EXPECT at AGU Dec. 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`` * Muri et al. AGU climate engineering session - {{ :noresm:projects:Muri_AGU16_EXPECT_141216.pptx |Simulated transition from RCP8.5 to RCP4.5 through three different Radiation Management techniques}}``

Presentations from EXPECT / GeoMIP meeting June 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| `` * Jon Egill Kristjansson GeoMIP presentation - ``\ 
| `` * Helene Muri Open Session presentation - {{ :noresm:projects:Muri_EXPECT_OpenSession_22062016_pdf.pdf |Solar Geoengineering}}``
| `` * Helene Muri EXPECT meeting Cirrus cloud thinning - {{ :noresm:projects:Muri_EXPECT_CCT_20June2016.pdf | CCT preliminary results}}``
| `` * Helene Muri EXPECT meeting Marine sky brightening - {{ :noresm:projects:Muri_EXPECT_MSB_20June2016.pdf |MSB preliminary results}}``

Presentations from project meeting January 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| `` * Jon Egill Kristjansson -  ``\ \ ``.``
| `` * Jon Egill Kristjansson -  ``\ \ ``.``
| `` * Alf Grini - ``\ ```Stratospheric``\ ````\ ``sulfate``\ ````\ ``simulations``\ ````\ ``RCP8.5``\ ````\ ``->``\ ````\ ``RCP4.5`` <ftp://ftp.met.no/projects/noresmatm/upload/EXPECT/Meeting160105/expectpres_1601005_AG.pdf>`__\ ``.``
| `` * Helene Muri - ``\ \ ``.``
| `` * Helene Muri - ``\ \ ``.``
| `` * Alan Robock - ``\ ```The``\ ````\ ``G4-Specified``\ ````\ ``Stratospheric``\ ````\ ``Aerosol``\ ````\ ``Experiment`` <http://climate.envsci.rutgers.edu/robock/talks/G4SSA2.pptx>`__\ ``.``

List of "official" model runs:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To purpose of this table is as follows:

| `` * Reproduce bit-identical results from any project run based solely on the information in this table!``
| `` * It should be possible to understand how much storage space is needed in total for the project``
| `` * It should be possible to understand the purpose of all the runs by reading the table``
| `` * Color coding (see runs performed): ``

.. raw:: html

   <html>

<font="green">Green

.. raw:: html

   </html>

runs are done,

.. raw:: html

   <html>

<font="red">red

.. raw:: html

   </html>

runs are not done.

| `` * CPU time and storage is given PER realization. ``
| `` * Note: *NRCP85BPRPEXMSB_01_2069 -re-run of year 2069, as 1 file was lost whilst transferring from norstore account NS2345K.``
| `` * Note: ``\ :sup:```§```\ ``NRCP85XTBPRPEX_CCT_02ext_2150 - re-run of year 2150 as oceanic productivity looked "funny" in original case from stopping and restarting, not running a full year at a time.``

^ Simulation name ^ Type of CE / Target area ^ Compset / Model version ^
# of runs \\\\ (done \\\\ /needed) ^ Reference run (run providing
restart files) ^ Storage (per realization) ^ CPU time [CPU hours] (per
realization) ^ RESPONSIBLE^ \|**//Initialisation runs//**|||||\| \|
`NORESM:ModelDefFiles:N1850BPRPCNOC_f19_g16_spin_02 <NORESM:ModelDefFiles:N1850BPRPCNOC_f19_g16_spin_02>`__
\| Spinup \| N1850AERBPRP, r242 \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| N1850BPRPCNOC_f19_g16_spin_01 \| 1 Tb \| 385K \| Jerry \| \|
`N20TRAERCNOCBPRP_EXPECT01 <NORESM:ModelDefFiles:N20TRAERCNOCBPRP_EXPECT01>`__
\| Historical (1850-2005) \| N20TRAERCNOCBPRP, r249 \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| N1850BPRPCNOC_f19_g16_spin_02 \| 1TB (missing output) \| 174K \|Jerry
\| \| //**CNTRL and RCP reference runs**//|||||\| \| NRCP85BPRPEX_01
(pure RCP8.5), NRCP85BPRPEX_ens02, NRCP85BPRPEX_ens03 \| RCP85
(2005-2100) \| NRCP85BPRPEX, r258 \|

.. raw:: html

   <html>

3/3

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \| 1,7 TB \| 110K \| Jerry/Odd Helge \| \|
NRCP45BPRPEX_01 (pure RCP4.5), NRCP45BPRPEX_ens02, NRCP45BPRPEX_ens03 \|
RCP45 (2005-2100) \| NRCP45BPRPEX, r258 \|

.. raw:: html

   <html>

3/3

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \| 3,1 TB \| 110K \| Jerry \| \|Exp 2 (PI
Control, 501-850)\\\ N1850BPRPCNOC_f19_g16_spin_02 \|none \|
N1850AERBPRP \|

.. raw:: html

   <html>

1/1 (?)

.. raw:: html

   </html>

\| N1850BPRPCNOC_f19_g16_spin_02 \| 6 TB \| 110K \| Jerry \|
\|//**Experiments**// \|||||\| \|Exp 1 (SAI on PI, 2020-2100)\\\
NPI_LINPIN5_01 \|SAI - Global \| \|

.. raw:: html

   <html>

1/1

.. raw:: html

   </html>

\| N1850BPRPCNOC_f19_g16_spin_02 \| 1,7 TB\| 220K \|Jerry \| \|Exp 3
(SAI on RCP85,2020-2100)\\\ NRCP85BPRPEX_03 \| SAI - Global (Simplyfied
aerosol data) \| NRCP85BPRPEX \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \| 1,7 TB\| 110K \| Jerry \| \|Exp 3 (SAI
on RCP85,2005-2100)\\\
`NORESM:ModelDefFiles:NRCP85BPRPEX_MPI_20100_LWF1 <NORESM:ModelDefFiles:NRCP85BPRPEX_MPI_20100_LWF1>`__
\\\\ NRCP85BPRPEX_MPI_20100_LWF1_2, NRCP85BPRPEX_MPI_20100_LWF1_4,
NRCP85BPRPEX_MPI_20100_LWF1_5 \| SAI - Global (ECHAM-aerosoldata) \|
NRCP85BPRPEX, r405 \|

.. raw:: html

   <html>

 3/3

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \| 1,7 TB\| 110K \| Alf G \| \|Exp 5
(2020-2100)\\\ NRCP85BPRPEXMSB_01, NRCP85BPRPEXMSB_02,
NRCP85BPRPEXMSB_03, NRCP85BPRPEXMSB_01_2069\* \| MSB - Global \|
NRCP85BPRPEX, r258 \|

.. raw:: html

   <html>

 3/3

.. raw:: html

   </html>

\| NRCP85BPRPEX_01 \|1,7T \| 110K \| Helene \| \|Exp 6 (2020-2100)
NRCP85BPRPEX_CCT_01, NRCP85BPRPEX_CCT_02, NRCP85BPRPEX_CCT_03 \|CCT -
Global \| NRCP85BPRPEX \|

.. raw:: html

   <html>

 3/3

.. raw:: html

   </html>

\| NRCP85BPRPEX_01 \|1,7T \| 110K \| Helene \| \|//**Termination
runs**//|||||\| \| NRCP85XTBPRPEX_01g (pure RCP8.5) \| RCP85 (2101-2200)
\| NRCP85BPRPEX, r258 \|

.. raw:: html

   <html>

1/1

.. raw:: html

   </html>

\| NRCP85BPRPEX_01 \| 1,7 TB \| 110K \| Jerry \| \|Exp 5 (2101-01 -
2150-12)\\\ NRCP85XTBPRPEX_MSB_01_ext \| termination of MSB - Global \|
NRCP85BPRPEX, r258 \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| NRCP85BPRPEXMSB_01 \|1,7T \| 110K \| Helene \| \|Exp 6 (2101-01 -
2150-12)\\\ NRCP85XTBPRPEX_CCT_02ext,
:sup:`§`\ NRCP85XTBPRPEX_CCT_02ext_2150\| termination of CCT - Global \|
NRCP85BPRPEX, r258 \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| NRCP85BPRPEX_CCT_02 \|1,7T \| 110K \| Helene \| \|Exp 3 (SAI on
RCP85,2101-2200)\\\
`NORESM:ModelDefFiles:NRCP85BPRPEX_MPI_20100_LWF1_T <NORESM:ModelDefFiles:NRCP85BPRPEX_MPI_20100_LWF1_T>`__
\| SAI - Global (ECHAM-aerosoldata) \| NRCP85BPRPEX, r405 \|

.. raw:: html

   <html>

 1/1

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \| 1,7 TB\| 110K \| Alf G \|
\|//**Targetted runs**//|||||\| \|Exp 7 (2005-2100)|MSB - Arctic \| \|

.. raw:: html

   <html>

 0/1tier2

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \|0,8T \| 110K \| Helene \| \|Exp 8
(2005-2100)|MSB - mid-lat continents \| \|

.. raw:: html

   <html>

 0/1tier2

.. raw:: html

   </html>

\| N20TRAERCNOCBPRP_EXPECT01 \|0,8T \| 110K \| Helene \| \|Exp 9
(2005-2100)|CCT - Arctic \| \|

.. raw:: html

   <html>

 0/1tier2

.. raw:: html

   </html>

\|N20TRAERCNOCBPRP_EXPECT01 \|0.8T \| 110K \| Helene \| \|Exp 10
(2005-2100)|CCT - mid-lat continents \| \|

.. raw:: html

   <html>

 0/1tier2

.. raw:: html

   </html>

\|N20TRAERCNOCBPRP_EXPECT01 \|0.8T \| 110K \| Helene \|

Diagnostics available:
~~~~~~~~~~~~~~~~~~~~~~

Table on NCAR diagnostics packages produced on experiments with
reference, provide weblink and name who run the package. This table
contains atmospheric diagnostics only, at present. Norstore project
webserver: https://webserver1.norstore.uio.no:8443/NS9033K/index.html,
username and password = projectname (small caps). Now migrated to NIRD:
https://ns9033k.webs.sigma2.no/

^ \**exp v / reference >*\* ^ \**RCP45*\* ^ \**RCP85*\* ^ \**SAI
(MPI)*\* ^ \**MSB*\* ^ \**CCT*\* ^ \|**RCP45**|N/A|N/A|N/A|N/A|N/A\|
\|**RCP85**\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_01-NRCP45BPRPEX_01/index.html>`__
(HM)|N/A|N/A|N/A|N/A\| \|**SAI
(MPI)**\|`cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_MPI_20100_LWF1_2-NRCP45BPRPEX_01/index.html>`__
(AG)\|`cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_MPI_20100_LWF1_2-NRCP85BPRPEX_01/index.html>`__
(AG)|N/A|N/A|N/A\|
\|**MSB**\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEXMSB_01-NRCP45BPRPEX_01/index.html>`__
(HM)\|`cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEXMSB_01-NRCP85BPRPEX_01/index.html>`__
(HM)\|`cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEXMSB_01-NRCP85BPRPEX_MPI_20100_LWF1_2/index.html>`__
(AG)|N/A|N/A\|
\|**CCT**\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_CCT_02-NRCP45BPRPEX_01/index.html>`__
(HM)
\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_CCT_02-NRCP85BPRPEX_01/index.html>`__
(HM)
\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_CCT_02-NRCP85BPRPEX_MPI_20100_LWF1_2/index.html>`__
(AG)
\|\ `cam <https://webserver1.norstore.uio.no:8443/NS9033K/diag/NRCP85BPRPEX_CCT_02-NRCP85BPRPEXMSB_01/index.html>`__
(HM)|N/A\|

List of other model runs:
~~~~~~~~~~~~~~~~~~~~~~~~~

Listed below are complementary experiments done to assess Cirrus Cloud
Thinning. "NE" compset is for slab ocean. "NF" is prescribed SSTs. Ice
crystal fall speed is perturbed for temperatures colder than -38C to
emulate CCT.

^ Simulation name ^ Forcing ^ # of runs ^ Reference run ^
machine/storage ^ RESPONSIBLE^ \| NE1850AERCN \| none \| 1 \| - \|
hexagon, norstore: NS9033K/muri/noresm1-m/archive/noresm-slab/ \| Helene
\| \| NE1850ACN2xCO2 \| 2xCO2 \| 1 \| NE1850AERCN \| --"-- \| Helene \|
\| NE1850ACNCCTh \| CCT (vf*8 for T < 235K) \| 1 \| NE1850AERCN \| --"--
\| Helene \| \| NE1850ACNCCTl \| CCT (vf\8 for T < 235K) \| 1 \|
NE1850AERCN \| --"-- \| Helene \| \| NE1850ACNCCTh2xCO2 \| CCT (vf*8 for
T < 235K) + 2xCO2 \| 1 \| NE1850AERCN \| --"-- \| Helene \| \|
NE1850ACNCCTl2xCO2 \| CCT (vf\8 for T < 235K) + 2xCO2 \| 1 \|
NE1850AERCN \| --"-- \| Helene \| \| NE1850ACNCCThvfx2 \| CCT (vf*2 for
T < 235K) \| 1 \| NE1850AERCN \| --"-- \| Helene \| \|
NE1850ACNCCThvfx2CO2x1.47 \| CCT (vf*2 for T < 235K) + 1.52xCO2 \| 1 \|
NE1850AERCN \| --"-- \| Helene \| \| NE1850ACNCCThvfx2CO2x2 \| CCT (vf*2
for T < 235K) + 2xCO2 \| 1 \| NE1850AERCN \| --"-- \| Helene \| \|
NF1850AERCNAMIPC \| none \| 1 \| - \| hexagon, norstore:
NS9033K/muri/noresm1-m/archive/noresm-slab/ \| Helene \| \|
NF1850ACN2xCO2 \| 2xCO2 \| 1 \| NF1850AERCNAMIPC \| --"-- \| Helene \|
\| NF1850ACNCCTh \| CCT (vf*8 for T < 235K) \| 1 \| NF1850AERCNAMIPC \|
--"-- \| Helene \| \| NF1850ACNCCTl \| CCT (vf\8 for T < 235K) \| 1 \|
NF1850AERCNAMIPC \| --"-- \| Helene \| \| NF1850ACNCCTh2xCO2 \| CCT
(vf*8 for T < 235K) + 2xCO2 \| 1 \| NF1850AERCNAMIPC \| --"-- \| Helene
\| \| NF1850ACNCCTl2xCO2 \| CCT (vf\8 for T < 235K) + 2xCO2\| 1 \|
NF1850AERCNAMIPC \| --"-- \| Helene \| \| NF1850ACNvfallx2 \| CCT (vf*2
for T < 235K) \| 1 \| NF1850AERCNAMIPC \| --"-- \| Helene \|

New GeoMIP CCMI stratospheric aerosol data set
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

```https://www2.acd.ucar.edu/gcm/geomip-g4-specified-stratospheric-aerosol-data-set`` <https://www2.acd.ucar.edu/gcm/geomip-g4-specified-stratospheric-aerosol-data-set>`__

Netcdf file with prescribed aerosols from ECHAM_HAM available at:

``hexagon: /home/uio/muri/input_noresm/geomip/CCMI_GeoMIP/``

| ``geomip_ccmi_2020-2071_volc_v3.nc includes:``
| `` * volume_density:long_name = "aerosol volume" ; volume_density:units = ``
