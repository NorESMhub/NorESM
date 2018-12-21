.. _settingupcamonlinuxpc:

Setting up CAM on your own linux PC
====================================                                   

CAM is the atmospheric component of NoRESM. It is possible to compile
and run CAM on your own Linux PC. This makes it easier to debug simple
tests using programs like ddd or gdb. CAM 5.3 compiles with gfortran.

Obtain CAM 5.3 source code
''''''''''''''''''''''''''
::

  svn checkout https://svn-ccsm-release.cgd.ucar.edu/model_versions/cesm1_2_0

You will be asked for a user name and password. You can easily get that
from NCAR through
http://www.cesm.ucar.edu/models/cesm1.0/register/register_cesm1.0.cgi

(the first time it will use your unix user name.. Just type the wrong
password, and then it will prompt you for another user name, then use
the one provided by NCAR).

-    To use the development version of CAM5-Oslo, check out NorESM (not
      CESM) from the noresm repository

::

  svn checkout https://svn.met.no/NorESM/noresm/branches/featureCAM5-OsloDevelopment_trunk2.0-4 myCamOsloDev

Compile the netcdf libraries using gfortran
'''''''''''''''''''''''''''''''''''''''''''

1) INSTALL NETCDF (4.2): Follow instructions on
http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-install/Quick-Instructions.html#Quick-Instructions

I created library directories on /home/alfg/LIBS/.

For example /home/alfg/LIBS/netcdf-4.2.gfortran. These directories are
use as "prefix=" in the installation guide..

When installing:

-  Use instructions on how to build with hdf5

-  Use the instructions about shared libraries. (There are also
   instructions about static libraries)

-  Remember to set the LD_LIBRARY_PATH variable as described. Otherwise
   it does not work.

==> Some exceptions

(Build order is wrong)
http://mail.lists.hdfgroup.org/pipermail/hdf-forum_lists.hdfgroup.org/2013-May/006818.html

(Have to do separately)

::

  make
  make check
  make install

Add the following to your .bashrc file:

::

  export FC=gfortran
  export CC=gcc
  export CFLAGS=-O0
  export CXX=g++
  export CXXFLAGS=-O0

The netcdf c-library complains about a non-successful compilation
because it can not find Doxyfile. This is not important. The compilation
needs also the following env-variables: CPPFLAGS=-I${dir}/include,
LDFLAGS=-L${dir}/lib, where "dir" is directory you use for the
"configure" scripts

3) Get the netcdf source code (including the c-headers) from
http://www.unidata.ucar.edu/software/netcdf/docs/getting.html a) make b)
make check c) make install

