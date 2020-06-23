.. _cmip6_data.rst

CMIP6 archive of NorESM results
===================


| NorESM2 contributes to the 6th phase of the Coupled Model Intercomparison Project (CMIP6; Eyring et al., 2016):   
| https://www.wcrp-climate.org/wgcm-cmip/wgcm-cmip6   
| 


**CMIP6:** 

- Project under World Climate Research Programme (WCRP)
- Since 1995 CMIP has coordinated climate model experiments
- Defines common experiment protocols, forcings and output.
- 33 model groups participate

**Advantages:**

- Several models perform the same experiments (enabeling comparisons across models and multi-model ensembles)
- Homogenized and standardized outputs (including variable names). More specifically, all data is in compliance with the standards of the Climate Model Output Rewriter (CMOR).

Data access
^^^^^^^

The Earth System Grid Federation (ESGF):
++++++++++++++++

**All data is CMOR-ized and public available here:**
https://esg-dn1.nsc.liu.se/search/cmip6-liu/

The (Norwegian) National Infrastructure for Research Data (NIRD)
+++++++++++++++
 
**All NIRD users can access the archive of CMOR-ized CMIP6 NorESM data** under project NS9034K::

   /projects/NS9034K/CMIP6/
   
This is the same data that you can access through the ESGF. Note data is organized by the different contributions/MIPs. The DECK and historical simulations are located under "CMIP".

**NIRD users that are members of NS9252K (NFR storage project for KeyCLIM) can access CMOR-ized CMIP6 data from multiple models under**:: 

   /projects/NS9252K/CMIP6/

Note this data has a different structure than the data residing in /projects/NS9034K/CMIP6/. If you want to make a request for data or for more data to be downloaded to this folder, contact jang@met.no. If you are a NIRD user, but not a member of this project and would like to request access, contact michaels@met.no.

**NIRD users that are members of NS9560K (NFR storage project for INES) can access most of the raw (non-CMOR-ized) model data under**::

   /projects/NS9560K/noresm/cases/ 
   
If you are a NIRD user, but not a member of this project, and would like to request access, contact mben@norceresearch.no.

DECK contributions
^^^^^^^^^^^^^^^^^^
NorESM2 contributions to the CMIP6 Diagnostic, Evaluation and Characterization of Klima (DECK) and CMIP6 historical simulations

.. list-table:: 
   :widths: 25 35 40
   :header-rows: 1
    
   * - Exp. short name
     - Exp. long name
     - NorESM2 version (members)
   *  - amip
      - a historical Atmospheric MIP simulation
      - NorESM2-LM (1), NorESM2-MM (1)
   * - piControl
     - pre-industrial control simulation
     - NorESM2-LM (1), NorESM2-MM (1)
   * - historical
     - historical 
     - NorESM2-LM (3), NorESM2-MM (1)
   * - abrupt-4xCO2
     - forced by an abrupt quadrupling of atmospheric CO2
     - NorESM2-LM (1), NorESM2-MM (1)
   * - 1pctCO2
     - forced by a 1 % pr. year atmospheric CO2 increase
     - NorESM2-LM (1), NorESM2-MM (1)


MIPs contributions
^^^^^^^^^^^^^^^^^

