.. _vc_github:

Version Control and GitHub
==========================

The NorESM source code is maintained in a version control system, also called a
source control system, that keeps track of changes in the source code. Initially
NorESM1 was maintained in a single Apache Subversion (svn) repository. Before
the release of NorESM2, the code base was ported to GitHub and is now managed by
the git version control system. Most model components are now managed by git,
but references to svn repositories may occur and is supported by the NorESM
system.


Create a GitHub user account
''''''''''''''''''''''''''''

Anyone who want to upload data to GitHub will first need to create a user
account on the system.

- **Create a github user:** You can create the github user yourself. Go to
  https://github.com/join and create a user (Make user-name which is easy to
  understand, for example FirstnameLastname. You can attach several
  email-addresses to the same user.)

- **Add SSH key to GitHub account:** (optional) If you plan to connect to GitHub
  with SSH (recommended) you will need to add a public SSH key to your GitHub
  account. See `Connecting to GitHub with SSH
  <https://docs.github.com/en/authentication/connecting-to-github-with-ssh>`_
  for a description on how to generate a SSH keypair and adding it to your
  GitHub account.


Clone a repository
''''''''''''''''''

There are currently three options for `cloning a repository from GitHub
<https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository>`_;
with HTTPS, with SSH, or with GitHub command line interface. No user
authentication is required to clone a repository with HTTPS, but all three
methods require some steps for user authentication before code can be pushed to
GitHub.

The SSH option requires the use of SSH keypair, which can be created by the user
on a local computer or a server, depending on where the user want to clone the
repository. An existing public key can be re-used on GitHub if the user has
already generated a keypair to connect to external servers. If the server allows
SSH agent forwarding, only a single public key for the local computer will be
sufficient to clone both to the local computer and to a server.

The HTTPS option does not require a GitHub account, so this is the easiest
option for someone who want the latest code version, but does not plan to
contribute code back to GitHub. To upload data over HTTPS it is necessary to
provide a personal access token (PAT) that can be created for a user account,
which replaces the password for user authentication when pushing code to a
GitHub repository.

The GitHub command line interface (CLI) is a recent development that allows a
user to interact with GitHub without going through the web interface. However,
this requires installation of the github-cli (gh) application.


.. _git-references:

Learn more about git version control
''''''''''''''''''''''''''''''''''''

There are several resources for learning more about git and version control. Basic use involve invoking ``git <command>`` in a terminal, but git has also been integrated in several text editors and in GUI applications. Here are a few resources for more information:

**git cheat sheet:**
    https://education.github.com/git-cheat-sheet-education.pdf
**git tutorials:**
    https://www.atlassian.com/git/tutorials
**The Pro Git book:**
    | https://git-scm.com/book/en/v2
    | In particular the chapter on first time git setup:
    | https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup
**Get started with GitHub:**
    https://docs.github.com/en/get-started
**Migrating from svn to git: cheat sheet**
    http://www.git-tower.com/blog/git-for-subversion-users-cheat-sheet/
