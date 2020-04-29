.. _platforms:

Running NorESM2 on different platforms
======================================

Platforms
'''''''''

Below is a list of platforms where NorESM2 has been installed, including platform specific intructions. 

<noresm-base>: the name of the folder where the model code has been downloaded (cloned from git)

Vilje @ Sigma2
^^^^^^^^^^^^^^
Configuration files for running NorESM2 on Vilje are distributed in all branches of the noresm code.

Input data is stored in /work/shared/noresm/inputdata/

Apply for membership in NorESM shared data storage (manager: mben@norceresearch.no) for access to the folder.

The run and archive directories are stored in /work/<user_name>/

Before configuring and compiling the model, add  this code

::

      module ()
     {
        eval `/usr/bin/modulecmd bash $*`
     }
     module load intelcomp/15.0.1 mpt/2.10 python/2.7.9 netcdf/4.3.2
     export PATH=$PATH:/opt/pbs/default/bin/

::


to your .bashrc

::

    cd
    vi .bashrc

::

Create a new case:

::

    ./create_newcase –case ../../../cases/<casename> --mach vilje –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  

::

Fram @ Sigma2
^^^^^^^^^^^^^
Configuration files for running NorESM2 on Fram are distributed in all branches of the noresm code.

Input data is stored in /cluster/shared/noresm/inputdata/

Apply for membership in NorESM shared data storage (manager: mben@norceresearch.no) for access to the folder.

The run and archive directories are stored /cluster/work/users/<user_name>/

Create a new case:

::

    ./create_newcase –case ../../../cases/<casename> --mach fram –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  

::

Nebula @ NSC
^^^^^^^^^^^^
Configuration files for running NorESM2 on Nebula are distributed in the featureCESM2.1.0-OsloDevelopment branch. If Nebula configurations are missing in your copy of the model the files can be found in the following folder on Nebula:

::

/nobackup/forsk/noresm/nebula_config_noresm2/
    
::

Apply for membership in NorESM shared data storage (manager: adag@met.no) for access to the folder.

Copy the files in the above folder to:

::

    cd <noresm-base>/cime/config/cesm/machines/
    cp /nobackup/forsk/noresm/nebula_config_noresm2/* .

::

Input data is stored in /nobackup/forsk/noresm/inputdata/

The run and archive directories are stored /nobackup/forsk/<user_name>/

Before configuring and compiling the model, add export LMOD_QUIET=1 to your .bashrc

::

    cd
    vi .bashrc

::

Create a new case:

::

    ./create_newcase –case ../../../cases/<casename> --mach nebula –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  

::


Tetralith @ NSC
^^^^^^^^^^^^^^^

Configuration files for running NorESM2 on Tetralith are distributed in the featureCESM2.1.0-OsloDevelopment branch. If Tetralith configurations are missing in your copy of the model the files can be found in the following folder on Tetralith:

::

/proj/cesm_input-data/tetralith_config_noresm2
    
::

Apply for membership in CESM climate model shared data storage (SNIC 2019/32-10) for access to the folder.

Copy the files in the above folder to:

::

    cd <noresm-base>/cime/config/cesm/machines/
    cp /proj/cesm_input-data/tetralith_config_noresm2/* .

::

Input data is stored /proj/cesm_input-data/ 

Before configuring and compiling the model, clear your environment and load the following modules:


::

  module purge 
  module load buildenv-intel/2018.u1-bare 
  module load netCDF/4.4.1.1-HDF5-1.8.19-nsc1-intel-2018a-eb 
  module load HDF5/1.8.19-nsc1-intel-2018a-eb 
  module load PnetCDF/1.8.1-nsc1-intel-2018a-eb

::

Create a new case:

::

./create_newcase –case ../../../cases/<casename> -mach triolith –res <resolution> -compset <compset_name> -pecount M -ccsm_out <NorESM_ouput_folder>

::

Adding a new platform
'''''''''''''''''''''

Edit the following files:

::

  config_batch.xml  
  config_compilers.xml  
  config_machines.xml

::  

located in

::

<noresm-base>/cime/config/cesm/machines/

::

config_batch.xml
^^^^^^^^^^^^^^^^

Add a batch_system entry in this file for your platform with appropriate settings. See examples below.

Machine example with SLURM batch system

