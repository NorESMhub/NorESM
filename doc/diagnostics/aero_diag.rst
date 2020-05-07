.. _aero_diag:

Aerosol diagnostics
===================

WILL BE UPDATED BY alfk@met.no

NCL Model Version Comparison package
------------------------------------

Making ncl plots of often used aerosol and cloud fields, including ERFs, for two model versions (CAM-Oslo only)

- Make a local copy (on Linux) of the directory models/atm/cam/tools/diagnostics/ncl/ModIvsModII

- Assuming that you have produced output data from 4 simulations: two different model versions, each with PD and PI emissions, and all run with #define AEROCOM & AEROFFL:

  - In ModIvsModII.csh (note: read the header info):
  
    - edit model info for the first model (shown to the left in the plots): modelI = CAM4-Oslo or modelI = CAM5-Oslo ?
    - provide paths and partial file names of the model data (PD and PI) for Model I (CAM4-Oslo or CAM5-Oslo) and Model II (must be CAM5-Oslo)
    - choose desired plot format (plotf=ps, eps, pdf or png)
    - Run the script: ./ModIvsModII.csh
    
- Furthermore, to display the plots in an organized form by use of a web browser (only possible if the chosen plot format is png):

    - download htm template files from ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/htm-templates/
    
    - edit general model info (only) in ModIvsModII.htm, and manually cut and paste the mass budget numbers from the script output into this file
    
    - copy all png (plots) and htm files to the desired output (common) directory
    - open ModIvsModII.htm in your browser: hyper-links to all other htm files, including plots, are found here
    
 Example: ftp://ftp.met.no/projects/noresmatm/upload/NorESM2Diagnostics/ModIvsModII/revision610inclSOA-Nudged_1984-12to1985-11_vs_CAM4-Oslo/ModIvsModII.htm

