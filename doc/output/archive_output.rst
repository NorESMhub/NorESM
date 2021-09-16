.. _archive_output:

Archiving NorESM output
=======================

Archiving of NorESM output involve three distinct processes that serve different purposes. The medium-term and long-term archiving described here depend on services provided by `sigma2 <https://www.sigma2.no>`_, but the procedures may also be relevant for other systems. 

Short-term archiving
^^^^^^^^^^^^^^^^^^^^

Medium-term archiving
^^^^^^^^^^^^^^^^^^^^^
Medium-term archiving is the process of transferring NorESM output from a HPC server to a storage server. This is usually required if data should be saved for later analysis, since HPC servers typically have only limited storage capacity, and often enforce automatic deletion (auto-cleanup) on their storage space at regular intervals.

The following example consider the case of moving data from the HPC *betzy* to the storage server *nird*, but these procedures should be possible to follow on most other systems. Readers may also refer to the `sigma2 file transfer <https://documentation.sigma2.no/files_storage/file_transfer.html>`_ documentation for further information.

We generally recommend to use ``rsync`` for data transfer between servers. ``rsync`` is available on most systems, and has a wide range of useful features, including an archive mode (``-a``) and the option to preserve partial file transfers (``-P``). This last option is particularly useful for transfer of large files between remote servers, which may sometimes suffer from interruptions due to unstable network connections. One drawback with the archive mode is that ``rsync`` tries to preserve all directory and file permissions from the source server (*betzy*), whereas we usually want to apply default file permissions from the destination server (*nird*) and share data with other project members. This problem can be solved by using either the ``--chown`` or ``--no-group`` flags, depending on whether ``rsync`` is running from the source server or destination server.

Running ``rsync`` from *nird*::

  rsync -aP --no-group <username>@betzy.sigma2.no:<path/to/noresm/output> <path/to/project/storage>

Running ``rsync`` from *betzy*::

  rsync -aP --chown=OWNER:GROUP <path/to/noresm/output> <username>@login.nird.sigma2.no:<path/to/project/storage>

For *nird* it is sufficient to use the ``--no-group`` flag, then the files and directories will automatically get the default group settings for the destination project directory. For *betzy* it is necessary to use ``--chown=OWNER:GROUP`` to obtain the same effect, where ``OWNER`` is the username for the person making the file transfer and ``GROUP`` is the project account (e.g. ``ns9252k``). It is possible to use the ``--no-group`` also from the source server, but this will only apply the destination group settings for directories. If file permissions are not updated during the data transfer, it is possible to do this on *nird* after the data transfer by running ``chown -R USER:GROUP`` on the archive directory that has been transferred.

If for some reason ``rsync`` is not applicable, it is possible to use other applications such as ``sftp`` or ``scp``, for instance::

  scp -r <path/to/noresm/output> <username>@login.nird.sigma2.no:<path/to/project/storage>


Long-term archiving
^^^^^^^^^^^^^^^^^^^
Long-term archiving is the process of transferring NorESM output from the NIRD storage to the NIRD research archive. This is usually done after the data has been cmorized and/or published to an ESGF node. The data is typically stored 5 - 10 years or longer. After the data has been uploaded and archived, the copy on NIRD storage should be deleted to save storage space.

The main documentation, `Research Data Archive User-Guide <https://documentation.sigma2.no/nird_archive/user-guide.html>`_ is found on the sigma2 site. The archiving is done by filling in a web-form, and the documentation includes most of the screenshots needed to see which metadata are required to fill them in. Mark the notes in the documentation on the constraints of the web-form.

Sigma2 are in their finalizing stages on creating an API for archiving data programatically, so this procedure may become simpler in the future. We are in dialog with sigma2 to make this API fit our needs.

Below are supplementary screenshots to the sigma2 user-guide, which also shows how to get hold of the metadata from the ESGF node.

Visit the noresm2cmor repository:

.. image:: images/long-term-archive-01.png
   :width: 800

Find the published data:

.. image:: images/long-term-archive-02.png
   :width: 800

Extract the ``:further_info_url`` from the data:

.. image:: images/long-term-archive-03.png
   :width: 800

Further info page:

.. image:: images/long-term-archive-04.png
   :width: 800

Find the metadata on the ES-DOC pages, and login to `NIRD research archive <https://archive.sigma2.no>`_ and start the deposit-dataset 
web-form:

.. image:: images/long-term-archive-05.png
   :width: 800

Page 1:

.. image:: images/long-term-archive-06.png
   :width: 800

Page 2a:

.. image:: images/long-term-archive-07.png
   :width: 800

Page 2b:

.. image:: images/long-term-archive-08.png
   :width: 800

Page 3a:

.. image:: images/long-term-archive-09.png
   :width: 800

Page 3b:

.. image:: images/long-term-archive-10.png
   :width: 800

Auto-reply from sigma2:

.. image:: images/long-term-archive-11.png
   :width: 800

The registered archive info:

.. image:: images/long-term-archive-12.png
   :width: 800

Page 4a:

.. image:: images/long-term-archive-13.png
   :width: 800

Page 4b:

.. image:: images/long-term-archive-14.png
   :width: 800
