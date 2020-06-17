.. _platforms:

Running on different platforms
======================================

HPC platforms
'''''''''''''

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
  
for the short queue. 

- 4. Add to the directives::

  <directive> --qos=devel</directive>

for the development queue and ::

  <directive> --qos=short</directive>

for the short queue option. 

**You need to make one config_batch setting for each queue option. You also need to add fram_devel and fram_short to config_machines.xml and config_compilers.xml** To do so, you just copy-paste the settings for fram and change the name *fram* to *fram_devel* and/or *fram_short* in the files config_machines.xml and config_compilers.xml. Hopefullt this will improve very soon, but the good thing is that you only need to do it once.

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
      <directive> --qos=devel</directive>
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
      <directive> --qos=short</directive>
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

Virtual Machine with Conda (@ https://www.nrec.no/ for example)
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This section describes how to install all the software environment (including compilers and libraries) needed to run CESM/NorESM on a Virtual Machine (like those available on the Norwegian Research and Education Cloud, the Google Cloud Platform, etc.), but a similar process allows to run the model(s) on a personal computer, laptop or desktop running **Centos7** (this distribution is convenient to use since it already contains most of the essential software packages).

The objective here is not to compete against HPCs in terms of sheer computing power, but to satisfy the everyday needs of the vast majority of CESM/NorESM developpers in terms of model development, debugging or testing, as well as for training/teaching purposes.

For this example we start with a completely empty machine with the Centos7 Linux Distribution, 16x Intel Core Processors (Haswell, no TSX), 128GB RAM, and a 100GiB volume (disk) attached on **/dev/sdb**.

The name of the user is **centos** (if your user name is different you will have to use your *username* instead).

The first step is to format the volume (if your disk is already formated and/or contains data, skip this step, but still create the **/opt/uio** folder since this is where the model(s) are configured to read/write).

::

  sudo mkfs.ext4 /dev/sdb

::

then mount it at /opt/uio

::

  sudo mkdir /opt/uio

  sudo chown -R centos /opt/uio

  sudo chgrp -R centos /opt/uio

  sudo mount /dev/sdb /opt/uio

  cd /opt/uio

::

and create the following folders:

::

  mkdir /opt/uio/inputdata

  mkdir /opt/uio/work

  mkdir /opt/uio/archive

  mkdir /opt/uio/archive/cases

::

Now we can install a few packages which will be needed later (to get the model(s), etc.) and miniconda (accept the terms of the license and accept the default location **/home/centos/miniconda3**, then answer yes to the question *"Do you wish the installer to initialize Miniconda3 by running conda init"*, exit the virtual machine and re-login).

::

  sudo yum install wget git subversion csh -y

  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

  bash Miniconda3-latest-Linux-x86_64.sh

  exit 

::

You will notice the next time you login the Virtual Machine that the prompt starts with *(base)* which indicates that you are in the base conda environment (since you accepted it during the miniconda install).

We recommend to create a new **esm** conda environment before adding the **bioconda** and **conda-forge** channels (in this order) and installing cesm

::

  conda create -n esm

  conda activate esm

  conda config --add channels bioconda

  conda config --add channels conda-forge

  conda install cesm=2.1.3 

::

The prompt should start with *(esm)* indicating that the esm conda environment has been activated, and every time you login you will have to type **conda activate esm** to be able to run the model(s).

This will have installed CESM2.1.3 as well as all the necessary compilers and libraries (HDF5, NetCDF, MKL, etc.) and their dependencies, and the very same environment can be used with NorESM.

In order to run the model(s) you still need configuration files (namely *config*, *config_machines.xml* and *config_compilers.xml*). These will eventually come with NorESM, but for the sake of convenience we provide hereafter an example of such files which have to be located in a **.cime** folder in your home directory (simply copy & past the content of the following cell to generate the files automatically and be carefull not to add any odd characters or lines since CESM/NorESM are extremely picky about it).

Notice that you only need to do this once, since both CESM and NorESM will use these configurations, and that the name of the machine created is **espresso**. 

::

  cd /home/centos

  mkdir .cime

  cd .cime

  cat >> config << EOF
  [main]
  CIME_MODEL=cesm
  EOF

  cat >> config_machines.xml << EOF
  <?xml version="1.0"?>
  <config_machines>
    <machine MACH="espresso">
      <DESC> Virtual Machine with 16 VCPUs and 128GiB memory
             OS is Centos7, Conda CESM environment
      </DESC>
      <NODENAME_REGEX>UNSET</NODENAME_REGEX>
      <OS>LINUX</OS>
      <PROXY>UNSET</PROXY>
      <COMPILERS>gnu</COMPILERS>
      <MPILIBS>mpich</MPILIBS>
      <SAVE_TIMING_DIR>UNSET</SAVE_TIMING_DIR>
      <CIME_OUTPUT_ROOT>/opt/uio/work</CIME_OUTPUT_ROOT>
      <DIN_LOC_ROOT>/opt/uio/inputdata</DIN_LOC_ROOT>
      <DIN_LOC_ROOT_CLMFORC>UNSET</DIN_LOC_ROOT_CLMFORC>
      <DOUT_S_ROOT>/opt/uio/archive/$CASE</DOUT_S_ROOT>
      <BASELINE_ROOT>UNSET</BASELINE_ROOT>
      <CCSM_CPRNC>UNSET</CCSM_CPRNC>
      <GMAKE_J>16</GMAKE_J>
      <BATCH_SYSTEM>none</BATCH_SYSTEM>
      <SUPPORTED_BY>noresmCommunity</SUPPORTED_BY>
      <MAX_TASKS_PER_NODE>16</MAX_TASKS_PER_NODE>
      <MAX_MPITASKS_PER_NODE>16</MAX_MPITASKS_PER_NODE>
      <PROJECT_REQUIRED>FALSE</PROJECT_REQUIRED>
      <mpirun mpilib="default">
        <executable>mpiexec</executable>
        <arguments>
          <arg name="anum_tasks"> -np \$TOTALPES</arg>
        </arguments>
      </mpirun>
      <module_system type="none"/>
      <environment_variables>
        <env name="KMP_STACKSIZE">64M</env>
      </environment_variables>
      <resource_limits>
        <resource name="RLIMIT_STACK">-1</resource>
      </resource_limits>
    </machine>
  </config_machines>
  EOF

  cat >> config_compilers.xml << EOF
  <?xml version="1.0"?>
  <config_compilers version="2.0">
    <compiler MACH="espresso">
      <LD>mpifort</LD>
      <AR>x86_64-conda_cos6-linux-gnu-ar</AR>
      <SFC>x86_64-conda_cos6-linux-gnu-gfortran</SFC>
      <SCC>x86_64-conda_cos6-linux-gnu-cc</SCC>
      <SCXX>x86_64-conda_cos6-linux-gnu-c++</SCXX>
      <MPIFC>mpifort</MPIFC>
      <MPICC>mpicc</MPICC>
      <MPICXX>mpicxx</MPICXX>
      <NETCDF_PATH>/home/centos/miniconda3/envs/esm</NETCDF_PATH>
      <FFLAGS>
        <append DEBUG="FALSE"> -O2 </append>
        <append MODEL="blom"> -fdefault-real-8 </append>
        <append MODEL="cam"> -finit-local-zero </append>
      </FFLAGS>
      <SLIBS>
        <append> -L\$(NETCDF_PATH)/lib -lnetcdff -lnetcdf -ldl </append>
        <append> -lmkl_gf_lp64 -lmkl_gnu_thread -lmkl_core -lomp -lpthread -lm </append>
      </SLIBS>
    </compiler>
  </config_compilers>
  EOF

::

To create a new CESM case F2000climo at resolution f19_g17 and run it for **1 day**, and because (for CESM only) *create_newcase* has been added to the *PATH*, simply type (from anywhere on the machine):

::

  create_newcase --case /opt/uio/archive/cases/conda_CESM213_F2000climo_f19_g17 --compset F2000climo --res f19_g17 --machine espresso --run-unsupported

  cd /opt/uio/archive/cases/conda_CESM213_F2000climo_f19_g17

  NUMNODES=-1

  ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES}

  ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1

  ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0

  ./xmlchange STOP_N=1

  ./xmlchange STOP_OPTION=ndays

  ./case.setup

  ./case.build

  ./case.submit

