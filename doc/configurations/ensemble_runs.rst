.. _ensemble_runs:

Ensemble runs: how to run several members at once
=========

Running several ensemble members in a single model experiment (case) is possible using the built-in **multi-instance component functionality**. This allows you to run multiple component instances under one model excecutable.  

Creating an ensemble experiment:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set up an experiment with 5 members, invoke the create_newcase script with the **multi-driver** and the **ninst** arguments, for instance  

:: 

   ./create_newcase --case $HOME/noresm_cases/NAME_OF_MY_AWESOME_ENSEMBLE_EXP --multi-driver --ninst 5 --res f19_f19_mg17 --mach vilje --compset NFHISTnorpddmsbc --run-unsupported --project <YOUR-PROJECT-FOR-CPU-HOURS-ON-VILJE>nnk
   
::

will create a new case in the folder $HOME/noresm_cases/NAME_OF_MY_AWESOME_ENSEMBLE_EXP with 5 ensemble members, the f19_f19_mg17 resolution, the NFHISTnorpddmsbc compset, with machine settings for Vilje, and using CPU hours from YOUR-PROJECT-FOR-CPU-HOURS-ON-VILJE. 

Note that when using the multi-instance component, *you will get one user namelist for each member and for each component* after running the script **case_setup** from your case folder. For the above case, these namelists are: 

::

user_nl_cam_0001  user_nl_cice_0001  user_nl_clm_0001  user_nl_cpl        user_nl_docn_0005    user_nl_mosart_0005
user_nl_cam_0002  user_nl_cice_0002  user_nl_clm_0002  user_nl_docn_0001  user_nl_mosart_0001
user_nl_cam_0003  user_nl_cice_0003  user_nl_clm_0003  user_nl_docn_0002  user_nl_mosart_0002
user_nl_cam_0004  user_nl_cice_0004  user_nl_clm_0004  user_nl_docn_0003  user_nl_mosart_0003
user_nl_cam_0005  user_nl_cice_0005  user_nl_clm_0005  user_nl_docn_0004  user_nl_mosart_0004

::

The namelists can be used to control various settings and to add output. Note that changes are made individually for the separate members, so if you for instance add extra output fields to user_nl_cam_0001 these fields will only be written out for member 1. To also get the extra output for members 2-5, modify the four other user namelists from cam. 


Perturbing the ensemble members:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the ensemble members to actually be different it is necessary to somehow perturb the initial condition of the member. **Note that the perturbation must be unique for each member**. 
