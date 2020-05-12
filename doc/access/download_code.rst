.. _download_code:

Downloading the model code
==============================

The NorESM2 model code is available through a  public GitHUB repository: 
https://github.com/NorESMhub/NorESM


Obtain a copy of the model (using git)
''''''''''''''''''''''''''''''''''''''
You need access to a git command line client on the machine where NorESM2 is build and run.

- **Create a github user:** You can create the github user yourself. Go to https://github.com/join and create a user (Make user-name which is easy to understand, for example FirstnameLastname. You can attach several email-addresses to the same user.)

- Visit this page:
  https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

- Send email to oyvind.seland@met.no to get the right permissions for the new github user (The email must contain who you are and the github username).

- When you have the right permissions, you can obtain the code.


To download the code, make a clone of the NorESM2 repository

::
  
  git clone https://github.com/NorESMhub/NorESM.git <noresm-base> 
  
::


instead of <noresm-base>, you can use the directory name you like. The <noresm-base> folder contains the latest version of the released code. 

::

   cd <noresm-base>

::

To use a previous version of the code, you can checkout a specific tag or a branch

* if you want a specific tag


::

  git tag --list                   [gives you all the possible tags]
  git checkout release-noresm2.0.1 [e.g, you checkout now the "release-noresm2.0.1" tag]


:: 

or  

* if you want a specific branch


::

   git branch --all                       [gives you all the possible branches]
   git checkout -b noresm2 origin/noresm2 [e.g, you checkout the "noresm2" branch]
 
::

Then you need to launch the download

:: 

   ./manage_externals/checkout_externals  [this will take one to a few minutes ...]

::

If you run into several SVN-related errors when launching the model, you may want to try to change required=True to required=False for pop2 and ww3 in Externals.cfg. POP2 and WW3 are not needed in NorESM2. Then try again.

To confirm a successful download of all components, you can run checkout_externals with the status flag -S to show the status of the externals or --logging to get a log of reported errors (if any):

::

  ./manage_externals/checkout_externals -S             [-S shows status of externals]
  ./manage_externals/checkout_externals --loggong      [write log of errors in manage_externals.log]

::


The checkout_externals script will read the configuration file called Externals.cfg and will download all the external component models and CIME into /path/to/<noresm-base>.

Now you have a complete copy of the NorESM code in the directory <noresm-base>.  There you can co go in the subdirectory cime/scripts and start creating a case :ref:`experiments`.
