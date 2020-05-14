.. _platforms:

Running on different platforms
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

Create a new case: ::

    ./create_newcase –case ../../../cases/<casename> --mach fram –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  

Queue options on Fram
------------------------
On fram there are different queues for testing and development experiments (usually short runs on few nodes) and longer experiments. If you want to run simulations using different queue options than *normal*, you can add new machine options to   <noresm-base>/cime/config/cesm/machines/config_batch.xml. Method (we are currently working on an improvment of this):

- 1. Copy the settings for Fram :
::

   <batch_system MACH="fram" type="slurm">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="-p" name="$JOB_QUEUE"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <directives> 
      <directive> --ntasks={{ total_tasks }}</directive>
      <directive> --export=ALL</directive>
      <directive> --switches=1</directive>
    </directives>
    <queues>
      <queue walltimemax="00:59:00" nodemin="1" nodemax="288" default="true">normal</queue>
    </queues>
  </batch_system>

:: '

- 2. Change "fram" to "fram_devel" or "fram_short"
 
- 3. Change the line

::

    <queue walltimemax="00:59:00" nodemin="1" nodemax="288" default="true">normal</queue>
    
::

to::
 
  <queue walltimemax="00:30:00" nodemin="1" nodemax="4" default="true">devel</queue>

for the development queue and ::

  <queue walltimemax="02:00:00" nodemin="1" nodemax="10" default="true">short</queue>
  
for the short queue. **You need to make one config_batch setting for each queue option. You also need to add fram_devel and fram_short to config_machines.xml and config_compilers.xml** To do so, you just copy-paste the settings for fram and change the name *fram* to *fram_devel* and/or *fram_short*. Hopefullt this will improve very soon, but the good thing is that you only need to do it once.
The resulting <noresm-base>/cime/config/cesm/machines/config_batch.xml. file:

::


  <batch_system MACH="fram" type="slurm">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="-p" name="$JOB_QUEUE"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <directives> 
      <directive> --ntasks={{ total_tasks }}</directive>
      <directive> --export=ALL</directive>
      <directive> --switches=1</directive>
    </directives>
    <queues>
      <queue walltimemax="00:59:00" nodemin="1" nodemax="288" default="true">normal</queue>
    </queues>
  </batch_system>

  <batch_system MACH="fram_devel" type="slurm">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="-p" name="$JOB_QUEUE"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <directives> 
      <directive> --ntasks={{ total_tasks }}</directive>
      <directive> --export=ALL</directive>
      <directive> --switches=1</directive>
    </directives>
    <queues>
      <queue walltimemax="00:30:00" nodemin="1" nodemax="4" default="true">devel</queue>
    </queues>
  </batch_system>

  <batch_system MACH="fram_short" type="slurm">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="-p" name="$JOB_QUEUE"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <directives> 
      <directive> --ntasks={{ total_tasks }}</directive>
      <directive> --export=ALL</directive>
      <directive> --switches=1</directive>
    </directives>
    <queues>
      <queue walltimemax="02:00:00" nodemin="1" nodemax="10" default="true">short</queue>
    </queues>
  </batch_system>

::

   

After, you can use the new machine settings when creating a new case: For the development queue:::

    ./create_newcase –case ../../../cases/<casename> --mach fram_devel –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  
    
and for the short queue::

       ./create_newcase –case ../../../cases/<casename> --mach fram_short –-res <resolution> --compset <compset_name> --project <project_name> --user-mods-dir <user_mods_dir> --run-unsupported  

| For a detailed guide on how to set up, submit and choosing the right job see: 
| https://documentation.sigma2.no/jobs/submitting.html  
| https://documentation.sigma2.no/jobs/choosing_job_types.html  
| 

Nebula @ NSC
^^^^^^^^^^^^
Configuration files for running NorESM2 on Nebula are distributed in the release tags release-noresm2* and in the noresm2 origin/noresm2 branch. If Nebula configurations are missing in your copy of the model, the files can be found in the following folder on Nebula:

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

on Fram:

::

  <batch_system MACH="fram" type="slurm">
    <batch_submit>sbatch</batch_submit>
    <submit_args>
      <arg flag="--time" name="$JOB_WALLCLOCK_TIME"/>
      <arg flag="-p" name="$JOB_QUEUE"/>
      <arg flag="--account" name="$PROJECT"/>
    </submit_args>
    <directives>
      <directive> --ntasks={{ total_tasks }}</directive>
      <directive> --export=ALL</directive>
      <directive> --switches=1</directive>
    </directives>
    <queues>
      <queue walltimemax="00:59:00" nodemin="1" nodemax="288" default="true">normal</queue>
    </queues>
  </batch_system>

::


On Tetralith:

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

On Fram:

