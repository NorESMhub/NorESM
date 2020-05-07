.. _download_input:

Downloading input data
======================

Input datasets are needed to run the model. We don't recommend downloading the entire dataset because of the size (~TB). and since the input data sets needed for a specific case and configuration will be automatically downloaded when you build the case. We also recommend to only have one input directory on a machine which is shared for all users. 

The input data needs to be stored in a local directory on the machine the model is build and run. The path to the local directory is set in <noresm-base>/cime/config/cesm/machines/config_machines.xml

::

  <DIN_LOC_ROOT>/cluster/shared/noresm/inputdata</DIN_LOC_ROOT>
  
::


Make sure that the input data files are write-protected. 


NorESM specific inputdata
^^^^^^^^^^^^^^^^^^^^^^^^^

PLEASE ADD


The recipe to download the complete NorESM2 code is based on how it is done for CESM. For more details please see
https://escomp.github.io/CESM/release-cesm2/downloading_cesm.html

