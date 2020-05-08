.. _lnd_model:

The land model
===================

The NorESM2 land model is **CLM5** (Lawrence et al., 2019) with one minor modification (Seland et al., 2020 in review for GMD). This specific modification was made to the surface water treatment in CLM. The surface water pool is a new feature replacing the wetland land unit in earlier versions of CLM (introduced in CLM4.5). This water pool does not have a frozen state, but is added to the snow-pack when frozen. To avoid water being looped between surface water and snow during alternating cold and warm periods, we remove infiltration excess water as runoff if the temperature of the surface water pool is below freezing. This was done to mitigate a positive snow bias and an artificial snow depth increase found in some Arctic locations during melting conditions.

In the NorESM/CTSM repository, the master branch is forked from ECOMP/CTSM, which is the CLM version used in the CESM2, while the branch release-clm5.0.14-Nor (based on the CLM version 5.0.14) stores the CLM version used in the NorESM with the modification above. 


References
^^^^^^^^^^

Lawrence, D. M., Fisher, R. A., Koven,C. D., Oleson, K. W., Swenson, S. C.,Bonan, G., et al. (2019). TheCommunity Land Model version 5:Description of new features,benchmarking, and impact of forcinguncertainty. Journal of Advances inModeling Earth Systems,https://doi.org/10.1029/2018MS001583
