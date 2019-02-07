Update of NorESM2 with CESM2.1.0
=================================

.. toctree::
    :maxdepth: 2
    :numbered:
    :titlesonly:
    :glob:
    :hidden:


This document describes the upgrade of NorESM with CESM2.1.0.  The
previous update of NorESM-dev dated from June 2018, and was based on a
predecessor of CESM2.0.

A new branch has been created : featureCESM2.1.0-OsloDevelopment [notice
the 2.1.0].  This is to prevent too much trouble for people currently
working with featureCESM2-OsloDevelopment.

Please feel free to edit and improve this document.  On several
locations, there are comments in colour and with question marks.  

The main topics treated in this document are :

A description of the CESM2.1.0 version used for the update.

A description of some of the structural differences between NorESM2 and
CESM2.

Update of NorESM2.

General comments and remarks
-----------------------------

This section contains some general comments about extra modification
suggestions to the code.  Most of them are not urgent.

Checking code
^^^^^^^^^^^^^

Directories to possible remove
"""""""""""""""""""""""""""""""

Skip in the code structure : directory CESM12\_deprecated.

Skip in the code structure : directory models

Skip in the code structure : cime\_config/usermods\_dirs/n1850r227

Skip in the code structure : cime\_config/usermods\_dirs/nhistr227

CISM
"""""

Current NorESM is setup to not used CISM2.  We should be careful that we
are consistent.  E.g., NorESM compsets use GLACE, whereas CESM compsets
use CISM2%NOEVOLVE.

Also for initial conditions/REFCASE one should be careful : see
cime\_config/config\_compsets.xml

Carbon cycle
"""""""""""""

There are now CO2 emissions at surface and from aircraft in CESM.  They
exist both on 0.9x1.25 and 1.9x2.5 resolution.

History\_dust
""""""""""""""

history\_dust : has been added on some places, but not everywhere.
CAM-Oslo is currently not using it.

Supported grids
"""""""""""""""

Should we use support\_grid (as for CESM)?

CLM
""""

UiO (Kjetil) is willing to implement an extra correction for the land
model

Running pure CESM code based on the NorESM repository
""""""""""""""""""""""""""""""""""""""""""""""""""""""

It is/would be a nice feature if one can still run pure CESM based on
the NorESM repository.  However, one should be careful about :

cam/bld/configure : how to switch off the NorESM directories for pure
CESM?

landmodel : there is a single modification which is hard-coded

one should avoid that CAM-Oslo namelist options end up in namelist
(dms\_source, volc\_fraction, …)

Clean-up of old compsets
"""""""""""""""""""""""""

There are still a lot of reference to emission files from CMIP5 used by
CAM-Oslo5.3 and NorESM\_c1.2. These are however not used and maybe can
be removed.

CLM and netcdf3/netcdf4
""""""""""""""""""""""""

There are two bomb-emissions files (for C13 and C14) for the landmodel,
which are used when “CMIP6” is activated in the land model.  These files
are however NetCDF3 format.  This requires to convert the files to
NetCDF4, or to use “netcdf” instead of “pnetcdf” for CLM.

1.9x2.5 grid in CESM
"""""""""""""""""""""

Only the CO2 emissions (surface and aircraft) used in BHIST have
separate resolutions.

Initial files for 1.9x2.5 are often old files (e.g. dating 2015).

Decisions to be made for NorESM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

CROP
""""

When will we have CROP active?  The F2000climo compset (CESM) has CROP
not anymore active, so I switched it also off for NF2000climo.

GHG concentration
""""""""""""""""""

Which GHG concentrations to be used in the spinup?  The GHG
concentrations in the pre-industrial control B1850 of CESM, are not
identical to the values in Meinshausen et al. [2017].  I will check this
again.

Naming conventions for NorESM compsets
"""""""""""""""""""""""""""""""""""""""

The current NorESM preindustrial compset, is named N1850OCBDRDDMS
(compared to B1850 in CESM).  This motivated me to call the historical
NorESM compset NHISTOCBDRDDMS (compared to BHIST in CESM).

Updates in CESM2.1.0 for CMIP6
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Forcings have been updated for quite some COMPSETS (for NF2000climo they
have not changed)

Diagnostics have been extended

New compsets have appeared : 4xCO2 and 1pctCO2

More for 2x2 has become available

CLM5 has now the CLM50%BGC-CROP-CMIP6DECK configuration
(cime\_config/config\_compsets.xml).

CICE has CICE%CMIP6

(should be extended)

CESM2.1.0 version
------------------

CESM2.1.0 standard version
^^^^^^^^^^^^^^^^^^^^^^^^^^

This section describes how the implemented CESM2.1.0 version has been
obtained.

CESM2.1.0 version made by THT
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The code is based on CESM2.1.0 : obtained from

git clone -b release-cesm2.1.0 https://github.com/ESCOMP/cesm.git

For CAM, some additional recent updates have been used (from
cam6\_1\_010) :

`https://svn-ccsm-models.cgd.ucar.edu/cam1/trunk\_tags/cam6\_1\_010 <https://www.google.com/url?q=https://svn-ccsm-models.cgd.ucar.edu/cam1/trunk_tags/cam6_1_010&sa=D&ust=1549451785395000>`__\ .
 By using cam6-1\_010 tag, 7 files were affected :

#. components/cam/cime\_config/config\_compsets.xml
#. components/cam/src/chemistry/mozart/mo\_fstrat.F90
#. components/cam/src/chemistry/mozart/mo\_photo.F90
#. components/cam/src/control/ncdio\_atm.F90
#. components/cam/src/physics/cam/physics\_types.F90
#. components/cam/src/physics/cam/physpkg.F90
#. components/cam/src/utils/cam\_grid\_support.F90

In addition, the code has been modified such that it contains the
changes from Thomas Thoniazzi (THT), and such that it can run on vilje
and fram.   This concerns files in several components, and is related to
energy conservation, flux parameterizations, …  However, all these
modification can be deactivated using correct settings in the namelist.

This version made by THT, and called cam\_cesm2\_1\_rel\_05, did not
contain POP, and had used on older version of WW3, than the one
prescribed in CESM2.1.0.

In the table below is shown wat tags were used for the different
components.


+------+-----------------------------+---------------------------------------------------------------------------------------+
|      |       CESM2.1.0             |   cam\_cesm2\_1\_rel\_05                                                              |
+======+=============================+======================+=======+==========================+=====+=======================+
|      | Externals.cfg               | Ext.cfg.all          | mini  | orig                     | pop | Ext.cfg.rest          |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| cam  | cam\_cesm2\_1\_rel\_05      | --                   | --    | --                       | --  | --                    |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| cice | cice5\_20181109             | (id.)                | (id.) | cice5\_cesm2\_0\_rel\_01 |  -- |  --                   |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
|cime  |cime5.6.10\_cesm2\_1\_rel\_06|(id.)                 | (id.) |cime\_cesm2\_0\_rel\_06   | --  |  --                   |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
|cism  | release-cesm2.0.04          | (id.)                | --    | release-cesm2.0.01       | --  | (id.)                 |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| clm  | release-clm5.0.14           | (id.)                | (id.) | release-clm5.0.01        | --  | --                    |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
|mosart| release-cesm2.0.03          | (id.)                | --    | release-cesm2.0.00       | --  | (id.)                 |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| pop  | pop2\_cesm2\_1\_rel\_n01    | (id.)                | --    | --                       |(id.)|                       |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| rtm  | release-cesm2.0.02          | (id.)                | --    | release-cesm2.0.00       | --  | (id.)                 |
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+
| ww3  | ww3\_cesm2\_1\_rel\_01      |ww3\_cesm2\_0\_rel\_01| --    | ww3\_cesm2\_0\_rel\_01   | --  | ww3\_cesm2\_0\_rel\_01|
+------+-----------------------------+----------------------+-------+--------------------------+-----+-----------------------+

The exernal files used were probably : Ext.cf.mini + Ext.cfg.rest

Overview of the modifications by THT
""""""""""""""""""""""""""""""""""""

The tables below shows which files in CESM2.1.0 made by THT differ from
a standard downloaded CESM2.1.0.

**CIME**


+-------------------------+-------------------------+-------------------------+
| 1                       | config\_grids.xml       |                         |
+-------------------------+-------------------------+-------------------------+
| 2                       | config\_batch.xml       |                         |
+-------------------------+-------------------------+-------------------------+
| 3                       | config\_compilers.xml   |                         |
+-------------------------+-------------------------+-------------------------+
| 4                       | config\_machines.xml    |                         |
+-------------------------+-------------------------+-------------------------+
| 5                       | case\_submit.py         |                         |
+-------------------------+-------------------------+-------------------------+
| 6                       | env\_batch.py           |                         |
+-------------------------+-------------------------+-------------------------+
| 7                       | case.build              |                         |
+-------------------------+-------------------------+-------------------------+
| 8                       | check\_case             |                         |
+-------------------------+-------------------------+-------------------------+
| 9                       | docn\_comp\_mod.F90     | THT                     |
+-------------------------+-------------------------+-------------------------+
| 10                      | namelist\_definition\_d | THT                     |
|                         | rv.xml                  |                         |
+-------------------------+-------------------------+-------------------------+
| 11                      | cime\_comp\_mod.F90     |                         |
+-------------------------+-------------------------+-------------------------+
| 12                      | seq\_flux\_mct.F90      |                         |
+-------------------------+-------------------------+-------------------------+
| 13                      | seq\_infodata\_mod.F90  |                         |
+-------------------------+-------------------------+-------------------------+
| 14                      | shr\_flux\_mod.F9       |                         |
+-------------------------+-------------------------+-------------------------+
| 15                      | shr\_orb\_mod.F90       |                         |
+-------------------------+-------------------------+-------------------------+

**CAM**

+--------------------+--------------------+--------------------+--------------------+
| 1                  | namelist\_defaults |                    | THT                |
|                    | \_cam.xml          |                    |                    |
|                    |                    |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 2                  | namelist\_definiti |                    | THT                |
|                    | on.xml             |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 3                  | config\_compsets.x | CAM\_6\_1\_010     |                    |
|                    | ml                 |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 4                  | mo\_fstrat.F90     | CAM\_6\_1\_010     |                    |
+--------------------+--------------------+--------------------+--------------------+
| 5                  | mo\_gas\_phase\_ch |                    | THT                |
|                    | emdr.F90           |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 6                  | mo\_photo.F90      | CAM\_6\_1\_010     |                    |
+--------------------+--------------------+--------------------+--------------------+
| 7                  | mo\_waccm\_hrates. |                    | THT                |
|                    | F90                |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 8                  | cam\_history.F90   |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 9                  | ncdio\_atm.F90     | CAM\_6\_1\_010     |                    |
+--------------------+--------------------+--------------------+--------------------+
| 10                 | cd\_core.F90       |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 11                 | ctem.F90           |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 12                 | tp\_core.F90       |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 13                 | cam\_diagnostics.F |                    | THT                |
|                    | 90                 |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 14                 | phys\_control.F90  |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 15                 | physics\_types.F90 | CAM\_6\_1\_010     | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 16                 | physpkg.F90        | CAM\_6\_1\_010     | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 17                 |  radiation.F90     |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 18                 | radiation.F90      |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+
| 19                 | cam\_grid\_support | CAM\_6\_1\_010     |                    |
|                    | .F90               |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 20                 | orbit.F90          |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+

**CICE**

+--------------------+--------------------+--------------------+--------------------+
| 1                  | ice\_orbital.F90   |                    | THT                |
+--------------------+--------------------+--------------------+--------------------+

**CLM**

+--------------------+--------------------+--------------------+--------------------+
| 1                  | SurfaceAlbedoMod.F |                    | THT                |
|                    | 90                 |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 2                  | SurfaceAlbedoMod.F |                    | THT                |
|                    | 90                 |                    |                    |
+--------------------+--------------------+--------------------+--------------------+

**WW3**

+--------------------+--------------------+--------------------+--------------------+
| 1                  | Changelog          |                    |                    |
+--------------------+--------------------+--------------------+--------------------+
| 2                  | buildnml           |                    |                    |
+--------------------+--------------------+--------------------+--------------------+

