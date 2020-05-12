.. _aero_diag:

Aerosol diagnostics
===================

For utilizing the comparison package described below, NorESM2 should be run with extra aerosol diagnostics and output, i.e. adding history_aerosol = .true. in user_nl_cam and enabling AROFFL and AEROCOM in preprocessorDefinitions.h . For a more detailed description, please see: :ref:`aerosol_output`  

NCL Model Version Comparison package ModIvsModII
------------------------------------

ModIvsModII produces plots and global life-cycling data (for use in a table) of often used aerosol, cloud and radiative flux fields, including ERFs. This is done for two model versions to be compared, either CAM4-Oslo vs. CAM6-Nor or CAM6-Nor vs. CAM6-Nor (but late versions of CAM5.3-Oslo can replace CAM6-Nor), and for PD and PI conditions, i.e. 4 simulations. If only e.g. the PD simulations are available, one can replace the PI data with those in the input to ModIvsModII, as long as one keeps that in mind when interpreting the shown diagnostics. ModI and ModII can also be the same, if you need to use these diagnostics but only have one model simulation for PD or PI or both.  

- Make a local copy (on Linux) of the directory models/atm/cam/tools/diagnostics/ncl/ModIvsModII

- Prepare climatological average monthly files of the (up to 4) simulations you want to compare, e.g. by use of the script create-clim.sh 

- Assuming that the simulations have been run with *history_aerosol = .true.*  and *#define AEROCOM & AEROFFL* (otherwise only some of the diagnostics will be produced):

  - In ModIvsModII.csh (note: read the header info):
  
    - edit model info for the first model (shown to the left in the plots): modelI = CAM4-Oslo or modelI = CAM5-Oslo (or later) ?
    - provide paths and partial file names of the model data (PD and PI) for Model I (CAM4-Oslo or CAM5-Oslo) and Model II (must be CAM5-Oslo or later)
    - choose desired plot format (plotf=ps, eps, pdf or png)
    - Run the script: ./ModIvsModII.csh
    
- Furthermore, to display the plots in an organized form by use of a web browser (only possible if the chosen plot format is png):
    
  - edit general model info (only) in ModIvsModII.htm, and manually cut and paste the mass budget numbers from the script output into this file (bottom part)
    
  - copy all png (plots) and htm files to the desired output (common) directory
  - open ModIvsModII.htm in your browser: hyper-links to all other htm files, including plots, are found here
    
Example: http://ns2345k.web.sigma2.no/aerosol_diagnostics/NFHISTnorpddmsbcsdyn_f09_mg17_20191101_vs_NHIST_f19_tn14_20190710/ModIvsModII.htm
 

