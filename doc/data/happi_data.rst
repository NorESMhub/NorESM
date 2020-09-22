.. _happi_data.rst

HAPPI and HappiEVA data
=============

Experiments for 1.5 and 2.0 degree warming 
^^^^^^^^^^^^^

AMIP-style HAPPI experiments
++++++++++++++++

A set of AMIP-style large ensemble experiments (125 members) were carried out with NorESM1-Happi (Graff et al., 2019) for three climate states: 

   - the present-day climate (the All-Hist experiment), 
   - a climate that is 1.5 degrees warmer than pre-industrial conditions (the Plus15-Future experiment), and 
   - a climate that is 2.0 degrees warmer than the pre-industrial (the Plus20-Future experiments) 

as a part of the HAPPI initiative (Half A degree additional warming, Prognosis and Projected Impacts; http://happimip.org; Mitchell et al., 2017). 

**CMOR-ized data for NorESM1-Happi and the other participating models can be retrieved from** http://portal.nersc.gov/c20c/data.html

**Raw model output for NorESM1-Happi can be retrived from the NIRD research data archive:**

   - https://doi.org/10.11582/2019.00006 (All-Hist)
   - https://doi.org/10.11582/2019.00002 (Plus15-Future)
   - https://doi.org/10.11582/2019.00003 (Plus20-Future)


Fully-coupled experiments
+++++++++++

Fully-coupled experiments targeting 
   - 1.5 degree warming (relative to pre-industrial conditions) and
   - 2.0 degree warming 
were conducted with NorESM1-Happi. See Graff et al. (2019) for details.

**The data (raw model output) can be retrieved from the NIRD research data archive:** https://doi.org/10.11582/2020.00021

Slab-ocean experiments
++++++++++

Slab-ocean experiments were conducted for 
   - a present-day climate that is as similar to that in the NorESM1-Happi All-Hist experiment as possible
   - a 1.5 degree warmer climate (relative to the pre-industrial) that is as similar to that in the NorESM1-Happi Plus15-Future experiment as possible
   - a 2.0 degree warmer climate (relative to the pre-industrial) that is as similar to that in the NorESM1-Happi Plus20-Future experimet as possible

**The data (raw model output) can be retrieved from the NIRD research data archive:** https://doi.org/10.11582/2020.00013



CMIP5 DECK and scenario experiments with NorESM1-Happi
^^^^^^^^^^^^^^^^^^^^^^^

A set of fully-coupled DECK experiments and scenario experiments were carried out with NorESM1-Happi (Graff et al., 2019) to enable an extensive validation of the model in line with the CMIP5 protocol (note that these experiments are not a part of the official CMIP5 data set):

   - a pre-industrial control simulation (the **piControl** experiment)
   - three historical members for the time period 1850-2005 (the **Hist1**, **Hist2**, and **Hist3** experiments)
   - Hist1 with external forcings as in 1850, but with with varying (historical)
   
      - greenhouse gases 
      - aerosols and aerosol precursor emissions 
      - natural solar radiation and vulcanos 
   - RCP scenario experiments in which the radiative forcing at the end of the 21st century corresponds to
   
      - 2.6 W/m\ :sup:`2`\  
      - 4.5 W/m\ :sup:`2`\  
      - 8.5 W/m\ :sup:`2`\  
   - experiments in forcings are as in the pre-industrial climate except the CO\ :sub:`2`\   concentrations which are
   
   - instantly quadroupled at the beginning of the experiment (the **abrupt-4xCO**\ :sub:`2`\ experiment)
   
      - increased by 1% per year untill quadroupling and then held constant (the **gradual-4xCO**\ :sub:`2`\   experiment)

**The data (raw model output) can be retrieved from the NIRD research data archive:** https://doi.org/10.11582/2020.00021

In addition, a set of slab-ocean experiments were conducted to assess the climate sensitivity of NorESM1-Happi under the slab-ocean configuration (for details, see Graff et al., 2019). These include
   - a pre-industrial (1850) control simulation  
   - a 2xCO\ :sub:`2`\  experiment 
   - a 4xCO\ :sub:`2`\  experiment
   
**Data from the slab-ocean experiments can be retrieved from the NIRD research data archive:** https://doi.org/10.11582/2020.00014


References
^^^^^^

Graff, L. S., Iversen, T., Bethke, I., Debernard, J. B., Seland, Ø., Bentsen, M., Kirkevåg, A., Li, C., and Olivié, D. J. L.: Arctic amplification under global warming of 1.5 and 2 ◦C in NorESM1-Happi, Earth System Dynamics, 10, 569–598, https://doi.org/10.5194/esd-10-569-2019, 2019.


Mitchell, D., AchutaRao, K., Allen, M., Bethke, I., Forster, P., Fuglestvedt, J., Gillett, N., Haustein, K., Iverson, T., Massey, N., Schleussner, C.-F., Scinocca, J., Seland, Ø., Shiogama, H., Shuckburgh, E., Sparrow, S., Stone, D., Wallom, D.,
Wehner, M., and Zaaboul, R.: Half a degree Additional warming, Projections, Prognosis and Impacts (HAPPI): Background
and Experimental Design, Geosci. Model Dev., 10, 571–583, https://doi.org/10.5194/gmd-10-571-2017, 2017.