Details of the modifications
"""""""""""""""""""""""""""""

This section describes in slightly more detail the differences between
the CESM2.1.0 made by THT and a standard CESM2.1.0 version.

Under “REMARK”, some of the differences are shortly described.  “FILE”
refers to the full path to the location of the file.

Difference can be found in CIME, CAM, CICE, CLM and WW3.

**CIME** 

1) config\_grids.xml

REMARK

a) extra grids (e.g., tn ...) : contained NorESM grids

b) extra grid : f09\_f09  [WHY?]

FILE

cime/config/cesm/config\_grids.xml

2) config\_batch.xml

REMARK

vilje and fram extra

FILE

cime/config/cesm/machines/config\_batch.xml

3) config\_compilers.xml [OK]

REMARK : vilje and fram extra

FILE : cime/config/cesm/machines/config\_compilers.xml

4) config\_machines.xml [OK]

REMARK : vilje and fram extra

FILE : cime/config/cesm/machines/config\_machines.xml

5) case\_submit.py

REMARK :

a) extra for fram : limit0, limit1

b) extra import sys [IS THIS NEEDED?]

c) extra caseroot [IS THIS NEEDED?]

FILE : cime/scripts/lib/CIME/case/case\_submit.py

6) env\_batch.py

REMARK :

a) extra for vilje

b) extra for fram : to define queue for archiving job

FILE : cime/scripts/lib/CIME/XML/env\_batch.py

7) case.build

REMARK : return of function : fixed argument 0 instead of "not
args.skip\_provenance\_check"

FILE : cime/scripts/Tools/case.build

8) check\_case

REMARK : case.check\_lockedfiles(skip="env\_batch") : instead of no
argument

FILE : cime/scripts/Tools/check\_case

9) docn\_comp\_mod.F90

REMARK

a) extra kifra

b) tfreeze = ... (modified)

c) factor order of multiplication changed

d) sst\_flattification

FILE : cime/src/components/data\_comps/docn/docn\_comp\_mod.F90

10) namelist\_definition\_drv.xml [THT modification]

REMARK : extra flux\_scheme and alb\_cosz\_avg

FILE : cime/src/drivers/mct/cime\_config/namelist\_definition\_drv.xml

11) cime\_comp\_mod.F90 [THT modification]

REMARK :

a) shr\_orb\_doalbavg, shr\_flux\_docoare

b) call seq\_flux\_ocnalb\_mct(..., dtime) : extra argument [4 times]

c) misses :  write\_hist\_alarm = t24hr\_alarm .or. stop\_alarm

FILE : cime/src/drivers/mct/main/cime\_comp\_mod.F90

12) seq\_flux\_mct.F90 [THT modification]

REMARK :

a) subroutine seq\_flux\_ocnalb\_mct(.., dtime) : extra argument

b) uses function shr\_orb\_cosz(..., dtavg) : extra argument

FILE :

cime/src/drivers/mct/main/seq\_flux\_mct.F90

13) seq\_infodata\_mod.F90 [THT modification]

REMARK : related to flux\_scheme and alb\_cosz\_avg

FILE : cime/src/drivers/mct/shr/seq\_infodata\_mod.F90

14) shr\_flux\_mod.F90  [THT modification]

REMARK : related to flux\_scheme, considerably different

FILE : cime/src/share/util/shr\_flux\_mod.F90

15) shr\_orb\_mod.F90 [THT modification]

REMARK : about alb\_cosz

a) definition function shr\_orb\_cosz(...,rad\_call) : extra argument

b) extra subroutine shr\_orb\_doalbavg(iflag)

FILE :

cime/src/share/util/shr\_orb\_mod.F90

**CAM**

1) namelist\_defaults\_cam.xml [THINGS SHOULD BE ACTIVATED AGAIN] [THT
modification]

REMARK

a) contains <dme\_energy\_adjust>.true.</dme\_energy\_adjust>

b) contains all cmip5 cam-oslo emission filenames from noresm-only
directory [MAYBE CAN BE SKIPPED]

c) contains (BUT COMMENTED OUT) : vol\_fraction-coarse,
aerotab\_table\_dir, dms\_source, dms\_source\_type, dms\_cycle\_year,
opom\_source, opom\_cycle\_year, ocean\_filename, ocean\_filepath

FILE :

components/cam/bld/namelist\_files/namelist\_defaults\_cam.xml

2) namelist\_definition.xml [THINGS SHOULD BE ACTIVATED AGAIN] [THT
modification]

REMARK

a) met\_nudge\_only\_uvps

b) cam\_chempkg; but trop\_mam\_oslo COMMENTED OUT

c) dme\_energy\_adjust

d) flds\_co2\_dmsb : but COMMENTE OUT

e) vol\_fraction-coarse, aerotab\_table\_dir, dms\_source,
dms\_source\_type, dms\_cycle\_year, opom\_source, opom\_cycle\_year,
ocean\_filename, ocean\_filepath; but COMMENTED  OUT

FILE :

components/cam/bld/namelist\_files/namelist\_definition.xml

3) config\_compsets.xml [CAM\_6\_1\_010]

REMARK :

1) FKESSLER : no science\_support grid

2) FW1850 : dissappeared

3) FWsc2010climo, FWsc2000climo, FWsc1850, FWscHIST, FW1850 : extra
science\_support grid

4) FW4madHIST, FW4madSD, FX2000, FXHIST, FXmadHIST, FXSD, FXmadSD :
CLM50 instead of CLM40

FILE :

components/cam/cime\_config/config\_compsets.xml

4) mo\_fstrat.F90 [CAM\_6\_1\_010]

REMARK :

lat variable disappeared (only within #ifdef DEBUG)

FILE :

components/cam/src/chemistry/mozart/mo\_fstrat.F90

5) mo\_gas\_phase\_chemdr.F90 [THT modification]

REMARK :

call zenith(..., delt) : extra argument

FILE :

components/cam/src/chemistry/mozart/mo\_gas\_phase\_chemdr.F90

6) mo\_photo.F90 [CAM\_6\_1\_010]

REMARK :

added "if (masterproc) then" (only within #ifdef DEBUG)

FILE

components/cam/src/chemistry/mozart/mo\_photo.F90

7) mo\_waccm\_hrates.F90 [THT modification]

REMARK

call zenith(..., dtavg) : extra argument

FILE

components/cam/src/chemistry/mozart/mo\_waccm\_hrates.F90

8) cam\_history.F90

REMARK

1) i\_am\_a\_nazi\_arse=.false.

2) fincl shift

3) fexcl shift

FILE

components/cam/src/control/cam\_history.F90

9) ncdio\_atm.F90 [CAM\_6\_1\_010 modification]

REMARK : ndims = ndims -1

FILE : components/cam/src/control/ncdio\_atm.F90

10) cd\_core.F90 [ALL EQUAL] : why was it present?

FILE : components/cam/src/dynamics/fv/cd\_core.F90

11) ctem.F90 [THT modification]

REMARK : on winds

FILE : components/cam/src/dynamics/fv/ctem.F90

12) tp\_core.F90

REMARK :

cos\_van, cos\_ppm = 0.1\_r8 !roughly at 84 deg instead of

cos\_van, cos\_ppm = D0\_25 !roughly at 75 deg

FILE :

components/cam/src/dynamics/fv/tp\_core.F90

13) cam\_diagnostics.F90 [THT modification]

REMARK

a) extra THT diagnostics : EBREAK, PTTEND\_DME, IETEND\_DME, EFLX  

b) subroutine diag\_phys\_tend\_writeout\_dry(...,  tmp\_t, eflx, dsema)
: 3 extra arguments

c) call check\_energy\_get\_integrals(..., ,
tedif\_glob\_out=tedif\_glob ): 1 extra argument

d) subroutine diag\_phys\_tend\_writeout(..., tmp\_t, ..., eflx, dsema)
: 3 extra arguments

e) call diag\_phys\_tend\_writeout\_dry(..., stmp\_t, eflx, dsema) : 3
extra arguments

FILE :

components/cam/src/physics/cam/cam\_diagnostics.F90

14) phys\_control.F90 [THT modification]

REMARK

a) dme\_energy\_adjust = .false. : extra

b) subroutine phys\_getopts(...,dme\_energy\_adjust\_out) : extra
argument

FILE

components/cam/src/physics/cam/phys\_control.F90

15) physics\_types.F90 [THT modification + CAM\_6\_1\_010 modification]

REMARK : unupdate <- orig (shows impact of THT)

a) logical, parameter :: adjust\_te  : commented out

b) subroutine physics\_dme\_adjust(...,  eflx, ent\_tnd, ohf\_adjust,
ocnfrac, sst, ts) : 6 extra arguments

c) subroutine physics\_dme\_adjust\_BAB : completely extra

d) subroutine physics\_dme\_adjust\_THT :completely extra

REMARK : final <- unupdated (shows impact of cam\_6\_1\_010 instead of
cam\_6\_1\_ ...)

a) cpairv\_loc(:,:), rairv\_loc(:,:) instead of cpairv\_loc(:,:,:),
rairv\_loc(:,:,:)

b) some related changes

FILE

components/cam/src/physics/cam/physics\_types.F90

16) physpkg.F90 [THT modification + CAM\_6\_1\_010 modification]

REMARK : unupdate <- orig (shows impact of THT)

a) extra variables : tmp\_t, eflx, dsema, ohf\_adjust,

b) call physics\_dme\_adjust(..., eflx, dsema, ohf\_adjust,
cam\_in%ocnfrac, cam\_in%sst, cam\_in%ts) : 6 extra arguments

c) call diag\_phys\_tend\_writeout(..., tmp\_t, ..., eflx, dsema) : 3
extra arguments

REMARK : final <- unupdated (shows impact of cam\_6\_1\_010 instead of
cam\_6\_1\_ ...)

a) call endrun (...) : change in message

FILE :

components/cam/src/physics/cam/physpkg.F90

17) radiation.F90 [THT modification]

REMARK :

a) cosz\_rad\_call=.true.

b) call zenith (..., cosz\_rad\_call) : extra argument

FILE :

components/cam/src/physics/camrt/radiation.F90

18) radiation.F90 [THT modification]

REMARK :

a) cosz\_rad\_call=.true.

b) function shr\_orb\_cosz(..., cosz\_rad\_call) : extra argument

FILE :

components/cam/src/physics/rrtmg/radiation.F90

19) cam\_grid\_support.F90 [CAM\_6\_1\_010 update]

REMARK :  call pio\_write\_darray( ...., ierr) instead of call
pio\_write\_darray(..., ierr, fillval=grid\_fill\_value)

FILE : components/cam/src/utils/cam\_grid\_support.F90

 

20) orbit.F90 [THT modification]

REMARK

a) subroutine zenith(..., rad\_call) : extra argument

b) call to function shr\_orb\_cosz(..., rad\_call) : extra argument

FILE

components/cam/src/utils/orbit.F90

**CICE**

1) ice\_orbital.F90 [THT modifications]

REMARK

1) use shr\_orb\_mod, only: shr\_orb\_cosz : extra

2) uses #ifdef CESMCOUPLED changes together with THT changes.  It is
equal to old NorESM, so probably ok. [IS THIS OK?]

FILE

components/cice/src/source/ice\_orbital.F90

**CLM**

1) SurfaceAlbedoMod.F90 [OK : THT modifications]

REMARK : use of function shr\_orb\_cosz (...,dtavg) : extra argument

FILE : components/clm/src/biogeophys/SurfaceAlbedoMod.F90

2) SurfaceAlbedoMod.F90 [OK : THT modifications]

REMARK : use of function shr\_orb\_cosz (...,dtavg) : extra argument

FILE : components/clm/src\_clm40/biogeophys/SurfaceAlbedoMod.F90

 

**WW3 : (because older tag used by THOMAS)**

1) ChangeLog 

REMARK : extra comment 01 Oct 2018

FILE : components/ww3/ChangeLog

2) buildnml

REMARK : quite some changes

FILE : components/ww3/cime\_config/buildnml

CESM2.1.0 brought into noresm-dev repository
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The version of CESM2.1.0 brought into the branch
featureCESMNCARBeta\_trunk2.0-7 of the repository noresm-dev is :

-  based on  CESM2.1.0 standard (downloaded from
   https://github.com/ESCOMP/cesm.git)
-  including the modifications from THT(cam\_cesm2\_1\_rel05)
-  includes POP
-  includes for WW3 the standard CESM2.1.0. tag (and not the older tag
   used in cam\_cesm2\_1\_rel05)

NorESM code structure
----------------------

How are the NorESM code changes introduced?

Some of the changes are modifications to existing files (scripts,
xml-files, F90-files, ...), some code by copying original files in a
different directory and modifying them, and really new code.

In some of the F90 file, some of the changes are
actived  by #CAMOSLO

Below some of the differences are described

The main differences in the code :

CAM-Oslo aerosol scheme

Different aerosol scheme in CAM.  The code for this scheme can be mainly
be found in the following directories :

components/cam/src/chemistry/pp\_trop\_mam\_oslo [contains code
generated by a preprocessor]

components/cam/src/chemistry/oslo\_aero [contains a lot of code which
originally resides in other cam-directories]

components/cam/src/physics/cam\_oslo

components/cam/NorESM/

components/cam/NorESM/fv

CAM

Some modifications in CAM (which are not related to the CAM-Oslo aerosol
scheme) are implemented in the original code, but with namelist choices
such that the modifications can be activated/deactivated:

flux parameterisation for ocean-atmosphere exchange

averaging over (changing) zenith angle during one model time step

energy conservation

previously angular momentum conservation

MICOM/HAMOCC

The ocean model micom and the ocean biogeochemistry model HAMOCC.  The
source code can be found in : components/micom.

As the ocean grid for micon is different from POP grid (standard CESM
ocean model),  specific definitions have to be added.

CICE

Modifications in CICE are implemented in the original code.  These
modifications can be deactivated by specific namelist settings.

CLM

Modifications in CLM, implemented in the original code.  These
modifications are always active.

Compsets in CESM and NorESM
---------------------------

NorESM compsets will start with “N”, but follow in general the CESM
naming convention.

fully-coupled compsets 
^^^^^^^^^^^^^^^^^^^^^^^

CESM
"""""

The table below shows for some compsets (left column) which
configuration of a component (top row) is used.    This table is based
on information in the file : cime\_config/config\_compsets.xml

+------------+------------+------------+------------+------------+------------+------------+
|            | CAM6       | CLM5       | CICE       | POP2       | CISM2      | BGC        |
+------------+------------+------------+------------+------------+------------+------------+
| B1850      |            | %BGC-CROP  |            | %ECO%ABIO- | %NOEVOLVE  | %BDRD      |
|            |            |            |            | DIC        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| B1850cmip6 |            | %BGC-CROP- | %CMIP6     | %ECO%ABIO- | %NOEVOLVE  | %BDRD      |
|            |            | CMIP6DECK  |            | DIC        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| BCO2x4cmip | %4xCO2     | %BGC-CROP- | %CMIP6     | %ECO%ABIO- | %NOEVOLVE  | %BDRD      |
| 6          |            | CMIP6DECK  |            | DIC        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| B1PCTcmip6 | %1PCT      | %BGC-CROP- | %CMIP6     | %ECO%ABIO- | %NOEVOLVE  | %BDRD      |
|            |            | CMIP6DECK  |            | DIC        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| BHIST      |            | %BGC-CROP  |            | POP2%ECO%A | %NOEVOLVE  | %BDRD      |
|            |            |            |            | BIO        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| BHISTcmip6 |            | %BGC-CROP- | %CMIP6     | %ECO%ABIO- | %NOEVOLVE  | %BDRD      |
|            |            | CMIP6DECK  |            | DIC        |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| B1850G     |            | %BGC-CROP  |            | %ECO       | %EVOLVE    | %BDRD      |
+------------+------------+------------+------------+------------+------------+------------+

NorESM
""""""

+-------------+-------------+-------------+-------------+-------------+-------------+
|             | CAM6        | CLM50       | MICOM       | SGLC        | BGC         |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850       | %PTAERO     | %BGC-CROP   |             |             | --          |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850OC     | %PTAERO     | %BGC        | %ECO        |             | --          |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850OCBPRP | %PTAERO     | %BGC        | %ECO        |             | %BPRP       |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850OCBPRP | %PTAERO     | %BGC        | %ECO        |             | %BPRPDMS    |
| DMS         |             |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850OCBDRD | %PTAERO     | %BGC-CROP   | %ECO        |             | %BDRDDMS    |
| DMS         |             |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+-------------+
| N1850OCDMS  | %PTAERO     | %BGC        | %ECO        |             | %DMS        |
+-------------+-------------+-------------+-------------+-------------+-------------+
| NHIST       | %PTAERO     | %BGC-CROP   |             |             | --          |
+-------------+-------------+-------------+-------------+-------------+-------------+
| NHISTOCBDRD | %PTAERO     | %BGC-CROP   | %ECO        |             | %BDRDDMS    |
| DMS         |             |             |             |             |             |
+-------------+-------------+-------------+-------------+-------------+-------------+

Remark 1 : the NHIST should maybe be changed into NHISTOCBDRDDMS.

Remark 2 : the CLM50 attributes are probably not correct (some with BGC,
some with BGC-CROP)

Remark 3 : new NHISTOCBDRDDMS

Fixed-SST compsets
^^^^^^^^^^^^^^^^^^^