4) Get fortran netcdf api
(http://www.unidata.ucar.edu/downloads/netcdf/index.jsp) and follow
http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-fortran-install.html

Compile CAM on your Linux PC
''''''''''''''''''''''''''''

When you have succesfully obtained netCDF libraries, you need to set
some environent variables in order to tell CAM where to find these
libraries, add the following to your .bashrc file (but change the path
to the correct path). Make sure you have the netcdf.mod-file in
"MOD_NETCF". These environment variables are used by the CAM "configure"
script!

::

  export INC_NETCDF=/home/alfg/LIBS/netcdf-4.2.gfortran/include 
  export LIB_NETCDF=/home/alfg/LIBS/netcdf-4.2.gfortran/lib 
  export MOD_NETCDF=/home/alfg/LIBS/netcdf-4.2.gfortran/include 
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LIB_NETCDF

The steps for building and installing CAM are well described at
http://www.cesm.ucar.edu/models/cesm1.0/cam/docs/ug5_1/ug.html

You need the following settings in your .bashrc file:

::

  export camcfg=/path/to/CESM_1_2_0/cesm1_2_0/models/atm/cam/bld
  export CSMDATA=/path/to/cam/input/data

This command configures CAM (not including any CAM-Oslo code) on my
machine. It creates a Makefile used later for compilation.

::

  $camcfg/configure -dyn fv -debug -hgrid 10x15 -fc gfortran -nospmd -nosmp -test -fc_type gnu

-   As long as $camcfg is defined, you can execute this from any
      directory..

Then you need the following commands **executed from the same directory
as you executed "configure"** 

::

  $camcfg/build-namelist -test -config config_cache.xml

::

  make

The input data have been collected and put at norstore:

:: 

  /projects/NS2345K/noresm/CAM5.3_PCLinux/CAM5.3Input10x15/csm/inputdata

You should copy these files to somewhere on your computer. The CSMDATA
environment variable should point to the "input-data" directory after
the copying. For example I copied it to /disk1/alfg/csm/, so my $CSMDATA
is 

::

  alfg@pc4400:$ echo $CSMDATA /disk1/alfg/csm/inputdata

Finally run the model simply executing the command ./cam

NOTE: In CAM5.5 (upcoming versions) this same procedure is supposed to
work with the following command (NOT VERIFIED): 

::

  $camcfg/configure -fc gfortran -fc_type gnu -debug -nospmd -nosmp -dyn fv -res 10x15 -ice sice -phys cam5

Including cam-oslo code
'''''''''''''''''''''''

This assumes you checked out NorESM (and CESM) with subversion

Works with latest version of oslo aerosol development branch

:: 

  $camcfg/configure -dyn fv -debug -hgrid 10x15 -fc gfortran -nospmd -nosmp -test -fc_type gnu -chem trop_mam_oslo 

There are additional input needed for the CAM-Oslo code. They are
available in the same input-directory as the normal CESM-input files. As
long as the whole input directory is copied and the
CSMDATA-environmen-variable is set, you don't have to do anything. The
input-directory at norstore is:

::

  /projects/NS2345K/noresm/CAM5.3_PCLinux/CAM5.3Input10x15/csm/inputdata

Debug the model using ddd or gdb
''''''''''''''''''''''''''''''''

Some first test show that the following information is useful:

gdb hangs forever on backtrace commmand sometimes. Adding //set print
frame-arguments none// to your ~/.gdbinit file solves that problem on
the expense of less information on "bt" command.

ddd sometimes hangs forever on startup. If that happens you need to
remove the ~/.ddd/init file

gdb has problems with printing info about allocatable arrays.
Allocatable arrays have to be displayed as "*((real_8 \*)my_array +
N)@M" where N is number of elements beyond first element and M is number
of elements to show. (See bottom of this page (and links therein)
http://stackoverflow.com/questions/11786958/how-to-print-fortran-arrays-in-gdb)

It is sometimes useful to let the compiler tell you about additional
errors. Assuming you use gfortran on your PC: See
https://gcc.gnu.org/onlinedocs/gfortran/Code-Gen-Options.html for
additional options. For example if you want to check just about
everything, add "-fcheck=all" to the "FC_FLAGS" in the gfortran section.
(Note: Running configure again re-generates the Makefile)

View results
''''''''''''

ncview has trouble visualizing results which are of this coarse
resolution (10x15 degrees). Panoply is a better option. Download from
http://www.giss.nasa.gov/tools/panoply/download_gen.html

1. Unpack the files

2. Add the folder where you find panoply.sh to your path. In your .bashrc file, add: 
  
::  

  export PATH=$PATH:/path/to/panoply/dot/sh

3. launch program with "panoply.sh netcdfFileName" from any folder

Configure your case
'''''''''''''''''''

If you want an other configuration than the standard configuration, you
must add a use-case. The use case is an xml-file which is added to the
/cesm1_2_0/models/atm/cam/bld/namelist_files/use_cases/ directory.

Below is an example of a use-case which writes some more frequent output
(every hour) to history files.

The file says that we have 5 different history files. The first one is
the monthly output with max one time step. The other files are output
every hour (-1) with max number of samples 30 in each file.

For each of the different files (1-5) we have specified the fields we
want to output. For example in the second, we output QREFHT, TREFHTMN
etc..

Fields which end in ":I" are instantaneous values as opposed to time
averages.

Save the xml-file to the use_cases directory as "my_case.xml" and run
the command

::

 $camcfg/build-namelist -test -config config_cache.xml -use_case my_case


::

  <?xml version="1.0"?>

  <namelist_defaults>

  <mfilt>1,30,30,30,30</mfilt>

  <nhtfrq>0,-1,-1,-1,-1</nhtfrq>

  <!-- TEM diagnostics output -->

  <fincl2>'QREFHT','TREFHTMN','TREFHTMX','TREFHT','PRECT','PRECC','PRECSC','PRECSL','PSL','T','Z3','U','V','PS','TS','SST','PHIS','CLDTOT'</fincl2>
  <fincl3>'U850:I','V850:I','T850:I','Q850:I','OMEGA850:I','U:I','V:I','T:I','PS:I','PSL:I','Q:I','PHIS:I'</fincl3>
  <fincl4>'PRECT','LHFLX','SHFLX','FLDS','FLNS','FSNS','PRECC','PRECSC','PRECSL'</fincl4>
  <fincl5>'TREFHT:I','QREFHT:I','TS:I','SST:I','PS:I'</fincl5>

 
 </namelist_defaults>