.. list-table:: 
   :widths: 25 35 45 15
   :header-rows: 1

   * - MIP short name
     - MIP long name
     - NorESM2 version
     - Contact person(s)*
   * - CMIP
     - Coupled MIP
     - NorESM2-LM, NorESM2-MM
     - ØS, TT, DJLO
   * - AerChemMIP
     - Aerosols and Chemistry MIP
     - NorESM2-LM
     - DJLO, MS
   * - C4MIP
     - Coupled Climate Carbon Cycle MIP
     - NorESM2-LME
     - JS, JT
   * - CDRMIP	   
     - The Carbon Dioxide Removal MIP
     - NorESM2-LM
     - JT, JS
   * - CFMIP
     - Cloud Feedback MIP
     - No contribution yet
     - TS, ØS
   * - DAMIP
     - Detection and Attribution MIP
     - NorESM2-LM
     - ØS
   * - DCPP
     - Decadal Climate Prediction Project
     - NorCPM1
     - NK, FC
   * - GeoMIP
     - Geoengineering MIP
     - No contribution yet
     - HM
   * - LUMIP
     - Land-Use MIP
     - No contribution yet
     - HL, YH
   * - OMIP
     - Ocean MIP
     - NorESM2-LM
     - MB, JS
   * - PAMIP
     - Polar Amplification MIP
     - NorESM2-LM
     - LSG, MB
   * - PMIP
     - Paleoclimate MIP
     - NorESM1-F, NorESM2-LM
     - CG, ZZ
   * - RFMIP
     - Radiative Forcing MIP
     - NorESM2-LM, NorESM2-MM
     - AK, DJLO
   * - ScenarioMIP
     - Scenario MIP
     - NorESM2-LM, NorESM2-MM
     - MB, MS
   * - SIMIP
     - Sea Ice MIP
     - No contribution yet
     - JBD
   * - ZECMIP	   
     - Zero Emissions Commitment MIP
     - NorESM2-LM
     - JS, JT

\* 
**MB**: Mats Bentsen <mats.bentsen@uni.no>,
**FC**: Francois Counillon <francois.counillon@nersc.no>,
**JBD**: Jens Boldingh Debernard <jensd@met.no>,
**LSG**: Lise Seland Graff <lisesg@met.no>,
**YH**: Yanchun He <yanchun.he@nersc.no>,
**AK**: Alf Kirkevag <alfk@met.no>,
**NK**: Noel Keenlyside <noel.keenlyside@gfi.uib.no>,
**HL**: Hanna Lee <hanna.lee@uni.no>,
**HM**: Helene Muri <helene.muri@ntnu.no>,
**DJLO**: Dirk Jan Leo Olivie <dirkjlo@met.no>,
**TT**: Thomas Toniazzo <thomas.toniazzo@uni.no>,
**JS**: Jörg Schwinger <jorg.schwinger@norceresearch.no>,
**MS**: Michael Schultz <michaels@met.no>
**TS**: Trude Storelvmo <trude.storelvmo@geo.uio.no>,
**ØS**: Øyvind Seland <oyvind.seland@met.no>,
**JT**: Jerry Tjiputra <Jerry.Tjiputra@norceresearch.no>,
**CG**: Chuncheng Guo <chgu@norceresearch.no>,
**ZZ**: Zhongshi Zhang <zhzh@norceresearch.no>,

| Overview CMIP6-Endorsed MIPs:
| https://www.wcrp-climate.org/modelling-wgcm-mip-catalogue/modelling-wgcm-cmip6-endorsed-mips


References
^^^^^^
Seland, Ø., Bentsen, M., Seland Graff, L., Olivié, D., Toniazzo, T., Gjermundsen, A., Debernard, J. B., Gupta, A. K., He, Y., Kirkevåg, A., Schwinger, J., Tjiputra, J., Schancke Aas, K., Bethke, I., Fan, Y., Griesfeller, J., Grini, A., Guo, C., Ilicak, M., Hafsahl Karset, I. H., Landgren, O., Liakka, J., Onsum Moseid, K., Nummelin, A., Spensberger, C., Tang, H., Zhang, Z., Heinze, C., Iverson, T., and Schulz, M.: The Norwegian Earth System Model, NorESM2 – Evaluation of theCMIP6 DECK and historical simulations, Geosci. Model Dev. Discuss., https://doi.org/10.5194/gmd-2019-378, in review, 2020.


Eyring, V., Bony, S., Meehl, G. A., Senior, C. A., Stevens, B., Stouffer, R. J., and Taylor, K. E.: Overview of the Coupled Model Intercomparison Project Phase 6 (CMIP6) experimental design and organization, Geosci. Model Dev., 9, 1937–1958, https://doi.org/10.5194/gmd-9-1937-2016, 2016.
