.. postp_plotting_faq.rst:

Post-processing and plotting FAQ
================


How do I compute a weighted average?
---------------------

**Using NCL**

- Examples on how to compute and plot weighted averages: https://www.ncl.ucar.edu/Applications/ave.shtml

- See also the examples at the bottom of the documentation for the ncl function wgt_areaavg (which computes the weighted average): https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_areaave.shtml


How do I compute annual averages?
---------------------

**Using python**


When calculating annual averages from NorESM2 data it is important use appropriate monthly weights, especially for individual radiative fluxes (can have errors of the order of 0.5-1 W/m^2 if not used). A python code example: 

::

  def annual_mean_to_file(var,fname,weights=np.array([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])/365):
      '''
      Calculate annual means from monthly means assuming no-leap calendar
      '''
      month_weights = xr.DataArray(np.tile(weights,len(var.time)//12),coords=[var.time], name='month_weights')
      annual_mean = (month_weights*var).groupby('time.year').sum('time')
      annual_mean = annual_mean.rename({'year':'time'})
      annual_mean = annual_mean.where(annual_mean!=0)
      annual_mean.rename(var.name).to_dataset().to_netcdf(fname)

::
