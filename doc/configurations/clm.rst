.. _clm:

Land-only experiments
===========================

The text below is extracted from the CLM5.0 users guide: https://escomp.github.io/ctsm-docs/versions/release-clm5.0/html/users_guide/setting-up-and-running-a-case/choosing-a-compset.html (last accessed 7th May 2020)

The compsets of interest when working with CLM are the "I" compsets (which contain CLM with a data atmosphere model and a stub ocean, and stub sea-ice models). When working with CLM you usually want to start with a relevant "I" compset before moving to the more complex cases that involve other active model components. The "I" compsets can exercise CLM in a way that is similar to the coupled modes, but with much lower computational cost and faster turnaround times.

Compsets coupled to data atmosphere and stub ocean/sea-ice ("I" compsets)
-------------------------------------------------------------------------

`Supported CLM Configurations <CLM-URL>`_ are listed in `Table 1-1 <CLM-1.1-Choosing-a-compset-using-CLM#table-1-1-scientifically-supported-i-compsets>`_ for the Scientifically Supported compsets (have been scientifically validated with long simulations) and in `Table 1-2 <CLM-1.1-Choosing-a-compset-using-CLM#table-1-2-functionally-supported-i-compsets>`_ for the Functionally Supported compsets (we've only checked that they function).


Note that using the "-user_compset" option even more combinations are possible. To get a list of the compsets use the "query_config"
command as follows:
::

    $CTSMROOT/cime/scripts/query_config --compsets clm

The $CTSMROOT/cime_config/config_compsets.xml lists all of the compsets and gives a full description of each of them. 
