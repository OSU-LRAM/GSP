# GSP
Geometric System Plotter:  A geometric mechanics GUI and visualizer.

To run this project:
Go to the ProgramFiles/v4.2 folder and run sysplotter.m to start the GUI. (4.1 is for Matlab 2012 and older). You can use the pull-down menus to select systems and shape changes, then use the checkboxes to choose which plots you want. There are three sets of checkboxes, so that you can save different sets of plots to go back and forth between them; in each set, the left column gives you plots in original coordinates, and the right box gives you plots in optimal coordinates.

To use the serpenoid-curve swimmer file, you'll need to have the LowRe_toolbox and curvature_mode_toolbox files in your matlab path.

You can add shchf (SHape CHange Function) files to in the UserFiles/v4/GenericUser/Shape_Changes directory. A good way to get started with them is to use an existing one, then click the "edit" button, change some things, and save the file under a new name that starts with shchf.