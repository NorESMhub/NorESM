.. _advanced:

Advanced configuration (NorESM1)
=================================                                

Understanding compsets
~~~~~~~~~~~~~~~~~~~~~~

A compset is a collection of configuration parameters which describe a
specific case. NorESM has several pre-defined compsets. The CCSM users
guide provides information on configuring your own compsets. The
compsets define things like *how many processors will be used in this
case*, *which options go to cam_oslo in this case*

For existing composets, search for the file config_compsets.xml in your
$NORESM folder. They can also all be printed by going to $NORESM/scripts
and type the command 

::

  ./create_newcase -list 

AMIP type simulations
~~~~~~~~~~~~~~~~~~~~~

For AMIP type simulations, using the data ocean model with prescribed
(observed) SST, use one of the pre-defined compsets with long names
starting with "NF_". One, used in the AMIP run for CMIP5, is
"NF_1979-2005\_ AER\_ AMIP_OBS", with the short name "NF2005AERAMIPO".
To create a Case with the chosen name AMIPtest for this compset, as an
example, write

::

  ./create_newcase  -case ../cases/AMIPtest/ -mach hexagon -res f19_f19  -compset NF2005AERAMIPO

Running with offline aerosol interaction
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to limit the number of compsets there are (at present) no
compsets available for automatically setting up the model in offline
mode (i.e., the meteorology is forced by aerosol optics and CDNC from
CAM4 instead of CAM4-Oslo) or for taking out extra AeroCom diagnostics,
which requires numerous additional subroutine calls and therefore is
quite expensive to run, both with respect to CPU time and memory. To set
up the model in offline mode (before compiling), simply find all
subroutines which contain the logical variable AEROFFL (e.g.: grep
AEROFFL \*.F90), and replace all instances of

::

  #undef AEROFFL

and

::

  !#define AEROFFL

with

::

  #define AEROFFL

This is useful for short simulations where we want to look at direct
and/or indirect radiative forcing by aerosols, since the meteorology
does not change with changing aerosol emissions (e.g. for year 1850 and
2000). Similarly, to set up the model to take out additional aerosol
output for use in AeroCom or other studies where there is a need for
extensive aerosol diagnostics, find all subroutines which contain the
logical variable AEROCOM (e.g.: grep AEROCOM \*.F90), and then replace
all

::

  !#define AEROCOM

with

::

  #define AEROCOM

The model may be run with any combination of these options: with AEROFFL
only, with AEROCOM only, or with AEROFFL and AEROCOM activated at the
same time.

See also presentation from NorESM workshop November 28'th 2013.

Use of look-up tables for aerosol optics and activation to cloud droplets
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See presentation from NorESM workshop November 28'th 2013:

The look-up table code, AeroTab, is now available through subversion
under cam/tools/AeroTab on norEsmTrunk. To obtain a local copy
(myAeroTab) of the newest version without checking out the whole NorESM
model, run

::

  svn checkout https://svn.met.no/NorESM/noresm/trunk/noresm/models/atm/cam/tools/AeroTab myAeroTab

Or, if you are interested in the CMIP5 version (with some updates), run
instead

::

  svn checkout -r 199 https://svn.met.no/NorESM/noresm/trunk/noresm/models/atm/cam/tools/AeroTab myAeroTab

Use of chemistry
~~~~~~~~~~~~~~~~

See presentation from :download:`NorESM workshop November 28'th 2013 <../presentations/dirkjlo_chemistry_noresmworkshopnov2013.pdf>`

