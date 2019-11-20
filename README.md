# AFC-code
Codebase for quantum memory experiment at the University of Maryland

Code is organized as follows:
- Data Analysis: contains matlab and python scripts used to process collected data
    - Data Processing: Contains the main analysis codes and the preAnalysis routines used to turn raw data into averaged data
    - Diagnostics: Set of routines to compare consecutive traces for echo and AFC data
    - UserScripts: Unmaintained list of old scripts
    - UserTools: Contains helper functions, plotting tools, file reading tools that are called in the various data processing scripts. Can also typically be called from the command line
- Hardware: 
    - LabView: contains all VIs, organized by instrument
    - PulseBlaster: contains the pulseblaster files used to run experiments
    - Magnetometer: contains MLX9309 control code (arduino+python script)
- Misc: 
    - Gaussian\_Beam\_Propagation: unmaintained list of VIs written to do gaussian beam propagation
    - Migdall\_VIs: unmaintained list of VIs written by Alan to perform various tasks
    - DataFileCreator\_MR.vi: VI used to automatically generate names for files with date time information
- Modeling: Hodgepodge of various simulation codes, needs some cleaning up

