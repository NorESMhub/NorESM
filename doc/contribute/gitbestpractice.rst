.. _gitbestpractice:

Version control - GitHub
============================


Obtain a copy of the model (using git)
''''''''''''''''''''''''''''''''''''''

- **Create a github user:** You can create the github user yourself. Go to https://github.com/join and create a user (Make user-name which is easy to understand, for example FirstnameLastname. You can attach several email-addresses to the same user.)

- Visit this page:
  https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

- Send email to oyvind.seland@met.no to get the right permissions for the new github user (The email must contain who you are and the github username).

- When you have the right permissions, you can obtain the code.

::

  git clone https://githubUserName@github.com/metno/noresm.git

The last point will create a new directory called "noresm" in the place
you checked out the model. Go to that directory before executing any
git-commands.

If you get error messages, verify that you can open the page
https://github.com/metno/noresm in a web-browser. If you can not, you
are probably not a github-user or not member of the noresm group on
github.

-  Also do the following on all machines where you use git:

  * **Make sure you have a version of git >= 2.0** (add the line "module load git" to your .bashrc files on hexagon, vilje)
  * **git config - -global push.default simple** (Will edit your ~/.gitconfig file to a safer way to share your modifications, see http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0)

Note that with git, the main branch is no longer called "trunk", it is
called "master"!

Verify that you have the correct checkout
'''''''''''''''''''''''''''''''''''''''''

When you have cloned the model, check that you have gotten what you
wanted!

Check that your favourite branch is available using the command git
branch --all 
(You should see the branch "master" on top with a star next
to it. This is the branch you get by default. The other branches are
listed below with remotes/origin/branchName, but you can not work on
them until you check them out, see below)

To check out (locally) your favourite branch and to start working on it,
write git checkout -b myBranchName origin/myBranchName (Note that
myBranchName must be one of the branches listed by the above command)

If you don't user the "-b" option, you will get something which is not
correct. Make sure you are tracking a remote branch. You can write git
branch -vv to see which remote branch you are tracking. The output will
be something like: \* myCheckedOutBranchName 1a08184
[origin/myCheckedOutBranchname] LatestCommitMessageOnBranch

Note that once a branch has been checked out using the -b option, you
can switch between any of your checked out branches using the command
git checkout aCheckedOutBranchName

Note that in git, switching to a new branch change the files in your
working directory. Git will warn you if you have any modified files
before switching to a new branch. This is different from how svn works.

Modify files
''''''''''''

Modify the code (for example a file named myChangedFile.F90) and send
back to your local repository through git add myChangedFile.F90 git
commit -m "aMessage"

The message should link to the issue on github, so if you fix issue
number 100 by this code change, you would probably write something like
git commit -am "Did part of the work to resolve metno/noresm#100"

Verify, using the tool "gitk" that the changes make sense.

Get modifications from github
'''''''''''''''''''''''''''''

::

  git pull

To be absolutely sure about branch names etc, you can do

git pull remoteName remoteBranchName:myLocalBranchName which if your are
picking up changes the master-branch would translate to git pull origin
master:master

Send modifications to github
''''''''''''''''''''''''''''

This command assumes that your changes go to the remote branch named
like your branch (which is most of the times the case) git push

You can also do (to be completely sure): git push remoteName
myLocalBranchName:remoteBranchName which if your are changing the
master-branch would translate to git push origin master:master (The
above command means push my changes to the remote named "origin" from my
local branch named master to the remote branch named master. If you are
changing another branch than master, you must obviously not write
"master".)

If you don't understand and want to get back to svn
'''''''''''''''''''''''''''''''''''''''''''''''''''

http://www.git-tower.com/blog/git-for-subversion-users-cheat-sheet/
