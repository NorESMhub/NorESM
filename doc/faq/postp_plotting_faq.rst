.. postp_plotting_faq.rst:

Post-processing and plotting FAQ
================

Very large ocean cell thickness in NorESM2
-----
The ocean layer thickness **dz** variable may not be very meaningful for NorESM. The ocean model component BLOM is an isopycnic-coordinated model and hence the model layer thickness is changing from each integration step. Therefore, it is possible that the layer thickness will exceed 3km to 4km under certain circumstances. For example, this occurs sometimes in polar waters under deep convection where the ocean column is not stratified. And also at some coastal regions (where the water may not be well-represented by 'isopycnic' movement). So in short, **dz** reflects how the model represents the water masses (faithfully or not). 

Weights and area information for the ocean component BLOM 
--------
The area and mask information for BLOM output can be found in the grid file usually stored together with the input data used by BLOM. Please see http://ns9560k.web.sigma2.no/inputdata/ocn/blom/grid/ for the grid files used. 

Weights for ocean calculations:

::

  gridpath = 'path_to_gridfile' # path to grid files
  grid = xr.open_mfdataset(gridpath + 'grid_tnx1v4_20170622.nc')
  parea =  grid.parea
  pmask =  grid.pmask
  pweight = parea*pmask
  
::


The vertical coordinate in BLOM
---------------------------
**Q:**
The vertical coordinate of NorESM2 is provided as the isopycnal coordinate (kg/m^3). I want to change this isopycnal coordinate to z coordinate (m).

**A:**
Vertically pre-interpolated output to z-level (including temperature, salinity and the overturning mass stream-functions) should be available for all NorESM2 experiments. For raw model output these variables often end with *lvl* . E.g.

- Temperature: templvl(time, depth, y, x)
- Salinity: salnlvl(time, depth, y, x)
- Velocity x-component: uvellvl(time, depth, y, x)
- Velocity y-component: vvellvl(time, depth, y, x)
- Overturning stream-function: mmflxd(time, region, depth, lat)

For CMORIZED data the pre-interpolated output to z-level uses a different grid identifier than *gn* (grid native). Please note that *gr* usually means regridded horizontally but in case of NorESM2 it is regridded vertically. E.g.

- Temperature: thetao(time, depth, y, x) on *gr* grid 
- Salinity: so(time, depth, y, x) on *gr* grid 
- Velocity x-component: uo(time, depth, y, x) on *gr* grid 
- Velocity y-component: vo(time, depth, y, x) on *gr* grid 
- Overturning stream-function: msftmz(time, region, depth, lat) on *grz* grid 

Different sea-ice and ocean grid
------------------------

**Q:** The sea ice output variables in NorESM2 are on a 360x384 grid, while the ocean output variables are on a 360x385 grid. Which variable shall I use if I want to e.g. calculate the area sum of the sea ice  (e.g., sea ice volume in the Northern Hemisphere)?

**A:**
The ocean/sea-ice grid of NorESM2 is a tripolar grid with 360 and 384 unique grid cells in i- and j-direction, respectively. Due to the way variables are staggered in the ocean model, an additional j-row is required explaining the 385 grid cells in the j-direction for the ocean grid. The row with j=385 is a duplicate of the row with j=384, but with reverse i-index.

The ocean and sea-ice components of NorESM define the grid cell area differently. In the ocean component, the grid cell area is found by computing the area of a spherical polygon with grid cell corners as vertices. The sea-ice component computes the area as dx*dy where dx and dy are grid cell sizes in i- and j-direction, respectively. In order to achieve good conservation in flux exchanges, we ensure that the ocean and sea-ice components have identical grid cell areas. To obtain this with the different approaches of computing grid cell area, we nudge the sea-ice grid locations slightly.

In conclusion, it is consistent to use the area variable defined on the ocean grid in relation to sea-ice variables, but you have to ignore the final j-row of e.g. area. So to conclude, just drop the last row with j=385 of area when dealing with the sea ice variables.


The surface variables in BLOM
---------------------------
**Q:** Are the surface variables diagnosed in BLOM identical to the values in the upper ("surface") layer (e.g. sst compared to temp @sigma =27.22 and templvl @depth = 0m)? 

**A:** Usually not. So if you think "surface is surface", please read below:

