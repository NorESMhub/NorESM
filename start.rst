.. _start:

Introduction
============
           

NorESM1 is the Norwegian Earth System model used for CMIP5. The model is
based on the CCSM framework
(http://en.wikipedia.org/wiki/Community_Climate_System_Model). However,
NorESM has special features developed by Norwegian researchers.

Main references are:

GMD - Special issue The Norwegian Earth System Model: NorESM; basic
development, validation, scientific analyses, and climate scenarios

http://www.geosci-model-dev.net/special_issue20.html
:cite:`gmd-6-687-2013`
:cite:`gmd-6-389-2013`
:cite:`gmd-6-207-2013`
:cite:`gmd-6-301-2013`

This website contains information shared between NorESM developers and
users.

Obtaining a version of the model
''''''''''''''''''''''''''''''''

-  The development version has been moved to git: Obtain a
   copy through git clone
   https://githubUserName@github.com/metno/noresm.git You first need
   to be registered as a noresm user on github (see detailed info in
   :ref:`gitbestpractice`.

If you are on a normal ubuntu PC and want the source code, you might see
that "svn checkout" complains about "gnome keyring". If you see this
problem, the solution is here:
http://askubuntu.com/questions/206604/svn-and-gnome-keyring


-  Need access to other versions: Special access document:


https://docs.google.com/a/met.no/document/d/1G1ezxtBhzDyNWwrKJYWmp8gn402bOWThe_6gN00PDMQ/edit?usp=sharing

Running / Configuring the model
'''''''''''''''''''''''''''''''

- :ref:`newbie`
- :ref:`advanced`
- :ref:`fluxescrossingboundaries`

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

-  **NEW**: After switching to git (13th november 2015) the
      svn-repository is read-only. Some advice on how to use the new
      git-repository are available here:
      :ref:`gitbestpractice`

Some guidelines for modifying NorESM’s subversion repository:
 :ref:`svnbestpractice`

How-to for setting up svn repositories on NorStore:
:ref:`svnnorstorehowto`

**noresm2nc4mpi**

- :ref:`noresm2nc4norstore`
- :ref:`modeldiagnostics`
- :ref:`esmvaltool`

Archive model results
'''''''''''''''''''''

Long-term archiving is normally done on NorStore's disk resources (e.g,
in /projects/NS2345K/noresm/cases).

To avoid loss of data, another copy should be placed on tape. For
instructions, see :ref:`norstoretape`

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

See presentation from :download:`NorESM workshop November 28'th 2013 <../presentations/dirkjlo_chemistry_noresmworkshopnov2013.pdf>`

- :download:`EVA final meeting: CMOR-ization and ESGF publication of NorESM2 simulations - Ingo Bethke <presentations/EVAannualMeeting2018_WP4_IngoBethke_20180831.pdf>`
- :download:`NICEST workshop for ESGF at NSC: CMOR post-processing of NorESM CMIP5 & CMIP6 output - Ingo Bethke <presentations/LiuWorkshopESGF2018_IngoBethke.pdf>`
- :download:`ESMValTool setup for NorESM (10 May 2017) - Ingo Bethke <presentations/NorESMValTool20170510.pdf>`
- TaiESM CCliCS workshop in Taipei 2016 - Ingo Bethke :download:`pptx <presentations/BethkeEtAl_CCliCS2016_v2.pptx>`, :download:`pdf <presentations/BethkeEtAl_CCliCS2016_v2.pdf>`
- :download:`HappiEVA kick-off 2016 - Ingo Bethke <presentations/HappiEVA_kickoff-meeting_Ingo.pdf>`
- :download:`NeIC/Nordic ESM workshop 2015 - CMOR-izing of NorESM output by Ingo Bethke  <presentations/NeICESMworkshop2015_IngoBethke.pdf>`
- :download:`Presentation on data management in EVA - EVA meeting, 2014, Bergen <presentations/eva2014_ingobethke.pdf>`
- :download:`NorESM Workshop 2014 SU - Alf Grini <presentations/alfg_stockholmpres.pdf>`
- :download:`NorESM Workshop 2014 SU - Annica Ekman <presentations/annica_new_noresm_workshop_2014.pdf>`
- :download:`NorESM Workshop 2014 SU - Chandan Basu <presentations/workshop-14_chandan.pdf>`
- :download:`NorESM Workshop 2014 SU - Francesco Pausata <presentations/pausata_noresm_2014.pdf>`
- :download:`NorESM Workshop 2014 SU - Juan-Camilo Acosta <presentations/pegasos_oct_acosta.pdf>`
- :download:`NorESM Workshop 2014 SU - Risto Makkonen <presentations/makkonen_noresm_ws_2014.pdf>`
- :download:`NorESM Workshop 2014 SU - Trond Iversen <presentations/trondiversen_noresm-workshop_oct2014.pdf>`
- :download:`NorESM Workshop 2014 SU - Vidya Varma <presentations/vidya_noresm_ws_2014_su.pdf>`
- :download:`After NorESM Workshop 2014 SU - Alf Kirkevåg: some AeroTab-slides <presentations/aerotab-slides.pdf>`

References
''''''''''

.. bibliography:: references_noresm.bib
   :cited:
   :style: unsrt
