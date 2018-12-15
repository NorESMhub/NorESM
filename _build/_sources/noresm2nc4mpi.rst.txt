.. _noresm2nc4mpi:

noresm2nc4mpi - hexagon compression tool for NorESM output
==========================================================
                                                          

Run */work/shared/noresm/tools/noresm2nc4mpi -h* to print detailed
instructions: Usage: /work/shared/noresm/tools/noresm2nc4mpi

Example: export ACCOUNT=nn9039k

| ``        export WALLTIME=24:00:00 ``
| ``        noresm2nc4mpi /work/ingo/archive/my-noresm-case ``
| `` ``

Purpose: Converts NorESM output to compressed netcdf 4 format and gzips
restart files

Description: noresm2nc4mpi is fully mpi parallized and submits a pbs job

| ``            to the queue to do the compression on the backend.  ``
| ``           ``
| ``            IMPORTANT: Only run one instance of noresm2nc4mpi on a single case``
| ``            at a time. Yet, it is safe to run multiple instances of noresm2nc4mpi ``
| ``            on multiple NorESM cases at a time. In case that a noresm2nc4mpi job ``
| ``            terminates before completion then simply run noresm2nc4mpi again ``
| ``            (the tool with continue where it stopped).  ``

| ``            Influencial environmental variables (default values): ``
| ``              ACCOUNT   (nn2345k)``
| ``              WALLTIME  (48:00:00) ``
| ``              NTHREADS  (32)                             # number of cpus used``
| ``              ZIPRES    (1)                              # 1=gzip restart files ``
| ``              RMLOGS    (1)                              # 1=remove log files``
| ``              COMPLEVEL (5)                              # compression level ``
| ``              NCCOPY    (/opt/cray/netcdf/4.1.3/gnu/46/bin/nccopy)``
| ``              NCDUMP    (/opt/cray/netcdf/4.1.3/gnu/46/bin/ncdump)  ``
| ``              GZIP      (/usr/bin/gzip) ``
| ``              TEMPDIR   (/work/ingo/noresm2nc4mpi) ``


