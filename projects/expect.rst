.. _expect:

Expect project
''''''''''''''

Project definitions
~~~~~~~~~~~~~~~~~~~

- What model resolution will be used?
    - 2 degree (is already validated and has control simulation done)
- A common model branch is created based on the CMIP5-version of the carbon cycle model but there are some differences
    - Please use the branch https://svn.met.no/NorESM/noresm/branches/projectEXPECT_cmip5-r143-1.
    - Hexagon account: **nn9182k**. New account for the period 2016.2, 2017.1: 
    - nn9448k

- NIRD (previously Norstore) account: **NS9033K**. I.e. data located at 

::

  login.nird.sigma2.no:/projects/NS9033K/

- Acknowledge RCN Grant Number: **229760/E10**.
- Public website: http://expected.bitbucket.io/

Open questions in the project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- How do we want to branch off the realisations?
- Do we want / can we computationally (CPU-hours and storage space) afford 3 realisations for each of the key experiments?
  >> 3 realisations will be done for Tier 1 / core experiments.
- What years do we want to do Climate Engineering? >> 2020 to 2100.
- How many years do we want to run after Climate Engineering is switched off ('termination effect')?
  >> 50 years for now.

Description of model reference version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The model reference is based on the NorESM1-ME version, which is the
same version used in CMIP5, with minor adjustments. The set up adopted
in the EXPECT project is based on a fully-interactive climate carbon
cycle coupling. The atmospheric CO2 concentration is spatially and
temporally varying and is prognostically simulated according to the
sources and sinks from land and ocean CO2 fluxes.

- Tjiputra, J. F., Roelandt, C., Bentsen, M., Lawrence, D. M., Lorentzen, T., Schwinger, J., Seland, Ø., and Heinze, C.: Evaluation of the carbon cycle components in the Norwegian Earth System Model (NorESM), Geosci. Model Dev., 6, 301-325, doi:10.5194/gmd-6-301-2013, 2013.

Presentations from EXPECT at AGU Dec. 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Muri et al. AGU climate engineering session - :download:`pdf <presentations/Muri_AGU16_EXPECT_141216.pptx>`
  Simulated transition from RCP8.5 to RCP4.5 through three different Radiation Management techniques

Presentations from EXPECT / GeoMIP meeting June 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Jon Egill Kristjansson GeoMIP presentation 
- Helene Muri Open Session presentation - :download:`Solar Geoengineering <presentations/Muri_EXPECT_OpenSession_22062016_pdf.pdf>`
- Helene Muri EXPECT meeting Cirrus cloud thinning - :download:`CCT preliminary results <presentations/Muri_EXPECT_CCT_20June2016.pdf>`
- Helene Muri EXPECT meeting Marine sky brightening - :download:`MSB preliminary results <presentations/Muri_EXPECT_MSB_20June2016.pdf>`

Presentations from project meeting January 2016:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Jon Egill Kristjansson 
- Jon Egill Kristjansson - 
- Alf Grini - Stratospheric sulfate simulations RCP8.5->RCP4.5 ftp://ftp.met.no/projects/noresmatm/upload/EXPECT/Meeting160105/expectpres_1601005_AG.pdf
- Helene Muri 
- Helene Muri 
- Alan Robock - The G4-Specified Stratospheric Aerosol Experiment http://climate.envsci.rutgers.edu/robock/talks/G4SSA2.pptx

List of "official" model runs:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To purpose of this table is as follows:

- Reproduce bit-identical results from any project run based solely on the information in this table!
- It should be possible to understand how much storage space is needed in total for the project
- It should be possible to understand the purpose of all the runs by reading the table
- Color coding (see runs performed): 

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

- CPU time and storage is given PER realization. 
- **Note:** NRCP85BPRPEXMSB_01_2069 -re-run of year 2069, as 1 file was lost whilst transferring from norstore account NS2345K.
- **Note:** :sup: § NRCP85XTBPRPEX_CCT_02ext_2150 - re-run of year 2150 as oceanic productivity looked "funny" in original case from stopping and restarting, not running a full year at a time.

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
