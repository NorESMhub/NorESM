.. _start:

Introduction
============
           

NorESM1 is the Norwegian Earth System model used for CMIP5. The model is
based on the CCSM framework
(http://en.wikipedia.org/wiki/Community_Climate_System_Model). However,
NorESM has special features developed by Norwegian researchers,
including (but not limited to)

- Atmosphere module : CAM-Oslo replaces standard CAM
- Ocean module : Based on the isopycnic coordinate model MICOM

Main references are:

GMD – Special issue The Norwegian Earth System Model: NorESM; basic
development, validation, scientific analyses, and climate scenarios.

http://www.geosci-model-dev.net/special_issue20.html
:cite:`gmd-6-687-2013`
:cite:`gmd-6-389-2013`
:cite:`gmd-6-207-2013`
:cite:`gmd-6-301-2013`

The next version of the model NorESM2 is built on a update version of
the CCSM framework, CESM2. (http://www.cesm.ucar.edu/models/cesm2/) ;
(https://en.wikipedia.org/wiki/Community_Earth_System_Model). Its
aerosol module is based on OsloAero5.3 of NorESM1.2 / CAM5.3-Oslo
:cite:`gmd-11-3945-2018`.

This website contains information shared between NorESM developers and
users

Obtaining a version of the model
''''''''''''''''''''''''''''''''

-  The development version has been moved to git: Obtain a
   copy through ``git clone https://<githubUserName>@github.com/metno/noresm-dev.git``. 
   You first need to be registered as a noresm user on github 
   (see detailed info in :ref:`gitbestpractice`).

If you are on a normal Ubuntu PC and want the source code, you might see
that "svn checkout" complains about "gnome keyring". If you see this
problem, the solution is here:
http://askubuntu.com/questions/206604/svn-and-gnome-keyring


-  Need access to other versions: Special access document**:
      https://docs.google.com/a/met.no/document/d/1G1ezxtBhzDyNWwrKJYWmp8gn402bOWThe_6gN00PDMQ/edit?usp=sharing

Running / Configuring the model
'''''''''''''''''''''''''''''''

- :ref:`newbie`
- :ref:`advanced`
- :ref:`advancednoresm2`
- :ref:`fluxescrossingboundaries`
- :ref:`cmip6_volcanic_forcing`
- :ref:`cmip6emissionsofshortlivedcomponents`
- :ref:`cmip6greenhouseGasConcentrations`
- :ref:`noresm2_output` (Oct 30'th 2018)

Develop the model
'''''''''''''''''

Setting up at different machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Most developers compile and run NorESM on hexagon (hexagon.bccs.uib.no).
That machine uses the portland group fortran compiler. Most developers
develop the code on that machine using "develop/compile/run/analyze
print statments" on that machine.

Some experiments have also been done with compiling running CAM on a
normal Linux PC in order to use interactive debuggers. (see below)

:ref:`settingupcamonlinuxpc` 

Issue tracker
^^^^^^^^^^^^^

Any development should ideally be agreed with the NorESM development
team and be properly described in the issue tracker, see the link below

:ref:`usingtheissuetracker`

If you have changed the model and want to merge your changes to the
trunk, your model has to pass some tests:

Testing
^^^^^^^

:ref:`testlist`

Version control best practices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  NEW**: After switching to git (13th november 2015) the
      svn-repository is read-only. Some advice on how to use the new
      git-repository are available here:
      :ref:`gitbestpractice`

Some guidelines for modifying NorESM’s subversion repository:
:ref:`svnbestpractice`

How-to for setting up svn repositories on NorStore:
:ref:`svnnorstorehowto`

NorESM2 branches in active development
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- https://github.com/metno/noresm/: master (this is the trunk/master version)
- https://github.com/metno/noresm/: featureCAM5-OsloDevelopment_trunk2.0-6 (Main development branch for CAM-Oslo aerosol features)
- https://github.com/metno/noresm/: feature-classnuc-ice_featureCAM5-OsloDevelopment-2 (ice nucleation feature branch)
- https://github.com/metno/noresm/: featureNitrate_featureCAM5-OsloDevelopment-2/ (aerosol nitrate feature branch)

NorESM1 branches in active development
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- https://github.com/metno/noresm/  noresm-ver1-cmip5/ (Original NorESM1-M CMIP5 version. Only technical updates)
- https://github.com/metno/noresm/: noresm-ver1_r112-r169/ (Further development from the CMIP5 version. Include EU-ACCESS project improvements)

You obtain the model code through checking it out. The command would be

::

   git clone https://<githubUserName>@github.com/metno/noresm-dev.git
   git checkout -b aBranchName origin/aBranchName 

This gives the code in your directory.

Uncertain parameters in the aerosol model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Developing the model also involves setting some uncertain numbers into
the model. Not all of these are available from namelists. Go to the link
below to understand where main uncertainties are.

:ref:`uncertainaerosolparameters`

Analyze model results
'''''''''''''''''''''

:ref:`modeldiagnostics`

Several tools are shared among NorESM users

- :ref:`noresm2nc4mpi`
- :ref:`noresm2nc4norstore`
- :ref:`modeldiagnostics`
- :ref:`esmvaltool`

Archive model results
'''''''''''''''''''''

Long-term archiving is normally done on NorStore's disk resources (e.g,
in /projects/NS2345K/noresm/cases).

To avoid loss of data, another copy should be placed on tape. For
instructions, see `Norstore Tape <NORESM:NorstoreTape>`__

Data that builds the basis of publications should be migrated to
NorStore's Research Data Archive in order to guarantee preservation and
also to offload the project area. For specific NorESM instructions, see
:ref:`norstorearchive`

CMIP5 archive of NorESM results
'''''''''''''''''''''''''''''''

:ref:`norstorearchive`

Share model results
'''''''''''''''''''

Model output and derived data products can be shared via the Norwegian
Earth System Grid data portal http://noresg.norstore.no (see
:ref:`norstoreesg`
for instructions).

Some aerosol and cloud-relevant output for the development version of
NorESM2 is available for those with MET Norway affiliation through VpN
at /vol/fou/emep/People/alfk/CAM-Oslo-diagnostics/

Past and ongoing work
'''''''''''''''''''''

Several simulations have been performed with NorESM. A list of available
simulations and runs can be found here.
:ref:`listofruns`. The page also contains an
overview of planned simulations. A fairly extensive description of the
model and to some extent also the CMIP5 runs can be found at
http://pcmdi9.llnl.gov/esgf-web-fe/

Choose one of the links. Search for NorESM1-M CMIP5 in the search
fields. Choose the link model documentation

NorESM is also used in several projects:
:ref:`projects`

Resources
'''''''''

* TaiESM CCliCS workshop in Taipei 2016 – Ingo Bethke

.. bibliography:: references_noresm.bib
   :cited:
   :style: unsrt
