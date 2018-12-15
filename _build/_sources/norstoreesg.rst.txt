.. _norstoreesg:

Simple online sharing
=======================                     

Share data online
'''''''''''''''''

For simple data sharing, use the script
\**/projects/NS2345K/tools/wwwpublish**: Usage:

| ``  wwwpublish ``\ \ `` ``\ \ `` ``
| ``  or ``
| ``  wwwpublish ``\ \ `` ``\ \ `` ``

Example:

| ``  wwwpublish /projects/NS2345K/noresm/thredds/CORE2/AMOC CORE2-AMOC ``
| ``  or``
| ``  wwwpublish /projects/NS2345K/noresm/noresm2cmor.tbz noresm2cmor ``

Purpose:

``  Publish data online at ``\ ```http://ns2345k.web.nird.no`` <http://ns2345k.web.nird.no>`__\ `` ``

Description:

``  The input path must be absolute and start with /projects/NS2345K.``

| ``  Only regular files are considered. Symbolic links are skipped.``
| ``         ``
| ``  All date files must have unique names as the folder stucture is ``
| ``  flattened during publication. ``

| ``  Reading permissions of the data files have to be open to everyone. ``
| ``  However, reading permissions of the folders containing the files ``
| ``  can be closed. ``
| ``             ``
| ``  ``\ \ `` should be one word and not contain any special ``
| ``  characters other than "-" and "_".           ``

The script provides following:

| `` *local path to a folder that contains hard-links to the data files ``
| `` *URL that points to the online-catalogue where the shared files are exposed ``
| `` *download-URL to a wget-script that can be used to download the entire dataset (note that execution permissions have to be changed prior to running the script)   ``

NOTE: The sharing method uses hard-links. This has the advantages that
no additional disk space is used and that the sharing happens
instantaneous. A removal of the hard-links will unshare the data, but
will not affect the original files.

Unshare data
''''''''''''

If you don't want to share a dataset anymore, use the script
\**/projects/NS2345K/tools/wwwunpublish**: Usage: wwwunpublish

Example: wwwunpublish CORE2-AMOC

Purpose: Unpublish a dataset from NorStore's www-server

NOTE: Unsharing data will not affect the original data.

Data sharing via the Norwegian ESG data portal
                                              

IMPORTANT: The portal is currently offline for maintenance and its operation is expected to be resumed sometime in October. For an alternative data sharing method see previous section "Simple data sharing".
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`{{ :noresm:noresg.png?nolink&512 \|}} <http://noresg.norstore.no>`__

Simplified publishing (unofficial ESG publication)
''''''''''''''''''''''''''''''''''''''''''''''''''

All users of the NorStore project ns2345k have the possibility to share
their data via NorStore's ESG data portal http://noresg.norstore.no.

Requirements are:

| `` * the data has to reside in /projects/NS2345K (same as /norstore_osl/projects/NS2345K)``
| `` * all files must be regular (i.e., no symbolic links) ``
| `` * file names must all be unique (folder hierarchy is flattened during publication)``
| `` * reading permissions of data files must be open to everyone (does not apply to their parent folders)``

Note that the data sharing solution uses hard links to avoid additional
use of disk resources. The original data is not touched/modified.

Publish a simple dataset to NorStore's ESG data portal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For simple data sharing with ESG support, use the script
\**/projects/NS2345K/tools/esgpublish**: Usage: esgpublish [unlisted]

| ``      or ``
| ``      esgpublish ``\ \ `` ``\ \ `` [unlisted]``

Example: esgpublish /projects/NS2345K/noresm/thredds/CORE2/AMOC
CORE2-AMOC

| ``        or``
| ``        esgpublish /projects/NS2345K/noresm/noresm2cmor.tbz noresm2cmor unlisted ``

Purpose: Publish data via NorStore's online data portal
http://noresg.norstore.no

Description: The input path must be absolute and start with
/projects/NS2345K or

``            /norstore_osl/projects/NS2345K.  ``

| ``            Only regular files (i.e., no symbolic links) are considered. ``
| ``         ``
| ``            All date files must have unique names as the folder stucture is ``
| ``            flattened during publication. ``

| ``            Reading permissions of the data files have to be open to everyone, ``
| ``            but reading permissions of the folders containing the files can be ``
| ``            closed. ``
| ``             ``
| ``            ``\ \ `` should be one word and not contain any special ``
| ``            characters other than "-" and "_". ``
| ``          ``
| ``            If a third argument is specified and set to "unlisted" then the ``
| ``            dataset will be served through the file server but not published ``
| ``            to the portal.             ``

Remove a simple dataset from NorStore's ESG data portal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To unpublish a dataset that previously has been published with
esgpublish, use the script \**/projects/NS2345K/tools/esgunpublish**:
Usage: esgunpublish

Example: esgunpublish CORE2-AMOC

Purpose: Unpublish a dataset from NorStore's online data portal
http://noresg.norstore.no

Standard publishing (official ESG publication)
''''''''''''''''''''''''''''''''''''''''''''''

Several projects (e.g, CMIP, GeoMIP, etc) require special
post-processing and ESG publishing procedures.

Please contact Ingo Bethke (ingo.bethke[at]uni.no) or Alf Grini
(alfg[at]met.no) for assistance.
