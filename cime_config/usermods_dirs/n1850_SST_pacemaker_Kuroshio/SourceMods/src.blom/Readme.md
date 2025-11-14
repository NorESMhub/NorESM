Small modifications were made to the BLOM source code to enable reading and initialization of the pacemaker mask variable (pcmask) from an external NetCDF file.
These updates allow BLOM to include region-specific SST forcing (overiding the BLOM SST) directly during grid initialization.

Files Modified:

1. mod_grid.F90

  Added declaration of the new variable pcmask to the grid module.

  Ensures the mask is initialized together with other grid variables in inivar_grid().

2. geoenv_file.F

  Updated to read the pacemaker_mask variable from the pacemaker_mask.nc file.

  Integrated pcmask loading alongside other grid fields.

  Ensures the mask is available globally after grid initialization.

Description of pcmask:

  Variable name: pcmask

  Source file: pacemaker_mask.nc

The mask has 1.0 in the core of the pacemaker region to 0.0 at the edges of the region (smooth tapering).

Current configuration:

The mask is set for the Kuroshio region in the North Pacific.

Location of the file: 

  /cluster/work/users/hra063/So_t/pacemaker_mask.nc
