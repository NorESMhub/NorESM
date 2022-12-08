.. _download_code:

Downloading the model code
==============================

The NorESM2 model code is available through a public GitHub repository: 
https://github.com/NorESMhub/NorESM

- Most users will probably want to clone the NorESM repository to a local machine using a git command-line client (see below). This gives easy access to both stable releases and development branches of NorESM.
- Users who do not wish to a git command-line client can download archive files (zip or tar.gz) of stable releases from https://github.com/NorESMhub/NorESM/tags 


Make a clone of the NorESM repository
+++++++++++++++++++++++++++++++++++++

You can obtain the code using the command-line git client on the appropriate machine as follows::
  
  git clone https://github.com/NorESMhub/NorESM.git <noresm-base> 
  

where *<noresm-base>* is the name of the directory where the latest version of the released code will be stored. You can replace *<noresm-base>* with the directory name you like. 

Enter the *<noresm-base>* folder ::

   cd <noresm-base>


Now you can check which remote servers you have configured:
::

  > git remote -v 
  origin	https://github.com/NorESMhub/NorESM.git (fetch)
  origin	https://github.com/NorESMhub/NorESM.git (push)



And check which branch you are using ::

  > git branch

To use another version of the code, you can check out a specific tag or a branch.

Check out a specific NorESM branch, e.g. NorESM2.0.1
++++++++++++++++++++++++++++++++++++++++++++++++++++

List all available tags ::

  > git tag --list 
  
To check out a specific tag, use **git checkout <tag-name>** where *<tag-name>* is a tag for the list, for instance *release-noresm2.0.1* ::

  > git checkout release-noresm2.0.1 

List all available branches ::

  > git branch --all              

To check out a specific branch, for instance *noresm2* ::

  > git checkout -b noresm2 origin/noresm2 
  
You can now inspect which tag or branch you are using by invoking the **git branch** command again. You can also inspect the commits log by invoking the **git log** command (to for instance only see the 3 commits, apply the **-n 3** option). 


NorESM releases configured for specific HPC platforms
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Machine configurations for specific HPC platforms have been integrated in different releases of NorESM, depending on when the HPC platforms became available. The following table shows which release introduced support for a specific platform. Please see :ref:`platforms` for more details.

+--------------------+-------------------------+
| **HPC platform**   | **NorESM release**      |
+--------------------+-------------------------+
| **Fram**           | *release-noresm2.0.0*   |
+--------------------+-------------------------+
| **Betzy**          | *release-noresm2.0.3*   |
+--------------------+-------------------------+


Manage externals
+++++++++++++++++

Then you need to launch the download:: 

   ./manage_externals/checkout_externals  [this will take one to a few minutes ...]

this will use the repositories, tags, branches as specified in **Externals.cfg** (see `Configure Externals.cfg`_ for its manipulation)

The *checkout_externals* script will read the configuration file called **Externals.cfg** and will download all the external component models and CIME into */path/to/<noresm-base>*.

Now you have a complete copy of the NorESM code in the directory *<noresm-base>*.  At this point you can enter the subdirectory *<noresm-base>/cime/scripts/* and start creating a case! (see :ref:`experiments`)

**Please note that if you checkout a new branch or tag, you will need to rerun checkout_externals in order to download the correct version of the model code**


Confirm successful download of all components
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To confirm a successful download of all components, you can run checkout_externals with the status flag ``-S`` to show the status of the externals or ``--logging`` to get a log of reported errors (if any): ::

  ./manage_externals/checkout_externals -S             [-S shows status of externals]
  ./manage_externals/checkout_externals --logging      [write log of errors in manage_externals.log]


Known python-related error
^^^^^^^^^^^^^^^^^^^^^^^^^^
If you encounter problems with  ``dictionary keys changed during iteration`` , please see :ref:`tech_faq`


Known SVN-related errors
^^^^^^^^^^^^^^^^^^^^^^^^
Some model components are maintained under SVN version control instead of git version control. If you run into several SVN-related errors when launching the model, you may want to try to change ``required=True`` to ``required=False`` for the model components POP2 and WW3 in **Externals.cfg**. POP2 and WW3 are not needed in NorESM2. Then try again.

When accessing svn repositories with **./manage_externals/checkout_externals** for the first time on a new machine, the download of the svn repository might not work. This can be solved by doing a manual checkout without ``--quiet``, e.g.: ::

    svn checkout https://svn-ccsm-models.cgd.ucar.edu/ww3/release_tags/ww3_cesm2_1_rel_01/cluster/projects/nn9560k/$USER/NorESMbittest/NorESM2.0/NorESM/components/ww3
    
accept with "(p)" (permanently). The next time, downloading svn repositories should go smoothly.


Configure Externals.cfg
+++++++++++++++++++++++

The **Externals.cfg** file contains code blocks that specify what model components to include in the NorESM build, where the source code for each component is located, and what verision of the model component to use. The file can be modified to use another repository, fork, branch or tag or release for any of the model components. The following example is for the land component, which in this case points to a version of the Community Terrestrial Systems Model (CTSM), which includes the Community Land Model (CLM)
::

  [clm]
  tag = release-clm5.0.14-Nor_v1.0.1
  protocol = git
  repo_url = https://github.com/NorESMhub/ctsm
  local_path = components/clm
  externals = Externals_CLM.cfg
  required = True



The file takes the following keywords
.. glossary::

  [component name]
    Component to be configured. See existing Externals.cfg file for valid options.

  required
    Wheter to include the component in the model build ('True' or 'False').

  local_path
    Where to download the source code to, relative to where the checkout script is called from.

  protocol
    Version control protocol used to manage the component ('git', 'svn', 'externals_only').

  repo_url
    URL for the repository location. This keyword accepts either a path to a remote repository or a local clone. For local clones, user expansions (e.g. ~/) and environment variable expansions (e.g. $HOME), will be performed.

  externals
    used to make *manage_externals* aware of sub-externals required by an external component.

  tag
    tag name to checkout from the repository.

  branch
    branch name to checkout from the repository.

  hash
    the git hash to checkout from the repository.

**NOTE:** one and only one of ``tag``, ``branch`` or ``hash`` must be supplied. The supplied string will be parsed to a ``git checkout`` command, but the the keyword determines what checks will be applied to the supplied string before parsing.

See more info here: 
https://github.com/ESCOMP/CESM/blob/master/README.rst


