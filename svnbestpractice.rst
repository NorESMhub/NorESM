.. _svnbestpractice:

SVN - Best Practice/FAQ
========================                       

We encourage developers to use branches when developing the model. Do
you find version control, branching and merging a bit difficult, try the
NorESM svn branch/merge tutorial to understand branching and merging. In
30 minutes you can become an svn wizard

Follow this link to find the tutorial:
  :ref:`svntutorial`

- **Note**: As of November 13th 2015, NorESM uses git as version control system. 
  The rules and guidelines for merging/branching, tags and branch names are still 
  valid in the new system

Branches
========

What is a branch?
^^^^^^^^^^^^^^^^^

A branch is your own version of the repository. Sometimes it is nice to
work on a feature "in private" without having to relate to other
developers' codes. And sometimes you want to work on something which
takes some time before it is finished.

In these cases you can create a *branch*. You can work on it on your
own or in a team of colleques. When you are happy with the the content
of the branch, you can merge it back to the *trunk*.

The *trunk* is considered a safe repository. The code in the trunk
should always have passed a set of tests to make sure it is
stable.(https://wiki.met.no/noresm/testlist)

Branches let you take advantage of the svn features, but without having
to worry every day that your code passes the tests.

Create a branch with
(http://svnbook.red-bean.com/en/1.7/svn.branchmerge.using.html)

::

  svn copy http://svn.example.com/repos/calc/trunk http://svn.example.com/repos/calc/branches/my-calc-branch  -m "Creating a private branch of /calc/trunk."

or specifically for the NorESM repository with

::

  svn copy https://svn.met.no/NorESM/noresm/tags/trunk2.0-1 https://svn.met.no/NorESM/noresm/branches/privateMYPORJECT_trunk2.0-1 -m "Creating a project branch of tags/trunk2.0-1." 

Then check out the branch using svn checkout $BRANCHURL
nameOfBranchOnMyPC

In git: First create your new branch locally and then make the remote
aware of the new branch like so: 

::

  git checkout -b my_branch_name 
  git push -u origin my_branch_name

..and make sure your .gitconfig-file is configured for doing a merge
(for example):

::

  [merge]
  
  tool = vimdiff
  
  [diff]
  
  tool = vimdiff

When should I work on a branch?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In most cases the answer is "always". However look at it this way:

If you work directly on the trunk you have to check that your code
passes the tests every time you change the code. This is cumbersome and
takes a lot of time. However if you are on a branch, you can work
peacefully together with your small team taking full advantage of the
version control system. In the end, when you and your teammates are
happy with the changes, you perform the tests and merge back to trunk.

You should obviously test your code also before you commit to a branch,
but for a branch the test does not include running and analyzing long
simulations.

How should I name the branch?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The NorESM branches have the following **naming convension :

{PurposeOfLife}_{ParentTagName}. 

This means that a branch name should
state **why** it is created and **where** it is created from.

PurposeOfLife is a text string (allowed characters are a-z, A-Z, 0-9 and ".") 
that must start with *feature*, *release*, *project* or *private*, where

- a *feature* branch is a temporary branch created to work on a complex change without interfering with the stability of /trunk (or another parent branch). Feature branches are always reintegrated. See also http://svnbook.red-bean.com/en/1.7/svn.branchmerge.commonpatterns.html
- a *release* branch is created if a version with frozen functionality is desired. 
  The development on the release branch itself is limited to bug fixes, addition of 
  forcing scenarios and other minor changes. Releases branches are not reintegrated. 

- a *project* branch is similar to a release branch. For some projects a specific version  with small changes might be required to do specific model runs. It is important that 
  all members of the project use the same code. If the project involves major 
  development tasks, the project team should concider creating a *feature* branch 
  instead. A *project* branch is likely not reintegrated.

- a *private* branch can be created if a project requires a strongly tailored version 
  of the model, that typically is maintained by only one person. Commits to a private 
  branch should be agreed on with the branch creator. Private branches are not 
  necessarily reintegrated. 

ParentTagName is the name of an existing noresm tag.

Examples of valid branch names are:

- featureIceActivation_trunk2.0-1: development of ice activation feature, created from tag trunk2.0-1)
- release2.0.0_trunk2.0-19 (release branch created from tag trunk2.0-19)
- release2.0.1_release2.0.0-15 (release branch created from tag release2.0.0-15)
- privateHiatusStudy_release2.0.1-3 (private branch for Ingo's hiatus study, created from tag release2.0.1-3)
- projectEXPECT_cmip5-r143-1 (branch created for use in project named EXPECT, created from tag cmip5-r143-1)

Note that in this scheme a new branch is never branched off directly
from trunk or another branch. **A tag MUST be created before creating a
branch** (see section on tags below).

Note that purposeOfLife of release-branches contains version numbers.
"release2.0.0" and "release2.0.1" are "purposeOfLife". When creating
release-branches, please agree on numbering with <Mats.Bentsen@uni.no>.
**The version numbers in release-branches** "purposeOfLife" should not
be confused with "increasingVersionNumber" used to make tag-names
unique.

A note on branch / tag naming
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Naming of feature branches and associated tags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Consider the following example: A small group decides to have a branch
of their own. The group defines their branch's purpose of life as
"featureLandSurfaceModeling".

They can now branch off from trunk and create the branch
*featureLandSurfaceModeling_trunk2.0-1*. They will work happily on their
branch until one day they have completed their feature. In the mean time
they have tagged their branch a couple of times as
*featureLandSurfaceModeling-1*, *featureLandSurfaceModeling-2*.

After the feature is completed, the branch is merged back to trunk, and
following svn recommendations, the branch should now be considered dead.

The team still want their branch on which they cooperate well. They
should now re-generate their branch from trunk, for example
*featureLandSurfaceModeling_trunk2.0-40*. This is OK. The repository
should now have two branches, but by inspection of branch names it is
easy to see that *featureLandSurfaceModeling_trunk2.0-40* is the recent
one and the other is a dead end.

While developing on *featureLandSurfaceModeling_trunk2.0-40*, the team
decides to tag their model twice, creating the tags
*featureLandSurfaceModeling-3* and *featureLandSurfaceModeling-4*.

The repository now has four tags: *featureLandSurfaceModeling-1*,
*featureLandSurfaceModeling-2*, *featureLandSurfaceModeling-3* and
*featureLandSurfaceModeling-4*. They originate from two different
branches. However this is OK in the NorESM naming convention scheme!

Naming of release branches and associated tags
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The PurposeOfLife string of a release branch should begin with "release"
followed by .. (e.g., *release2.0.1*).

The numbers and are inherited from the tag from which the branch is
created. The number is set to 0 in the special case that the parent is a
trunk tag (e.g., *release2.0.0_trunk2.0-19*) and augmented if the
release branch is created from an existing release branch tag (e.g.,
*release2.0.1_release2.0.0-5*).

For more information on and see section "How should I name the tag".

How and when should I merge from trunk to my branch?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can decide this for yourself. The main hypothesis is that the trunk
is always stable and working, so you will not harm your branch by
merging from trunk. If you are working on something which you will
finally merge back to the trunk, you can merge often. Then the final
merge will be easier.

Just use svn merge ^/noresm/trunk (The "^" means “the URL of the
repository's root directory" in newer versions of svn. In older versions
you need to give full URL)

How can I merge my branch back into the trunk?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can merge to trunk after your changed code has passed a list of
tests. The tests are available here: https://wiki.met.no/noresm/testlist

If your code does not pass the tests, you can **not** merge your code
back to the trunk

Note that in svn, **you can only merge ONE time from your branch to the
trunk**, or you risk making a mess of the system! (See
http://svnbook.red-bean.com/en/1.7/svn.branchmerge.basicmerging.html ==>
"Reintegrating a branch", note the statement **Once a --reintegrate
merge is done from branch to trunk, the branch is no longer usable for
further work"**). 

N.B. There is a workaround to this, described in
http://svnbook.red-bean.com/en/1.7/svn.branchmerge.advanced.html#svn.branchmerge.advanced.reintegratetwice

The merge command (from trunk) will be something like
(http://svnbook.red-bean.com/en/1.7/svn.branchmerge.basicmerging.html)

::

  svn merge --reintegrate $BRANCHURL

Using git, just use git merge branchNameIWantToMergeWith

Tags
''''

What is a tag?
^^^^^^^^^^^^^^

A tag is a version of the model which should be considered "frozen". It
makes sense to make a new "tag" for a production system, for example a
specific version which should be used for many runs.

In svn notation, there is no difference between a branch and a tag. It
is just a question of naming convension. Recommended convension is that
tags are branches saved under the "tags" subdirectory and a branch is
saved under the "branches" directory.

- In NorESM tags are considered frozen, and people are not allowed
      to do developement on tagged versions.

Create the tag with a command like
(http://svnbook.red-bean.com/en/1.6/svn.branchmerge.tags.html)

::

  svn copy http://svn.example.com/repos/calc/trunk http://svn.example.com/repos/calc/tags/release-1.0 -m "Tagging the 1.0 release of the 'calc' project."

 or specifically for the NorESM repository with

::

  svn copy https://svn.met.no/NorESM/noresm/trunk https://svn.met.no/NorESM/noresm/tags/trunk2.0-2 -m "Creating new tag of trunk." 

When should I create a tag?
^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should create a tag in the following cases:

- When you want to create a branch! **Always tag the model first and then create the 
  branch from the tag**. (If a tag has already been made at the point where you want 
  to branch off, you don't need to create a new tag!!)
- A "released" version, a version which has been properly tested and which we recommend 
  other users to run
- A version which has been used for some specific paper (maybe you want to do more runs 
  after referee comments)

What tags exist?
^^^^^^^^^^^^^^^^

All tags are in https://svn.met.no/viewvc/noresm/noresm/tags/. Have a
look there to find out which tags exist before you create a new tag. In
order not to break the naming convension scheme, you need to know which
tags exist already!

How should I name the tag?
^^^^^^^^^^^^^^^^^^^^^^^^^^

Tags created from trunk have the naming convention:

::

 trunk{MainModelVersion}.{MinorModelVersion}-{IncreasingVersionNumber}

Tags created from branches have the naming convention:

::

 {BranchPurposeOfLife}-{IncreasingVersionNumber}

Every time a release branch is created from trunk, then
MinorModelVersion is increased and IncreasingVersionNumber reset to 1.
If no new release branch is created, then MinorModelVersion stays the
same and IncreasingVersionNumber is increased.

- Important: If a user wants to create a tag from a freshly
      created branch, then IncreasingVersionNumber should be set to 0
      (e.g., *featureMicomDevelopment-0*). Be aware, however, that
      creating a tag from a freshly created branch results in tag
      duplication, e.g., if the branch is
      *featureMicomDevelopment_trunk2.0-19* then
      *featureMicomDevelopment-0* will be identical to *trunk2.0-19*.

MainModelVersion and MinorModelVersion are global counters while
IncreasingVersionNumber is local to the trunk or a specific branch.

Examples are:

- trunk2.0-1
- trunk2.0-2
- featureIceActivation-1
- release2.0.0-1
- release2.0.0-2
- release2.0.1-1 (associated branch created from tag release2.0.0-2)``
- privateHiatusStudy-1  (owned by Ingo)``
- privateKatlaStudy-1  (owned by Øyvind)``

Note how this is consistent with the branch naming scheme. You
actually need to create a tag in order to give your branch a proper
name!

Tagging noresm0 and noresm1 branches?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

NorESM0 and NorESM1 had a quite random naming convension for branches
where branch names involved "noresm" and "revision numbers". For example
a NorESM1 branch names is "noresm-ver1_cmip5-r112/". When tagging these,
we need to know what is "purposeOfLife" of this branch. People tend to
talk about these branches as the "112-version" or the branch
"noresm-ver1_cmip5-r143/" as the "143 version".

Therefore, even though it is confusing it is proposed here to use
"cmip5-r112" or "cmip5-r143" as purposeOfLife for these branches. So
tags created from these branches would be called "cmip5-r112-1",
"cmip5-r112-2", "cmip5-r143-1", "cmip5-r143-2" etc.

- purposeOfLife of NorESM1 branches is therefore whatever follows
      after "noresm-verX-" in the branch name

Tricky use cases
''''''''''''''''

Case 1
^^^^^^

*A user has performed a control simulation using a tagged NorESM
version. He/she wants to use this control simulation as baseline for
several new implementations. How should the user create/update working
branches without having to worry about changes in trunk that can affect
the result?*

This is straight forward. The user creates several branches based on the
original tag. Following the naming convension scheme, they all have a
different "PurposeOfLife" but they have the same ParentTagName. The
combination is a unique branch name for all the new implementations.

Importantly, "merge from trunk" - which is required to be able to
reintegrate the branch into trunk - has to be postponed until after
evaluation experiments for the new implementations have been performed.

Case 2
^^^^^^

*A user group wants to develop one model component without constantly
having to worry about changes in other model components.*

A solution is to bundle new implementations for a specific component by
creating a super branch (e.g., *featureMicomDevelopment_trunk2.0-19*).

The super branch can then be used to create ordinary feature branches
for the individual implementations (e.g.,
*featureNewMixingScheme_featureMicomDevelopment-0*).

Reintegration into trunk is done in two steps: First, feature branches
from the individual implementations are reintegrated into the super
branch. Last, the super branch is reintegrated into trunk.

Case 3
^^^^^^

* A tagged NorESM version has been used for the production of a certain
simulation. Part of the simulations has to be rerun with extended
diagnostic capability (e.g., with U10 output). How can I commit the
extended diagnostic capability to svn?*

One can imagine that something like this happened:

- The originally tagged version was made from a branched called "release2.0.0_trunk2.0-45"
- The experiment was run with "release2.0.0-3"

When the update is needed there are two possibilities:

Option 1
--------

This is the normal (and simplest) case:

Update the "release2.0.0_trunk2.0-45" branch with the changes needed.
After the development is done on "release2.0.0_trunk2.0-45" brand, tag
this as "release2.0.0-4" and do the experiments.

Option 2
--------

In the mean time, someone has done a lot of bugfixing in
"release2.0.0_trunk2.0-45", so the latest version of
"release2.0.0_trunk2.0-45" is significantly different from
"release2.0.0-3" and you are afraid including the bugfixes will change
the original results. You can not include all the bugfixes before doing
the extra simulations so using the latest version of
"release2.0.0_trunk2.0-45" is not an option.

In this case, create a new branch: "release2.0.1_release2.0.0-3", update
it and tag it "release2.0.1-1". **Note that in this case, you have
created a new branch with a different "purposeOfLife": "release2.0.1" is
different from "release2.0.0".**

``===== SVN messages =====``

What should be stated in the commit message?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Always state the JIRA issue associated with the work! This makes
      the code changes pop up in JIRA!: For example:
      
::

      svn commit -m "NE-100: These are the fixes needed to solve this issue" 
      
(see https://wiki.met.no/noresm/usingtheissuetracker)

The commit message should include a concise description of the committed
changes.

Furthermore, it should indicate whether the changes preserve
bit-reproducibility. If this information is omitted, then one should
assume that bit-identity is broken.

Examples 1:

::

  Added new compset COMPSETNAME, bit identical compared to revision r

Examples 2:

::

  Added new diagnostics in cloud.F90, bit identical compared to revision r

What should be stated in the copy message of a branch?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A more elaborated "purpose of life" than indicated by the branch name
can be provide as svn message when creating the branch. If a
corresponding jira issue exists, then the text provided to the issue
track can be reused here.

What should be stated in the copy message of a tag?
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ideally, the commit message of a tag should provide a complete change
history relative to the last tag. This information can be easily
extracted from the svn viewer.

Example 1: 

::

  Change history: trunk-2.0 -> trunk-2.1 (r190 -> r198)

  Revision 198

  changes made in r198...

  Revision 193

  changes made in r193...

  Revision 190

  changes made in r190...

Example 2: 

::

  Change history: trunk-2.3 -> featureMicomDevelopment-1 (r200 -> r205)

  Revision 205

  changes made in r205 to branch featureMicomDevelopment...

  Revision 202

  changes made in r202 to branch featureMicomDevelopment...

  Revision 200

  changes made in r200 to branch featureMicomDevelopment...