The surface mixed boundary layer in BLOM is divided into 2 model layers with thickness dz(1) and dz(2) for the upper and lower layer, respectively. Let h = dz(1) + dz(2) be the total thickness of the mixed layer, then dz(1) = min(10 m, h/2). Further, the minimum thickness of the mixed layer is 5 m. Thus, the upper model layer, dz(1), will have a thickness between 2.5 m to 10 m.  For a comparison of the output variables  **sst**, **temp**, **templvl** :

- **temp:**  the temperature weighted by the thickness of the layer. For the upper layer this will be: ::
         
         sum(temp(1)*dz(1))/sum(dz(1))
         
time averaged over the time interval used for the diagnostics.

- **templvl**:  the temperature weighted by a pre-defined depth interval for every time step and subsequently averaged over the time interval used for the diagnostics. For the upper (first) layer of templvl, the depth interval is 0 to 5 m.

- **sst**:  temperature in the upper (first) model layer for every time step in the diagnostics interval and subsequently averaged over the time interval used for the diagnostics.

Thus: 

- **temp** and **sst** will usually not be identical since *temp* is weighted by the layer thickness and *sst* is not. The only exception is if h is greater than 20m throughout the average time period used for the diagnostics, then a constant weighting will be applied (i.e.  dz(1) = 10 m).

- **templvl** and **sst** will usually not be identical since *templvl* is weighted by the layer depth interval and *sst* is not. The only exception is if dz(1) is greater then 5 m throughout the average time period used for the diagnostics. Usually, dz(1) is less than 5 m in some regions e.g. tropical upwellilng regions and hence templvl @depth=0 and sst will differ.

These results apply to other variables as well (e.g. salinity and velocities) and to all CMIP6 compsets. Please note, for the actual weighting calculations in BLOM pressure is used instead of layer thickness, but the explanation stays the same. 



How do I compute a weighted average?
---------------------

**Using NCL**

- Examples on how to compute and plot weighted averages: https://www.ncl.ucar.edu/Applications/ave.shtml

- See also the examples at the bottom of the documentation for the ncl function wgt_areaavg (which computes the weighted average): https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_areaave.shtml

**Using python**

When calculating annual averages from NorESM2 data it is important use appropriate monthly weights, especially for individual radiative fluxes (can have errors of the order of 0.5-1 W/m^2 if not used). 

The monthly files in NorESM2 (not BLOM/MICOM/iHAMOCC files) are written *after* the last time step of the month. Consequently, the date in the netcdf file is the first of the following month. E.g. The date in FILENAME.cam.h0.0001-01.nc will be 01-02-0001 (the first of *February* and not January). This needs to be taken into account when calculating annual averages using python packages like xarray and iris. One method is to use the time bounds (instead of time), another method is to correct the time stamps in the time array. 

**xarray**


For BLOM/MICOM/iHAMOCC files there are no issues with the time variable, and annual averages can be calculated:

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

One way to handle the time issue is to take annual averages by looping over 12 files at the time (slow method):

::

  def area_avg(ds, var, monthw = np.array([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])):
    '''
    Calculate global and annual means from monthly means
    '''
    field = ds[var].mean(dim = 'lon')
    return np.sum(monthw*[ np.nansum((field[i,:]*ds.gw[0]).values)/
                          np.nansum(ds.gw[0]) for i in range(0,len(ds[var].time))])/np.sum(monthw)
                          
::

Weights for ocean calculations:

::

  gridpath = 'ocngrid/tnx1v4/' # path to grid files
  grid = xr.open_mfdataset(gridpath + 'grid.nc')
  parea =  grid.parea
  pmask =  grid.pmask
  pweight = parea*pmask
  
::

-

**iris**

It is also possible to use iris for analysing and visualising NorESM2 data
Documentation: https://scitools.org.uk/iris/docs/latest/

::

  def get_cube_varname(cube_list, var_name):
      '''
      Subtract cube with name var_name from the cube_list
      '''
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
      '''
      Fix time issue by subtracting one second from the time array
      '''
      time = cube.coord("time")
      new_points = time.points - 1/86400
      new_time = DimCoord(new_points, standard_name="time", 
                          units=time.units)
      cube.remove_coord("time")
      cube.add_dim_coord(new_time, 0)
      return cube
    
  def annual_weighted_avg(path,file, varname):
      '''
      Calculate global and annual means from monthly means
      '''
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
      n=len(monthw)
      tmp = [cube_collapsed[i:i+n].collapsed('time', aggregator= iris.analysis.MEAN,weights=monthw) for i in range(0,n*yrs,n)]
      cubes_aa = iris.cube.CubeList(tmp).merge()
      return cubes_aa[0]
  

::
