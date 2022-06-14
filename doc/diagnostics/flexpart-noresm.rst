****************************
FLEXPART NORESM
****************************

Introduction
============

FLEXPART (“FLEXible PARTicle dispersion model”) is a Lagrangian transport and dispersion model suitable for the simulation of a large range of atmospheric transport processes. Apart from transport and turbulent diffusion, it is able to simulate dry and wet deposition, decay, linear chemistry; it can be used in forward or backward mode, with defined sources or in a domain-filling setting. It can be used from local to global scale. A version of FLEXPART for use with the Norwegian Earth System Model (NorESM1-M) has been created in 2016 and since than it has been updated with the current parametrizations used in the newest FLEXPART version, as well as compatibility to run with NorESM2.

The offline FLEXible PARTicle (FLEXPART) stochastic dispersion model is currently a community model used by many scientists. The transport of pollutants, but also pysichal properties (e.g. moisture) is the main application. It provides an advanced tool to directly analyse and diagnose atmospheric transport properties of the state-of-the-art climate model NorESM in a reliable way. Extensive evaluation confirmed the effectiveness of the combined modelling system FLEXPART with NorESM in producing realistic transport statistics.

The documentation of FLEXPART-NORESM has been published in GMD and can be found here:
assiani, M., Stohl, A., Olivié, D., Seland, Ø., Bethke, I., Pisso, I., and Iversen, T.: The offline Lagrangian particle model FLEXPART–NorESM/CAM (v1): model description and comparisons with the online NorESM transport scheme and with the reference FLEXPART model, Geosci. Model Dev., 9, 4029–4048, ​https://doi.org/10.5194/gmd-9-4029-2016, 2016. 


Installation
============

The source codes of the FLEXPART-NorESM are developed and maintained on the git.nilu.no:

git clone https://git.nilu.no/flexpart/flexpart-noresm.git

Examples
============

Based on CMIP6 simulations from NorESM2 backward calculations for a BC tracer has been established, the results can be viewd here:
https://niflheim.nilu.no/SabinePY/INES.py
