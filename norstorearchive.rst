.. _norstorearchive:

NorStore Research Data Archive: Guidelines for ingestion of NorESM output
==========================================================================                                                                         

The recommendations presented on this page are based on discussion
between Alok, Mats and Ingo. Please feel free to comment and modify
them.

The access point to NorStore's Research Data Archive is
http://archive.norstore.no

For testing purposes, the alternative site
http://archive-test.norstore.uio.no should be used.

Metadata recommendations
''''''''''''''''''''''''

BibliographicCitation
^^^^^^^^^^^^^^^^^^^^^

Specify "http://cmip-pcmdi.llnl.gov/cmip5/terms.html" as value.

Coverage
^^^^^^^^

Please follow DCMI recommendations when specifying coverage.

Box (http://dublincore.org/documents/dcmi-box)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If coverage is global, use:

- northlimit=90
- southlimit=-90
- westlimit=-180
- eastlimit=180
- units=signed decimal degrees

(leave rest unspecified)

Period (http://dublincore.org/documents/dcmi-period http://www.w3.org/TR/NOTE-datetime)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Specification of start- and end-year required (optionally, month and day):

- start=YYYY[-MM-DD]
- end=YYYY[-MM-DD]
- scheme=W3C-DTF

The value of *scheme* should be always set to W3C-DTF. The value of
*name* can be left blank.

Description
^^^^^^^^^^^

Recommended content in description:

- long version of title, e.g. "Norwegian Earth System Model version 1 (medium resolution) output prepared for the CMIP5 pre-industrial control experiment."
- citation information (see below)
- reference to CMIP5 experimental design (http://cmip-pcmdi.llnl.gov/cmip5/docs/Taylor_CMIP5_design.pdf)
- forcing agents (link to http://search.es-doc.org) **(INGO: skip?)** 
- initialisation (parent experiment, branch time) **(INGO: skip?)**

NorESM1-M citation:

- Bentsen, M., Bethke, I., Debernard, J. B., Iversen, T., Kirkevåg,
      A., Seland, Ø., Drange, H., Roelandt, C., Seierstad, I. A., Hoose,
      C., and Kristjánsson, J. E.: The Norwegian Earth System Model,
      NorESM1-M – Part 1: Description and basic evaluation of the
      physical climate, Geosci. Model Dev., 6, 687-720,
      doi:10.5194/gmd-6-687-2013, 2013.

NorESM1-ME citation:

- Tjiputra, J. F., Roelandt, C., Bentsen, M., Lawrence, D. M.,
      Lorentzen, T., Schwinger, J., Seland, Ø., and Heinze, C.:
      Evaluation of the carbon cycle components in the Norwegian Earth
      System Model (NorESM), Geosci. Model Dev., 6, 301-325,
      doi:10.5194/gmd-6-301-2013, 2013.

Mapping of CMIP experiment long/short names
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

  10- or 30-year run initialized in year XXXX    decadalXXXX
  volcano-free hindcast initialized in year XXXX noVolcXXXX
  prediction with 2010 volcano                   volcIn2010
  pre-industrial control                         piControl
  historical                                     historical
  historical extension                           historicalExt
  other historical forcing                       historicalMisc
  mid-Holocene                                   midHolocene
  last glacial maximum                           lgm
  last millennium                                past1000
  RCP4.5                                         rcp45
  RCP8.5                                         rcp85
  RCP2.6                                         rcp26
  RCP6                                           rcp60
  ESM pre-industrial control                     esmControl
  ESM historical                                 esmHistorical
  ESM RCP8.5                                     esmrcp85
  ESM fixed climate 1                            esmFixClim1
  ESM fixed climate 2                            esmFixClim2
  ESM feedback 1                                 esmFdbk1
  ESM feedback 2                                 esmFdbk2
  1 percent per year CO2                         1pctCO2
  abrupt 4XCO2                                   abrupt4xCO2
  natural-only                                   historicalNat
  GHG-only                                       historicalGHG
  AMIP                                           amip
  2030 time-slice                                sst2030
  control SST climatology                        sstClim
  CO2 forcing                                    sstClim4xCO2
  all aerosol forcing                            sstClimAerosol
  sulfate aerosol forcing                        sstClimSulfate
  4xCO2 AMIP                                     amip4xCO2
  AMIP plus patterned anomaly                    amipFuture
  aqua planet control                            aquaControl
  4xCO2 aqua planet                              aqua4xCO2
  aqua planet plus 4K anomaly                    aqua4K
  AMIP plus 4K anomaly                           amip4K


Boundary conditions
~~~~~~~~~~~~~~~~~~~

piControl: 

::

  -Prescribed atmospheric concentrations of pre-industrial well mixed gas: Carbon Dioxide
  -Unperturbed Pre-Industrial Land Use
  -Prescribed concentrations or emissions of pre-industrial natural aerosols
  -Prescribed concentrations or emissions of pre-industrial natural aerosol precursors
  -Prescribed atmospheric concentration of pre-industrial short lived (reactive) gas species 
  -Prescribed concentrations or emissions of pre-industrial short lived (reactive) aerosol species 
  -Prescribed atmospheric concentrations of pre-industrial well mixed gases: excluding CO2

Label
^^^^^

If the dataset matches a NorESM case then specify the case name as
label, e.g., ``NAER1850CNOC_f19_g16_06``.

Rights holder
^^^^^^^^^^^^^

If in doubt, specify

- Organization: *Norwegian Climate Centre*
- Organization acronym: *NCC*
- Organization web-page: *gfi.uib.no/EarthClim*
- Contact email: *noresm-ncc@met.no* **(INGO: NEED TO FIND BETTER SOLUTION FOR EMAIL ADDRESS)**

Title
^^^^^

We recommend to use following formula:

::

  <MODEL ACRONYM> <PROJECT> <OFFICIAL EXPERIMENT ACRONYM> (<experiment number in Taylor document>) r<realisation number>[<realisation letter>] <output type> 

Examples:

 
- NorESM1-M CMIP5 historicalExt (3.2) r1 raw output 
- NorESM1-ME CMIP5 rcp85 (4.2) r1a raw output 
- NorESM1-ME CMIP5 rcp85 (4.2) r1 cmor-processed output 

<output type> should be a brief and general description of the type of output, e.g. raw output or cmor-processed output. Information on data format etc will be specified elsewhere. 


<realisation letter> can be used if an experiment is composed of several cases – e.g., NorESM1-ME CMIP5 rcp85 r1 is associated with the cases NRCP85AERCNOC_f19_g16_01 and NRCP85AERCNOC_f19_g16_02 – and one intends to create a dataset for each cases. 

Mapping between CMIP5 experiment acronyms and NorESM1-M cases: 

::

  piControl     r1 N1850AERCNOC_f19_g16_CTRL_02 
  1pctCO2       r1 N1850RMAERCNOC_f19_g16_02 
  historical    r1 N20TRAERCNOC_01
  esmControl    r1 N1850AERBPRP_f19_g16_02 
  esmHistorical r1 N20TRAERCNOCBPRP_f19_g16_01  
  esmrcp85      r1 NRCP85AERBPRP_f19_g16_03   
  esmFdbk1      r1 N1850RMAERCNOC_f19_g16_RAD_02  
  esmFixClim1   r1 N1850RMAERCNOC_f19_g16_BGC_02 
  rcp26         r1 NRCP26AERCNOC_f19_g16_01 (2006-2060), NRCP26AERCNOC_f19_g16_02 (2061-2101)  
  rcp45         r1 NRCP45AERCNOC_f19_g16_02  
  rcp6          r1 NRCP60AERCNOC_f19_g16_01 (2006-2050), NRCP60AERCNOC_f19_g16_02 (2051-2101) 
  rcp85         r1 NRCP85AERCNOC_f19_g16_01 (2006-2044), NRCP85AERCNOC_f19_g16_02 (2045-2100)   

Mapping between CMIP5 experiment acronyms and NorESM1-ME cases names:

::

  piControl     r1 N1850AERCNOC_f19_g16_CTRL_02
  1pctCO2       r1 N1850RMAERCNOC_f19_g16_02
  historical    r1 N20TRAERCNOC_01
  esmControl    r1 N1850AERBPRP_f19_g16_02
  esmHistorical r1 N20TRAERCNOCBPRP_f19_g16_01
  esmrcp85      r1 NRCP85AERBPRP_f19_g16_03
  esmFdbk1      r1 N1850RMAERCNOC_f19_g16_RAD_02
  esmFixClim1   r1 N1850RMAERCNOC_f19_g16_BGC_02
  rcp26         r1 NRCP26AERCNOC_f19_g16_01 (2006-2060), NRCP26AERCNOC_f19_g16_02 (2061-2101)
  rcp45         r1 NRCP45AERCNOC_f19_g16_02
  rcp6          r1 NRCP60AERCNOC_f19_g16_01 (2006-2050), NRCP60AERCNOC_f19_g16_02 (2051-2101)
  rcp85         r1 NRCP85AERCNOC_f19_g16_01 (2006-2044), NRCP85AERCNOC_f19_g16_02 (2045-2100)   

Project
^^^^^^^

For CMIP5 output, specify *Integrated Earth System Approach to Explore Natural Variability and Climate Sensitivity (EarthClim)*

Conforms to
^^^^^^^^^^^

If in doubt, specify "*Climate and Forecast (CF) metadata conventions*"

Provenance
^^^^^^^^^^

In case the output has been compressed, specify "*gzip compression of restart files and conversion of history output to compressed NetCDF-4 format*" and state the time stamp of the last compressed restart file.

Please add additional provenance entries in case further manipulations have been performed on the output.

Metadata example
''''''''''''''''

Link to `this section <norstorearchive#metadata_example>`__. 

+-------------------------+------------------------------------+----------------------------------+
| Parameter               | Value                              | Comment                          |
+=========================+====================================+==================================+
| **Title**               | NorESM1-M CMIP5 historicalExt (3.2)|                                  |
|                         | r2 raw output                      |                                  | 
+-------------------------+------------------------------------+----------------------------------+
|**Created on**           | 29/Oct/2011                        | **Ingo:** time stamp of the last |
|                         |                                    | restart folder (i.e, time        |
|                         |                                    | experiment was completed)        |
+-------------------------+------------------------------------+----------------------------------+
| **Category**            | Simulation                         |                                  |
+-------------------------+------------------------------------+----------------------------------+
| **State**               | Raw                                |                                  |
+-------------------------+------------------------------------+----------------------------------+
| **Domain**              | Natural Sciences                   |                                  |
+-------------------------+------------------------------------+----------------------------------+
| **Field**               | Earth Sciences                     |                                  |
+-------------------------+------------------------------------+----------------------------------+
| **Creator**             | Norwegian Climate Center (NCC)     |                                  |
+-------------------------+------------------------------------+----------------------------------+
|**Contributor**          |Alok Kumar Gupta (Alok.Gupta@uni.no)| **Ingo:** NorStore defines the   |
|                         |                                    | contributor as the person who    |
|                         |                                    | puts in the metadata             |
+-------------------------+------------------------------------+----------------------------------+
|**Data Manager**         |Alok Kumar Gupta (Alok.Gupta@uni.no)|                                  |
+-------------------------+------------------------------------+----------------------------------+
|**Rights Holder**        | Norwegian Climate Center (NCC)     |                                  |
|                         | (Ingo.Bethke@uni.no)               | **Ingo:** need to find better    |
|                         |                                    | solution for the email address   |
+-------------------------+------------------------------------+----------------------------------+
|**Access Rights**        | Public                             | **Ingo:** our processed CMIP5    |
|                         |                                    | is public, so we might as well   |
|                         |                                    | make the raw data public         |
+-------------------------+------------------------------------+----------------------------------+
| **Label**               | NRCP85AERCN_f19_g16_02             | **Ingo:** decided to use the     |
|                         |                                    | experiment "case name" as label  |
+-------------------------+------------------------------------+----------------------------------+
|**BibliographicCitation**|``http://www.geosci-model-dev.net/6/|                                  |
|                         |687/2013/gmd-6-687-2013.html``      | **Ingo:** the                    | 
|                         |                                    |*BibliographicCitation* value has |
|                         |                                    | to be an URL.                    |
|                         |                                    | We decided to add additional     |
|                         |                                    | citation information to          |
|                         |                                    | **Description**                  |
+-------------------------+------------------------------------+----------------------------------+
|**Project**              | Integrated Earth System Approach   | **Ingo**: specify time stamp of  |
|                         | to Explore Natural Variability and | last compressed restart file     |
|                         | Climate Sensitivity (EarthClim)    |                                  | 
+-------------------------+------------------------------------+----------------------------------+
| **Conforms to**         | Climate and Forecast (CF) metadata |                                  |
|                         | conventions                        |                                  | 
+-------------------------+------------------------------------+----------------------------------+
| **Provenance**          | gzip compression of restart files  |                                  |
|                         | and conversion of history output to|                                  |
|                         | compressed NetCDF-4 format         |                                  |
+-------------------------+------------------------------------+----------------------------------+
| **Coverage**            | Box: Southlimit=-90,               | **Ingo**: use of DCMI standard   |
|                         | Northlimit=90, Westlimit=-180,     | makes it easy for external       |
|                         | Eastlimit=180, Uplimit=20000,      | servers to interpret the         |
|                         | Downlimit=-9000, Units=signed      | coverage information             |
|                         | decimal degrees, Zunits=m; Period: |                                  |
|                         | start=2006-01-01, end=2012-12-31,  |                                  |
|                         | scheme=W3C-DTF                     |                                  |
+-------------------------+------------------------------------+----------------------------------+


**Description**

::

  Norwegian Earth System Model version 1 (medium resolution) output 
  prepared for the CMIP5 historical extension experiment with forcing
  scenario RCP8.5.
  
  Citation: Bentsen, M., Bethke, I., Debernard, J. B., Iversen, T., Kirkevåg, 
            A., Seland, Ø., Drange, H., Roelandt, C., Seierstad, I. A., Hoose, C., 
	    and Kristjánsson, J. E.: The Norwegian Earth System Model, NorESM1-M – 
	    Part 1: Description and basic evaluation of the physical climate, 
	    Geosci. Model Dev., 6, 687-720, doi:10.5194/gmd-6-687-2013, 2013.
	    
  Technical details: Production machine: Cray XT3 in Bergen (hexagon)

  Model source: https://svn.met.no/viewvc/noresm/noresm/branches/noresm-ver1_cmip5-r112
  Model revision number: 112 Model components: atmosphere=CAM4;
  ocean=MICOM; land=CLM; sea ice=CICE Horizontal resolution:
  atmosphere/land=1.9x2.5 degree; ocean/sea ice=~1 degree Output
  frequency: monthly + daily + 6-hourly + 3-hourly as requested by CMIP5
 
  Experiment type: fully coupled Initialisation: branched from CMIP5
  historical simulation r2 (N20TRAERCN_f19_g16_02) at 2006-01-01 Changing
  forcing agents: prescribed GHG concentration changes; aerosol emissions
  for SO4, POM and BC (see Kirkevåg et al. 2013) Tuning parameters changed
  relative to the host model CAM4: rhminl=0.90 (0.91 in CAM4) reduced RH
  threshold for formation of low stratiform clouds; critrp=5.0 mm/day (0.5
  mm/day in CAM4) maximum precipitation rate for suppression of
  autoconversion of cloud water; r3lc=14 um (10 um in CAM4) critical mean
  droplet volume radius for onset of autoconversion Other comments: -

  External references:
  http://cmip-pcmdi.llnl.gov/cmip5/docs/Taylor_CMIP5_design.pdf
  (experimental design) http://search.es-doc.org (model system, boundary
  conditions, experiments, etc) http://noresg.norstore.no (Norwegian ESGF
  portal with post-processed CMIP5 data)
  http://www.geosci-model-dev.net/special_issue20.html (NorESM special
  issue)
  http://www.cristin.no/as/WebObjects/cristin.woa/wo/18.Profil.29.25.2.3.3.7
  (link to national publication database)
