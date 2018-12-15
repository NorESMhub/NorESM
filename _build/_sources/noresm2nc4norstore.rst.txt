.. _noresm2nc4norstore:

noresm2nc4 - NorESM output compression tool (NorStore version)
===============================================================                                                              

This version of NorESM's output compression script works on NorStore's
login-nodes as well as on NorStore's newly established computational
node cruncher.norstore.uio.no (request access to cruncher via
support@norstore.no).

Run */projects/NS2345K/tools/noresm2nc4 -h* to print detailed
instructions: Usage: noresm2nc4

Example: noresm2nc4 /project/NS2345K/noresm/cases/my-noresm-case

Purpose: Converts NorESM output to compressed netcdf 4 format and gzips
restarts

Description: IMPORTANT: Only run one instance of noresm2nc4 on a single
case

| ``            at a time (it is ok to run multiple instances of noresm2nc4 on multiple ``
| ``            NorESM cases). If a noresm2nc4 job terminates before completion then ``
| ``            rerun noresm2nc4 (the tool will continue where it stopped).  ``

| ``            Influencial environmental variables (default values): ``
| ``              NTHREADS  (8)                              # number of cpus used``
| ``              ZIPRES    (1)                              # 1=gzip restart files ``
| ``              RMLOGS    (1)                              # 1=remove log files``
| ``              COMPLEVEL (5)                              # compression level ``

Change history: 2014.06.26 (ingo.bethke@uni.no): ported hexagon version
to NorStore

``               2014.04.29 (ingo.bethke@uni.no): first version of noresm2nc4``


