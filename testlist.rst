.. _testlist:

Test list for NorESM
''''''''''''''''''''

This page contains a list of tests which need to pass before any changes
can be ported to the trunk. By definition, the trunk always passes these
tests. Any person who finds that the trunk does not pass these tests
should immediately send an email to noresm-ncc(at)met.no

Any development version which does **not** pass the tests **can only exist on branches**.

Restart test
~~~~~~~~~~~~

- Start a 2 month branch run, create monthly average output

- Start the same model run, but define it as two single months with restart in between.

- Verify that the last monthly average is equal in both runs.

Bit-identical meteorology for "technical only" code changes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This test is applicable for code which is not supposed to change the
model physics (e.g. writing out extra diagnostics, cleaning up code
without changing the functionality..)

- Run the code without the new changes

- Run the code with the new changes

- Verify that temperature is equal in both runs (ncdiff file1.nc file2.nc file3.nc) should give zero values in file3.nc

Physical tests (early development)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These tests are applicable for early development of the model. At later
stages, closer to important deliveries, other (and stricter) tests may
apply.

Compare your new result with a result from the previous version of the
trunk code.

If any of the global average of the following variables change with more
than a limit X, then you must first pass through a discussion with the
other developers. Send an e-mail to noresm-ncc(at)met.no before merging
your changes to trunk:


- Aerosol optical depth (AOD_VIS, X=10%)

- Cloud droplet number concentration (CDNC, X=10%)

- Temperature (X = 2K)

- Liquid water path (LWP, X=10%)

- Total aerosol number concentration (N_AER, X=10%)

- Total precipitation (PRECT, X=10%)