::

  <batch_system type="slurm" MACH="tetralith">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <queues>
      <queue walltimemax="168:00:00" nodemin="1" default="true">default</queue>
      <queue walltimemax="01:00:00" nodemin="1" nodemax="4" >development</queue>
    </queues>
  </batch_system>

::

Machine example with PBS batch system

::

  <batch_system MACH="vilje" type="pbs">
    <submit_args>
      <arg flag="-N cesmRun"/>
    </submit_args>
    <directives>
      <directive>-A nn2345k</directive>
      <directive>-l select={{ num_nodes }}:ncpus={{ MAX_TASKS_PER_NODE }}:mpiprocs={{ tasks_per_node }}:ompthreads={{ thread_count }}</directive>
    </directives>
    <queues>
      <queue walltimemax="00:59:00" nodemin="1" nodemax="9999" default="true">workq</queue>
    </queues>
    <!--walltimes>
                            <walltime default="true">00:59:00</walltime>
    </walltimes-->
  </batch_system>

::

config_compilers.xml
^^^^^^^^^^^^^^^^^^^^
 
Add a compiler entry in this file for your platform with appropriate settings. See examples below.
 
::
 
   <compiler MACH="tetralith" COMPILER="intel">
    <MPICC> mpiicc  </MPICC>
    <MPICXX> mpiicpc </MPICXX>
    <MPIFC> mpiifort </MPIFC>
    <PNETCDF_PATH>$ENV{PNETCDF_DIR}</PNETCDF_PATH>
    <NETCDF_PATH>$ENV{NETCDF_DIR}</NETCDF_PATH>
    <SLIBS>
      <append>-L$(NETCDF_PATH)/lib -lnetcdf -lnetcdff</append>
    </SLIBS>
    <FFLAGS>
      <append> -xHost -fPIC -mcmodel=large </append>
    </FFLAGS>
    <FFLAGS>
      <append DEBUG="FALSE"> -O0 -xAVX </append>
      <append MODEL="micom"> -r8 </append>
    </FFLAGS>
    <CFLAGS>
      <append> -xHost -fPIC -mcmodel=large </append>
    </CFLAGS>
    <LDFLAGS>
      <append> -mkl </append>
    </LDFLAGS>
  </compiler>
 
::
 
 

config_machines.xml
^^^^^^^^^^^^^^^^^^^
 
Add a machine entry in this file for your platform with appropriate settings. See examples below.
 
::
 
   <machine MACH="tetralith">
    <DESC>Tetralith Linux Cluster (NSC, Sweden), 32 pes/node, batch system SLURM</DESC>
    <OS>LINUX</OS>
    <COMPILERS>intel</COMPILERS>
    <MPILIBS>impi</MPILIBS>
    <PROJECT>snic2019-1-2</PROJECT>
    <CHARGE_ACCOUNT>bolinc</CHARGE_ACCOUNT>
    <CIME_OUTPUT_ROOT>/proj/$CHARGE_ACCOUNT/users/$ENV{USER}/noresm2</CIME_OUTPUT_ROOT>
    <DIN_LOC_ROOT>/proj/cesm_input-data/inputdata/</DIN_LOC_ROOT>
    <DIN_LOC_ROOT_CLMFORC>/proj/cesm_input-data/inputdata/atm/datm7</DIN_LOC_ROOT_CLMFORC>
    <DOUT_S_ROOT>$CIME_OUTPUT_ROOT/cesm_archive/$CASE</DOUT_S_ROOT>
    <BASELINE_ROOT>$CIME_OUTPUT_ROOT/cesm_baselines</BASELINE_ROOT>
    <CCSM_CPRNC>/$CIME_OUTPUT_ROOT/cesm_tools/cprnc/cprnc</CCSM_CPRNC>
    <GMAKE_J>4</GMAKE_J>
    <BATCH_SYSTEM>slurm</BATCH_SYSTEM>
    <SUPPORTED_BY>snic</SUPPORTED_BY>
    <MAX_TASKS_PER_NODE>32</MAX_TASKS_PER_NODE>
    <MAX_MPITASKS_PER_NODE>32</MAX_MPITASKS_PER_NODE>
    <PROJECT_REQUIRED>TRUE</PROJECT_REQUIRED>
    <mpirun mpilib="default">
      <executable>mpprun</executable>
    </mpirun>
    <module_system type="none">
    </module_system>
  </machine>
 
::
 
 
 
 
 
 
