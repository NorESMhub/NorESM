.. _tech_faq:

Technical FAQ
=============

Different sea-ice and ocean grid
''''

**Q:** The sea ice output variables in NorESM2 are on a 360x384 grid, while the ocean output varibales are on a 360x385 grid. Which variable shall I use if I want to e.g. calculate an the area sum of the sea ice  (e.g., sea ice volume in the Northern Hemisphere)?

**A:**
The ocean/sea-ice grid of NorESM2 is a tripolar grid with 360 and 384 unique grid cells in i- and j-direction, respectively. Due to the way variables are staggered in the ocean model, an additional j-row is required explaining the 385 grid cells in the j-direction for the ocean grid. The row with j=385 is a duplicate of the row with j=384, but with reverse i-index.

The ocean and sea-ice components of NorESM defines the grid cell area differently. In the ocean component, the grid cell area is found by computing the area of a spherical polygon with grid cell corners as vertices. The sea-ice component computes area as dx*dy where dx and dy are grid cell sizes in i- and j-direction, respectively. In order to achieve good conservation in flux exchanges, we ensure that the ocean and sea-ice components have identical grid cell areas. To obtain this with the different approaches of computing grid cell area, we nudge the sea-ice grid locations slightly.

In conclusion, it is consistent to use the area variable defined on the ocean grid in relation to sea-ice variables, but you have to ignore the final j-row of areacello. So to conclude, just drop the last row with j=385 of areacello when dealing with the sea ice variables.
