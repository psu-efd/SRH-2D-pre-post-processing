# SRH2D-pre-post-processing
Pre- and post-processing for SRH-2D using open source tools
============================================================

by Xiaofeng Liu, Ph.D., P.E., 

Assistant Professor

Department of Civil and Environmental Engineering

Penn State University

What is this repository about?
------------------------------------------------------------
Here are the lecture notes and cases I use for a training course on the SRH-2D model. The aim is to use open source tools to do the pre- and post-processing work for SRH-2D. This is a (free) alternative to other commercial pre/post processing tools for SRH-2D.

SRH-2D, Sedimentation and River Hydraulics – Two-Dimensional model, is a two-dimensional (2D) hydraulics and sediment transport model developed Dr. Yong Lai at the Bureau of Reclamation. You can find more information about SRH-2D at its website: [http://www.usbr.gov/pmts/sediment/model/srh2d/] (http://www.usbr.gov/pmts/sediment/model/srh2d/)

What open source tools used?
-----------------------------------------------------------
0. Preprocessing: Gmsh and scripts written Python and Fortran
1. Postprocessing: Paraview

General pre-processing steps:
-----------------------------------------------------------
0. Use Gmsh to generate the mesh. You should prepare the boundary of the domain. Unfortunately, Gmsh don't have GIS capabillity so georeferencing is not possible. Export the mesh in gmsh format. Note that the mesh is flat, i.e., there is no elevation information for the grid points.
1. Run the DEMInterpolate program to interpolate the DEM data onto the gmsh grid points. This will result in a new gmsh file.
2. Use the new gmsh file and the IPython script to convert the gmsh file to SMS 2DM format. The Python script is only a translator. 
3. Run SRH-2D.

It is noted that these pre-processing steps are sometime tricky.

General post-processing steps:
------------------------------------------------------------
0. Paraview can load the SRH-2D results (in Tecplot) format directly. So almost zero learning curve.

Who should be interested?
-----------------------------------------------------------
0. Whoever is interested to test out SRH-2D but don't have license for commercial software. 
1. Developers who wants to add more functionalities and have more freedom.


