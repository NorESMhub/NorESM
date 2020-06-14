.. _aero_faq:

Aerosol FAQ
============


**All NorESM users and developers are here invited to submit questions and/or answers about aerosol related topics not covered elsewhere in NorESM-doc.**

---------------------

How can I get mass and number concentration diagnostics via AeroTab and postprocessing?
^^^^^
**Example a) retrieve the aerocom mass and number smaller than a given size**  

**Example b) for FORCES/CRESCENDO, using the SALSA definition of size range for aitken, accumulation, and coarse mode: Nucleation: 3-7.7 nm; Aitken: 7.7-50 nm, Accumulation: 50-700 nm, Coarse: 700-10 000 nm.**

Availability of such output mainly follows the AeroCom requirements, which for specific size intervals only concern mass concentrations. For the most accurate calculations of size-specific number concentrations and mass concentrations which are not currently included in AeroTab and AerOslo (NorESM2), this can with some effort be added by extending the code to do so. There are, however, alternative ways to approximate both mass and number concentrations through post-processing. To see what output is generally available from the look-up tables made by AeroTab and directly outputted in NorESM2 when configured with #define AEROCOM, see the AeroTab User’s Guide at NorESMhub: https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf

Specifically, this particular configuration of NorESM2 produces output which, by use of the post-processing script createaerocom-NorESM2.sh, can be reformatted to conform with the AeroCom standard: 

PM2.5 concentrations, accurate method (included in the look-up tables) 

::

"sconcpm25&PM25&ug m-3&S"   

::

and PM10 concentrations, approximate method (assuming no growth of large sizes)  

::

"sconcpm10[time,lat,lon]&PMTOT(:,:,:)-PS(:,:,:)/287.0f/TS(:,:,:)*1.e9f*(${F10DSTA3}*DST_A3(:,$LL,:,:)+${F10SSA3}*SS_A3(:,$LL,:,:))&ug m-3&S"

::

where	the mass fraction of DST_A3 for d>10 um (from AeroTab, assuming no growth)

::

F10DSTA3="0.23f"

::

anf the mass fraction of SS_A3 for d>10 um (from AeroTab, assuming no growth)

::

F10SSA3="0.008f"

::

PM1 is also produced by NorESM2, and can be added to the create-aerocom script. Mass concentrations for other intervals are not standard output, although AOD is taken out for diameters < 1 um and for > 1um. 

Concerning number and mass concentrations for various size intervals: Modified, aged (but dry) size distributions in AeroTab are fitted to lognormal size-distributions for use in cloud droplet activation, giving modal median radii R and standards deviations SIGMA, in addition to the modal number concentrations. From this, approximate mass and number concentrations for any (dry) size range can be calculated by integration over the given size range. A good example/template for this is the fortran code made for use in the PNSD (particle number size distribution) experiment for AeroCom, with the main program file pnsd.f (see link below). This has been used only with NorESM1.2/CAM5.3-Oslo data (the experiment was never followed through and published), and may need to be modified.  

Where is the example script which produces with AeroTab the tables necessary to postprocess diagnostics for eg  mass and number below a certain diameter?
^^^^

For general AeroCom use:
/components/cam/tools/aerocom/createaerocom-NorESM2.sh

For the PNSD experiment (number concentrations):
/components/cam/tools/aerocom3-PNSD_scripts-and-code/pnsd/

Where is the documentation for doing an EasyAerosol simulation? Compset, input, etc.
^^^^^

This will be described once the actual SpAer code has been tested and committed to the new model version (NorESM2.0.1), where each of the components exist on separate repositories.

What is needed to add a tracer to the NorESM2 model?
^^^^^

Øyvind, Dirk, or someone else who has experience with this?...

What is the hygroscopicity for different species in NorESM2, expressed as kappa?
^^^^^

The aerosol hygroscopicities in NorESM2/CAM6-Nor are the same as in NorESM1.2/CAM5.3-Oslo, and are as described by Kirkevåg et al. (2018) (https://www.geosci-model-dev.net/11/3945/2018/gmd-11-3945-2018.pdf), see Section 2.3. The Kohler equation applied (in AeroTab) is as expressed on pages 4 and 21 in https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-slides-updateJan2020.pdf, where the whole expression marked with an **x** on p. 21 is the sought **kappa** (here summed over all components for an internal mixture). The first NorESM reference is Kirkevåg and Iversen (2001) (https://agupubs.onlinelibrary.wiley.com/doi/pdf/10.1029/2001JD000886), but see also Ghan et al. (2001) (J. Geophys. Res., 106, 5295–5316, 2001) or Pruppacher and Klett, Microphysics of Clouds and Precipitation, 954 pp., Kluwer Acad., Norwell, Mass., 1997.

Is there enhancement of absorption due to organic coating of BC or Organic aerosols in NorESM2 (AeroTab6)?
^^^^^

Internal mixtures of OM or water with BC is taken into account in the optics calculations, but with the assumption that the mixture
for a certain size is homogeneous (but size-dependent). There is therefore no lensing effect,  since this requires a core-shell treatment (and a different, more advanced Mie code). More specifically, AeroTab calculates complex refractiv indices for an internal mixture of aerosol components based on the component specific refractive indices, where the method used is simple volume mixing for all components (including water) except BC. For mixing of BC with the rest, the Maxwell Garnett mixing rule is applied (see Kirkevåg et al., 2005:(https://www.researchgate.net/publication/265111344_Revised_schemes_for_aerosol_optical_parameters_and_cloud_condensation_nuclei_in_CCM-Oslo).

In NorESM1.2/CAM5.3-Oslo simulations for AeroCom's in-situ optics study, it was surprisingly little (almost no) absorption enhancement from increased hygroscopic swelling (for the arious prescribed RH values). There is probably quite little enhancement also for OM, although that is not so readily seen without doing special sensitivity tests (similar to optics the in-situ study, but with varying OM instead of water).  

Which types of AeroTab tables are read in when running NorESM2?
^^^^^

An overview of which AeroTab look-up tables (LUT) are used for the various model configurations is found in Sect. 5 of the AeroTab User's Guide at https://github.com/NorESMhub/NorESM/blob/noresm2/doc/configurations/AeroTab-user-guide_v16april2020.pdf. Also the nature and content of the LUT are described there. Not specifically mentioned there is that a specific set of LUT is only read in by the model for the configurations where they are actually used. 

How to invoke and activate the different levels of aerosol diagnostics in a NorESM model run?
^^^^^

In particular: **Which namelist arguments do what? Do they overlap, complement each other?**

This is covered here: https://noresm-docs.readthedocs.io/en/noresm2/output/aerosol_output.html#aerosol-output.
An exception is the namelist option "history_budget=.true.", which produces a budget for cloud water mass and number analysis, but has not been technically or scientifically tested in NorESM2. If still working, this should work as in earlier versions of NorESM, and is described at 
https://noresm-docs.readthedocs.io/en/noresm1/modeldiagnostics.html#cloud-water-mass-and-number-analysis-budgets.

