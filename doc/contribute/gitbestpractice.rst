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

Note that with git, the main branch is no longer called "trunk", it is called "master"!


Verify that you have the correct checkout
'''''''''''''''''''''''''''''''''''''''''

When you have cloned the model, check that you have gotten what you
wanted!

Check that your favourite branch is available using the command 
::

  git branch --all 

(You should see the branch "master" on top with a star next
to it. This is the branch you get by default. The other branches are
listed below with remotes/origin/branchName, but you can not work on
them until you check them out, see below)

To check out (locally) your favourite branch and to start working on it,
write 
::

  git checkout -b myBranchName origin/myBranchName 

(Note that myBranchName must be one of the branches listed by the above 
command)

If you don't user the "-b" option, you will get something which is not
correct. Make sure you are tracking a remote branch. You can write 
::

git branch -vv 

to see which remote branch you are tracking. The output will
be something like: 
::

  \* myCheckedOutBranchName 1a08184 [origin/myCheckedOutBranchname] LatestCommitMessageOnBranch

Note that once a branch has been checked out using the -b option, you
can switch between any of your checked out branches using the command
::

  git checkout aCheckedOutBranchName

Note that in git, switching to a new branch change the files in your
working directory. Git will warn you if you have any modified files
before switching to a new branch. This is different from how svn works.


Modify files
''''''''''''

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


Get modifications from github
'''''''''''''''''''''''''''''

Get modification from remote source by
::

  git pull

To be absolutely sure about branch names etc, you can do
::

  git pull remoteName remoteBranchName:myLocalBranchName 

which if your are picking up changes the master-branch would 
translate to 
::

  git pull origin master:master


Send modifications to github
''''''''''''''''''''''''''''

This command assumes that your changes go to the remote branch named
like your branch (which is most of the times the case) 
::

  git push

You can also do (to be completely sure): 
::

  git push remoteName myLocalBranchName:remoteBranchName 
  
which if your are changing the master-branch would translate to 
::

  git push origin master:master 
  
(The above command means push my changes to the remote named "origin" from my
local branch named master to the remote branch named master. If you are
changing another branch than master, you must obviously not write
"master".)


Git workflows - centralized vs. fork-and-branch workflow
'''''''''''''''''''''''''''''''''''''''''''''''''''''''
Before you start to clone the repository to your local machine, decide which workflow which is best suited for your work. See https://www.atlassian.com/git/tutorials/comparing-workflows. 

When working with documentation and text which is not critical i.e. breaking any software or build, a simple workflow like the **Centralized Workflow** should work well. However, when collaborating on a software development project, it is recommended to use the **Forking Workflow** https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow.  Note that this includes the **Feature Branch Workflow** https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow.

There are many advantages with forking workflow, e.g. you cannot mess up the official repository, only your own, but the greatest benefit is that instead of pushing directly to the official repository, you instead create a **pull request** (PR) a.k.a. **merge request** to the upstream repository. This allows commits/branches to be reviewed by others and create a discussion thread before the PR is merged into the upstream repository.

Basically, the "fork and branch" workflow looks something like this:

  * Fork a GitHub repository.
  * Clone the forked repository to your local system.
  * Add a Git remote for the original repository.
  * Create a feature branch in which to place your changes.
  * Make your changes to the new branch.
  * Commit the changes to the branch.
  * Push the branch to GitHub.
  * Open a pull request from the new branch to the original repo.
  * Clean up after your pull request is merged.
  
To start off:

  * Press the Fork button in the project, and clone the forked project.
  * Add the remote upstream repository that you pull from, in order to keep your forked updated with the main development, e.g.
::

  git remote add upstream https://github.com/NorESMhub/NorESM.git
  git remote -v                 # check that you are tracking the right repositories (origin and upstream)
  git pull upstream master      # pull latest from the upstream master branch; do it often if possible
  git push origin master        # do this when upstream is ahead of you local (origin) repos, to stay in sync.
  git checkout -b my-feature    # create and switch to a new branch "my-feature".
  ...                           # edit some code
  git commit -a -m "Add first draft of my feature"
  git push

You are now ready to make a pull request of my-feature branch. This can by done from github after you pushed. Remember that after the PR is created and reviewed by others, you may need to go back and fix things before it is accepted and can be merged.
After merging the PR, you should normally delete the feature branch and update your local repos. to keep things clean. It will still be seen as a (merged) branch in the upstream repository.

**Note**: If your feature branch has many commits, it may be smart to "squash" the history before creating the PR, so that it is easier to review the full changes by others (and yourself). This can be done using the **git rebase** command, but this will not be covered here.

Development branch vs. continous integration tool (CI)
''''''''''''''''''''''''''''''''''''''''''''''''''''''
When working using the forking workflow and committing code through reviewed pull requests, there will still be times when code changes will break the software build for various reasons. It is therefore common to merge PR's into a **development branch** in the upstream repository, rather than directly to **master**. This adds additional management, because administrator must merge the development branch into master frequently and regularly, unless the build is broken. The gain is that **master** *always should work*.

An alternative to this scheme is to configure the workflow using a **CI/CD tool** that automates this process. I.e. when the pull request is created, the branch will automatically checked out on a dedicated build server and built. The pull request will not be published before the build is successful on the build server. On github, this is possible with **Github Actions** https://help.github.com/en/actions. It requires effort to get this in place for complex projects, but is normally worth it for large projects.

Another huge benefit of using a CI-tool is that it can automatically run test-suites in your project. E.g. a limited test-suite after successful build (part of evaluating that the build was OK), and a larger set test-suite after nightly builds.


Tips and Gotcha's when working with Git
'''''''''''''''''''''''''''''''''''''''
Git is a very complex system, and combining it with a complex workflow, it can be overwhelming. Here are some tips to make things easier:
  
  * **Limit number of simultaneous work branches**. The system can technically handle huge number of branches, but mentally it is very difficult to remember what exactly the different branches contain, espesially if they are not sync with the master branch. Try not to have more than two feature branches alive at any time.
  * **Make branches short-lived**. Unless you are making huge refactoring changes in the code (which should have been accepted by the team beforehand), you should generally always create feature-branches that are small enough to be finished within a day or two. When you are not able to finish the feature this rapid, create a **work-in-progress (WIP) pull request** so that the team is informed about what you work on and its progress.
  * **Don't underestimate the value of publishing your commits**. Public commits to git is very often the most valuable communication asset to the rest of the team (in some periodes, the only way you communicate). To view what others are doing is key to make your own commits consistent and in sync with others and the whole project. This is another important reason why you should avoid working privately on your own branches for prolonged periods. As mentioned above, also unfinished features are worthy a WIP pull request.


If you don't understand and want to get back to svn
'''''''''''''''''''''''''''''''''''''''''''''''''''

http://www.git-tower.com/blog/git-for-subversion-users-cheat-sheet/
