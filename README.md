# thesis-data-processing
 
## AnnAGNPS Data Summaries

AnnAGNPS outputs a daily time series. The scripts labeled 01-04 here import data that had previously been exported via Python to csv files after model simulation. The script then lay out a handful of functions for analyzing inundation dynamics of priarie potholes, including days inundated per year per scenario and maximum volumes per month/year/scenario. It also begins to compare these scenarios by common modeling factor levels like drainage, land use, or tillage. 

## AnnAGNPS Data Conversion

We calibrated AnnAGNPS to water volume, taking the simulated depth times the wetland surface area. This is the output value in files such as 'Bunny_Output_TEST_headers.csv.' However, we are also interesting in depths and more importantly, surface areas of flooding. The surface area of a wetland in AnnAGNPS is static and thus needs to be converted using stage-storage type relationships that were calculated by Alex Martin in his thesis (2018). The script '20_VolumetoAreaandDepth.Rmd' first solves the quadratic for depth between d-V and creates a depth time series for every simulated scenario. This was done in two parts, where d<0.1 is linear and >0.1 is quadratic. The depth time series was then plugged into the d-A relationship, a linear or quadratic relationship to create surface area time series (easier step than V -> d). 

## Figures

Scripts to generate figures for Ch. 3 (annagnps simulations) and Ch. 4 (random forest) of my thesis were aggregated from multiple prior R projects. Source data for each of the figures was saved to csv format to create standalone Rmd files. Some of these figure scripts rely on data generated from prior steps (see above headings), so there may be ways to back out the data and redo certain portions of it if objectives for figures change, etc. 
