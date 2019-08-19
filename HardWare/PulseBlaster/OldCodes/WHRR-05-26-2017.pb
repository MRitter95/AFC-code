// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve
//
// Set clock frequency = 400 MHz
//
// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= Local Oscillator (AOM4), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH1 Trigger, 10= AD9959 B2CH2 Trigger, 11= AD9959 B3CH3 Trigger, 12= AD9959 B4CH4 Trigger,
//       13= Filter Probe, 14= Filter Burn, 15-21= Unused, 22-24= must be kept '1'.

       0b1110 0000 0000 0000 0000 0000, 100 ms // Load AD Board

// Burn trench and repump




Sweep: 0b1110 0000 0000 0000 0000 0001, 100 ms 
       0b1110 0000 0000 0000 0000 0000, 100 ms, branch, Sweep
 