.. _cmip_other:

Other CMIP5/6 data
===================
In addition to CMIP data by NorESM, some other CMIP5 and CMIP6 model and observational data are also downloaded and (currently) stored on Betzy, which is also accessible from NIRD. However, it is not a full replica of ESGF archive. Missing data can be downloaded from ESGF to directory /cluster/shared/ESGF/rawdata, see instructions below.

.. note::
    Data usage policy:
    Users of the CMIP data copy are requested to respect the data policies of CMIP and acknowledge the KeyCLIM project for providing access to the data (acknowledgement shall be done in CRISTIN for any publication resulting of data usage taken from the nird data, KeyCLIM project number 295046).

Data access
^^^^^^^^^^^^^^
All Betzy users can access the (partial) replica of CMIP6 data under Betzy: 
::

   /cluster/share/ESGF
   
It contains CMIP5, CMIP6 and obs4MIPs datasets. These data are also accessible (read-only) on NIRD for members of NS9252K 
:: 

   /projects/NS9252K/ESGF_betzy

Data download
^^^^^^^^^^^^^^
There are two alternatives to download additional CMIP datasets:

1. Make a request for data or for more data to be downloaded to this folder, contact jang@met.no.
2. Download data by yourself, one can use the automatically-generated wget shell script on the ESGF data portal (e.g., `DKRZ ESGF portal <https://esgf-data.dkrz.de/projects/esgf-dkrz/>`_), or use the tool called `Synda <https://prodiguer.github.io/synda/index.html>`_ (Refer to the following subsection :ref:`download_with_synda`).

For either way to download the data, please follow the :ref:`data_download_guideline` to download and move your data to the right place so that it will be sorted to the DKRZ structure.
   
If you are a NIRD user, but not a member of this project and would like to request access, contact michaels@met.no.

.. note::
    NorESM CMIP data! They are stored on nird under /pojects/NS9034K/ (not under /projects/NS9252K). You don't need to download NorESM data to avoid duplication.

.. _data_download_guideline:

Data download guideline
-------------------------

(This guidline is also noted in /cluster/shared/ESGF/README.)

1. Download your data under (recommended, but OK to be elsewhere): 
::

    /cluster/shared/ESGF/rawdata/model

2. After all downloaded, invoke the script ``move2autosort.sh`` to move data to ``/cluster/shared/ESGF/rawdata/autosort`` and automatically set correct file permission/ownership:

    For example: ::

        $ cd /cluster/shared/ESGF/rawdata
        $ ./move2autosort.sh "/cluster/shared/ESGF/rawdata/model/mydata*.nc"

    or  ::

        $ ./move2autosort.sh "/cluster/shared/ESGF/rawdata/model/mydatafolder"


.. note::
    * You can create subfolders to organise the downloaded data
    * Do NOT download data directly to /cluster/shared/ESGF/rawdata/autosort
    * The data will start to be automatically sorted to ESGF/DKRZ folder structures within 30 minutes.
    * The users can NOT invoke the 'raw2dkrz.sh' script anymore (since April 2022).

3. If data are NOT sorted to the desired place, then:
    - Check if they have been moved to: ``/cluster/shared/ESGF/rawdata/autosort/failed``
    - If so, check what was going on in the recent log under: ``/cluster/shared/ESGF/rawdata/logs``

.. note::
    * If you are sure your dataset are correct, you can try to move your data under /cluster/shared/ESGF/rawdata/autosort/failed again back to /cluster/shared/ESGF/rawdata/autosort (simply by 'mv' or 'move2autosort.sh')
    * Sometimes the HPC will be rebooted, and the crontab job to automatically sort the data will be swipped away. Or some internet problem so that the Synda connections can not be established correctly. 
    * If there is still problem, please contact yanchun.he@nersc.no to report the error (but not for specific data download requests).

.. _download_with_synda:

Download data with Synda
------------------------

``Synda`` is installed under Betzy for downloading and managing CMIP data from ESGG.

It is currently installed at `/cluster/shared/ESGF/software/synda`.

(Note, this just serves as an alternative to the tool/scripts `ESGF_download <https://github.com/metno/ESGF_download>`_ by Jans)

Refer to its `documentation <http://prodiguer.github.io/synda/>`_ for introduction and user's guide. But be alerted that its documentation seems not well written and keeps up-to-date.

A simply tutorial on how to use it to download and mange CMIP data.

Activate the tool
++++++++++++++++++

