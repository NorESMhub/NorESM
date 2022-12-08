.. _tech_faq:

Technical FAQ
=============

Manage externals
----------------
I get a ``Dictionary keys changed`` error when checking out externals in my cloned repository. 

**Error:**

::
  
  ./manage_externals/checkout_externals
  Processing externals description file : Externals.cfg
  Checking status of externals: cam, dictionary keys changed during iteration
  

**Solution:**

Change to an older python version <= 3.7. If you have activated a conda environtment, you can deactivate conda 
(i.e. type ``deactivate conda`` in the terminal) when creating, building and submitting a case. 
The default python versions on BETZY and FRAM is 2.7.5 and will not create such errors.

Creating a case
----------------

I get a ``SyntaxError: invalid syntax`` error when creating a case in my cloned repository. 

**Error:**

::

  ./create_newcase --case ../../../cases/$CASENAME --mach fram --res f19_tn14 --compset NHIST
  Traceback (most recent call last):
    File "./create_newcase", line 9, in <module>
      from CIME.case          import Case
    File "/cluster/projects/nn2345k/$user/<noresm-base>/cime/scripts/Tools/../../scripts/lib/CIME/case/__init__.py", line 1, in <module>
      from CIME.case.case import Case
    File "/cluster/projects/nn2345k/$user/<noresm-base>/cime/scripts/Tools/../../scripts/lib/CIME/case/case.py", line 41, in <module>
      class Case(object):
    File "/cluster/projects/nn2345k/$user/<noresm-base>/cime/scripts/Tools/../../scripts/lib/CIME/case/case.py", line 72, in Case
      from CIME.case.case_submit import check_DA_settings, check_case, submit
    File "/cluster/projects/nn2345k/$user/<noresm-base>/cime/scripts/Tools/../../scripts/lib/CIME/case/case_submit.py", line 33
      print "limit0",resource.getrlimit(resource.RLIMIT_STACK)
            ^
  SyntaxError: invalid syntax

**Solution:**

Change to an older python version. If you are working in an active conda environtment, you can deactivate conda 
(i.e. type ``deactivate conda`` in the terminal) when creating, building and submitting a case. 
The default python versions on BETZY and FRAM is 2.7.5 and will not create such errors.
