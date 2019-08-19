#The files in this folder are used to perform some initial processing of RSA and LeCroy traces:

##combineFiles.m: 
###input arguments: path 		
###outputs: averaged traces for RSA and LeCroy

This routine will go to a folder specified by the user and perform averaging on 
all the traces in the subfolders that it finds there. Each subfolder will generate 
four traces: rfc (Radio Frequency Comb), ofc (Optical Frequency Comb), afc (Atomic
Frequency Comb), and probe (probe amplitude trace). These traces are saved in a .bin 
format to save space. The RSA files are a simple array with frequency and amplitudes
being the two saved rows. The LeCroy files (afc and probe) have two parts: the first
four entries are the conversion factors from the oscilloscope (time interval, offset,
vertical gain, and vertical offset) followed by a 1D array of int16 values 
representing the ADC values from the LeCroy. The readbin routine properly scales the
y axis again and generates a time axis from the conversion factors

##readbin.m:
###input arguments: file to read, 'true/false' string to choose between LeCroy and RSA files
###output: wave data structure with x, y fields holding the x,y data

This routine reads the binary file specified by the user and loads the data in a wave 
structure. For LeCroy files, the routine also generates a time array and conversion the
y data back to voltages
 
##doAVG.m:
###input argument: list of files generated from matlab dir command
###output: x,y arrays as well as conversion factors for LeCroy

Helper routine that actually performs the averaging. Will go through a list of files 
specified by the user and calculate the cumulative sum of the y values. Computes the
average by simply divinding the final result by the number of files. For LeCroy files
the routine also gets the conversion factors from the .trc files. The RSA files, this
routine creates a frequency axis to be saved with the amplitudes.

##ReadLeCroyBinaryWaveformExtra.m:
###input argument: .trc file to be read
###output: wave structure (x,y data) and conversion factors for amplitude and time scaling

Just like regular ReadLeCroyBinaryWaveform function that reads in a .trc file and 
produces a wavestructure with x,y data properly scaled. This method has been modified 
to also return the conversion factors to allow us to store the ADC values instead of 
voltage values (int16 vs float data size) and skip storing a time array since we can 
regenerate it from these conversion factors.

##FindTones2.m:
###input arguments: wave structure from readbin or ReadLeCroyBinary waveform and boolean 
for plotting option
###output: array of falling edges in calibration tone

Locates calibration tones. It might be possible to adapt this to finding comb teeth,
if it works better than what you do now.

Basically it just checks that the signal consistently exceeds some threshold for the right amount
of time (not too little, not too much). If it passes that test, it further checks that the signal
in the candidate peak is higher than the signal to the left and right of it.
