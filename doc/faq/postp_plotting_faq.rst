.. postp_plotting_faq.rst:

Post-processing and plotting FAQ
================


How do I compute a weighted average?
---------------------

**Using NCL**

- Examples on how to compute and plot weighted averages: https://www.ncl.ucar.edu/Applications/ave.shtml

- See also the examples at the bottom of the documentation for the ncl function wgt_areaavg (which computes the weighted average): https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_areaave.shtml

**Using python**

The monthly files in NorESM2 (not BLOM files) are written *after* the last time step of the month. Consequently, the date in the netcdf file is the first of the following month. E.g. The date in FILENAME.cam.h0.0001-01.nc will be 01-02-0001 (the first of *February* and not January). This needs to be taken into account when calculating annual averages. 

When calculating annual averages from NorESM2 data it is important use appropriate monthly weights, especially for individual radiative fluxes (can have errors of the order of 0.5-1 W/m^2 if not used). 


**xarray**

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
 -
 
**iris**
It is also possible to use iris for analysing and visualising NorESM2 data
Documentation: https://scitools.org.uk/iris/docs/latest/

::

  def get_cube_varname(cube_list, var_name):
      if type(var_name) is list:
          var_cube = iris.cube.CubeList()
          for name in var_name:
                  print(name)
                  for cube in cube_list:
                      if cube.var_name == name:
                          var_cube.append(cube)
          return sum(var_cube)
      else:
          for cube in cube_list:
              if cube.var_name == var_name:
                  return cube

  def subtract_second_timedim(cube):
      time = cube.coord("time")
      new_points = time.points - 1/86400
      new_time = DimCoord(new_points, standard_name="time", 
                          units=time.units)
      cube.remove_coord("time")
      cube.add_dim_coord(new_time, 0)
      return cube
    
  def annual_weighted_avg(path,file, varname):
      cube = iris.load(path + file)
      ts = get_cube_varname(cube, varname)
      cube = subtract_second_timedim(ts)
      lons = cube.coord("longitude")
      lats = cube.coord("latitude")
      lons.guess_bounds()
      lats.guess_bounds()
      weights = iris.analysis.cartography.area_weights(cube)
      cube_collapsed =cube.collapsed(coords=["latitude", "longitude"], 
                                     aggregator=iris.analysis.MEAN, 
                                     weights=weights)
      monthw=[31,28,31,30,31,30,31,31,30,31,30,31]
      monthw = np.tile(monthw, 30)
      monthw=monthw/np.sum(monthw)
      cube_aa = cube_collapsed.collapsed('time', aggregator= iris.analysis.MEAN,weights=monthw)
      return cube_aa

::