CESM
"""""

The following table is based on the file :
featureCESM2.1.0-OsloDevelopment.

+------------+------------+------------+------------+------------+------------+------------+
|            | CAM6       | CLM50      | CICE       | DOCN       | CISM2      | BGC        |
+------------+------------+------------+------------+------------+------------+------------+
| F1850      |            | %SP        | %PRES      | %DOM       | %NOEVOLVE  | --         |
+------------+------------+------------+------------+------------+------------+------------+
| F1850\_BDR |            | %BGC       | %PRES      | %DOM       | %NOEVOLVE  | %BDRD      |
| D          |            |            |            |            |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| FHIST      |            | %SP        | %PRES      | %DOM       | %NOEVOLVE  | --         |
+------------+------------+------------+------------+------------+------------+------------+
| FHIST\_BGC |            | %BGC-CROP  | %PRES      | %DOM       | %NOEVOLVE  | --         |
+------------+------------+------------+------------+------------+------------+------------+
| FHIST\_BDR |            | %BGC-CROP  | %PRES      | %DOM       | %NOEVOLVE  | %BDRD      |
| D          |            |            |            |            |            |            |
+------------+------------+------------+------------+------------+------------+------------+
| F2000climo |            | %SP        | %PRES      | %DOM       | %NOEVOLVE  | --         |
+------------+------------+------------+------------+------------+------------+------------+
| F2010climo |            | %SP        | %PRES      | %DOM       | %NOEVOLVE  | --         |
+------------+------------+------------+------------+------------+------------+------------+

Remark 1 : -- means that the components is NOT active.

Remark 2 : not mentioning anything : component is ACTIVE but without any
specific configuration

Remark 3 :  why F1850\_BDRD with only BGC (and not BGC-CROP) in CLM50?

NorESM
"""""""

+-------------+-------------+-------------+-------------+-------------+-------------+
|             | CAM60       | CLM50       | CICE        | DOCN        | GLACE       |
+-------------+-------------+-------------+-------------+-------------+-------------+
| NF1850      | %PTAERO     | %SP         | %PRES       | %DOM%DOM    |             |
+-------------+-------------+-------------+-------------+-------------+-------------+
| NFHIST      | %PTAERO     | %SP         | %PRES       | %DOM%DOM    |             |
+-------------+-------------+-------------+-------------+-------------+-------------+
| NF2000climo | %PTAERO     | %SP         | %PRES       | %DOM%DOM    |             |
+-------------+-------------+-------------+-------------+-------------+-------------+

Remark 1) currently only NF2000climo exists

Remark 2) added NF1850 and NFHIST

Remark 3) do we need a NF2010climo?

Forcings and initial conditions
--------------------------------

CESM
^^^^^

Currently, the setup of BCO2x4cmip6 differs from B1850 only in its
initial file (ncdata) and co2vmr.  Therefore BCO2x4cmip6 will not be
mentioned explicitly for most of the forcings.

CAM
""""

Aersol emissions

The same files (on 1x1) are used for 1x1 and 2x2 simulations.

Dust emissions

Scaling factor : always 0.7 (both for 1x1 and 2x2 resolution).

Erod file : always dst\_source2x2tunedcam6-2x2-04062017.nc

Topography

+--------------------------------------+--------------------------------------+
|                                      | bnd\_topo                            |
+--------------------------------------+--------------------------------------+
| 1x1                                  | fv\_0.9x1.25\_nc3000\_Nsw042\_Nrs008 |
|                                      | \_Co060\_Fi001\_ZR\_sgh30\_24km\_GRN |
| 2x2                                  | L\_c170103.nc                        |
|                                      |                                      |
|                                      | fv\_1.9x2.5\_nc3000\_Nsw084\_Nrs016\ |
|                                      | _Co120\_Fi001\_ZR\_061116.nc         |
+--------------------------------------+--------------------------------------+

Solar forcing

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | solar\_irrad\_data | solar\_data\_ymd   |
|                    |                    | \_file             |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850,F1850        | 1x1, 2x2           | SolarForcingCMIP6p | 18500101           |
|                    |                    | iControl\_c160921. |                    |
|                    |                    | nc                 |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST/FHIST        | 1x1, 2x2           | SolarForcingCMIP6\ |                    |
|                    |                    | _18491230-22991231 |                    |
|                    |                    | \_c171031.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | SolarForcing1995-2 | 20000101           |
|                    |                    | 005avg\_c160929.nc |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           | SolarForcing1995-2 | 20100101           |
|                    |                    | 005avg\_c160929.nc |                    |
+--------------------+--------------------+--------------------+--------------------+

Remark 1) SolarForcing1995-2005avg\_c160929.nc contains 2 dates :
00000101 and 99991231.

Remark 2) SolarForcingCMIP6\_18491230-22991231\_c171031.nc contains
daily dates : from 18491230 until 22991231.

Ozone forcing

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | prescribed\_ozone\ |                    |
|                    |                    | _file              |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850,F1850        | 1x1, 2x2           | ozone\_strataero\_ | 1850               |
|                    |                    | cyclical\_WACCM6\_ |                    |
|                    |                    | L70\_CMIP6-piContr |                    |
|                    |                    | ol.001\_y21-50avg\ |                    |
|                    |                    | _zm\_5day\_c180802 |                    |
|                    |                    | .nc                |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST/FHIST        | 1x1, 2x2           | ozone\_strataero\_ |                    |
|                    |                    | WACCM\_L70\_zm5day |                    |
|                    |                    | \_18500101-2015010 |                    |
|                    |                    | 3\_CMIP6ensAvg\_c1 |                    |
|                    |                    | 80923.nc           |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | ozone\_strataero\_ | 2000               |
|                    |                    | CAM6chem\_2000clim |                    |
|                    |                    | o\_zm\_5day\_c1710 |                    |
|                    |                    | 04.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           |  ozone\_strataero\ | 2010               |
|                    |                    | _CAM6chem\_2010cli |                    |
|                    |                    | mo\_zm\_5day\_c171 |                    |
|                    |                    | 004.nc             |                    |
+--------------------+--------------------+--------------------+--------------------+

Oxidants

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | tracer\_cnst\_file |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850, F1850       | 1x1, 2x2           | tracer\_cnst\_WACC | 1850               |
|                    |                    | M6\_halons\_3Dmont |                    |
|                    |                    | hlyL70\_1850climoC |                    |
|                    |                    | MIP6piControl001\_ |                    |
|                    |                    | y21-50avg\_c180802 |                    |
|                    |                    | .nc                |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, FHIST       | 1x1, 2x2           | tracer\_cnst\_halo |                    |
|                    |                    | ns\_3D\_L70\_1849- |                    |
|                    |                    | 2015\_CMIP6ensAvg\ |                    |
|                    |                    | _c180927.nc        |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | tracer\_cnst\_CAM6 | 2000               |
|                    |                    | chem\_2000climo\_3 |                    |
|                    |                    | D\_monthly\_c17100 |                    |
|                    |                    | 4.nc               |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           |  tracer\_cnst\_CAM | 2010               |
|                    |                    | 6chem\_2010climo\_ |                    |
|                    |                    | 3D\_monthly\_c1710 |                    |
|                    |                    | 04.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+

H2O emissions

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | ext\_frc\_specifie |                    |
|                    |                    | r                  |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850, F1850       | 1x1, 2x2           | H2O\_emission\_CH4 | 1850               |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_3DmonthlyL70\_1 |                    |
|                    |                    | 850climoCMIP6piCon |                    |
|                    |                    | trol001\_y21-50avg |                    |
|                    |                    | \_c180802.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, FHIST       | 1x1, 2x2           | H2OemissionCH4oxid |                    |
|                    |                    | ationx2\_3D\_L70\_ |                    |
|                    |                    | 1849-2015\_CMIP6en |                    |
|                    |                    | sAvg\_c180927.nc   |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | H2O\_emission\_CH4 | 2000               |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_3Dmonthly\_L70\ |                    |
|                    |                    | _2000climo\_c18051 |                    |
|                    |                    | 1.nc               |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           | H2O\_emission\_CH4 | 2010               |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_3Dmonthly\_L70\ |                    |
|                    |                    | _2010climo\_c18051 |                    |
|                    |                    | 1.nc               |                    |
+--------------------+--------------------+--------------------+--------------------+

GHG forcing

+--------------------+--------------------+--------------------+--------------------+
| B1850, F1850       | 1x1, 2x2           | ch4vmr = 791.6e-9  |                    |
|                    |                    | co2vmr        =    |                    |
|                    |                    |  284.7e-6          |                    |
|                    |                    | f11vmr         =   |                    |
|                    |                    |  12.48e-12         |                    |
|                    |                    | f12vmr         =   |                    |
|                    |                    |  0.0               |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    | = ' '              |                    |
|                    |                    | n2ovmr         =   |                    |
|                    |                    |  275.68e-9         |                    |
+--------------------+--------------------+--------------------+--------------------+
| BCO2x4cmip6        | 1x1                | ch4vmr = 791.6e-9  |                    |
|                    |                    | co2vmr        =    |                    |
|                    |                    |  1138.8e-6         |                    |
|                    |                    | f11vmr         =   |                    |
|                    |                    |  12.48e-12         |                    |
|                    |                    | f12vmr         =   |                    |
|                    |                    |  0.0               |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    | = ' '              |                    |
|                    |                    | n2ovmr         =   |                    |
|                    |                    |  275.68e-9         |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1PCTcmip6         | 1x1,2x2            | LBC\_CMIP6\_1pctCO |                    |
|                    |                    | 2\_y1-165\_GlobAnn |                    |
|                    |                    | Avg\_0p5degLat\_c1 |                    |
|                    |                    | 80929.nc           |                    |
|                    |                    |                    |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    |      =             |                    |
|                    |                    | 'CO2','CH4','N2O', |                    |
|                    |                    | 'CFC11eq','CFC12'  |                    |
|                    |                    | flbc\_type         |                    |
|                    |                    |    = 'SERIAL'      |                    |
|                    |                    | scenario\_ghg      |                    |
|                    |                    | =                  |                    |
|                    |                    | 'CHEM\_LBC\_FILE'  |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, FHIST       | 1x1, 2x2           | LBC\_1750-2015\_CM |                    |
|                    |                    | IP6\_GlobAnnAvg\_c |                    |
|                    |                    | 180926.nc          |                    |
|                    |                    |                    |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    |      =             |                    |
|                    |                    | 'CO2','CH4','N2O', |                    |
|                    |                    | 'CFC11eq','CFC12'  |                    |
|                    |                    | flbc\_type         |                    |
|                    |                    |    = 'SERIAL'      |                    |
|                    |                    | scenario\_ghg      |                    |
|                    |                    | =                  |                    |
|                    |                    | 'CHEM\_LBC\_FILE'  |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | flbc\_cycle\_yr    | 2000               |
|                    |                    |  =   2000          |                    |
|                    |                    | flbc\_file         |                    |
|                    |                    |                    |                    |
|                    |                    | =LBC\_2000climo\_C |                    |
|                    |                    | MIP6\_0p5degLat\_c |                    |
|                    |                    | 180227.nc'         |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    |     =              |                    |
|                    |                    | 'CO2','CH4','N2O', |                    |
|                    |                    | 'CFC11eq','CFC12'  |                    |
|                    |                    | flbc\_type         |                    |
|                    |                    |   = 'CYCLICAL'     |                    |
|                    |                    | scenario\_ghg    = |                    |
|                    |                    | 'CHEM\_LBC\_FILE'  |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           | flbc\_cycle\_yr    | 2010               |
|                    |                    | =   2010           |                    |
|                    |                    | flbc\_file         |                    |
|                    |                    |    =               |                    |
|                    |                    | LBC\_2010climo\_CM |                    |
|                    |                    | IP6\_0p5degLat\_c1 |                    |
|                    |                    | 80227.nc           |                    |
|                    |                    | flbc\_list         |                    |
|                    |                    |    =               |                    |
|                    |                    | 'CO2','CH4','N2O', |                    |
|                    |                    | 'CFC11eq','CFC12'  |                    |
|                    |                    | flbc\_type         |                    |
|                    |                    |      = 'CYCLICAL'  |                    |
|                    |                    | scenario\_ghg      |                    |
|                    |                    |       =            |                    |
|                    |                    | 'CHEM\_LBC\_FILE'  |                    |
+--------------------+--------------------+--------------------+--------------------+

Volcanic forcing (same files as ozone forcing)

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | prescribed\_strata |                    |
|                    |                    | ero\_file          |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850, F1850       | 1x1, 2x2           | ozone\_strataero\_ | 1850               |
|                    |                    | cyclical\_WACCM6\_ |                    |
|                    |                    | L70\_CMIP6-piContr |                    |
|                    |                    | ol.001\_y21-50avg\ |                    |
|                    |                    | _zm\_5day\_c180802 |                    |
|                    |                    | .nc                |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, FHIST       | 1x1, 2x2           | ozone\_strataero\_ |                    |
|                    |                    | WACCM\_L70\_zm5day |                    |
|                    |                    | \_18500101-2015010 |                    |
|                    |                    | 3\_CMIP6ensAvg\_c1 |                    |
|                    |                    | 80923.nc           |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1, 2x2           | ozone\_strataero\_ | 2000               |
|                    |                    | CAM6chem\_2000clim |                    |
|                    |                    | o\_zm\_5day\_c1710 |                    |
|                    |                    | 04.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1, 2x2           | ozone\_strataero\_ | 2010               |
|                    |                    | CAM6chem\_2010clim |                    |
|                    |                    | o\_zm\_5day\_c1710 |                    |
|                    |                    | 04.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+

Sea surface temperatures (SSTs)

+--------------------+--------------------+--------------------+--------------------+
| F1850              | 1x1                | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 0.9x1.25\_clim\_pi |                    |
|                    | 2x2                | \_c101028.nc       |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_clim\_pi\ |                    |
|                    |                    | _c101028.nc        |                    |
+--------------------+--------------------+--------------------+--------------------+
| FHIST              | 1x1                | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 0.9x1.25\_1850\_20 |                    |
|                    | 2x2                | 17\_c180507.nc     |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_1850\_201 |                    |
|                    |                    | 7\_c180507.nc      |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1                | sst\_HadOIBl\_bc\_ | 2000               |
|                    |                    | 0.9x1.25\_2000clim |                    |
|                    | 2x2                | o\_c180511.nc      |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_2000climo |                    |
|                    |                    | \_c180511.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1                | sst\_HadOIBl\_bc\_ | 2010               |
|                    |                    | 0.9x1.25\_2010clim |                    |
|                    | 2x2                | o\_c180511.nc      |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_2010climo |                    |
|                    |                    | \_c180511.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+

CAM Initial files

+-------------------------+-------------------------+-------------------------+
|                         |                         | ncdata                  |
+-------------------------+-------------------------+-------------------------+
| B1850                   | 1x1                     | b.e20.B1850.f09\_g17.pi |
|                         |                         | \_control.all.299\_merg |
|                         | 2x2                     | e\_v2.cam.i.0134-01-01- |
|                         |                         | 00000.nc                |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| F1850                   | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| BCO2x4cmip6             | 1x1                     | b.e21.B1850.f09\_g17.CM |
|                         |                         | IP6-piControl.001.cam.i |
|                         | 2x2                     | .0501-01-01-00000.nc    |
+-------------------------+-------------------------+-------------------------+
| B1PCTcmip6              | 1x1                     | b.e21.B1850.f09\_g17.CM |
|                         |                         | IP6-piControl.001.cam.i |
|                         | 2x2                     | .0501-01-01-00000.nc    |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | b.e21.B1850.f09\_g17.CM |
|                         |                         | IP6-piControl.001.cam.i |
|                         | 2x2                     | .0501-01-01-00000.nc    |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| FHIST                   | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| FHIST\_BGC              | 1x1                     | b.e20.BHIST.f09\_g17.20 |
|                         |                         | thC.297\_01\_v2.cam.i.1 |
|                         | 2x2                     | 979-01-01-00000.nc      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| F2000climo              | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| F2010climo              | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+

CO2 cycle