::

Hopefully this should create the case, configure it, compile it (for this particular machine the compilation time is less then 3 minutes) and run it (starting with the download of the necessary input files the first time you run it).

For NorESM, first clone the github repository, here in /opt/uio/**noresm2**, as follows (be careful: you have to be in the **(base)** conda environment for that):

::

  cd /opt/uio

  git clone -b noresm2 https://github.com/NorESMhub/NorESM.git noresm2

  cd noresm2/

  sed -i.bak "s/'checkout'/'checkout', '--trust-server-cert'/" ./manage_externals/manic/repository_svn.py
 
  ./manage_externals/checkout_externals -v 

::

To create a "similar" NorESM case NF2000climo at resolution f19_tn14 and also run it for **1 day**, and after having activated the **(esm)** environment (if you are not already in it), do:

::

  cd /opt/uio/noresm2/cime/scripts

  ./create_newcase --case /opt/uio/archive/cases/conda_NorESM_NF2000climo_f19_tn14 --compset NF2000climo --res f19_tn14 --machine espresso --run-unsupported

  cd /opt/uio/archive/cases/conda_NorESM_NF2000climo_f19_tn14

  NUMNODES=-1

  ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES}

  ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1

  ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0

  ./xmlchange STOP_N=1

  ./xmlchange STOP_OPTION=ndays

  ./case.setup

  ./case.build

  ./case.submit

::

On our machine the compilation takes less then 3 minutes, and if everything went well the input files should download automatically before the run starts.

Note: AeroTab is supposed to be a folder, if a file has been created instead simply add a "trailing slash" (/) at line 1946 in components/cam/bld/namelist_files/namelist_defaults_cam.xml (which has to be written as: <aerotab_table_dir>noresm-only/atm/cam/camoslo/AeroTab_8jun17/</aerotab_table_dir>) and resubmit.

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
       <append MODEL="blom"> -r8 </append>
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
      <append MODEL="blom"> -r8 </append>
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
 
 
 
 
 
 
