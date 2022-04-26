.. _comp_netcdf:

***************************************
Compare netCDF files from NorESM output
***************************************

For model development it is often useful to compare output from different model runs, to check if a change that has been introduced in the model code or run parameters results in changes of the model output. Since NorESM output contains run-specific metadata, a standard file comparison will usually show that output from different model runs are different, although the data fileds may be identical. Specific tools can be applied to circumvent this problem.


cprnc
-----
**cprnc** is a tool that is included with the NorESM source files, under ::

   cime/tools/cprnc

The tool is available on both Fram and Betzy under ::

   /cluster/shared/noresm/diagnostics/compare_netCDF 

As **cprnc** requires access to shared library files to process netCDF files, specific modules must be loaded in order to use the tool. A wrapper script is therefore available from ::

   /cluster/shared/noresm/diagnostics/compare_netCDF/run_cprnc.sh

A file comparison can be performed by running the script with two input files ::

   ./run_cprnc.sh <file1.nc> <file2.nc>


nccmp
-----
**nccmp** is a general purpose tool that is independent of the NorESM installation, and includes similar functionality as **cprnc**. It is available for download from gitHub at `<https://gitlab.com/remikz/nccmp>`_. Currently we do not maintain installations of **nccmp** on any systems, so users will need to personally download and install this tool.
