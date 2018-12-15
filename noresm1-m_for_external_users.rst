.. _noresm1-m_for_external_users:

NorESM1-M for external users
=============================                            

--------------

Access
''''''

To request model access, please send a request to //noresm-ncc@met.no//
with some background information on how you plan to use the model.

--------------

Installing
''''''''''

Untar //NorESM1-M_sourceCode_vXXX.tar.zg// in your home directory. This
will install the model source code in the folder //$HOME/NorESM1-M//.

Untar //NorESM1-M_inputdata_vXXX.tar.zg// to a folder that is available
during run-time and has at least 70 GB of free space. This will create a
sub-folder inputdata and install NorESM's forcing data and other
boundary conditions to it.

Untar //NorESM1-M_initialPiHist1_vXXX.tar.zg// to a folder that is
available during run-time and has at least 2 GB of free space. This will
install restart conditions for the CMIP5 PiControl and first member of
historical experiment.

--------------

Porting
'''''''

Machine name and characteristics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Define the characteristics of your HPC system in
//NorESM1-M/scripts/ccsm_utils/Machines/config_machines.xml//.

Edit following section:

Set //MACH// to an acronym/name tag of your choice of your HPC system.
Update //DESC// correspondingly.

Set //EXEROOT// to the root location where the model should create the
build and run-directories. The model will replace //$CCSMUSER// with
your unix user and //$CASE// with the specific case name
(=simulation/experiment name).

Set //DIN_LOC_ROOT_CSMDATA// to the location where you installed the
forcing and boundary condition data (this path should end with
"/inputdata").

Set //DOUT_S_ROOT// to the root location for the short-term archiving
(normally on the work disk area of the HPC system).

Optionally, set //DOUT_L_MSROOT// to the root location for the long-term
archiving (normally a location that is not subject to automatic
deletion). Leave unchanged if you don't plan to use automatic long-term
archiving (e.g., if you want to move the data manually).

Optionally, set //DOUT_L_MSHOST// to the name of the (remote)-server for
long-term archiving. Leave unchanged if you don't plan to use automatic
long-term archiving

Set //BATCHSUBMIT// to the submit command on your HPC system.

Set //GMAKE_J// to the number of make instances run in parallel when
building the system. Set to 1 if licence or memory issues occur.

Set //MAX_TASKS_PER_NODE// to the maximum number of MPI tasks that can
run on a single node on your HPC system (usually the same as the number
of cores per node).

CPU configurations
^^^^^^^^^^^^^^^^^^

Define NorESM1-M CPU-configurations for your HPC system in
//NorESM1-M/scripts/ccsm_utils/Machines/config_pes.xml//.

As a start, we recommend to simply replace all instances of //vilje//
with your choice for //MACH// (i.e. the name tag of your machine).

Building and runtime options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Copy //env_machopts.vilje// to //env_machopts.$MACH// where //$MACH//
has to be replaced with the name of your machine.

Edit settings as necessary. The settings should make compilers,
libraries, queuing system commands ect. available during building and
model execution. You will likely have to remove/replace all module
specifications, while the runtime environment settings should work for
most systems.

Compiler and linker options
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Copy //Macros.vilje// to //Macros.$MACH// if your compiler is intel. If
your compiler is pgi, then instead use //Macros.hexagon// as template.

Following lines need to be customised:
``FC := FORTRAN COMPILER COMMAND`` ``CC := FORTRAN COMPILER COMMAND``
``NETCDF_PATH := ROOT PATH FOR NETCDF LIBRARY``
``MPI_ROOT := ROOT PATH FOR MPI LIBRARY``
``INC_NETCDF := $(NETCDF_PATH)/include``
``LIB_NETCDF := $(NETCDF_PATH)/lib``
``MOD_NETCDF := $(NETCDF_PATH)/include``
``INC_MPI := $(MPI_ROOT)/include`` ``LIB_MPI := $(MPI_ROOT)/lib``

Batch/queuing system rules
^^^^^^^^^^^^^^^^^^^^^^^^^^

Copy //mkbatch.vilje// to //mkbatch.$MACH//.

Change as necessary the settings for //mach//, //group_id//,
//mppsize//, //mppnodes//, etc.

Replace the line *mpiexec_mpt -stats -n $mpptotal omplace -nt
${maxthrds} ./ccsm.exe >&! ccsm.log.\$LID* with the submit command and
appropriate options for your HPC system.

--------------

Testing
'''''''

We suggest to test the installation by running a pre-industrial spin-up
experiment that is configured as 'start-up' simulation (i.e. uses
idealised conditions and observational climatologies as initial
conditions).

Change directory to //$HOME/NorESM1-M/scripts//.

Set up pre-industrial spin-up simulation with *./create_newcase -case
../cases/NorESM1-M_PI_spinup -compset NAER1850CN -res f19_g16 -mach
$MACH -pecount S* where //$MACH// is the name tag of your machine.

Change directory to //../cases/NorESM1-M_PI_spinup//

Run *.configure -case* to set up simulation.

Run *./NorESM1-M_PI_spinup.$MACH.build* to stage namelists in run
directory and build model code.

Submit run-script //./NorESM1-M_PI_spinup.$MACH.run// (use appropriate
submit command for your HPC system, e.g. qsub).

If the test was successful then the model should run for 5 days and
write our restart conditions at the beginning of the 6th day. The
location of the run directory is specified via EXEROOT in
config_machines.xml (see section Porting).

Resources
'''''''''

| `` * ``\ ```Quickstart``\ ````\ ``for``\ ````\ ``running``\ ````\ ``NorESM1`` <noresm:runmodel:newbie>`__
| `` * ``\ ```Advanced``\ ````\ ``options``\ ````\ ``for``\ ````\ ``running``\ ````\ ``NorESM1`` <noresm:runmodel:advanced>`__
| `` * ``\ ```Porting``\ ````\ ``of``\ ````\ ``NorESM1``\ ````\ ``to``\ ````\ ``TERI``\ ````\ ``(India)`` <http://www.teriin.org/projects/nfa/pdf/Working_paper7.pdf>`__