::

   <compiler MACH="fram">
     <CPPDEFS>
       <append> -D$(OS) </append>
     </CPPDEFS>
     <FFLAGS>
       <append> -xCORE-AVX2 -no-fma </append>
     </FFLAGS>
     <NETCDF_PATH>$(EBROOTNETCDFMINFORTRAN)</NETCDF_PATH>
     <PNETCDF_PATH>$(EBROOTPNETCDF)</PNETCDF_PATH>
     <MPI_PATH>$(MPI_ROOT)</MPI_PATH>
     <MPI_LIB_NAME>mpi</MPI_LIB_NAME>
     <FFLAGS>
       <append DEBUG="FALSE"> -O2 </append>
       <append MODEL="micom"> -r8 </append>
       <append MODEL="cam"> -init=zero,arrays </append>
     </FFLAGS>
     <MPICC> mpiicc </MPICC>
     <MPICXX> mpiicpc </MPICXX>
     <MPIFC> mpiifort </MPIFC>
     <PIO_FILESYSTEM_HINTS>lustre</PIO_FILESYSTEM_HINTS>
     <SLIBS>
       <append>-mkl=sequential -lnetcdff -lnetcdf</append>
     </SLIBS>
  </compiler>

::

On Tetralith:

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

On Fram:

::

  <machine MACH="fram">
    <DESC>Lenovo NeXtScale M5, 32-way nodes, dual 16-core Xeon E5-2683@2.10GHz, 64 GiB per node, os is Linux, batch system       is SLURM</DESC>
    <OS>LINUX</OS>
    <COMPILERS>intel</COMPILERS>
    <MPILIBS>impi</MPILIBS>
    <CIME_OUTPUT_ROOT>/cluster/work/users/$USER/noresm</CIME_OUTPUT_ROOT>
    <DIN_LOC_ROOT>/cluster/shared/noresm/inputdata</DIN_LOC_ROOT>
    <DIN_LOC_ROOT_CLMFORC>UNSET</DIN_LOC_ROOT_CLMFORC>
    <DOUT_S_ROOT>/cluster/work/users/$USER/archive/$CASE</DOUT_S_ROOT>
    <DOUT_L_ROOT>/projects/NS2345K/noresm/cases</DOUT_L_ROOT>
    <DOUT_L_HOSTNAME>login.nird.sigma2.no</DOUT_L_HOSTNAME>
    <!--DOUT_L_MSROOT>UNSET</DOUT_L_MSROOT-->
    <BASELINE_ROOT>UNSET</BASELINE_ROOT>
    <CCSM_CPRNC>UNSET</CCSM_CPRNC>
    <GMAKE_J>8</GMAKE_J>
    <BATCH_SYSTEM>slurm</BATCH_SYSTEM>
    <SUPPORTED_BY>noresmCommunity</SUPPORTED_BY>
    <MAX_TASKS_PER_NODE>32</MAX_TASKS_PER_NODE>
    <MAX_MPITASKS_PER_NODE>32</MAX_MPITASKS_PER_NODE>
    <PROJECT_REQUIRED>TRUE</PROJECT_REQUIRED>
    <mpirun mpilib="mpi-serial">
      <executable></executable>
    </mpirun>
    <mpirun mpilib="default">
      <executable>mpirun</executable>
    </mpirun>
    <module_system type="module">
      <init_path lang="perl">/cluster/software/lmod/lmod/init/perl</init_path>
      <init_path lang="python">/cluster/software/lmod/lmod/init/env_modules_python.py</init_path>
      <init_path lang="csh">/cluster/software/lmod/lmod/init/csh</init_path>
      <init_path lang="sh">/cluster/software/lmod/lmod/init/sh</init_path>
      <cmd_path lang="perl">/cluster/software/lmod/lmod/libexec/lmod perl</cmd_path>
      <cmd_path lang="python">/cluster/software/lmod/lmod/libexec/lmod python</cmd_path>
      <cmd_path lang="sh">module</cmd_path>
      <cmd_path lang="csh">module</cmd_path>
      <modules>
        <command name="purge">--force</command>
        <command name="load">StdEnv</command>
        <!-- djlo Deactivated THT settings -->
        <!--command name="load">intel/2016a</command-->
        <!--command name="load">netCDF-Fortran/4.4.3-intel-2016a</command-->
        <!--command name="load">PnetCDF/1.8.1-intel-2016a</command-->
        <!--command name="load">CMake/3.5.2-intel-2016a</command-->
        <command name="load">intel/2018a</command>
        <command name="load">netCDF-Fortran/4.4.4-intel-2018a-HDF5-1.8.19</command>
        <command name="load">PnetCDF/1.8.1-intel-2018a</command>
        <command name="load">CMake/3.9.1</command>
      </modules>
    </module_system>
    <environment_variables>
      <env name="KMP_STACKSIZE">64M</env>
      <env name="I_MPI_EXTRA_FILESYSTEM_LIST">lustre</env>
      <env name="I_MPI_EXTRA_FILESYSTEM">on</env>
    </environment_variables>
    <resource_limits>
      <resource name="RLIMIT_STACK">-1</resource>
    </resource_limits>
  </machine>

::

On Tetralith:

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
 
 
 
 
 
 