+----------------+----------------+----------------+----------------+----------------+
|                |                | co2\_flag      | co2\_readflux\ | co2\_readflux\ |
|                |                |                | _fuel          | _aircraft      |
+----------------+----------------+----------------+----------------+----------------+
| B1850          | 1x1, 2x2       | true           |                |                |
+----------------+----------------+----------------+----------------+----------------+
| F1850          | 1x1, 2x2       | --             |                |                |
+----------------+----------------+----------------+----------------+----------------+
| BHIST          | 1x1, 2x2       | true           | true           | true           |
+----------------+----------------+----------------+----------------+----------------+
| FHIST          | 1x1, 2x2       |                |                |                |
+----------------+----------------+----------------+----------------+----------------+
| F2000climo     | 1x1, 2x2       |                |                |                |
+----------------+----------------+----------------+----------------+----------------+
| F2010climo     | 1x1, 2x2       |                |                |                |
+----------------+----------------+----------------+----------------+----------------+

CO2 - aircraft

+-------------------------+-------------------------+-------------------------+
|                         |                         | aircraft\_specifier     |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | ac\_CO2\_filelist\_1750 |
|                         |                         | 01-201512\_fv\_0.9x1.25 |
|                         | 2x2                     | \_c20181011.txt         |
|                         |                         |                         |
|                         |                         | ac\_CO2\_filelist\_1750 |
|                         |                         | 01-201512\_fv\_1.9x2.5\ |
|                         |                         | _c20181011.txt          |
+-------------------------+-------------------------+-------------------------+

These txt files contain the following information :

+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | emissions-cmip6\_CO2\_a |
|                         |                         | nthro\_ac\_175001-20151 |
|                         | 2x2                     | 2\_fv\_0.9x1.25\_c20181 |
|                         |                         | 011.nc                  |
|                         |                         |                         |
|                         |                         | emissions-cmip6\_CO2\_a |
|                         |                         | nthro\_ac\_175001-20151 |
|                         |                         | 2\_fv\_1.9x2.5\_c201810 |
|                         |                         | 11.nc                   |
+-------------------------+-------------------------+-------------------------+

CO2 - surface

+-------------------------+-------------------------+-------------------------+
|                         |                         | co2flux\_fuel\_file     |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | emissions-cmip6\_CO2\_a |
|                         |                         | nthro\_surface\_175001- |
|                         | 2x2                     | 201512\_fv\_0.9x1.25\_c |
|                         |                         | 20181011.nc             |
|                         |                         |                         |
|                         |                         | emissions-cmip6\_CO2\_a |
|                         |                         | nthro\_surface\_175001- |
|                         |                         | 201512\_fv\_1.9x2.5\_c2 |
|                         |                         | 0181011.nc              |
+-------------------------+-------------------------+-------------------------+

CLM
""""

Landfraction

+--------------------------------------+--------------------------------------+
|                                      | fatmlndfrc                           |
+--------------------------------------+--------------------------------------+
| 1x1                                  | domain.lnd.fv0.9x1.25\_gx1v7.151020. |
|                                      | nc                                   |
| 2x2                                  |                                      |
|                                      | domain.lnd.fv1.9x2.5\_gx1v7.170518.n |
|                                      | c                                    |
+--------------------------------------+--------------------------------------+

CLM initial files

+-------------------------+-------------------------+-------------------------+
|                         |                         | finidat                 |
+-------------------------+-------------------------+-------------------------+
| B1850                   | 1x1                     | b.e20.B1850.f09\_g17.pi |
|                         |                         | \_control.all.299\_merg |
|                         | 2x2                     | e\_v2.clm2.r.0134-01-01 |
|                         |                         | -00000.nc               |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| BCO2x4cmip6             | 1x1                     | b.e21.B1850.f09\_g17.CM |
|                         |                         | IP6-piControl.001.clm2. |
|                         | 2x2                     | r.0501-01-01-00000.nc   |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| F1850                   | 1x1                     | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         | 2x2                     | 50\_c181029.nc          |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | b.e21.B1850.f09\_g17.CM |
|                         |                         | IP6-piControl.001.clm2. |
|                         | 2x2                     | r.0501-01-01-00000.nc   |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| FHIST                   | 1x1                     | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         | 2x2                     | 00\_c181015.nc          |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+
| FHIST\_BGC              | 1x1                     | b.e20.BHIST.f09\_g17.20 |
|                         |                         | thC.297\_01\_v2.clm2.r. |
|                         | 2x2                     | 1979-01-01-00000.nc     |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+
| F2000climo              | 1x1                     |  clmi.BHIST.2000-01-01. |
|                         |                         | 0.9x1.25\_gx1v7\_simyr2 |
|                         | 2x2                     | 000\_c181015.nc         |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+
| F2010climo              | 1x1                     |  clmi.BHIST.2000-01-01. |
|                         |                         | 0.9x1.25\_gx1v7\_simyr2 |
|                         | 2x2                     | 000\_c181015.nc         |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+

CLM interpolation initial file

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | init\_interp\_meth | use\_init\_interp  |
|                    |                    | od                 |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850              | 1x1                | use\_finidat\_area | true               |
|                    |                    | s                  |                    |
|                    | 2x2                |                    | true               |
|                    |                    | general            |                    |
+--------------------+--------------------+--------------------+--------------------+
| B1850cmip6         | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| F1850              | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| BHIST              | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| FHIST              | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| FHIST\_BGC         | 1x1                | --                 | --                 |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| F2000climo         | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| F2010climo         | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+

CLM surface types

+-------------------------+-------------------------+-------------------------+
|                         |                         | fsurdat                 |
+-------------------------+-------------------------+-------------------------+
| B1850                   | 1x1                     | surfdata\_0.9x1.25\_78p |
|                         |                         | fts\_CMIP6\_simyr1850\_ |
|                         | 2x2                     | c170824.nc              |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_78pf |
|                         |                         | ts\_CMIP6\_simyr1850\_c |
|                         |                         | 170824.nc               |
+-------------------------+-------------------------+-------------------------+
| F1850                   | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r1850\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 1850\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | 1x1                     | surfdata\_0.9x1.25\_78p |
|                         |                         | fts\_CMIP6\_simyr1850\_ |
|                         | 2x2                     | c170824.nc              |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_78pf |
|                         |                         | ts\_CMIP6\_simyr1850\_c |
|                         |                         | 170824.nc               |
+-------------------------+-------------------------+-------------------------+
| FHIST                   | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r1850\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 1850\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+
| FHIST\_BGC              | 1x1                     | surfdata\_0.9x1.25\_78p |
|                         |                         | fts\_CMIP6\_simyr1850\_ |
|                         | 2x2                     | c170824.nc              |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_78pf |
|                         |                         | ts\_CMIP6\_simyr1850\_c |
|                         |                         | 170824.nc               |
+-------------------------+-------------------------+-------------------------+
| F2000climo              | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r2000\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 2000\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+
| F2010climo              | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r2000\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 2000\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+

Rermark) F2000climo and F2010climo use the same fsurdat files.

NorESM
^^^^^^^

CAM
""""

Aerosol emissions

Seperate files are used for 1x1 and 2x2.

Dust emission factor

Always 0.7

Always soil\_erod\_file = dst\_source2x2tunedcam6-2x2-04062017.nc

Ozone forcing

Modified :
components/cam/bld/namelist\_files/use\_cases/1850\_cam6\_oslo.xml

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | prescribed\_ozone\ |                    |
|                    |                    | _file              |                    |
+--------------------+--------------------+--------------------+--------------------+
| N1850, NF1850      | 1x1, 2x2           | ozone\_strataero\_ | 1850               |
|                    |                    | WACCM6\_L70\_zm5da |                    |
|                    |                    | y\_1850climo\_295\ |                    |
|                    |                    | _c180426.nc        |                    |
|                    |                    |                    |                    |
|                    |                    | ozone\_strataero\_ |                    |
|                    |                    | cyclical\_WACCM6\_ |                    |
|                    |                    | L70\_CMIP6-piContr |                    |
|                    |                    | ol.001\_y21-50avg\ |                    |
|                    |                    | _zm\_5day\_c180802 |                    |
|                    |                    | .nc                |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST/FHIST        | 1x1, 2x2           | ozone\_strataero\_ |                    |
|                    |                    | CAM6chem\_1849-201 |                    |
|                    |                    | 4\_zm\_5day\_c1709 |                    |
|                    |                    | 24.nc              |                    |
|                    |                    |                    |                    |
|                    |                    | ozone\_strataero\_ |                    |
|                    |                    | WACCM\_L70\_zm5day |                    |
|                    |                    | \_18500101-2015010 |                    |
|                    |                    | 3\_CMIP6ensAvg\_c1 |                    |
|                    |                    | 80923.nc           |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1, 2x2           | ozone\_strataero\_ | 2000               |
|                    |                    | CAM6chem\_2000clim |                    |
|                    |                    | o\_zm\_5day\_c1710 |                    |
|                    |                    | 04.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+

Oxidants

Modified :
components/cam/bld/namelist\_files/use\_cases/1850\_cam6\_oslo.xml

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | tracer\_cnst\_file |                    |
+--------------------+--------------------+--------------------+--------------------+
| N1850.NF1850       | 1x1, 2x2           | tracer\_cnst\_WACC | 1850               |
|                    |                    | M6\_halons\_3Dmont |                    |
|                    |                    | hlyL70\_1850climo2 |                    |
|                    |                    | 95\_c180426.nc     |                    |
|                    |                    |                    |                    |
|                    |                    | tracer\_cnst\_WACC |                    |
|                    |                    | M6\_halons\_3Dmont |                    |
|                    |                    | hlyL70\_1850climoC |                    |
|                    |                    | MIP6piControl001\_ |                    |
|                    |                    | y21-50avg\_c180802 |                    |
|                    |                    | .nc                |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, NFHIST      | 1x1, 2x2           | tracer\_cnst\_CAM6 |                    |
|                    |                    | chem\_1849-2014\_3 |                    |
|                    |                    | D\_monthly\_c17092 |                    |
|                    |                    | 5.nc               |                    |
|                    |                    |                    |                    |
|                    |                    | tracer\_cnst\_halo |                    |
|                    |                    | ns\_3D\_L70\_1849- |                    |
|                    |                    | 2015\_CMIP6ensAvg\ |                    |
|                    |                    | _c180927.nc        |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1, 2x2           |                    | 2000               |
+--------------------+--------------------+--------------------+--------------------+

H2O emissions

Modified :
components/cam/bld/namelist\_files/use\_cases/1850\_cam6\_oslo.xml

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | ext\_frc\_specifie |                    |
|                    |                    | r                  |                    |
+--------------------+--------------------+--------------------+--------------------+
| N1850. NF1850      | 1x1, 2x2           | H2O\_emission\_CH4 | 1850               |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_3DmonthlyL70\_1 |                    |
|                    |                    | 850climo295\_c1804 |                    |
|                    |                    | 26.nc              |                    |
|                    |                    |                    |                    |
|                    |                    | H2O\_emission\_CH4 |                    |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_3DmonthlyL70\_1 |                    |
|                    |                    | 850climoCMIP6piCon |                    |
|                    |                    | trol001\_y21-50avg |                    |
|                    |                    | \_c180802.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+
| BHIST, FHIST       | 1x1, 2x2           | H2O\_emission\_CH4 |                    |
|                    |                    | \_oxidationx2\_ele |                    |
|                    |                    | v\_1850-2100\_CCMI |                    |
|                    |                    | \_RCP6\_0\_c160219 |                    |
|                    |                    | .nc                |                    |
|                    |                    |                    |                    |
|                    |                    | H2OemissionCH4oxid |                    |
|                    |                    | ationx2\_3D\_L70\_ |                    |
|                    |                    | 1849-2015\_CMIP6en |                    |
|                    |                    | sAvg\_c180927.nc   |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1, 2x2           |                    | 2000               |
+--------------------+--------------------+--------------------+--------------------+

GHG forcing

+--------------------+--------------------+--------------------+--------------------+
| N1850, NF1850      | 1x1, 2x2           | ch4vmr         =   |                    |
|                    |                    |  808.25e-9         |                    |
|                    |                    |                    |                    |
|                    |                    |  co2vmr         =  |                    |
|                    |                    |    284.32e-6       |                    |
|                    |                    |                    |                    |
|                    |                    |  f11vmr         =  |                    |
|                    |                    |    32.11e-12       |                    |
|                    |                    |                    |                    |
|                    |                    |  f12vmr         =  |                    |
|                    |                    |    0.0             |                    |
|                    |                    |                    |                    |
|                    |                    |  flbc\_list        |                    |
|                    |                    |        = ' '       |                    |
|                    |                    |                    |                    |
|                    |                    |  n2ovmr         =  |                    |
|                    |                    |    273.02e-9       |                    |
+--------------------+--------------------+--------------------+--------------------+
| NHIST, NFHIST      | 1x1, 2x2           | LBC\_17500116-2015 |                    |
|                    |                    | 0116\_CMIP6\_0p5de |                    |
|                    |                    | gLat\_c180227.nc   |                    |
|                    |                    |                    |                    |
|                    |                    | LBC\_1750-2015\_CM |                    |
|                    |                    | IP6\_GlobAnnAvg\_c |                    |
|                    |                    | 180926.nc          |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1, 2x2           | (as F2000climo)    | 2000               |
+--------------------+--------------------+--------------------+--------------------+

Remark : so no latitudinal dependence anymore in HIST.

Volcanic forcing

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | prescribed\_volcae |                    |
|                    |                    | ro\_file           |                    |
+--------------------+--------------------+--------------------+--------------------+
| N1850, NF1850      | 1x1, 2x2           | CMIP\_CAM6\_radiat | 1850               |
|                    |                    | ion\_average\_v3\_ |                    |
|                    |                    | reformatted.nc     |                    |
+--------------------+--------------------+--------------------+--------------------+
| NHIST, NFHIST      | 1x1, 2x2           | CMIP\_CAM6\_radiat |                    |
|                    |                    | ion\_v3\_reformatt |                    |
|                    |                    | ed.nc              |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1, 2x2           | CMIP\_CAM6\_radiat | 2000               |
|                    |                    | ion\_v3\_reformatt |                    |
|                    |                    | ed\_1995-2005\_cli |                    |
|                    |                    | m.nc               |                    |
+--------------------+--------------------+--------------------+--------------------+

Sea surface temperatures (SSTs)

+--------------------+--------------------+--------------------+--------------------+
| NF1850             | 1x1                | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 0.9x1.25\_clim\_pi |                    |
|                    | 2x2                | \_c101028.nc       |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_clim\_pi\ |                    |
|                    |                    | _c101028.nc        |                    |
+--------------------+--------------------+--------------------+--------------------+
| NFHIST             | 1x1                | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 0.9x1.25\_1850\_20 |                    |
|                    | 2x2                | 17\_c180507.nc     |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_1850\_201 |                    |
|                    |                    | 7\_c180507.nc      |                    |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1                | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 0.9x1.25\_2000clim |                    |
|                    | 2x2                | o\_c180511.nc      |                    |
|                    |                    |                    |                    |
|                    |                    | sst\_HadOIBl\_bc\_ |                    |
|                    |                    | 1.9x2.5\_2000climo |                    |
|                    |                    | \_c180511.nc       |                    |
+--------------------+--------------------+--------------------+--------------------+

