#!/usr/bin/env python3
import sys
from CIME.case import Case

"""
Python script to run a model several times within one job submission.

Documentation on this script can be found at:
https://esmci.github.io/cime/versions/master/html/ccs/running-a-case.html#data-assimilation-scripts

This script can be activated in a NorESM case by using these commands
(from within the case directory) before submitting an experiment:

./xmlchange DATA_ASSIMILATION_SCRIPT=$(./xmlquery --value SRCROOT)/tools/rerun_noresm.py
./xmlchange DATA_ASSIMILATION_CYCLES=3

"""

def rerun_noresm(caseroot, cycle_num):
    """Print the current cycle number and set the case to restart"""
    with Case(caseroot, read_only=False) as case:
        num_cycles = case.get_value('DATA_ASSIMILATION_CYCLES')
        print(f"Completed cycle {int(cycle_num) + 1} / {num_cycles}")
        case.set_value('CONTINUE_RUN', True)
        case.create_namelists()
        case.flush()


if __name__ == "__main__":
    caseroot = sys.argv[1]
    cycle_num = sys.argv[2]
    rerun_noresm(caseroot, cycle_num)
