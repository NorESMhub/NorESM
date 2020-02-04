.. _uncertainaerosolparameters:

Uncertain parameters (which can be discussed) in the aerosol model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

^ Parameter ^ Meaning ^ Where in code ^ \| sticking coefficients \| How
easy is it for H2SO4 to condense on aerosol modes \| condtend.F90 (and
AeroTab for the look-up tables) \| \| size distribution/total dust
emission \| Tune on fraction of dust going to different modes (back to
aerocom estimates??): how much is emitted in DST_A2 relative to the
DST_A3 tracer \| oslo_dust_intr.F90 \| \| om_to_oc \| How much more "OM"
do we get when "OC" is emitted \| mo_srf_emission.F90, mo_extfrc.F90 \|
\| below cloud scavenginv coeffs \| Below cloud scavenging coefficients
\| aerosoldef.F90 \| \| size of "life-cycle species" \| what is the
effective size of "condensate", "coagulate" \| aerosoldef.F90 \|