Initial conditions CAM

+-------------------------+-------------------------+-------------------------+
|                         |                         | ncdata                  |
+-------------------------+-------------------------+-------------------------+
| N1850OCBDRDDMS          | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| NF1850                  | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| NHISTOCBDRDDMS          | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| NFHIST                  | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+
| NF2000climo             | 1x1                     | cami-mam3\_0000-01-01\_ |
|                         |                         | 0.9x1.25\_L32\_c141031. |
|                         | 2x2                     | nc                      |
|                         |                         |                         |
|                         |                         | cami-mam3\_0000-01-01\_ |
|                         |                         | 1.9x2.5\_L32\_c150407.n |
|                         |                         | c                       |
+-------------------------+-------------------------+-------------------------+

CO2 cycle

+----------------+----------------+----------------+----------------+----------------+
|                |                | co2\_flag      | dms\_source    |                |
+----------------+----------------+----------------+----------------+----------------+
| N1850OCBDRDDMS | 1x1, 2x2       | true           | ocean\_flux    |                |
+----------------+----------------+----------------+----------------+----------------+
| NF1850         | 1x1, 2x2       | --             | lana           |                |
+----------------+----------------+----------------+----------------+----------------+
| NHISTOCBDRDDMS | 1x1, 2x2       | true           | ocean\_flux    |                |
+----------------+----------------+----------------+----------------+----------------+
| NFHIST         | 1x1, 2x2       | --             | lana           |                |
+----------------+----------------+----------------+----------------+----------------+
| NF2000climo    | 1x1, 2x2       | --             | lana           |                |
+----------------+----------------+----------------+----------------+----------------+

