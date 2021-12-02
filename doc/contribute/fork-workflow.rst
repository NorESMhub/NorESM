.. _fork-workflow:

Workflow with GitHub forks
==========================

The recommended workflow for NorESM code contibutions is based on using a personal fork repositories of the main NorESM repository in GitHub, which is then cloned to a location were code development and testing can be performed (local computer or HPC server). This procedure follows the guidelines set out in the coderefinery tutorial on `distributed version control and forking workflow <https://coderefinery.github.io/git-collaborative/03-distributed>`_.

.. _(Fig. 1):
.. image:: ../img/git_fork_3_users.png
   :width: 600
   :alt: Git fork and clone layout
**Figure 1:** Collaborative fork-based workflow with three users.

:ref:`Figure 1<(Fig. 1)>` shows an example where three users are collaborating with code contributions to a main repository using a fork-based workflow. The workflow passes through the following steps:

#. `Fork the main repository <https://docs.github.com/en/get-started/quickstart/fork-a-repo>`_ to a new fork repository on GitHub. (first time)
#. `Clone the fork repository <https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository>`_ to a local computer or HPC server. (first time)
#. After making code changes, push code changes to fork repository.
#. Create a pull request to push code changes from fork repository to the main repository.
#. Synchronize local clone (and/or fork repository) with recent changes from the main repository.


Make code changes
'''''''''''''''''

- Create a new feature branch for your code changes (optional, but recommended)



It is generally a good practice to keep branches that are shared among 

Modify the code (for example a file named myChangedFile.F90) and send
back to your local repository through 
::

  git add myChangedFile.F90 
  git commit -m "aMessage"

The message should link to the issue on github, so if you fix issue
number 100 by this code change, you would probably write something like
::

  git commit -am "Did part of the work to resolve metno/noresm#100"

Verify, using the tool "gitk" that the changes make sense.


Make changes directly in GitHub
'''''''''''''''''''''''''''''''



Synchronize local repositories through a GitHub fork repository
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

.. _(Fig. 2):
.. image:: ../img/git_fork_sync.png
   :width: 500
   :alt: Synchronize through git fork
**Figure 2:** Synchronize code changes between local git
repositories through a shared GitHub fork repository.

