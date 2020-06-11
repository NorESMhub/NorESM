.. _git-recipes:

Git Recipes
============================

Before doing things locally

::

  git status
  git pull

Merging a file from another branch into current branch

::

  clone, git pull, go to directory where to put file
  git checkout -b newbranch
  git checkout master file
  git commit -m "add file"
  git pull
  git push

Check the branch you are on

::

  git branch -a