CLM
""""

Land fraction

(still to be added)

Initial conditions CLM

+-------------------------+-------------------------+-------------------------+
|                         |                         | finidat                 |
+-------------------------+-------------------------+-------------------------+
| N1850OCBDRDDMS          | 1x1                     | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         | 2x2                     | 50\_c181029.nc          |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| NF1850                  | 1x1                     | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         | 2x2                     | 50\_c181029.nc          |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| NHISTOCBDRDDMS          | 1x1                     | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         | 2x2                     | 50\_c181029.nc          |
|                         |                         |                         |
|                         |                         | clmi.B1850.1171-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr18 |
|                         |                         | 50\_c181029.nc          |
+-------------------------+-------------------------+-------------------------+
| NFHIST                  | 1x1                     | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         | 2x2                     | 00\_c181015.nc          |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+
| NF2000climo             | 1x1                     | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         | 2x2                     | 00\_c181015.nc          |
|                         |                         |                         |
|                         |                         | clmi.BHIST.2000-01-01.0 |
|                         |                         | .9x1.25\_gx1v7\_simyr20 |
|                         |                         | 00\_c181015.nc          |
+-------------------------+-------------------------+-------------------------+

Remark : some initial files differ from CESM.

CLM interpolation initial file

+--------------------+--------------------+--------------------+--------------------+
|                    |                    | init\_interp\_meth | use\_init\_interp  |
|                    |                    | od                 |                    |
+--------------------+--------------------+--------------------+--------------------+
| N1850OCBDRDDMS     | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| NF1850             | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| NHISTOCBDRDDMS     | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| FHIST              | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+
| NF2000climo        | 1x1                | general            | true               |
|                    |                    |                    |                    |
|                    | 2x2                | general            | true               |
+--------------------+--------------------+--------------------+--------------------+

CLM surface types

+-------------------------+-------------------------+-------------------------+
|                         |                         | fsurdat                 |
+-------------------------+-------------------------+-------------------------+
| N1850OCBDRDDMS          | 1x1                     | surfdata\_0.9x1.25\_78p |
|                         |                         | fts\_CMIP6\_simyr1850\_ |
|                         | 2x2                     | c170824.nc              |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_78pf |
|                         |                         | ts\_CMIP6\_simyr1850\_c |
|                         |                         | 170824.nc               |
+-------------------------+-------------------------+-------------------------+
| NF1850                  | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r1850\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 1850\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+
| NHISTOCBDRDDMS          | 1x1                     | surfdata\_0.9x1.25\_78p |
|                         |                         | fts\_CMIP6\_simyr1850\_ |
|                         | 2x2                     | c170824.nc              |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_78pf |
|                         |                         | ts\_CMIP6\_simyr1850\_c |
|                         |                         | 170824.nc               |
+-------------------------+-------------------------+-------------------------+
| NFHIST                  | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r1850\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 1850\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+
| NF2000climo             | 1x1                     | surfdata\_0.9x1.25\_16p |
|                         |                         | fts\_Irrig\_CMIP6\_simy |
|                         | 2x2                     | r2000\_c170824.nc       |
|                         |                         |                         |
|                         |                         | surfdata\_1.9x2.5\_16pf |
|                         |                         | ts\_Irrig\_CMIP6\_simyr |
|                         |                         | 2000\_c170824.nc        |
+-------------------------+-------------------------+-------------------------+

Different namelist settings between CESM and NorESM
----------------------------------------------------

Namelist for CAM : atm\_in
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------------------------------+----------------------------+------------------------------------+
|                                     | NorESM                     | CESM                               |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | Angular momentum                                                |
+-------------------------------------+----------------------------+------------------------------------+
| fv\_am\_correction                  | true                       |  --                                |
+-------------------------------------+----------------------------+------------------------------------+
| fv\_am\_diag                        | true                       |  --                                |
+-------------------------------------+----------------------------+------------------------------------+
| fv\_am\_fix\_lbl                    | true                       |  --                                | 
+-------------------------------------+----------------------------+------------------------------------+
| fv\_am\_fixer                       | true                       |  --                                |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | Energy conservation correction                                  |
+-------------------------------------+----------------------------+------------------------------------+
| dme\_energy\_adjust                 | true                       |  --                                |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | Deep convection                                                 |
+-------------------------------------+----------------------------+------------------------------------+
| zmconv\_c0\_lnd                     | 0.03                       | 0.0075                             |
+-------------------------------------+----------------------------+------------------------------------+
| zmconv\_c0\_ocn                     | 0.03                       | 0.03                               |
+-------------------------------------+----------------------------+------------------------------------+
| zmconv\_ke                          | 8e-6                       | 5e-6                               |
+-------------------------------------+----------------------------+------------------------------------+
| zmconv\_ke\_lnd                     | 8e-6                       | 1e-5                               |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | Circulation diagnostics                                         |
+-------------------------------------+----------------------------+------------------------------------+
| do\_circulation\_diags              | true                       |  --                                |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | Some general settings                                           |
+-------------------------------------+----------------------------+------------------------------------+
| mode\_defs                          | --                         |                                    |
+-------------------------------------+----------------------------+------------------------------------+
| aer\_drydep\_list                   | --                         | [list of aerosols]                 |
+-------------------------------------+----------------------------+------------------------------------+
| aer\_wetdep\_list                   | --                         | [list of aerosols]                 |
+-------------------------------------+----------------------------+------------------------------------+
| modal\_accum\_coarse-exch           | --                         | true                               |
+-------------------------------------+----------------------------+------------------------------------+
| seasalt\_emis\_scale                | --                         | 1                                  |
+-------------------------------------+----------------------------+------------------------------------+
| clim\_modal\_aero\_top\_press       | --                         | 1e-4                               |
+-------------------------------------+----------------------------+------------------------------------+
| water\_refindex\_file               | --                         | water\_refindex\_rrtmg\_c080910.nc |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | oslo\_ctl\_nl                                                   |
+-------------------------------------+----------------------------+------------------------------------+
| aerotab\_table\_dir                 | ‘/cluster/shared/noresm/…’ | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| dms\_cycle\_year                    | 2000                       | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| dms\_source                         | ‘lana’                     | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| dms\_source\_type                   | ‘CYCLICAL’                 | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| ocean\_filename                     |‘Lana\_ocean\_1849\_2006.nc’| --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| ocean\_filepath                     |‘/cluster/shared/noresm/…’  | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| opom\_cycle\_year                   | 2000                       | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| opom\_source                        | ‘odowd’                    | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| opom\_source\_type                  | ‘CYCLICAL’                 | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| volc\_fraction\_coarse              |  0.0                       | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | prescribed\_volcaero\_nl                                        |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_volcaero\_cycle\_yr      | e.g., 2000                 | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_volcaero\_datapath       |                            | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| prescribed\_volcaero\_file          |                            | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
| prescribed\_volcaero\_type          | e.g., ‘CYCLICAL’           | --                                 |
+-------------------------------------+----------------------------+------------------------------------+
|                                     | prescribed\_strataero\_nl                                       |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_strataero\_cycle\_yr     | --                         | e.g., 2000                         |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_strataero\_datapath      | --                         |                                    |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_strataero\_file          | --                         |                                    |
+-------------------------------------+----------------------------+------------------------------------+
| prescribed\_strataero\_type         | --                         | e.g.,                              |
+-------------------------------------+----------------------------+------------------------------------+
|prescribed\_strataero\_use\_chemtrop | --                         | .false.                            |
+-------------------------------------+----------------------------+------------------------------------+

Remark 1) The oslo\_ctl\_nl variables currently also appear in the CESM
namelist, but they should not.

Namelist for CLM : lnd\_in
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

+-------------------------+-------------------------+-------------------------+
|                         | NorESM                  | CESM                    |
+-------------------------+-------------------------+-------------------------+
| glc\_do\_dynglacier     | .false.                 | .true.                  |
+-------------------------+-------------------------+-------------------------+
| fatmlndfrc              |                         |                         |
+-------------------------+-------------------------+-------------------------+
| finidat                 |                         |                         |
+-------------------------+-------------------------+-------------------------+
| init\_interp\_method    |                         |                         |
+-------------------------+-------------------------+-------------------------+

drv\_in
^^^^^^^^

+-------------------------+-------------------------+-------------------------+
|                         | NorESM                  | CESM                    |
+-------------------------+-------------------------+-------------------------+
| flds\_co2\_dmsb         | .true.                  | .false.                 |
+-------------------------+-------------------------+-------------------------+
| flds\_co2               | .false.                 | .true.                  |
+-------------------------+-------------------------+-------------------------+
| seq\_flds\_i2o\_per\_ca | .false.                 | .true.                  |
| t                       |                         |                         |
+-------------------------+-------------------------+-------------------------+
| alb\_cosz\_avg          | .true.                  | .false.                 |
+-------------------------+-------------------------+-------------------------+
| bfbflag                 | .true.                  | .false                  |
+-------------------------+-------------------------+-------------------------+
| flux\_scheme            | 1                       | 0                       |
+-------------------------+-------------------------+-------------------------+
| glc\_gnam               | null                    | gland4                  |
+-------------------------+-------------------------+-------------------------+
| ice\_gnam               | tnx1v4                  | gx1v7                   |
+-------------------------+-------------------------+-------------------------+
| ocn\_gnam               | tnx1v4                  | gx1v7                   |
+-------------------------+-------------------------+-------------------------+
| wav\_gnam               | null                    | ww3a                    |
+-------------------------+-------------------------+-------------------------+
| glc\_cpl\_dt            | 1800                    | 86400                   |
+-------------------------+-------------------------+-------------------------+

8.3drv\_flds\_in
^^^^^^^^^^^^^^^^

+-------------------------+-------------------------+-------------------------+
|                         | NorESM                  | CESM                    |
+-------------------------+-------------------------+-------------------------+
| megan\_factors\_file    |                         | --                      |
+-------------------------+-------------------------+-------------------------+
| megan\_specifier        |                         | --                      |
+-------------------------+-------------------------+-------------------------+

Merging CESM2.1.0 into NorESM
------------------------------

The branch featureCESMNCARBeta\_trunk2.0-7 (which contains the update
CESM2.1.0) has been merged into the branch featureCESM2-OsloDevelopment.

This is done by :

git config merge.renameLimit 999999

git merge origin/featureCESMNCARBeta\_trunk2.0-7  -X rename-threshold=20
[to have only 20% resemblance needed]

git mergetool [to resolve conflicts]

This however does not update the files which live in specific NorESM
directories (pp\_trop\_mam\_oslo, oslo\_aero, or NorESM).  Those have to
be updated by comparing them with the updates in the original CESM
directories.

Below are listed most of the changes.

Even after the merge, some files (belonging to CESM) had not appeared in
the NorESM structure [lacking].  They have been added too, and maybe
should not be listed here as these were not modified.

CESM12\_deprecated
^^^^^^^^^^^^^^^^^^^^^

Only in noresm-dev-oslo: CESM12\_deprecated [MAYBE CAN BE REMOVED?]

cesm2NorESM.log
^^^^^^^^^^^^^^^^

Only in noresm-dev-oslo: cesm2NorESM.log [MAYBE SHOULD BE UPDATED?]

ChangeLog
^^^^^^^^^^^^

 [MAYBE SHOULD BE UPDATED?]

CIME :
^^^^^^^^

1. config\_archive.xml

REMARK : something on MICOM

MERGE-REMARK : something on rtm and mosart removed

FILE : cime/config/cesm/config\_archive.xml

2. config\_files.xml

REMARK

1) micom

2) mpas-o [QUESTION : DO WE NEED THIS?]

FILE : cime/config/cesm/config\_files.xml

3. config\_grids.xml [MAYBE SHOULD BE CHECKED]

REMARK : extra

a) T62\_tn21

b) tnx2v1

c) ...

REMARK-AUTOMERGE : extra

a) f05\_f05\_mg17

b) 0.47x0.63 : extra gx1v7

c) T42 : update gx1v7 dates

d) T62/tnx1v1 tnx1v3 tnx1v4 tnx0.25v1 tnx0.25v3 tnx0.25v4

e) r05/tnx1v1 tnx1v4 tnx1v3 tnx0.25v1 tnx0.25v3 tnx0.25v4

f) 0.47x0.63

FILE : noresm-dev-oslo/cime/config/cesm/config\_grids.xml

4. config\_batch.xml

REMARK : 0:59:00 instead of 0:20:00

REMARK-MERGE : quite some changes

FILE : cime/config/cesm/machines/config\_batch.xml

5. config\_compilers.xml

REMARK : identical (vilje before defined twice - removed one)

REMARK-MERGE : quite some different machines

FILE :cime/config/cesm/machines/config\_compilers.xml

6. cime\_dir.rst : lacking file

cime/doc/source/users\_guide/cime-dir.rst [CIME-COPIED]

7. case.py

REMARK

1) noresm2netcdf4.sh extra

2) things about "ABOUT YOUR GIT VERSION CONTROL SYSTEM"

FILE

cime/scripts/lib/CIME/case/case.py

8. case\_st-archive.py

REMARK

1) things on fram

2) things on compressing files

3) "import sys" [MAYBE NOT NEEDED?]

FILE

cime/scripts/lib/CIME/case/case\_st\_archive.py

9. env\_batch.py

REMARK

difference is commented out block.  [CAN THIS BE REMOVED?]

FILE

cime/scripts/lib/CIME/XML/env\_batch.py

10. archive\_metadata : lacking

FILE : cime/scripts/Tools/archive\_metadata [CIME-COPIED]

11. case.build

REMARK : return of function has hardcoded 0 (instead of not
args.skip\_provenance\_check)

FILE : cime/scripts/Tools/case.build

12. Makefile

REMARK : something on MICOM (FFLAGS += -DPNETCDF)

FILE : cime/scripts/Tools/Makefile

13. noresm2netcdf4.sh [only in NorESM]

cime/scripts/Tools/noresm2netcdf4.sh

14. docn\_comp\_mod.F90

FILE :noresm-dcime/src/components/data\_comps/docn/docn\_comp\_mod.F90

REMARK : docn\_comp\_mod.F90 exists and is equal in both CESM and NorESM

15. buildnml

REMARK : COSZ\_AVG, OCN\_FLUX\_SCHEME

FILE ; cime/src/drivers/mct/cime\_config/buildnml

16. config\_component\_cesm.xml [MAYBE TO BE CHECKED]

REMARK

1) COMPRESS\_ARCHIVE\_FILES

2) \_MICOM

3) CO2\_DMSA,CO2\_DMSB : links BGC%BPRPDMS to CO2\_DMSA, BGC%BDRDDMS to
CO2\_DMSB, and BGC%DMS to CO2\_DMSB

4) COSZ\_AVG : true for \_CAM5%PTAEROUPD1 \_CAM60%PTAERO,
\_CAM54%PTAERO,\_CAM5%NUDGEPTAEROUPD1,\_CAM54%NUDGEPTAERO,
\_CAM60%NUDGEPTAERO,\_MICO5) OCN\_FLUX\_SCHEME : 1 for ...

FILE :

cime/src/drivers/mct/cime\_config/config\_component\_cesm.xml

17. config\_component.xml

REMARK : for tnx2v1, EPS\_OGRIS = 0.1 instead of 0.01

FILE : cime/src/drivers/mct/cime\_config/config\_component.xml

18. namelist\_definition\_drv.xml

REMARK

1) flds\_co2\_dmsb / CO2\_DMSB

2) $OCN\_FLUX\_SCHEME (instead of 0) [QUESTION : IS THIS OK?]

3) $COSZ\_AVG (instead of 1)            [QUESTION : IS THIS OK?]

FILE

cime/src/drivers/mct/cime\_config/namelist\_definition\_drv.xml

19. seq\_flds\_mod.F90

REMARK : flds\_co2\_dmsb

FILE : cime/src/drivers/mct/shr/seq\_flds\_mod.F90

20. cmake\_config.h.in [copied in]

cime/src/externals/pio2/cmake\_config.h.in [CIME-COPIED]

21. maps

cime/tools/mapping/gen\_mapping\_files/runoff\_to\_ocn/maps [EMPTY
ANYWAY - NOT YET COPIED OVER]

22.-26. lacking files [copied over]

cime/tools/statistical\_ensemble\_test/pyCECT/EET.py [CIME-COPIED]

cime/tools/statistical\_ensemble\_test/pyCECT/ens\_sub.pbs [CIME-COPIED]

cime/tools/statistical\_ensemble\_test/pyCECT/exclude\_empty.json
[CIME-COPIED]

cime/tools/statistical\_ensemble\_test/pyCECT/included\_varlist.json
[CIME-COPIED]

cime/tools/statistical\_ensemble\_test/pyCECT/test\_pyEnsSumPop.sh
[CIME-COPIED]

CIME\_CONFIG
^^^^^^^^^^^^

1. config\_compsets

REMARK

1) our still contains CAM54

2) N1850 NHIST N1850OC N1850OCBPRP N1850OCBPRPDMS N1850OCBDRDDMS
N1850OCDMS N1850P N1850CwWs N1850C5L45BGCR

REMARK-MERGE :

1) B1850 B1850cmip6 BCO2x4cmip6 B1PCTcmip6 BW1850cmip6 ...

2) support grid : should we also do that

3) RUN\_REFDATE, RUN\_TYPE, ... CLM\_NAMELIST\_OPTS (like
use\_init\_interp=.true.)

FILES

cime\_config/config\_compsets.xml

2. config\_pes.xml

REMARK : a lot of vilje/fram things (some commented out) / djlo [SHOULD
BE CHECKED]

FILE : cime\_config/config\_pes.xml

3. n1850r227 [only in NorESM]

FILE : cime\_config/usermods\_dirs/n1850r227 [CAN BE REMOVED LATER]

4. nhistr227

FILE  :cime\_config/usermods\_dirs/nhistr227 [CAN BE REMOVED LATER]

CAM :
^^^^^^^^

1. build-namelist

REMARK

1) flds\_co2\_dmsb

2) \_oslo, \_mam\_oslo

3) avoiding standard cam6 volcanoes when using cam\_oslo

4) old part on dms\_oslo\_emis\_file, ... [CAN MAYBE REMOVED]

5) list of cam\_oslo variables : volc\_fraction\_ coarse,
aerotab\_table\_dir, dms\_source, dms\_source\_type dms\_cycle\_year
ocean\_filename, ocean\_filepath, opom\_source , opom\_source\_type
opom\_cycle\_year

6) use\_hetfrz\_classnuc (phys\_ctl\_nl) set .true. when cam\_oslo  [IS
THIS NEEDED]

FILE

components/cam/bld/build-namelist

2. definition.xml

REMARK

1) "chem" contains possibility of "trop\_mam\_oslo"

2) "ocn" contains possibility of "micom"

FILE

components/cam/bld/config\_files/definition.xml

3. configure

REMARK

1) "chem" contains possibility of "trop\_mam\_oslo"

2) \_oslo then -DOSLO\_AERO -DDIRIND

3) camsrcdir/cam/src/NorESM and camsrcdir/cam/src/NorESM/$dyn [THIS
SHOULD NOT BE ACTIVE WHEN PURE CESM]

4) camsrcdir/cam/src/chemistry/oslo\_aero and
$camsrcdir/cam/src/physics/cam\_oslo (instead of modal\_aero and
bull\_aero)

FILE

components/cam/bld/configure

4. namelist\_defaults\_cam.xml

REMARK

1) prescribed\_aero\_datapath/file/model/ ... in case of "aer\_model =
oslo" [but probably not used]

2) aerodep\_flx\_datapath/file/type/cycle\_yr in case of "aer\_model =
oslo" [but probably not used]

3) something on micro\_do\_sb\_physics : but commented out [can probably
be removed]

4) something on dust\_emis\_fact in case of trop\_mam\_oslo, but
commented out : can probably be removed.  However, still used for cam6,
so maybe to keep here istead of in other namelist; can be resolution
dependent

5) THT had commented out volc\_fraction, aerotab\_table\_dir, ... :
still active in norESM version [so activated again] [HOW TO
ACTIVATE/DEACTIVATE?]

FILE

components/cam/bld/namelist\_files/namelist\_defaults\_cam.xml

5. namelist\_definition.xml

REMARK

1) cam\_chempkg : trop\_mam\_oslo extra

2) dme\_energy\_adjust extra

3) flds\_co2\_dmsb : active (while commented out in ncar)

4) volc\_fraction\_coarse, aerotab\_table\_dir, ... : active (but
commented out in ncar)

FILE

components/cam/bld/namelist\_files/namelist\_definition.xml

Files in NorESM

components/cam/bld/namelist\_files/use\_cases/1850\_cam54\_ptaero.xml

components/cam/bld/namelist\_files/use\_cases/1850\_cam5\_ptaero.xml

components/cam/bld/namelist\_files/use\_cases/1850\_cam6\_oslo.xml

components/cam/bld/namelist\_files/use\_cases/2000\_cam6\_noclb\_oslonudge.xml

components/cam/bld/namelist\_files/use\_cases/2000\_cam6\_noclb\_oslo.xml

components/cam/bld/namelist\_files/use\_cases/2000\_cam6\_noclb.xml

components/cam/bld/namelist\_files/use\_cases/2000\_cam6\_oslonudge.xml

components/cam/bld/namelist\_files/use\_cases/2000\_cam6\_oslo.xml

components/cam/bld/namelist\_files/use\_cases/cam54\_ptaero\_up1.xml

components/cam/bld/namelist\_files/use\_cases/cam5\_nudge\_ptaero\_up1.xml

components/cam/bld/namelist\_files/use\_cases/cam5\_ptaero\_up1.xml

Lacking file [copied over]

components/cam/bld/namelist\_files/use\_cases/dctest\_tj2016.xml
[CAM-COPIED]

Only in NorESM

components/cam/bld/namelist\_files/use\_cases/hist\_cam6\_oslo.xml

Lacking file [copied over]

components/cam/bld/namelist\_files/use\_cases/hist\_trop\_strat\_vbsext\_cam6.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/hist\_trop\_strat\_vbsfire\_cam6.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/sd\_cam6.xml [CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/sd\_waccm\_ma\_cam4.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/waccm\_ma\_hist\_cam4.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/waccm\_sc\_1850\_cam6.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/waccm\_sc\_2000\_cam6.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/waccm\_sc\_2010\_cam6.xml
[CAM-COPIED]

components/cam/bld/namelist\_files/use\_cases/waccm\_tsmlt\_2010\_cam6.xml
[CAM-COPIED]

components/cam/bld/scripts/remapfv2eul.ncl [CAM-COPIED]

components/cam/chem\_proc/bin [CAM-COPIED]

components/cam/chem\_proc/output [CAM-COPIED]

components/cam/chem\_proc/src/OBJ [CAM-COPIED]

components/cam/chem\_proc/tmp [CAM-COPIED]

6. buildnml

REMARK : DMS\_MODE                = case.get\_value("CCSM\_BGC")

FILE :components/cam/cime\_config/buildnml

7. config\_component.xml

REMARK

1)  ...PTAERO... / ...NUDGEPTAERO... things [DO WE KEEP ALL THOSE?]

2) CAM54

3) \_BGC%BDRD, \_BGC%BPRPDMS (extra), \_BGC%BDRDDMS (extra), \_BGC%DMS
(extra) (CESM only has \_BGC%BDRD)

FILE

components/cam/cime\_config/config\_component.xml

8. config\_compsets.xml

REMARK

1) NF2000climo [CROP ...]

2) extra combinations with g%null... SGLC instead of g%gland4
...CISM2%NOEVOLVE (3 times: RUN\_TYPE, RUN\_REFCASE, RUN\_REFDATE,
RUN\_REFDIR)

FILE

components/cam/cime\_config/config\_compsets.xml

9. config\_pes.xml

REMARK : only extra is vilje\|hexagon on 1.9x2.5

FILE : components/cam/cime\_config/config\_pes.xml

Lacking files [copied over]

components/cam/cime\_config/testdefs/testmods\_dirs/cam/nudging
[CAM-COPIED]

components/cam/cime\_config/testdefs/testmods\_dirs/cam/outfrq1d\_amie
[CAM-COPIED]

components/cam/cime\_config/testdefs/testmods\_dirs/cam/outfrq9s\_amie
[CAM-COPIED]

components/cam/cime\_config/testdefs/testmods\_dirs/cam/outfrq9s\_sd
[CAM-COPIED]

components/cam/cime\_config/testdefs/testmods\_dirs/cam/waccmx\_weimer
[CAM-COPIED]

components/cam/cime\_config/usermods\_dirs/CMIP6\_B1850 [CAM-COPIED]

components/cam/cime\_config/usermods\_dirs/CMIP6\_B1850\_WACCM
[CAM-COPIED]

components/cam/cime\_config/usermods\_dirs/CMIP6\_BHIST

components/cam/cime\_config/usermods\_dirs/CMIP6\_BHIST\_ WACCM
[CAM-COPIED]

components/cam/cime\_config/usermods\_dirs/CMIP6\_GENERIC [CAM-COPIED]

10. chemistry.F90

REMARK : CT\_H2O\_GHG instead of CT\_H2O (only affects diagnostics)

FILES : components/cam/src/chemistry/mozart/chemistry.F90

Oslo\_aero : components/cam/src/chemistry/oslo\_aero
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This directory contains files which are only used by CAM-Oslo, or CESM
files which have been modified to be used in CAM-Oslo.

When files have a CESM analogue, the location of that analogue is
mentioned.  If that analogue is updated, one should also update the
CAM-Oslo version

1. aero\_model.F90

REMARK

1) contains #include <preprocessorDefinitions.h>

2) has\_sox boolean is not used [NOT A DRAMA]

3) contains empty versions of subroutines (which are used in CAM)

subroutine aero\_model\_readnl

subroutine aero\_model\_register

subroutine aero\_model\_init

subroutine aero\_model\_drydep : contains call calcaersize\_sub and call
oslo\_aero\_dry\_intr

subroutine aero\_model\_wetdep : contains call oslo\_aero\_wet\_intr

subroutine aero\_model\_surfarea : not  empty

subroutine aero\_model\_strat\_surfarea : shorter

subroutine aero\_model\_gasaerexch

subroutine aero\_model\_emissions

subroutine surf\_area\_dens

subroutine modal\_aero\_bcscavcoef\_init

subroutine modal\_aero\_depvel\_part

subroutine modal\_aero\_bcscavcoef\_get

subroutine calc\_1\_impact\_rate [NOT in oslo\_aero]

subroutine qqcw2vmr

subroutine vmr2qqcw

FILES

cam/src/chemistry/oslo\_aero/aero\_model.F90 [SHOULD WE UPDATE THE
DUST?]

cam/src/chemistry/bulk\_aero/aero\_model.F90 [NEW : history\_dust]

cam/src/chemistry/modal\_aero/aero\_model.F90[NEW : history\_dust]

2. aeronucl.F90

cam/src/chemistry/oslo\_aero/aeronucl.F90

3. aerosoldef.F90

cam/src/chemistry/oslo\_aero/aerosoldef.F90

4. appformrate.F90

cam/src/chemistry/oslo\_aero/appformrate.F90

5. calcaersize.F90

cam/src/chemistry/oslo\_aero/calcaersize.F90

6. commondefinitions.F90

cam/src/chemistry/oslo\_aero/commondefinitions.F90

cam/tools/AeroTab/commondefinitions.F90 [NOT RELEVANT]

7. condtend.F90

cam/src/chemistry/oslo\_aero/condtend.F90

8. constants.F90

cam/src/chemistry/oslo\_aero/constants.F90

9. const.F90

cam/src/chemistry/oslo\_aero/const.F90

10. dust\_model.F90

cam/src/chemistry/oslo\_aero/dust\_model.F90

cam/src/chemistry/bulk\_aero/dust\_model.F90 [NO CHANGE]

cam/src/chemistry/modal\_aero/dust\_model.F90 [NO CHANGE]

11. dust\_sediment\_mod.F90

cam/src/chemistry/oslo\_aero/dust\_sediment\_mod.F90

cam/src/chemistry/aerosol/dust\_sediment\_mod.F90 [NO CHANGE]

12. hetfrz\_classnuc\_oslo.F90

REMARK : very different [SHOULD THIS BE CHECKED/UPDATED AT SOME POINT]

cam\_oslo CONTAINS :

subroutine hetfrz\_classnuc\_oslo\_readnl

subroutine hetfrz\_classnuc\_oslo\_register

subroutine hetfrz\_classnuc\_oslo\_init

subroutine hetfrz\_classnuc\_oslo\_calc

subroutine hetfrz\_classnuc\_oslo\_save\_cbaero

subroutine get\_aer\_num

standards cam CONTAINS :

subroutine hetfrz\_classnuc\_init

subroutine hetfrz\_classnuc\_calc

subroutine collkernel

subroutine hetfrz\_classnuc\_init\_pdftheta

FILES :

cam/src/chemistry/oslo\_aero/hetfrz\_classnuc\_oslo.F90

cam/src/physics/cam/hetfrz\_classnuc.F90 [NO CHANGE]

13. initlogn.F90

cam/src/chemistry/oslo\_aero/initlogn.F90

14. intlog1to3.F90

cam/src/chemistry/oslo\_aero/intlog1to3.F90

15. intlog4.F90

cam/src/chemistry/oslo\_aero/intlog4.F90

16. intlog5to10.F90

cam/src/chemistry/oslo\_aero/intlog5to10.F90

17. koagsub.F90

cam/src/chemistry/oslo\_aero/koagsub.F90

18. microp\_aero.F90

cam/src/chemistry/oslo\_aero/microp\_aero.F90

19. mo\_chm\_diags.F90

REMARK :

1. does not have history\_dust [SHOULD WE ADD IT?]

2. has WD\_A (aersol deposition) [MAYBE NOT NEEDED ANYMORE] [SHOULD BE
CHECKED]

3. has a lot of extra output : SRF, mmr\_AEROSOLTYPE, cb\_AEROSOLTYPE,
cloud-tracers

4. subroutine chm\_diags(...,pbuf) : extra argument

FILES :

cam/src/chemistry/oslo\_aero/mo\_chm\_diags.F90 : [SKIPPED :
do\_neu\_wetdep]

cam/src/chemistry/mozart/mo\_chm\_diags.F90 [NEW : history\_dust]

20. modal\_aero\_data.F90

REMARK : very different

FILES :

cam/src/chemistry/oslo\_aero/modal\_aero\_data.F90

cam/src/chemistry/modal\_aero/modal\_aero\_data.F90 [NO CHANGE]

21. modal\_aero\_deposition.F90

REMARK

1) considerably different

2) assignment to cam\_out%ocphidry, ... happens here

FILES

cam/src/chemistry/oslo\_aero/modal\_aero\_deposition.F90

cam/src/chemistry/utils/modal\_aero\_deposition.F90 [NO CHANGE]

22. modalapp2d.F90

./cam/src/chemistry/oslo\_aero/modalapp2d.F90

23. mo\_drydep.F90

REMARK : Only difference : prog\_modal\_aero = .TRUE. (#ifdef
OSLO\_AERO)

FILES

cam/src/chemistry/oslo\_aero/mo\_drydep.F90

cam/src/chemistry/mozart/mo\_drydep.F90 [NO CHANGE]

24. mo\_extfrc.F90

REMARK : Only difference is a typo

FILES

cam/src/chemistry/oslo\_aero/mo\_extfrc.F90

cam/src/chemistry/mozart/mo\_extfrc.F90 [NO CHANGE]

25. mo\_gas\_phase\_chemdr.F90

REMARK

1. treatment of oxidant climatologies : IHK

2. call chm\_diags(...,pbuf) : has extra argument

3. most of differences by #ifdef OSLO\_AERO, but not all (so little bit
inconsistent)

FILES

cam/src/chemistry/oslo\_aero/mo\_gas\_phase\_chemdr.F90 [I removed
"is\_first\_timestep"]

cam/src/chemistry/mozart/mo\_gas\_phase\_chemdr.F90 [is\_first\_timestep
: DISAPPEARED]

26. mo\_neu\_wetdep.F90

REMARK : oslo\_aero has this output in case of NEU : WD\_A [THIS CAN
PROBABLY BE REMOVED]

FILES

cam/src/chemistry/oslo\_aero/mo\_neu\_wetdep.F90 [do\_neu\_wetdep was
not in agreement : corrected this]

cam/src/chemistry/mozart/mo\_neu\_wetdep.F90 [NO CHANGE]

27. mo\_setsox.F90

REMARK

1) only difference : cloud\_borne = .TRUE. , modal\_aerosols = .TRUE.

2) all well with OSLO\_AERO

FILES

cam/src/chemistry/oslo\_aero/mo\_setsox.F90

cam/src/chemistry/aerosol/mo\_setsox.F90 [NO CHANGE]

28. mo\_srf\_emissions.F90

REMARK

1) only difference related to DMS

2) not completely consistent with #OSLO\_AERO  

FILES

cam/src/chemistry/oslo\_aero/mo\_srf\_emissions.F90

cam/src/chemistry/mozart/mo\_srf\_emissions.F90 [NO CHANGE]

29. mo\_usrrxt.F90

REMARK

1) only difference : nmodes / nmodes\_oslo / ntot\_amode

2) consistent with #OSLO\_AERO

FILES

cam/src/chemistry/oslo\_aero/mo\_usrrxt.F90

cam/src/chemistry/mozart/mo\_usrrxt.F90 [NO CHANGE]

30. ndrop.F90

REMARK : complicated [WORTH CHECKING]

FILES

cam/src/chemistry/oslo\_aero/ndrop.F90

cam/src/physics/cam/ndrop.F90 [NO CHANGE]

31a. nucleate\_ice\_oslo.F90

REMARK

1) considerably different

2) subroutines have "\_oslo" instead of "\_cam"

FILES :

cam/src/chemistry/oslo\_aero/nucleate\_ice\_oslo.F90

cam/src/physics/cam/nucleate\_ice\_cam.F90 [NO CHANGE]

31b. nucleate\_ice.F90

cam/src/physics/cam/nucleate\_ice.F90 [NO CHANGE] [probably used by both
...]

32. oslo\_aerosols\_intr.F90

REMARK :

1) complicated comparison

2) contains

subroutine oslo\_aero\_initialize   (based on aerol\_model\_init)

subroutine oslo\_aero\_dry\_intr         (based on aero\_model\_drydep,
but more arguments)

subroutine oslo\_aero\_wet\_intr         (based on aero\_model\_wetdep,
same arguments)

subroutine modal\_aero\_depvel\_part (as modal\_aero\_depvel\_part)

3) contains implicit solving method for tracers with short lifetime

FILE

cam/src/chemistry/oslo\_aero/oslo\_aerosols\_intr.F90 [SHOULD WE TAKE
THIS OVER]

cam/src/chemistry/modal\_aero/aero\_model.F90 [NEW : history\_dust]

33. oslo\_ocean\_intr.F90

cam/src/chemistry/oslo\_aero/oslo\_ocean\_intr.F90

34. oslo\_utils.F90

cam/src/chemistry/oslo\_aero/oslo\_utils.F90

35. oxi\_diurnal\_var.F90

REMARK

because CAM-Oslo has diurnal variation

FILE

cam/src/chemistry/oslo\_aero/oxi\_diurnal\_var.F90

36. parmix\_progncdnc.F90

FILE

cam/src/chemistry/oslo\_aero/parmix\_progncdnc.F90

37. seasalt\_model.F90

REMARK

considerably different

FILES

cam/src/chemistry/oslo\_aero/seasalt\_model.F90

cam/src/chemistry/bulk\_aero/seasalt\_model.F90 [NO CHANGE]

cam/src/chemistry/modal\_aero/seasalt\_model.F90 [NO CHANGE]

38. sox\_cldaero\_mod.F90

REMARK :

1) considerably different

2) shouldn't aqh2so4(:,n)=aqh2so4(:,n) + ... be
aqh2so4(i,n)=aqh2so4(i,n)+ ... [I THINK IT IS WRONG] It is probably a
column-integrated diagnostic, so it will not affect the simulation.

FILES

cam/src/chemistry/oslo\_aero/sox\_cldaero\_mod.F90

cam/src/chemistry/bulk\_aero/sox\_cldaero\_mod.F90 [NO CHANGE]

cam/src/chemistry/modal\_aero/sox\_cldaero\_mod.F90 [NO CHANGE]

39. vertical\_diffusion.F90

REMARK

1) prog\_modal\_aero = .TRUE. (#ifdef OSLO\_AERO)

2) some extra output (AL)

3) Oslo aero adds emissions together with dry deposition : process not
done here but somewhere else

FILES

cam/src/chemistry/oslo\_aero/vertical\_diffusion.F90

cam/src/physics/cam/vertical\_diffusion.F90 [NO CHANGE]

40. zm\_microphysics.F90

REMARK :

only difference : call activate\_modal(...) commented out

FILES

cam/src/chemistry/oslo\_aero/zm\_microphysics.F90

cam/src/physics/cam/zm\_microphysics.F90 [NO CHANGE]

Only in noresm-dev-oslo/components/cam/src/chemistry/pp\_trop\_mam\_oslo
[WHOLE DIRECTORY]

pp\_trop\_mam4 [NO CHANGE]

pp\_trop\_mam7 [NO CHANGE]

Only in
noresm-dev-ncar/components/cam/src/chemistry/pp\_trop\_strat\_mam4\_vbsext
[CAM-COPIED]

Only in noresm-dev-ncar/components/cam/src/chemistry/pp\_waccm\_mad
[CAM-COPIED]

CONTINUATION STANDARD CAM DIRECTORY :

41. prescribed\_volcaero.F90

REMARK

1) is in directory which is normally not touched for CAM-Oslo
developments

2) prescribed\_volcaero.F90 has been further developed for CAM-Oslo

3) new has\_prescribed\_volcaero\_cmip6,solar\_bands,terrestrial\_bands,
has\_prescribed\_volcaero\_cmip6

FILE

components/cam/src/chemistry/utils/prescribed\_volcaero.F90

42. runtime\_opts.F90

REMARK

1) is in directory which is normally not toucjed for CAM-Oslo
developments

2) call oslo\_ctl\_readnl(nlfilename) #if (defined OSLO\_AERO)

3) nicely used #if (defined OSLO\_AERO)

FILE

components/cam/src/control/runtime\_opts.F90

NORESM : components/cam/src/NorESM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This directory contains files which have a CESM version but are modified
to run NorESM.  

We mention therefore here the file as it can be found in the
NorESM-directory, but also the location of the original CESM file it is
based on.

When the original CESM is updated, the corresponding NorESM file should
also be updated.

1. cam\_diagnostics.F90

REMARK

1) contains #include <preprocessorDefinitions.h>

2) ixcldice, ixcldliq, ixcldni, ixcldnc : defined in diag\_init\_dry
(but not used [COULD BE REMOVED])

3) contains AL changes

4) contains a lot of Aerocom output

5) call outfld for m=1.pcnst

FILE :

components/cam/src/NorESM/cam\_diagnostics.F90 [UPDATED with most of the
cam changes]

components/cam/src/physics/cam/cam\_diagnostics.F90 [CHANGE : quite some
changes

1) energy and angular momentum diagnostics : shifted from subroutine
diag\_init\_moist to subroutine diag\_init\_dry [IS THIS OK]

2) pbuf for some of the arguments

3) PSL added in buffer

4) extra iftest if (ixcldliq > 0) then

5) subroutine diag\_phys\_writeout\_dry and diag\_phys\_writeout\_moist
: arguments changed]

2. macrop\_driver.F90

REMARK

1) contains AL (Anna Lewinschal) extra output

2) why not in oslo\_aero directory?

FILE

cam/src/NorESM/macrop\_driver.F90

cam/src/physics/cam/macrop\_driver.F90

3. micro\_mg1\_0.F90

REMARK : contains AL extra output

FILE

cam/src/NorESM/micro\_mg1\_0.F90

cam/src/physics/cam/micro\_mg1\_0.F90

4. micro\_mg2\_0.F90

REMARK : contains AL changes

FILE

cam/src/NorESM/micro\_mg2\_0.F90

cam/src/physics/cam/micro\_mg2\_0.F90 [Andrew Gettleman  comment
disappeared - NO OTHER

5. micro\_mg\_cam.F90

REMARK :

1) contains AL changes

2) contains IHK (Bennartz) changes

3) contains AKC6 changes

FILE

cam/src/NorESM/micro\_mg\_cam.F90

cam/src/physics/cam/micro\_mg\_cam.F90 [NO CHANGE]

6. phys\_control.F90

REMARK

1) only remaining difference pro\_modal\_aer = .FALSE.

2) nicely uses #ifdef OSLO\_AERO

FILE

cam/src/NorESM/phys\_control.F90 : ADDED history\_dust [SO MAYBE ALSO
EVERYWHERE ELSE?]

cam/src/physics/cam/phys\_control.F90 [NEW : history\_dust]

7. physpkg.F90 : should be checked !!!

REMARK

1) contains include <preprocessorDefinitions.h> : is that still needed?

2) contains AL variables, DIRIND, AEROCOM

3) contains call oslo\_ocean\_intr with #ifdef CAM\_OSLO

4) maybe an m-index is not used

TO BE CHECKED !!!!! :

CHECK DYCORE IFs !!!!

CHECK call calc\_te\_and\_aam\_budgets !!! (looks fine)

FILES :

cam/src/NorESM/physpkg.F90 : REMOVED infnan (was used to initialise some
arrays (probably for testing)), changed diag\_phys\_writeout

cam/src/physics/cam/physpkg.F90 [CHANGE : quite some changes; infnan
removed, nudging, co2\_cycle, THT changes are different, dycore,
diag\_phys\_writeout]

cam/src/physics/cam/physpkg.F90.beta07

cam/src/physics/simple/physpkg.F90 [CHANGE : quite some, e.g. tj2016]

8. zm\_conv.F90

REMARK : contains THT modifications

FILES

cam/src/NorESM/zm\_conv.F90

cam/src/physics/cam/zm\_conv.F90 [NO CHANGE]

9. zm\_conv\_intr.F90

REMARK : contains THT modifications

FILES

cam/src/NorESM/zm\_conv\_intr.F90

cam/src/physics/cam/zm\_conv\_intr.F90 [NO CHANGE]

10. fv/dp\_coupling.F90   

REMARK :

1) extra test : (iam .lt. grid%npes\_xy)

2) contains THT changes related to ixcldice and ixcldliq [IS THIS OK]

FILES

cam/src/NorESM/fv/dp\_coupling.F90

cam/src/dynamics/fv/dp\_coupling.F90 [NO CHANGE]

cam/src/dynamics/se/dp\_coupling.F90

cam/src/dynamics/eul/dp\_coupling.F90

11. fv/metdata.F90

REMARK

contains IHK uvps : does not nudge

1) stress and heat fluxes

2) TS and SNOWH

3) T and Q

FILES

cam/src/NorESM/fv/metdata.F90 [HAVE taken over all changes, and tried to
keep IH changes]

cam/src/dynamics/fv/metdata.F90 [QUITE SOME CHANGES]

OUTSIDE STANDARD :

noresm-dev-oslo/components/cam/src/physics/cam/check\_energy.F90

noresm-dev-ncar/components/cam/src/physics/cam/check\_energy.F90 [only a
different comment]

File remnants from earlier updates

Only in
noresm-dev-oslo/components/cam/src/physics/cam/check\_energy.F90.orig

Only in
noresm-dev-oslo/components/cam/src/physics/cam/clubb\_intr.F90.beta07

Only in
noresm-dev-oslo/components/cam/src/physics/cam/micro\_mg2\_0.F90.orig

Only in
noresm-dev-ncar/components/cam/src/physics/cam/physics\_types.F90.unupdated

Only in
noresm-dev-oslo/components/cam/src/physics/cam/physpkg.F90.beta07

Only in
noresm-dev-ncar/components/cam/src/physics/cam/physpkg.F90.unupdated

Only in
noresm-dev-oslo/components/cam/src/physics/cam/vertical\_diffusion.F90.beta07

CAM\_OSLO : components/cam/src/physics/cam\_oslo
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This directory contains subroutines for the CAM-Oslo aerosol scheme.
 They are specific to that scheme and have for most of them no
corresponding CESM version.

Files only in NorESM

1. aerocopt2.h

2. aerocopt.h

3. aerodry.h

4. aero\_to\_srf.F90

5. checkTableHeader.F90

6. coltst4intcons.F90

7. initaeropt.F90

8. initdryp.F90

9. inputForInterpol.F90

10. intaeropt0.F90

11. intaeropt1.F90

13. intaeropt2to3.F90

14. intaeropt4.F90

15. intaeropt5to10.F90

16. intdrypar0.F90

17. intdrypar1.F90

18. intdrypar2to3.F90

19. intdrypar4.F90

20. intdrypar5to10.F90

21. intfrh.F90

22. lininterpol3dim.F90

23. lininterpol4dim.F90

24. lininterpol5dim.F90

25. opticsAtConstRh.F90

26. optinterpol.F90

27. opttab.F90

28. opttab\_lw.F90

29. oslo\_control.F90

30. pmxsub.F90

31. preprocessorDefinitions.h 

REMARK contains

#undef AEROCOM

#undef AEROFFL

#undef COLTST4INTCONS

#undef AEROCOM\_INSITU

32. ptaero\_table.F90

33. radiation.F90 [probably OK]

REMARK

1) based on rrtmg-version

2) contains #include <preprocessorDefinitions.h>

3) contains #DIRIND AEROCOM AEROFFL

4) uses volc\_fraction\_coarse [IS THIS WELL SET]

FILE :

components/cam/src/physics/cam\_oslo/radiation.F90 [updated based on
rrtmg version]

components/cam/src/physics/camrt/radiation.F90 [contains 2 modified THT
lines]

components/cam/src/physics/simple/radiation.F90

components/cam/src/physics/rrtmg/radiation.F90 [updated with

1)FLNTCLR, FREQCLR

2) 0 -> 0.\_r8

3) subroutine radiation\_output\_lw(..., freqclr, flntclr) : two extra
arguments

4) call radiation\_output\_lw(..., freqclr, flntclr) : two extra
arguments ]

Lacking files

components/cam/src/physics/waccmx/trsolv\_mod.F90 [CAM-COPIED]

components/cam/test/system/config\_files/f0.9c6aqccdm [CAM-COPIED]

components/cam/test/system/config\_files/f10c6aqtsvbsxdm [CAM-COPIED]

components/cam/test/system/config\_files/f1.9c6aqtsvbsxdh [CAM-COPIED]

components/cam/test/system/tests\_waccmx\_mpi [CAM-COPIED]

Files only in NorESM

components/cam/tools/aerocom

components/cam/tools/aerocom3-PNSD\_scripts-and-code

components/cam/tools/AeroTab

components/cam/tools/diagnostics

components/cam/tools/emis

CICE
^^^^^^^^^

1. check\_decomp.csh

REMARK : extra resolutions : tnx1v1 tnx0.25v1 tnx1v3 tnx1v4

FILE : components/cice/bld/check\_decomp.csh

2. buildnml

REMARK

1) ocn\_model

2) snowphys\_nml

FILE

components/cice/cime\_config/buildnml

3. config\_component.xml

REMARK : missed CICE\_NAMELIST\_OPTS / \_CAM4 [SHOULD THIS BE PRESENT?]

FILE : components/cice/cime\_config/config\_component.xml

4. namelist\_definition\_cice.xml

REMARK

1) extra grids :tnx2v1 tnx1v1 tnx1v3 tnx1v4 tnx0.25v1 tnx0.25v3
tnx0.25v4

2) extra snowphys\_nml  : blowingsnow, rhos, ksno

3) update\_ocn\_f (commented out in NCAR)

4) f\_sn2oc, f\_snfonice (instead of f\_dsnow)

FILE

components/cice/cime\_config/namelist\_definition\_cice.xml

5. ice\_constants.F90

REMARK

1) extra rhos and ksno (in module)

2) rhos          = 330.0\_dbl\_kind and ksno   = 0.30\_dbl\_kind :
commented out

FILE

components/cice/src/drivers/cesm/ice\_constants.F90

6. ice\_prescribed\_mod.F90

REMARK : several parameters commented out

FILE : components/cice/src/drivers/cesm/ice\_prescribed\_mod.F90

7. ice\_flux.F90

REMARK : snow2ocn, snowfonice, ... extra

FILE : components/cice/src/source/ice\_flux.F90

8. ice\_history.F90

REMARK : f\_sn2oc, f\_snfonice : extra

FILE : components/cice/src/source/ice\_history.F90

9. ice\_history\_shared.F90

REMARK : f\_sn2oc, \_snfonice : extra

FILE : components/cice/src/source/ice\_history\_shared.F90

10. ice\_init.F90

REMARK : rhos, ksno, blowingsnow : extra

FILE : components/cice/src/source/ice\_init.F90

11. ice\_itd.F90

REMARK : max\_error = puny\*Lfresh\*rhos : described later

FILE : components/cice/src/source/ice\_itd.F90

12. ice\_snowphys\_mod.F90

REMARK : This file only exists for NorESM

FILE : components/cice/src/source/ice\_snowphys\_mod.F90

13. ice\_step\_mod.F90

REMARK : blowingsnow,snowphys\_snowfonice,snowfonicen, snow2ocnn,
snowfonice, snow2ocn : extra

FILE : components/cice/src/source/ice\_step\_mod.F90

14. ice\_therm\_mushy.F90

REMARK A = c1 / (rhos \* cp\_ice) : variable instead of parameter [DOES
IT MATTER?]

FILE : components/cice/src/source/ice\_therm\_mushy.F90

CISM
^^^^^^^^^

Lacking file :

Only in noresm-dev-ncar/components/cism/doc [CISM-COPIED]

Lacking file [not copied over]

components/cism/manage\_externals/test/repos/container.git

components/cism/manage\_externals/test/repos/mixed-cont-ext.git

components/cism/manage\_externals/test/repos/simple-ext-fork.git

components/cism/manage\_externals/test/repos/simple-ext.git

CLM
^^^^

Lacking file :

components/clm/bld/namelist\_files/createMkSrfEntry.py [CLM-COPIED]

1) namelist\_definition\_clm4\_5.xml

REMARK : extra grids :
tnx1v1,tnx0.25v1,tnx0.25v3,tnx0.25v4,tnx1v4,tnx1v3

FILE :
components/clm/bld/namelist\_files/namelist\_definition\_clm4\_5.xml

Lacking file :

components/clm/bld/namelist\_files/use\_cases/2010\_control.xml
[CLM-COPIED]

2) buildnml

REMARK :

1) ocn\_grid = case.get\_value("OCN\_GRID")

2) extra if test : tnx1v1, tnx0.25v1, tnx1v3, tnx1v4, tnx0.25v3,
tnx0.25v4

FILE:

noresm-dev-oslo/components/clm/cime\_config/buildnml

Lacking files

components/clm/cime\_config/testdefs/testmods\_dirs/clm/basic
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/clm50cam6LndTuningMode
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/cmip6\_deck
 [CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/DA\_multidrv
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/output\_bgc\_highfreq
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/output\_crop\_highfreq
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/output\_sp\_highfreq
[CLM-COPIED]

components/clm/cime\_config/testdefs/testmods\_dirs/clm/waccmx\_offline
[CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/cmip6\_deck [CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/cmip6\_waccm\_deck
[CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/\_includes [CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_bgc [CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_bgc\_highfreq
[CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_crop [CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_crop\_highfreq
[CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_sp [CLM-COPIED]

components/clm/cime\_config/usermods\_dirs/output\_sp\_highfreq
[CLM-COPIED]

components/clm/CONTRIBUTING.md [CLM-COPIED]

components/clm/CTSMMasterChecklist [CLM-COPIED]

components/clm/doc/clm5\_0\_ChangeLog [CLM-COPIED]

components/clm/doc/design [CLM-COPIED]

Lacking files (not taken over)

components/clm/manage\_externals/test/repos/container.git

components/clm/manage\_externals/test/repos/mixed-cont-ext.git

components/clm/manage\_externals/test/repos/simple-ext-fork.git

components/clm/manage\_externals/test/repos/simple-ext.git

3. SoilHydrologyMod.F90

REMARK : t\_h2osfc [PROBABLY KJETIL CORRECTION]

FILE : components/clm/src/biogeophys/SoilHydrologyMod.F90

Lacking files :

Only in noresm-dev-ncar/components/clm/src/biogeophys/test/Balance\_test
 [CLM-COPIED]

4. histFileMod.F90

REMARK :

1) iftest hist\_ndens(t) == 1 : switched off

2) always ncd\_double

FILE :

components/clm/src/main/histFileMod.F90

Lacking files :

components/clm/test/tools/nl\_files/mksrfdt\_1x1\_numaIA\_crp\_SSP5-8.5\_1850-2100
 [CLM-COPIED]

components/clm/test/tools/tests\_posttag\_dav\_mpi  [CLM-COPIED]

components/clm/tools/mkmapdata/regridgeyser.sh  [CLM-COPIED]

MICOM
^^^^^^

Only in noresm-dev-oslo/components/micom

POP
^^^^^^

General remark : a lot files are missing.  I copied over everything
except 4 \*.git files

Lacking files [copied over]

components/pop/cime\_config/testdefs/testmods\_dirs/pop/default\_spacecurve
[POP-COPIED]

components/pop/cime\_config/testdefs/testmods\_dirs/pop/ecosys\_cesm2\_0\_settings
[POP-COPIED]

components/pop/cime\_config/testdefs/testmods\_dirs/pop/ecosys\_ocn\_transient\_1850\_2000
[POP-COPIED]

components/pop/cime\_config/testdefs/testmods\_dirs/pop/no\_cvmix
[POP-COPIED]

components/pop/doc [POP-COPIED]

components/pop/externals/CVMix/bin  [POP-COPIED]

components/pop/externals/CVMix/bld/obj  [POP-COPIED]

components/pop/externals/CVMix/include  [POP-COPIED]

components/pop/externals/CVMix/inputdata  [POP-COPIED]

components/pop/externals/CVMix/lib  [POP-COPIED]

Lacking files [not copied over]

components/pop/externals/manage\_externals/test/repos/container.git

components/pop/externals/manage\_externals/test/repos/mixed-cont-ext.git

components/pop/externals/manage\_externals/test/repos/simple-ext-fork.git

components/pop/externals/manage\_externals/test/repos/simple-ext.git

components/pop/externals/manage\_externals/test/test\_sys\_repository\_git.py

Lacking files [copied over]

components/pop/externals/MARBL/defaults  [POP-COPIED]

components/pop/externals/MARBL/docs  [POP-COPIED]

components/pop/externals/MARBL/include [POP-COPIED]

components/pop/externals/MARBL/INSTALL [POP-COPIED]

components/pop/externals/MARBL/lib [POP-COPIED]

components/pop/externals/MARBL/LICENSE.txt [POP-COPIED]

components/pop/externals/MARBL/MARBL\_tools/code\_consistency.py
[POP-COPIED]

components/pop/externals/MARBL/MARBL\_tools/pylintrc [POP-COPIED]

components/pop/externals/MARBL/MARBL\_tools/run\_test\_suite.sh
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_ciso\_diagnostics\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_ciso\_init\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_ciso\_interior\_tendency\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_ciso\_surface\_flux\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_diagnostics\_share\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_glo\_avg\_mod.F90 [POP-COPIED]

components/pop/externals/MARBL/src/marbl\_interior\_tendency\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_interior\_tendency\_share\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_surface\_flux\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/src/marbl\_surface\_flux\_share\_mod.F90
[POP-COPIED]

components/pop/externals/MARBL/tests/driver\_exe [POP-COPIED]

components/pop/externals/MARBL/tests/obj [POP-COPIED]

components/pop/externals/MARBL/.travis.yml  [POP-COPIED]

components/pop/input\_templates/gm\_bolus\_terms\_tavg\_contents
 [POP-COPIED]

components/pop/input\_templates/gm\_bolus\_terms\_tavg\_contents\_high\_freq
 [POP-COPIED]

components/pop/input\_templates/submeso\_terms\_tavg\_contents
 [POP-COPIED]

components/pop/input\_templates/submeso\_terms\_tavg\_contents\_high\_freq
 [POP-COPIED]

components/pop/source/hmix\_gm\_share.F90   [POP-COPIED]

components/pop/test/system  [POP-COPIED]

WW3
^^^^

Lacking files [copied over]

components/ww3/src/cpl\_esmf [WW3-COPIED]

MODELS
^^^^^^^^

Only in noresm-dev-oslo: models


Overview of test experiments
-----------------------------

These experiments can be found on fram in the directory :

/cluster/projects/nn2345k/olivie/cases-cesm2.1.0

CESM
^^^^^

+-------------------------+-------------------------+-------------------------+
|                         | 1x1                     | 2x2                     |
+-------------------------+-------------------------+-------------------------+
| B1850                   | E13                     | E21                     |
+-------------------------+-------------------------+-------------------------+
| B1850cmip6              | E15                     |                         |
+-------------------------+-------------------------+-------------------------+
| BHIST                   | E16                     | E31                     |
+-------------------------+-------------------------+-------------------------+
| BHISTcmip6              | E18                     | E22/E23                 |
+-------------------------+-------------------------+-------------------------+
| F1850                   | E40                     | E41                     |
+-------------------------+-------------------------+-------------------------+
| FHIST                   | E28                     | E29                     |
+-------------------------+-------------------------+-------------------------+
| FHIST\_BGC              | E38                     | E39                     |
+-------------------------+-------------------------+-------------------------+
| F2000climo              | E24                     | E25                     |
+-------------------------+-------------------------+-------------------------+
| F2010climo              | E26                     | E27BCO2x4cmip6          |
+-------------------------+-------------------------+-------------------------+

NorESM
^^^^^^

+-------------------------+-------------------------+-------------------------+
|                         | 1x1                     | 2x2                     |
+-------------------------+-------------------------+-------------------------+
| N1850OCBDRDDMS          | E34                     | E35                     |
+-------------------------+-------------------------+-------------------------+
| NHISTOCBDRDDMS          | E46                     | E47                     |
+-------------------------+-------------------------+-------------------------+
| NF1850                  | E42                     | E43                     |
+-------------------------+-------------------------+-------------------------+
| NFHIST                  | E44                     | E45                     |
+-------------------------+-------------------------+-------------------------+
| NF2000climo             | E36                     | E37                     |
+-------------------------+-------------------------+-------------------------+


