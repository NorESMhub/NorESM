.. _esmvaltool:

**********
ESMValTool
**********

The Earth System Model eValuation Tool (`ESMValTool <https://esmvaltool.readthedocs.io>`_)
  is a community-development that aims at improving diagnosing and understanding of the causes and effects of model biases and inter-model spread. The ESMValTool can process multiple model outputs, including NorESM, but these model output need to be post-processed to conform with the CMIP data standard (i.e., `CMOR <https://cmor.llnl.gov>`_). ESMValTool support all the published model data output on the `ESGF <https://esgf-data.dkrz.de>`_ 

The `esmvaltool-on-nird <https://github.com/orgs/NorESMhub/teams/esmvaltool-on-nird>`_ discussion group can be a useful resource if you plan to run ESMValTool on Nird.


Run ESMValTool on NIRD service node
===================================

The ESMValTool is currently installed under the dedicated IPCC service node (`<ipcc.nird.sigma2.no>_) for data post-processing. The following NIRD project areas are mounted under /projects of the ``IPCC`` node: NS2345K, NS9034K, NS9039K, NS9252K, NS9560K, NS9588K.

Activate and run ESMValTool
---------------------------

An example of steps to run the ESMValTool on ipcc.nird.sigma2.no

1. login in the ipcc node: ::

    ssh -l username ipcc.nird.sigma2.no

2. load ESMValTool on nird: ::

    conda active /conda/esmvaltool/2.0.0b4/

(note, the esmvaltool may be upgraded in the future. Therefore, use ``ls /conda/esmvaltool/`` to check the currently installed vesion if 2.0.0b4 does not exist.)

3. copy the following config file and recipe to your favourite place: ::

    /projects/NS9252K/share/yanchun/esmvaltool/config_heyc.yml
    /projects/NS9252K/share/yanchun/esmvaltool/recipe_seaice.yml
    
You should copy and modify the config_heyc.yml file to store some intermediate data files and final plots to your own directory.

4. run ``esmvaltool``: ::

    esmvaltool -c config_xxx.yml ./recipe_seaice.yml

5. A sample result under:

    `<http://ns2345k.web.sigma2.no/diagnostics/esmvaltool_output/yanchun>`_

Download data automatically with Synda
--------------------------------------

`Synda <https://esmvaltool.readthedocs.io/en/latest/quickstart/running.html?highlight=synda#running>`_
  is a tool to download and manage model data form the `ESGF <https://esgf-data.dkrz.de>`_, it can be called by the ``esmvaltool`` as a command line option ``--synda`` so that it can automatically download necessary model data as specified in the receipe of ESMValTool. For example, ::

   esmvaltool -c config_heyc.yml ./recipe_seaice.yml --synda

Note, it is OPTIONAL to use synda to download data automatically during the runtime of ESMValTool. One can download the data by some other tools or scripts before running the ESMValTool.

If you do want to use ``synda``, there are two major steps you need to do:

**Activate the tool**

It is install with ``conda``, so you can add ``synda`` exectable to your search path, e.g., ::

  export PATH:$PATH:/projects/NS9252K/conda/synda/bin/synda

Then it should be availabe in your command windown by the ``synda`` command.

**Set up your credentials**

1. register (one of) the `ESGF node <https://esgf-data.dkrz.de/projects/esgf-dkrz/>`_ and `Globus transfer <https://www.globus.org>`_ (not toally sure if account on globus is mandatory if this option will not be used, but seem yes according to my experience, you can firstly try without it)

2. paste your username and password to in ``~/.synda/conf/credentials.conf``

3. configure ``synda`` parameters in ``~/.synda/conf/sdt.conf``, use my setting as template.

4. maybe you need get `globus token`. Run the following command: ::

    synda token -p globus renew

it will give out something like: ::

  Native App Authorization URL:
  https://auth.globus.org/v2/oauth2/authorize?code_challenge=BrmiBhFVVuHVNyGDj6hn5N8M1-EKJNnNgptobIsbTqI&state=_default&redirect_uri=https%3A%2F%2Fauth.globus.org%2Fv2%2Fweb%2Fauth-code&response_type=code&client_id=83ec00c1-e67a-4356-9f1f-f7e31177e31a&scope=openid+email+profile+urn%3Aglobus%3Aauth%3Ascope%3Atransfer.api.globus.org%3Aall&code_challenge_method=S256&access_type=offline
  Enter the auth code:

Paste the above https address to browser, and you will find a authen code, and past back to the command line.
 

Run ESMValTool on NIRD toolkit service
======================================

The ESMValTool is also available from `NIRD Toolkit <https://apps.sigma2.no>`_ applications (Jupyter and JupyterHub), provided by Docker images.

`NIRD Toolkit <https://www.sigma2.no/nird-toolkit>`_ is a cloud infrastructure that gives access to compute nodes on Nird. The service is managed by `Kubernetes <https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/>`_ which launches applications from `Docker containers <https://docs.docker.com/get-started/overview/>`_.

Access to the NIRD Toolkit service is provided according to a 3 tier ranking

1. **Owner** : a project leader/executive officer of a NSxxxxK project

2. **Admin** : a person authorized by an **owner** to manage NIRD Toolkit applications

3. **Member** : a person authorized by the **owner** or **admin** to access a NIRD Toolkit application

In order to use NIRD Toolkit, an **owner** of of a NSxxxxK project should create a group in `dataporten <https://minside.dataporten.no/#userinfo>`_, and invite **members** to join, who may be given **admin** status by the **owner** or existing **admin** people. See Sigma2 information page about `deploing service <https://www.sigma2.no/get-ready-deploy-service-through-nird-toolkit>`_ for details about the procedure.

Install and run an application
------------------------------

Applications in NIRD Toolkit are available from::

    https://apps.sigma2.no/nird

An owner/admin can launch a new application by installing it, and request resources to be made available to the application via the Kybernetes management system. A member can launch an existing application that has previously been set up by an owner/admin. The application setup allows access to storage areas under NSxxxxK storage volumes (read-only by default) and a user storage area under a specific NSxxxxK/subfolder with write access, but only applications pre-defined in the docker image provided to the Kybernetes system can be used.

Install ESMValTool docker image
-------------------------------

ESMValTool is not included in the default docker images provided by Sigma2, but has been installed in modified docker images. These are created by building ESMValTool on top of an official Sigma2 docker image, and package in a new docker container. Such modified docker images are available for `jupyter` and `jupyterhub` applications.

1. **jupyterhub:** nordicesmhub/jupyterhub-nird-toolkit
  - *source* : https://github.com/NorESMhub/jupyterhub-nird-toolkit
  - *docker* : https://hub.docker.com/r/nordicesmhub/jupyterhub-nird-toolkit ::

   nordicesmhub/jupyterhub-nird-toolkit:latest

2. **jupyterhub:** tomastorsvik/nird_jupyterhub-singleuser_esmvaltool
  - *source* : https://github.com/TomasTorsvik/jupyterhub-nird-toolkit
  - *docker* : https://hub.docker.com/repository/docker/tomastorsvik/nird_jupyterhub-singleuser_esmvaltool ::

   tomastorsvik/nird_jupyterhub-singleuser_esmvaltool:latest

3. **jupyter:** tomastorsvik/nird_jupyter-spark_esmvaltool
  - *source* : https://github.com/TomasTorsvik/jupyter-spark-nird-toolkit
  - *docker* : https://hub.docker.com/repository/docker/tomastorsvik/nird_jupyter-spark_esmvaltool ::

     tomastorsvik/nird_jupyter-spark_esmvaltool:latest


To install the docker image you need access to the Nird Toolkit service through a project, and install a new instance of e.g. "jupyter". On the installation page you select whatever standard settings you like (application name, projectspace, persistent storage, machine type), and then select "Show advances configuration..." and replace the standard dockerimage with: ::

    tomastorsvik/nird_jupyter-spark_esmvaltool:latest

One can activate the "JupyterLab" option in the configuration (but it is may not necessary to do so to run ESMValTool). To test if the image is installed correctly (provided the jupyter notebook environment builds without errors) you can open a terminal in the environment and type ``esmvaltool -h``, which should give you the help page for the tool in the terminal window.

As the development of ESMValTool and the updating of the NIRD Toolkit base system are not syncronous, there may sometimes be conflits in the package dependencies of what ESMValTool wants and what NIRD Toolkit provides. Hence, it is sometimes necessary to build ``esmvaltool`` in a separate ``conda`` environment (not "base"). If ``esmvaltool -h`` fails to give the expected output, check if there exist any alternative environments by doing ::

  conda env --list

If you find an ``esmvaltool`` environment, this can be activated by ::

  source activate esmvaltool

At the time of writing (10 June 2020), the preferred activation method ``conda activate esmvaltool`` is not recognized inside a NIRD Toolkit application.
