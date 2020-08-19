.. _ensemble_runs:

Ensemble experiments
===================
**How to run several members at once**

Running several ensemble members in a single model experiment (case) is possible using the built-in **multi-instance component functionality**. This allows you to run multiple component instances under one model executable.  

Creating an ensemble experiment:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To set up an experiment with 5 members, invoke the create_newcase script with the **multi-driver** and the **ninst** arguments. For instance  

:: 

   ./create_newcase --case $HOME/noresm_cases/MY_AWESOME_ENSEMBLE_EXP --multi-driver --ninst 5 --res f19_f19_mg17 --mach vilje --compset NFHISTnorpddmsbc --run-unsupported --project <YOUR-PROJECT-FOR-CPU-HOURS-ON-VILJE>
   
::

will create a new case in the folder $HOME/noresm_cases/MY_AWESOME_ENSEMBLE_EXP with 5 ensemble members, the f19_f19_mg17 resolution, the NFHISTnorpddmsbc compset, with machine settings for Vilje, and using CPU hours from YOUR-PROJECT-FOR-CPU-HOURS-ON-VILJE. NFHISTnorpddmsbc is the compset for the CMIP6 AMIP experiment in which sea surface temperatures and sea ice are prescribed to observed values.

When using the multi-instance component, *you will get one user namelist for each member and for each component* after running the script **case_setup** from your case folder. For the above case, these namelists are: 

::

   user_nl_cam_0001  user_nl_cice_0001  user_nl_clm_0001  user_nl_cpl        user_nl_docn_0005    user_nl_mosart_0005
   user_nl_cam_0002  user_nl_cice_0002  user_nl_clm_0002  user_nl_docn_0001  user_nl_mosart_0001
   user_nl_cam_0003  user_nl_cice_0003  user_nl_clm_0003  user_nl_docn_0002  user_nl_mosart_0002
   user_nl_cam_0004  user_nl_cice_0004  user_nl_clm_0004  user_nl_docn_0003  user_nl_mosart_0003
   user_nl_cam_0005  user_nl_cice_0005  user_nl_clm_0005  user_nl_docn_0004  user_nl_mosart_0004

::

The namelists can be used to control various settings and to add output. Note that changes are made individually for the separate members, so if you for instance add extra output fields to user_nl_cam_0001 these fields will only be written out for member 1. To also get the extra output for members 2-5, modify the four other user namelists from cam. 

Something to keep in mind: the number of tasks set in env_mach_pes.xml corresponds to the number of tasks that one member will use. The total number of tasks used when running the experiment will thus be the tasks used by one member multiplied by the number of members. If you want to run a very large number of members, it might be a good idea to divide them into separate cases to make sure that you don't use too many CPUs per case. 


Perturbing the ensemble members: PERTLIM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For the ensemble members to actually be different it is necessary to somehow perturb the initial condition of each member. The perturbation must be unique for each member. 

One way of doing this is to use the CAM namelist parameter **PERTLIM**. The default value of PERTLIM is 0.0. By choosing a non-zero value, a random parturbation with a size up to that given by the PERTLIM value will be added to the initial temperature field in the atmosphere. The value could be round-off error size, for instance 1e-14. **The PERTLIM value must be unique for each ensemble member.**

**PERTLIM only works for startup or hybrid runs.** It is not possible to use PERTLIM when doing a branch run. 

While it is perhaps do-able to manually create 5 different namelists with five different PERTLIM values, you will probably want to do this in a more automated way if you want to run, say, 25 different members. The approach described below provides an example of how to do this. It is assumed that you have already created a template namelist called user_nl_cam_template which contains at least the following line:

::

   pertlim          = 1e-14

::

The nice thing about using a template namelist is that you can add various content to the user_nl_cam_template that you want to apply to all members, such as additional output, and then you can create a set of namelists afterwards that only differ by their PERTLIM value using the script below:

