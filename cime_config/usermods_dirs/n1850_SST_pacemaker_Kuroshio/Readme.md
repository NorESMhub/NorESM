**Important usage Notes**

External data format:

The external SST file and pcmask must match the model domain and resolution.

External SST file dimensions: (y, x, time)

Time Handling:

SST is applied at the current model timestep via the send buffer. Thus the time index (nstep_strm) should be aligned. (line 451 in ocn_comp_mct.F90)

Branch runs:

If starting from a specific model year (e.g., year 1320), the time index nstep_strm must account for prior simulation years. That is,

nstep_strm = int(time) - int(time0) - 481434 ! (corresponding to year 1319 * 365 - 1)

Hybrid runs:

No special alignment is required; the time index can be set relative to the model start

nstep_strm = int(time) - int(time0) - 1

The current implementation hard-codes the time index for reading SST. We are trying to fix this with a dynamic approach that calculates the correct time index automatically, avoiding the need for hard-coded values.

Mask Replacement:

To run SST pacemaker experiments in a different region, provide a new mask file and update the pcmask variable.
