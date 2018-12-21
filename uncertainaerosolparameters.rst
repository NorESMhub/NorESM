.. _uncertainaerosolparameters:

Uncertain parameters (which can be discussed) in the aerosol model
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+-----------------------+-------------------------------+-------------------------------+
| Parameter             | Meaning                       | Where in code                 |
+=======================+===============================+===============================+
| sticking coefficients | How easy is it for H2SO4 to   |                               |
|                       | condense on aerosol modes     | condtend.F90 (and AeroTab for |
|                       |                               | the look-up tables)           |
+-----------------------+-------------------------------+-------------------------------+
|size distribution/total| Tune on fraction of dust going|                               |
|dust emission          | to different modes (back to   |                               |
|                       | aerocom estimates??): how much| oslo_dust_intr.F90            |
|                       | is emitted in DST_A2 relative |                               |
|                       | to the DST_A3 tracer          | oslo_dust_intr.F90            |
+-----------------------+-------------------------------+-------------------------------+
| om_to_oc              | How much more "OM" do we get  | mo_srf_emission.F90,          |
|                       | when "OC" is emitted          | mo_extfrc.F90                 |
+-----------------------+-------------------------------+-------------------------------+
| below cloud scavenginv| Below cloud scavenging        | aerosoldef.F90                |
| coeffs                | coefficients                  |                               |
+-----------------------+-------------------------------+-------------------------------+
| size of "life-cycle   | what is the effective size of |                               |
| species"              | "condensate", "coagulate"     | aerosoldef.F90                |
+-----------------------+-------------------------------+-------------------------------+