::

   #!/bin/bash

   # Create cam namelists with 25 unique values for PERTLIM
   nmems=25

   # Detault PERTLIM value in template version of cam namelist
   # (will be repaced by random value)
   pertlimSuffix=e-14
   pertlimTemplate=1$pertlimSuffix

   # Start of cam namelist
   camNamelistStr=user_nl_cam_

   # Name of cam template namelist
   camNamelistTemplate=${camNamelistStr}template

   # Path to perturbed cam namelists
   path2camNamelist='namelists_perturbed'

   # Create nmems unique values for PERTLIM
   random=$(shuf -i 500-1500 -n $nmems)

   # Loop through values random and make a new namelist file for cam for each
   # value where the default PERTLIM value is replaced
   counter=1
   for val in $random ; do
       echo $counter
       x=$(bc -l <<< $(echo $val/1000))
       camNamelist=$camNamelistStr$(printf "%04d" $counter)
       pertlimNew=$(printf "%.02f" $x)$pertlimSuffix
       cp $camNamelistTemplate $path2camNamelist/$camNamelist
       sed -i -e 's/'"$pertlimTemplate"'/'"$pertlimNew"'/g' $path2camNamelist/$camNamelist
       counter=$(($counter+1))
   done

::

The above script puts the namelists in a folder called namelists_perturberd, located in your current working directory. Remember that the namelists must be moved to the case folder when you are happy with them.



Starting an ensemble run from a deterministic run:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In some cases, you may want to start an ensemble run as a hybrid run from a deterministic run (that is, a case with only one member). To achieve this, some manual interference is required to make sure that there are restart files and rpointers for each member. The script below provides an example of how to do this automatically for the case MY_AWESOME_ENSEMBLE_EXP:

::

   #!/bin/sh

   # Input data
   path2restfiles=<PATH-TO-RESTART-FILES-YOU-WANT-TO-USE>

   # You can list several cases here
   cases='MY_AWESOME_ENSEMBLE_EXP'

   for case in $cases ; do                                                                                                   
       path2runDir=<PATH-TO-RUN-DIRECTORY-OF-CASE>                                                                                                                                                                                                         
       compsNetcdf='cam cpl cice clm2 docn mosart'                                                                           
       compsRpointers='atm drv ice lnd ocn rof'                                                                              
                                                                                                                             
       for comp in $compsNetcdf ; do                                                                                         
        files=$(ls $path2restfiles/*$comp*)                                                                                  
        for file in $files ; do                                                                                              
            ln -sf $file $path2runDir/.                                                                                      
            for mem in $(seq -w 0001 0005) ; do                                                                              
                ln -sf $file $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                           
            done                                                                                                             
        done                                                                                                                 
       done                                                                                                                  
                                                                                                                             
       for comp in $compsRpointers ; do                                                                                      
        files=$(ls $path2restfiles/rpointer*$comp*)                                                                          
        for file in $files ; do                                                                                              
            echo $file                                                                                                       
            for mem in $(seq -w 0001 0005) ; do                                                                              
                cp $file $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                               
                if [ $comp == "atm" ] ; then                                                                                 
                    sed -i -e 's/cam/cam_'"$mem"'/g' \                                                                       
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                                                                                                           
                if [ $comp == "drv" ] ; then                                                                                 
                    sed -i -e 's/cpl/cpl_'"$mem"'/g' \                                                                       
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                                                                                                           
                if [ $comp == "ice" ] ; then                                                                                 
                    sed -i -e 's/cice/cice_'"$mem"'/g' \                                                                     
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                                                                                                           
                if [ $comp == "lnd" ] ; then                                                                                 
                    sed -i -e 's/clm2/clm2_'"$mem"'/g' \                                                                     
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                                                                                                           
                if [ $comp == "ocn" ] ; then                                                                                 
                    sed -i -e 's/docn/docn_'"$mem"'/g' \                                                                     
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                         
                   if [ $comp == "rof" ] ; then                                                                                 
                    sed -i -e 's/mosart/mosart_'"$mem"'/g' \                                                                 
                        $path2runDir/$(basename ${file/$comp/${comp}_${mem}})                                                
                fi                                                                                                           
            done                                                                                                             
        done                                                                                                                 
       done                                                                                                                  
   done      

