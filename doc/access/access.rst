.. _access:

Downloading NorESM2
====================

.. toctree::
   :maxdepth: 2
   :numbered:

   download_code.rst
   download_input.rst
  

Downloading NorESM2 model code
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The NorESM2 model code is available through a  public GitHUB repository: 
https://github.com/NorESMhub/NorESM

You need access to a git command line client on the machine where NorESM2 is build and run. To download the code, make a clone of the NorESM2 repository

::
  
  git clone https://github.com/NorESMhub/NorESM.git <noresm-base> 
  
::


instead of <noresm-base>, you can use the directory name you like. The <noresm-base> folder contains the latest version of the released code. 

::

   cd <noresm-base>

::

To use a previous version of the code, you can checkout a specific tag or a branch

* if you want a specific tag


::

  git tag --list                   [gives you all the possible tags]
  git checkout release-noresm2.0.1 [e.g, you checkout now the "release-noresm2.0.1" tag]


:: 

or  

* if you want a specific branch


::

   git branch --all                       [gives you all the possible branches]
   git checkout -b noresm2 origin/noresm2 [e.g, you checkout the "noresm2" branch]
 
::

Then you need to launch the download

:: 

   ./manage_externals/checkout_externals  [this will take one to a few minutes ...]

::

If you run into several SVN-related errors when launching the model, you may want to try to change required=True to required=False for pop2 and ww3 in Externals.cfg. POP2 and WW3 are not needed in NorESM2. Then try again.

To confirm a successful download of all components, you can run checkout_externals with the status flag -S to show the status of the externals or --logging to get a log of reported errors (if any):

::

  ./manage_externals/checkout_externals -S             [-S shows status of externals]
  ./manage_externals/checkout_externals --loggong      [write log of errors in manage_externals.log]

::


The checkout_externals script will read the configuration file called Externals.cfg and will download all the external component models and CIME into /path/to/<noresm-base>.

Now you have a complete copy of the NorESM code in the directory <noresm-base>.  There you can co go in the subdirectory cime/scripts and start creating a case :ref:`experiments`.


Downloading input data
^^^^^^^^^^^^^^^^^^^^^^

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

