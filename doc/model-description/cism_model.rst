.. _cism_model:

The land ice model; CISM
========================
CISM is a thermomechanical ice sheet model that solves the equations of ice flow, given suitable approximations and boundary conditions. The source code is written primarily in Fortran 90 and 95. The model resides on the ESCOMP github repository (https://github.com/ESCOMP/cism), where it is under active development. CISM2.1 is currently the default ice sheet model in CESM2.0 and NorESM2 inherits much of the functionality and coupling infrastructure from there.

The CESM Land Ice Documentation and User Guide gives a detailed overview of this model component.
https://escomp.github.io/cism-docs/cism-in-cesm/versions/release-cesm2.0/html/index.html

CISM in NorESM2
================
We have recently started to develop and use CISM as a coupled component in NorESM2, which is work in progress. A number of coupled experiments have already been set up, but are still being analyzed and tested. We will update this documentation as the work towards a fully scientifically supported coupled climate - ice sheet configuration progresses and matures.   

References
^^^^^^^^^^
Lipscomb, W., R. Bindschadler, E. Bueler, D. Holland, J. Johnson, and S. Price, 2009: A community ice sheet model for sea level prediction, Eos Trans. AGU, 90, 23.

Lipscomb, W. H., Fyke, J. G., Vizcaíno, M., Sacks, W. J., Wolfe, J., Vertenstein, M., Craig, A., Kluzek, E., & Lawrence, D. M. (2013). Implementation and Initial Evaluation of the Glimmer Community Ice Sheet Model in the Community Earth System Model, Journal of Climate, 26(19), 7352-7371.