Synda is installed with ``Conda`` Betzy, so you can load it by: ::

    conda activate /cluster/shared/ESGF/software/synda

or just add ``synda`` exectable to your search path, e.g., ::

    mkdir -p ~/local/bin
    ln -s /cluster/shared/ESGF/software/synda/bin/synda ~/local/bin/synda
    echo 'export PATH=$PATH:~/local/bin' >>~/.bashrc

Then it is availabe by the ``synda`` command.

Configuration
++++++++++++++++

You’ll need to properly configure the synda work environment. To do so, the first step is the set a synda home environment variable. This will the be the directory that will harbor all the configuration, database and other required files for synda to function properly. So choose it well. For instance: /home/user/.synda would do the trick. ::

    export ST_HOME=$HOME/.synda

For more information, please refer to the `Synda documentation <https://prodiguer.github.io/synda/sdt/conda_install.html#configuration>`_

Set up your credentials
+++++++++++++++++++++++

1. register (one of) the `ESGF node <https://esgf-data.dkrz.de/projects/esgf-dkrz/>`_ and `Globus transfer <https://www.globus.org>`_ (not toally sure if account on globus is mandatory if this option will not be used, but seem yes according to my experience, you can firstly try without it)
2. paste your username and password to in `~/.synda/conf/credentials.conf`
3. configure `synda` parameters in `~/.synda/conf/sdt.conf`, use my setting as template (find them under `/cluster/shared/ESGF/software/noresmvaltool/synda/config/sdt.conf`.
4. maybe you need get `globus token`.

running the following command: ::

    synda token -p globus renew

it will give out something like: ::

    Native App Authorization URL:
    https://auth.globus.org/v2/oauth2/authorize?code_challenge=BrmiBhFVVuHVNyGDj6hn5N8M1-EKJNnNgptobIsbTqI&state=_default&redirect_uri=https%3A%2F%2Fauth.globus.org%2Fv2%2Fweb%2Fauth-code&response_type=code&client_id=83ec00c1-e67a-4356-9f1f-f7e31177e31a&scope=openid+email+profile+urn%3Aglobus%3Aauth%3Ascope%3Atransfer.api.globus.org%3Aall&code_challenge_method=S256&access_type=offline
    Enter the auth code:

paste the above https address to browser, and you will find a authen code, and past back to the command line.

Examples to download data
+++++++++++++++++++++++++

Firstly search the targeting datasets: ::

    ## CMIP5 datasets
    synda search -f project=CMIP5 model=NorESM1-M,NorESM1-ME variable=thetao,tos experiment=historical ensemble=r1i1p1 timeslice=200101-200612
    synda search project=CMIP5 product=output1 institute=NCAR model=CCSM4 experiment=historical frequency=mon realm=atmos cmor_table=Amon ensemble=r1i1p1 latest=true variable=rlut timeslice=195001-200512 version=20160829

    ## CMIP6 datasets
    synda search project=CMIP6 activity_id=CMIP institution_id=NCC,EC-Earth-Consortium source_id=NorESM2-LM,EC-Earth3 table_id=Amon experiment_id=historical variable_id=tas variant_label=r1i1p1f1  latest=true
    synda search project=CMIP6 activity_id=CMIP institution_id=NCC,EC-Earth-Consortium  source_id=NorESM2-LM,EC-Earth3 experiment_id=historical variant_label=r1i1p1f1 table_id=SImon variable_id=siconc grid_label=gn timeslice=197001-198901 latest=true

It puts here as many as parameters to serve as a template, and you can tune these parameters as you like. And you can reduce the amount of facets/parameters.

The above command gives you results: ::

    new  CMIP6.CMIP.NCC.NorESM2-LM.historical.r1i1p1f1.Amon.tas.gn.v20190815
    new  CMIP6.CMIP.EC-Earth-Consortium.EC-Earth3.historical.r1i1p1f1.Amon.tas.gr.v20200310

Use ``synda search -f`` list all the matching files.

each dataset contains several files, then download the dataset to the current directory, for example, ::

    synda get CMIP6.CMIP.EC-Earth-Consortium.EC-Earth3.historical.r1i1p1f1.Amon.tas.gr.v20200310

or individual file(s) by: ::

    synda get CMIP6.CMIP.NCC.NorESM2-LM.historical.r1i1p1f1.Amon.tas.gn.v20190815.tas_Amon_NorESM2-LM_historical_r1i1p1f1_gn_201001-201412.nc

