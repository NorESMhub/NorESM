.. _esmvaltool:

**********
ESMValTool
**********

The Earth System Model eValuation Tool (`ESMValTool <https://esmvaltool.readthedocs.io>`_)
  is a community-development that aims at improving diagnosing and understanding of the causes and effects of model biases and inter-model spread. The ESMValTool can process multiple model outputs, including NorESM, but these model output need to be post-processed to conform with the CMIP data standard (i.e., `CMOR <https://cmor.llnl.gov>`_). ESMValTool support all the published model data output on the `ESGF <https://esgf-data.dkrz.de>`_ 


Run ESMVAlTool on NIRD service node
===================================

The ESMValTool is currently installed under the dedicated IPCC service node (`<ipcc.nird.sigma2.no>_) for data post-processing.

Activate and run ESMValTool
----------------

An example of steps to run the ESMValTool on ipcc.nird.sigma2.no

1. login in the ipcc node: ::

    ssh -l username ipcc.nird.sigma2.no

2. load ESMValTool on nird: ::

    conda active /conda/esmvaltool/2.0.0b4/

(note, the esmvaltool may be upgraded in the future. Therefore, use ``ls /conda/esmvaltoo/`` to check the currently installed vesion if 2.0.0b4 does not exist.)

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
  is a tool to download and manage model data form the `ESGF <https://esgf-data.dkrz.de>`_, it can be called by the ``esmvaltool`` as a command line option ``--synda`` so that it can automatically download necessary model data as specified in the receipe of ESMValTool. For example, ``esmvaltool -c config_heyc.yml ./recipe_seaice.yml --synda``.

Note, it is OPTIONAL to use synda to download data automatically during the runtime of ESMValTool. One can download the data by some other tools or scripts before running the ESMValTool.

If you do want to use Synda, there are two major steps you need to do:

**Activate the tool**

It is install with `Conda`, so you can add ``synda`` exectable to your search path, e.g., ::

  export PATH:$PATH:/projects/NS9252K/conda/synda/bin/synda

Then it should be availabe in your command windown by the ``synda`` command.

**Set up your credentials**

1. register (one of) the [ESGF node](https://esgf-data.dkrz.de/projects/esgf-dkrz/) and [Globus transfer](https://www.globus.org) (not toally sure if account on globus is mandatory if this option will not be used, but seem yes according to my experience, you can firstly try without it)

2. paste your username and password to in ``~/.synda/conf/credentials.conf``

3. configure ``synda`` parameters in ``~/.synda/conf/sdt.conf``, use my setting as template.

4. maybe you need get `globus token`. Run the following command: ::

    synda token -p globus renew

it will give out something like: ::

  Native App Authorization URL:
  https://auth.globus.org/v2/oauth2/authorize?code_challenge=BrmiBhFVVuHVNyGDj6hn5N8M1-EKJNnNgptobIsbTqI&state=_default&redirect_uri=https%3A%2F%2Fauth.globus.org%2Fv2%2Fweb%2Fauth-code&response_type=code&client_id=83ec00c1-e67a-4356-9f1f-f7e31177e31a&scope=openid+email+profile+urn%3Aglobus%3Aauth%3Ascope%3Atransfer.api.globus.org%3Aall&code_challenge_method=S256&access_type=offline
  Enter the auth code:

Paste the above https address to browser, and you will find a authen code, and past back to the command line.
 

Run ESMVAlTool on NIRD toolkit service
======================================

The ESMValTool is also installed as a service at the NIRD Toolkit Service (`<https://apps.sigma2.no>`_)

To install the docker image you need access to the Nird Toolkit service through a project, and install a new instance of "jupyter": ::

    https://apps.sigma2.no/nird

On the installation page you select whatever standard settings you like (application name, projectspace, persistent storage, machine type), and then select "Show advances configuration..." and replace the standard dockerimage with: ::

    tomastorsvik/nird_jupyter-spark_esmvaltool:latest

One can activate the "JupyterLab" option in the configuration (but it is may not necessary to do so to run ESMValTool). To test if the image is installed correctly (provided the jupyter notebook environment builds without errors) you can open a terminal in the environment and type ``esmvaltool -h``, which should give you the help page for the tool in the terminal window.

(Some details about how to access the NS9034K project area for NorESM CMIP5/CMIP6 model experiments are still missing...)


