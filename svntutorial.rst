.. _svntutorial:

SVN Branch/Merge tutorial
==========================                         

NOTE: THE EXAMPLES ARE DONE ON ALFS PC, AND ANY DIRECTORY NAMES
CONTAINING "alfg" ARE NOT VALID ON YOUR PC!! USE SOME NAMES WHICH MAKE
SENSE ON YOUR PC!

PART 1 : Create a repository and put a file there
'''''''''''''''''''''''''''''''''''''''''''''''''

CREATE A REPOSITORY alfg@pc4400:~$svnadmin create $HOME/svnrepos

CREATE A WORKING DIRECTORY WITH CODE alfg@pc4400:~$mkdir
$HOME/testproject

Use the following as the file test.F90:

 program test

``   implicit none``

| ``   real, parameter :: a=4.0``
| ``   real, parameter :: b=5.0``

| ``   print*, "a is " , a ``
| ``   print*, "b is " , b ``
| ``   print*, "a+b is " , a+b ``

end program test

CD TO WORKING DIRECTORY AND VERIFY THAT THE TEST FILE IS THERE
alfg@pc4400:~/testproject$ ls -l total 4 -rw-rw-r-- 1 alfg alfg 166 Dec
6 14:51 test.F90

CD TO THE FRESHLY CREATED REPOSITORY AND CREATE "testproject"
alfg@pc4400:~/svnrepos$ svnadmin create testproject

IMPORT YOUR WORKING-DIRECTORY TO THE REPOSITORY alfg@pc4400:~$svn import
$HOME/testproject/ file://$HOME/svnrepos/testproject/trunk -m "Initial
version of testproject"

MAKE A BRANCHES-DIRECTORY alfg@pc4400:~$svn mkdir
file://$HOME/svnrepos/testproject/branches/ -m "created branches
directory"

==>YOU NOW HAVE A REPOSITORY CONTAINING TRUNK AND (EMPTY) BRANCHES
DIRECTORY. YOU CAN START TO USE IT

===== PART 2: Create a working directory for two developers ====

 alfg@pc4400:~$mkdir twoDevelopers alfg@pc4400:~$cd twoDevelopers

CHECK OUT TRUNK FOR ONE DEVELOPER alfg@pc4400:~/twoDevelopers$svn
checkout file://$HOME/svnrepos/testproject/trunk trunk
alfg@pc4400:~/twoDevelopers$cd trunk

CREATE A BRANCH BASED ON TRUNK alfg@pc4400:~/twoDevelopers/trunk$ svn
copy file://$HOME/svnrepos/testproject/trunk
file://$HOME/svnrepos/testproject/branches/aBranch -m "created branch
aBranch"

CD BACK ONE STEP AND CHECK OUT THE BRANCH FOR THE OTHER DEVELOPER
alfg@pc4400:~/twoDevelopers$ svn checkout
file://$HOME/svnrepos/testproject/branches/aBranch aBranch

==> THE DIRECTORY "TWODEVELOPERS" NOW HAS TWO DIRECTORIES, ONE WITH
TRUNK AND ONE WITH A BRANCH VERIFY THAT THEY ARE THERE USING THE "LS"
COMMAND

 alfg@pc4400:~/twoDevelopers$ ls -trl total 8 drwxrwxr-x 3 alfg alfg
4096 Dec 9 08:36 trunk drwxrwxr-x 3 alfg alfg 4096 Dec 9 09:40 aBranch

PART 3: Create conflict in the file test.F90
''''''''''''''''''''''''''''''''''''''''''''

EDIT FILE ON TRUNK alfg@pc4400:~/twoDevelopers/trunk$ vim test.F90
alfg@pc4400:~/twoDevelopers/trunk$ svn commit -m "added hello"
alfg@pc4400:~/twoDevelopers/trunk$ svn update

EDIT FILE ON BRANCH alfg@pc4400:~/twoDevelopers/aBranch$ vim test.F90
alfg@pc4400:~/twoDevelopers/aBranch$ svn commit -m "added Hi man"
alfg@pc4400:~/twoDevelopers/aBranch$ svn update

==> We have now created a conflict between the branch "aBranch" and
"trunk"

 alfg@pc4400:~/twoDevelopers$ diff aBranch/test.F90 trunk/test.F90 9c9 <
print*, "Hi Man! a+b is " , a+b --- > print*, "Hello a+b is " , a+b

PART 4: Test the merge dialog
'''''''''''''''''''''''''''''

TRY TO MERGE TRUNK INTO BRANCH alfg@pc4400:~/twoDevelopers/aBranch$ svn
merge file://$HOME/svnrepos/testproject/trunk

You will get the message that there is a conflict in file test.F90, you
will have to resolve the conflict Push the "postpone" option to quit the
merge dialog

UNDO THE MERGE WITH alfg@pc4400:~/twoDevelopers/aBranch$ svn revert -R .

==> You have undone the merge, nothing has happened
alfg@pc4400:~/twoDevelopers/aBranch$ svn diff
alfg@pc4400:~/twoDevelopers/aBranch$

PART 5: Set up favourite editor as merge tool
'''''''''''''''''''''''''''''''''''''''''''''

