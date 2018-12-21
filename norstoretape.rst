.. _norstoretape:

NorStore Tape Storage
=====================                     

Basic use
'''''''''

Instructions for basic use of the tape resources are found on NorStore's
`homepage <https://www.norstore.no/services/tape-storage>`__.

Advanced use
''''''''''''

A collection of high-level tape tools is available in
``/projects/NS2345K/tools``.

noresm2tape
^^^^^^^^^^^

noresm2tape copies the output of a NorESM case from NorStore's disk area
to NorStore's tape resource. The output folder should be organised in
the standard CCSM way (e.g., atmospheric output is expected in
'atm/hist'). If that is not the case, please use the command disk2tape
instead.

- **IMPORTANT:** 
 It is highly recommended to run the script in background using the nohup command, e.g.,

::

  nohup /projects/NS2345K/tools/noresm2tape &
  

Make sure not to forget the "&" at the end of the line. After submitting the script with nohup, it is safe to log out. You will receive a notification email when the transfer to tape is completed.   ``

Run ``/projects/NS2345K/tools/noresm2tape -h`` to print detailed instructions:

::

  Usage: noresm2tape

  Example: noresm2tape /scratch/ingo/mycase /tape/NS2345K/cases/mycase auto replica

  Purpose: Copies NorESM case output from disk to tape.

  Description: <path on disk> and <path on tape> must be full path names (see example). 
               <chunk size> must be one of: auto, all, 1, 10, 100, or 1000 (numbers indicate simulation years per chunk)
	       <replication flag> must be either 'replica' - resulting in two tape copies - or 'noreplica'.  
	       
	       The output folder <path on tape> will be created - with parent
	       directories if necessary - and must not exist before running this script.
	       
	       The input data is staged in form of tar-chuncks in 
	       /scratch/ingo/noresm2tape. The tar-chunks are removed from
	       scratch after successfull transfer to tape.
	       
	       Checksums for all input files are computed and stored in a separate
	       checksum file. The checksums are used to verify the tar-chunks.  


disk2tape
^^^^^^^^^

disk2tape copies a folder from NorStore's disk area to NorStore's tape
resource. In contrast to noresm2tape, the data folder can have any
structure and content.

**IMPORTANT:** 
It is highly recommended to run the script in background using the nohup command, e.g.,

::


  nohup  /projects/NS2345K/tools/disk2tape &
  
Make sure not to forget the "&" at the end of the line. After submitting the script with nohup, it is safe to log out. You will receive a notification email when the transfer to tape is completed. 

Run 

::

  /projects/NS2345K/tools/disk2tape -h
  
to print detailed instructions: 

::

  Usage: disk2tape [none|gzip|bzip2] [replicate]

  Example: disk2tape /projects/NS2345K/hirlam /tape/NS2345K/hirlam

  Purpose: Copies a folder from disk to tape.

  Description: <path on disk> must be the absolute path to the input folder.
               <path on tape> will be created - with parent directories if 
	                      necessary - and must not exist before running this script.
			      
	       gzip or bzip2 compression will be performed if the third argument is 
	       set to "gzip" or "bzip2", respectively. The default is no compression.
	       
	       If the forth argument is set to "replicate" then a second copy of
	       the data will be stored on another physical tape medium.
	       
	       The path of the additional copy differs from the path of the first 
	       copy by that /tape is replaced with /replica. 
	       
	       The input data is staged in form of tar-chuncks in
	       /scratch/$USER/`basename $0`. The tar-chunks are removed from scratch 
	       after success transfer to tape.
	       
	       The size of a single tar-chunk is about 15Gb if no compression is 
	       applied. If compression is applied, the size of the tar-chunks can
	       be up to 60Gb as a compression factor 4 is assumed.
	       
	       Checksums for all input files are computed and stored in a separate
	       checksum file. The checksums are used to verify the tar-chunks.


tape2disk
^^^^^^^^^

tape2disk copies a folder that had been put on tape with either
noresm2tape or disk2tape. All tar-archieves found in the top-level
folder are unpacked while tar-files stored within tar-files are not
inflated.

Run 

::
  
  /projects/NS2345K/tools/tape2disk -h
  
to print detailed instructions:

::

  Usage: /projects/NS2345K/tools/tape2disk <path on tape> <path on disk>

  Example: /projects/NS2345K/tools/tape2disk /tape/NS2345K/hirlam /scratch/ingo/hirlam

  Purpose: Retrieves a folder from tape and unpacks all tar-archieves contained in it.

  Description: <path on disk> will be created if it does not exist.

listontape
^^^^^^^^^^

listontape lists all files that are archived in a tape folder.

Run 

::

  /projects/NS2345K/tools/listontape -h
  
to print detailed instructions:

::

  Usage: /projects/NS2345K/tools/listontape <path to data-directory on tape> 
         or
	 /projects/NS2345K/tools/listontape <path to checksum file on tape>
  
  Example: 
         /projects/NS2345K/tools/listontape /tape/NS2345K/hirham_nobackup/BCM
         or
	 /projects/NS2345K/tools/listontape /tape/NS2345K/hirham_nobackup/BCM/BCM.md5.tar
	 
  Purpose: Lists the names of files that are archived in a given directory on tape.
  
  Description: The script relies on the existence of a checksum file, with extension
               md5.tar, that is stored in the archive directory. 
	       
	       If exactly one checksum file exists then directory path is sufficient
	       as input argument. However, if two or more checksum file exist then
	       the absolute path to the checksum file has to be provided.
