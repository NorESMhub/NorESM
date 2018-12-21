.. _newbie:

Newbies guide to running NorESM
================================                               

The purpose of this page is to be able to set up and run the model
within 15 minutes. For more advanced configuration, please consult
http://www.cesm.ucar.edu/models/ccsm4.0/ccsm_doc/ug.pdf

This guide assumes that you have properly checked out the model to some
directory which will call $NORESM. This directory will contain
subdirectories "models" and "scripts".

Go to scripts directory
~~~~~~~~~~~~~~~~~~~~~~~

::

  cd $NORESM/scripts

Create the case
~~~~~~~~~~~~~~~

:: 

  ./create_newcase -case ../cases/casename/ -mach machinename -res f19_g16 -compset compsetname

(where casename, machinename and compsetname are user input.
Res is imodel resolution. The user can *not* give any resolution since
input data are not prepared for any resolution in NorESM.)

To see a list of available composets type

::

  ./create_newcase -list

The simplest case which runs production tagged aerosols and data ocean
in a VERY coarse resolution is

::

  ./create_newcase -case /path/to/where/I/store/the/case -compset NFPTAERO -mach hexagon -res f10_f10

Configure the case
~~~~~~~~~~~~~~~~~~

:: 

  cd $NORESM/cases/casename

edit any configuration files (understand env_conf.xml and env_run.xml)

:: 

  ./configure -case (in NorESM1 / CAM4)

or

::

  ./cesm_setup (in NorESM2 / CAM5)

After these two commands, the case is configured

Build the case
~~~~~~~~~~~~~~

::

  ./casename.machinename.build (NorESM1 / CAM4)

  ./casename.build (NorESM2 / CAM5)

Run the case
~~~~~~~~~~~~

::

  qsub casename.machinename.run

Example
~~~~~~~


There are already several pre-defined compsets. They all have long and
short names. As and example we can use the compset N_2000_AEROSLO_CN
(with short name N2000AERCN). Thus a valid command on the machine
*hexagon* is:

::

  ./create_newcase -case /path/to/my/case/directory/ -mach hexagon -res f19_g16 -compset N2000AERCN

(will run a "year 2000" CAM4/NorESM1 case with the Oslo-aerosols)

:: 

  ./create_newcase -case /path/to/my/case/directory/ -mach hexagon -res f19_g16 -compset FAMIPC5

(will configure the "default" atmoshere-only simulation of CAM5)

Important files
~~~~~~~~~~~~~~~

The most important files to understand in your case-directory are:


- env_run.xml (model run type, how long time to run etc)

- env_conf.xml (model configuration)

More information
~~~~~~~~~~~~~~~~

Go to :ref:`advanced` for
more information
