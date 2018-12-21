.. _usingtheissuetracker:

Using the issue tracker
'''''''''''''''''''''''

`Quick Link to NORESM scrum <https://scrum.met.no/jira/browse/NE>`__

Why do we need an issue tracker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Oslo and Bergen can easily see what the others are working on

- Better traceabilty of code changes (an issue can contain a reference to a code change)

- Better work planning

- Better communication between developers

- Help us work as a team, not just a collection of individuals.

Log in and check what is there
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- In github: Go to the "issues" tab. Sort by milestones or labels to see the ones you are interested in

Create issues
~~~~~~~~~~~~~

- Go to "create issue". Note that in NorESM, the issues are different **components**. 
  Make sure you select the right component for your issue.

- Also add other information to the issue as label (can be e.g. be a project-name). Adding Multiple labels is OK.

Priority definition for NorESM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Blocker: We need to solve this immediately. Some project can not be delivered because of this problem. 
  Problem blocks other people from working.

- Critical: Should be solved as quickly as possible. Major problem with product functionality.

- Major: This is the default priority

- Minor: Nice to do this, but not really necessary

- Trivial: Fix this when you have the time

- Not prioritized: We don't need to do this

Which issues should we add to different milestones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Find out together with your team which issues are most important

- Add the issue to the appropriate milestone

Working
~~~~~~~

- When you want to start working on something you should always do something 
  which is **included in a milestone**. Those are the tasks that the team 
  has defined as most important.

- Go to the task and choose "assign" and "assign to me".

Connection to version control system
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Mention the task when you commit the fix. For example:

::

  git commit -m "metno/noresm#346: I did something clever" 

will link the changeset to the right issue in github.
