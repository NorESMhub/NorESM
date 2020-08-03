.. _download_input:

Downloading inputdata
======================

Input datasets are needed to run the model. We don't recommend downloading the entire dataset because of the size (~1TB).
Input datasets needed for a specific case and configuration will be automatically downloaded when a user submits a case. 
We recommend to only have one input directory on a machine which is shared for all users. 

The input data needs to be stored in a local directory on the machine the model is build and run. The path to the local
directory is set in <noresm-base>/cime/config/cesm/machines/config_machines.xml

::

  <DIN_LOC_ROOT>/cluster/shared/noresm/inputdata</DIN_LOC_ROOT>
  
::

The main download location for input data is https://noresm.org/inputdata/ from where the downloading request 
might be redirected to another location.


NorESM specific inputdata
^^^^^^^^^^^^^^^^^^^^^^^^^

WILL BE UPDATED BY adag@met.no
The recipe to download the complete NorESM2 code is based on how it is done for CESM. For more details please see
https://escomp.github.io/CESM/release-cesm2/downloading_cesm.html

The input data sets are downloaded from multiple servers. The servers and download protocols used are listed in ::

<noresm-base>/cime/config/cesm/config_inputdata.xml


SVN problems during downloading 
^^^^^^

If the user encounter problems using svn, e.g. that the CESM2 files from ucar.edu are not downloaded automatically when submitting a case, there are several workarounds:

- 1. On some machines you need to first download one file to permanently add the certificate. If the certificate is not issued by a trusted authority, you need to use the fingerprint to validate the certificate manually. This is done by explicit download one file with svn such that the user can choose "(p) permanently" to add the certificate.  One example file: 
::
   
   svn export https://svn-ccsm-inputdata.cgd.ucar.edu/trunk/inputdata/atm/waccm/lb/LBC_1750-2014_CMIP6_0p5degLat_c170126.nc

::

or

- 2. Put the CESM2 inputdata (with svn protocol) before the noresm.org in cime/config/cesm/config_inputdata.xml, then the downloading happens in one go.

or

- 3. In the case folder, run `./check_inputdata --download` twice 

or

- 4. Submit the case twice i.e run  `./case.submit`
