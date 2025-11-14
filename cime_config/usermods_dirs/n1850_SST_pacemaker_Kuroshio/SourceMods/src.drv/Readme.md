Modifications were made to the DRV source code to override the BLOM Sea Surface Temperature (SST) over a defined pacemaker region with SSTs from a separate NetCDF file. These changes do not affect other fields or fluxes outside the pacemaker region.


Key Changes

1. External SST (So_t) and Pacemaker Mask (pcmask)

SST is read from an external NetCDF file using the subroutine "get_So_t" (lines 425 - 524 in ocn_comp_mct.F90)

The pacemaker mask (pcmask) defines where the SST override is applied. It has values range from 1 in the core of the pacemaker region to 0 at the edges for smooth spatial transition. It is currently set for the Kuroshio region; other regions can be used by updating the mask.

Initialization of these variables are done in mod_grid.f90 /geoenv.F files in src.blom.

2. Send Buffer Accumulation (sumsbuff_mct.F)

Modified to apply external SST wherever pcmask > 0 (see sumsbuff_mct subroutine, lines 112–115).

Inside the masked region, model SST is fully overridden by the external SST:

  sbuff(i,j,index_o2x_So_t) = sbuff(i,j,index_o2x_So_t) + temp(i,j,k1n)*baclin + pcmask(i,j)*(So_t(i,j)-temp(i,j,k1n))*baclin

Outside the masked region, model SST remains unchanged.

Other prognostic fields are unaffected.

3. Coupling Integration

The SST override is applied in the MCT send buffer, ensuring proper integration with the BLOM coupling cycle.


Important usage Notes

External data format:

The external SST file and pcmask must match the model domain and resolution.

External SST file dimensions: (y, x, time)

Time Handling:

SST is applied at the current model timestep via the send buffer. Thus the time index (nstep_strm) should be aligned. (line 451 in ocn_comp_mct.F90)

Branch runs: 

If starting from a specific model year (e.g., year 1320), the time index nstep_strm must account for prior simulation years. That is, 

nstep_strm = int(time) - int(time0) - 481434  ! (corresponding to year 1319 * 365 - 1)


Hybrid runs:

No special alignment is required; the time index can be set relative to the model start

nstep_strm = int(time) - int(time0) - 1

The current implementation hard-codes the time index for reading SST. We are trying to fix this with a dynamic approach that calculates the correct time index automatically, avoiding the need for hard-coded values.

Mask Replacement:

To run SST pacemaker experiments in a different region, provide a new mask file and update the pcmask variable.
