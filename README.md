# Norwegian Earth System Model Documentation

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

[![NordicESMhub chat](https://img.shields.io/badge/zulip-join_chat-brightgreen.svg)](https://nordicesmhub.zulipchat.com/)

[![Documentation Status](https://readthedocs.org/projects/noresm-docs/badge/?version=latest)](https://noresm-docs.readthedocs.io/en/latest/?badge=latest)

The documentation is for now what was available as part of the MetNo wiki and needs to be re-organized (see project).

## How to contribute to the NorESM documentation

- step 1: Fork this repository as shown in the figure below.

<img src="img/fork_NorESM-docs.png" alt="Fork NorESM documentation repository">

- step 2: Go online to [NorESM documentation](https://noresm-docs.readthedocs.io/en/latest/) and whenever you would like to update the documentation, click on "Edit on GitHub".

<img src="img/edit_on_github.png" alt="Edit documentation online">

- step 3: Then click on the "pen" (see image below) and write your text ([reStructuredText](http://docutils.sourceforge.net/docs/user/rst/quickref.html)) 


<img src="img/edit_in_your_fork.png" alt="Edit the file in your fork">

- step 4: Save your changes in your forked repository and create a pull request.


<img src="img/propose_changes.png" alt="Propose your changes">


If you do not like to update the documentation online and prefer to use your favorite editor locally on your machine/laptop, you can skip step-3 and 4 and then clone your forked repository to edit the files locally. Once pushed to your forked github repository, you can create a pull request and propose your changes.

Example on how to see your changes locally with sphinx:

Prepare your PC/MAC

conda install sphinx

conda install -c conda-forge sphinxcontrib-bibtex

conda install -c conda-forge sphinx_rtd_theme

Copy NorESMdoc repository to local

git clone git@github.com:NorESMhub/NorESM-docs.git

go to NorESM-docs dir

sphinx-build . _build

open _build/index.html in browser

More info
See https://coderefinery.github.io/documentation/04-sphinx/

