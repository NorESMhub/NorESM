.. _download_code:

Downloading the model code
==============================

The NorESM2 model code is available through a public GitHub repository: 
https://github.com/NorESMhub/NorESM

Git and GitHub
+++++++++++

To download the model, you need access to a git command-line client on the machine where you want NorESM2 to build and run. You also need a git user and permissons to obtain the code:

- **Create a github user:** You can create the github user yourself. Go to https://github.com/join and create a user. (Choose a user name which is easy to understand, for example FirstnameLastname. You can attach several email-addresses to the same user.)

- Visit this page to learn how to **configure git** (for instance setting your name and email adress, this will be used in git commits):
  https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

- Send email to oyvind.seland@met.no to **get the right permissions** for the new github user (The email must contain who you are and the github username).

- When you have the right permissions, you can obtain the code.


Make a clone of the NorESM repository
+++++++++++

You can obtain the code using the command-line git client on the appropriate machine as follows::
  
  git clone https://github.com/NorESMhub/NorESM.git <noresm-base> 
  

where <noresm-base> is the name of the directory where the latest version of the released code will be stored. You can replace <noresm-base> with the directory name you like. 

Enter the <noresm-base> folder::

   cd <noresm-base>


Now you can check which remote servers you have configured:

::

  > git remote -v 
  origin	https://github.com/NorESMhub/NorESM.git (fetch)
  origin	https://github.com/NorESMhub/NorESM.git (push)

::

And check which branch you are using::

  > git branch



To use another version of the code, you can check out a specific tag or a branch.


Check out a specific NorESM branch, eg NorESM2.0.1
+++++++++++++++

List all available tags::

  > git tag --list 
  

To check out a specific tag, use **git checkout <tag-name>** where tag-name is a tag for the list, for instance release-noresm2.0.1::

  > git checkout release-noresm2.0.1 

List all available branches::

  > git branch --all              

To check out a specific branch, for instance noresm2::

  > git checkout -b noresm2 origin/noresm2 
  
You can now inspect which tag or branch you are using by invoking the **git branch** command again. You can also inspect the commits log by invoking the **git log** command (to for instance only see the 3 commits, apply the **-n 3** option). 


Manage externals
++++++++++++

Then you need to launch the download:: 

   ./manage_externals/checkout_externals  [this will take one to a few minutes ...]

this will use the repositories, tags, branches as specified in Externals.cfg (see below for its manipulation)

**If you run into several SVN-related errors when launching the model, you may want to try to change required=True to required=False for pop2 and ww3 in Externals.cfg. POP2 and WW3 are not needed in NorESM2. Then try again.**

**To confirm a successful download of all components**, you can run checkout_externals with the status flag -S to show the status of the externals or --logging to get a log of reported errors (if any):

::

  ./manage_externals/checkout_externals -S             [-S shows status of externals]
  ./manage_externals/checkout_externals --logging      [write log of errors in manage_externals.log]

::


The checkout_externals script will read the configuration file called Externals.cfg and will download all the external component models and CIME into /path/to/<noresm-base>.

Now you have a complete copy of the NorESM code in the directory <noresm-base>.  Now you can to the subdirectory cime/scripts and start creating a case! (see :ref:`experiments`)

Configure Externals.cfg
++++++++++++

The file can be modified to use another repo, fork, branch or tag or release for any of the model components.

See more info here: 
https://github.com/ESCOMP/CESM/blob/master/README.rst


.