1) Create a file somewhere in your pc, for example I use
$HOME/bin/mergetoolscript.sh

For emacs users, the content of the script is:

#. !/bin/sh

emacs -q --eval "(ediff-merge-files-with-ancestor "\"$2"\" \\""$3"\"
\\""$1"\" nil \\""$4"\")"

For vi users, the content of the script is:

#. !/bin/sh

vim -d "+diffsplit $3" "+vert diffsplit $1" "+vert diffsplit $2" -o $4

2) Open your $HOME/.subversion/config file and replace the line with
merge tool (NOTE THAT FULL PATH IS NEEDED. NO BLANK CHARACTERS AT
BEGINNGING OF LINE!!) merge-tool-cmd = /home/alfg/bin/mergetoolscript.sh

MAKE SURE SCRIPT IS EXECUTABLE chmod +x $HOME/bin/mergetoolscript.sh

==> You should now have working merge tools. This will make merging
EASY!!

PART 6: Go back to merge operation and use merge tool
'''''''''''''''''''''''''''''''''''''''''''''''''''''

 alfg@pc4400:~/twoDevelopers/aBranch$ svn merge
file://$HOME/svnrepos/testproject/trunk

type "s" to "show all options" and "l" to "launch external tool".

==> emacs or vi should be invoked in "merge mode"

//The vi script// shows (your, ancestor, mine) on top and output below.
Move around in the different windows with "ctrl+w+arrow". When in the
upper windows you can use "[c" and "]p"] go move to previous/next diffs.

//the emacs script// shows (yours, mine) on top and merged version
(including common ancestor) below

All editing should happen in the lowest part of the editor window

When done editing, save the file and quit the editor

When back in the merge-dialog, press "r" (resolved)

PART 7: Verify that you are happy with merge
''''''''''''''''''''''''''''''''''''''''''''

 alfg@pc4400:~/twoDevelopers/aBranch$ svn diff

Note how it is difficult to understand the diff ==> we need to configure
a diff tool!

To configure a nice diff-viewer, you need to replace a line in your
$HOME/.subversion/config file like this:

 diff-cmd = /home/alfg/bin/diffwrap.sh

The script "diffwrap.sh" has be created somewhere on your PC. The script
is only TWO LINES long!! (Make sure it is executable with "chmod +x
scriptname")

The content of this script (only two lines) for emacs users can be:

#. !/bin/sh

emacs --eval "(ediff-files "\"$6"\" \\""$7"\" )"

(In emacs, use \| (pipeline) key in the "ediff" dialog to toggle between
vertical/horizontal diff view)

The content of this script for vi users can be

#. !/bin/sh

vimdiff $6 $7

Visually verify the diff again using the diff viewer
alfg@pc4400:~/twoDevelopers/aBranch$ svn diff

When you are happy with the diffs, do

 alfg@pc4400:~/twoDevelopers/aBranch$ svn commit -m "Successfully
branched trunk to my branch"

==> DONE

PART 8: Merge back to trunk
'''''''''''''''''''''''''''

After the conflict is resolved and committed from branch, go back to
trunk

 alfg@pc4400:~/twoDevelopers/trunk$ svn update
alfg@pc4400:~/twoDevelopers/trunk$ svn merge --reintegrate
file://$HOME/svnrepos/testproject/branches/aBranch

AT THIS POINT YOU WANT TO PASS THE TESTS (IF THIS WAS NORESM)

 alfg@pc4400:~/twoDevelopers/trunk$ svn commit -m "merged aBranch back
to trunk"

==> Observe that you don't get any conflict this time. Svn knows that
the conflict is already resolved.

Other important points
''''''''''''''''''''''

| `` * The merge is not completed until you commit!``
| `` * You have to know if you are doing a reintegrate merge or a merge from trunk (see noresm wiki)``
| `` * You can undo the merge with alfg@pc4400:~/twoDevelopers/aBranch$ svn revert -R .``
| `` * When you have done a "reintegrate merge", consider  your branch dead! (svn delete branchUrl -m "removed reintegrated branch aBranch")``
| `` * If you insist on keeping reintegrated branches alive, there are two options:``
| ``     - Start using another version control system``
| ``     - Make sure you have latest svn version (version >= 1.7), Then read (and understand)  ``\ ```http://svnbook.red-bean.com/en/1.7/svn.branchmerge.advanced.html#svn.branchmerge.advanced.reintegratetwice`` <http://svnbook.red-bean.com/en/1.7/svn.branchmerge.advanced.html#svn.branchmerge.advanced.reintegratetwice>`__
| `` ``
