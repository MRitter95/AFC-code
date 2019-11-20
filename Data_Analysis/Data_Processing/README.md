# Scripts in folder
- colormappingAFC:
This function generates a colormap plot of the echoes. The intensity/
brightness on the colormap indicates the relative efficiency of storage at
that frequency. The code expects a configuration file containing the peak
finding parameters (prominence and min distance) and the experimental
parameters (start and stop frequency, sweeprate etc.). If no path is
specified, the code will use the current directory to find all the files
(currently the config file is one folder up)

    - function parameters
        - Input: config, file containing peakfinding and sweep parameters
        - Input: userpath, path to .bin files
        - Input: savefigs, boolean for user to speficy whether figures should be saved
        - Input: plotprobes, boolean controlling if the probes are plotted on the combs
        - Output: none, saves figure in pdf/ .fig format if savefigs is true 

- colormappingEcho:
This function generates a colormap plot of the echoes. The intensity/
brightness on the colormap indicates the relative efficiency of storage at
that frequency. The code expects a configuration file containing the peak
finding parameters (prominence and min distance) and the experimental
parameters (start and stop frequency, sweeprate etc.). If no path is
specified, the code will use the current directory to find all the files
(currently the config file is one folder up)

    - function parameters
        - Input: config, file containing peakfinding parameters
        - Input: userpath, path to .bin files
        - Input: savefigs, boolean determining if figures are saved
        - Output: none, saves figures in pdf/ .fig format if savefigs is true
