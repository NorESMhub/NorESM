.. _filenaming:

Naming of input files used in  NorESM
======
All input data files need to have the version information included in the file name. We recommend to add the creation date at the end of 
the file name on the format YYYYMMDD, where:

| YYYY: year
| MM: month
| DD: day
|
| If the files are generated for NorESM specifically, we recommend to add an **n** before the creation date: 

::

   $FILENAME_nYYYYMMDD.$EXT
   
::

$EXT is e.g. nc for a NetCDF file
