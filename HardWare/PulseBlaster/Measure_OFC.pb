// Bits: 0= Memory Pulse (AOM1), 1= Memory Burn (AOM2), 2= High Probe (AOM3a), 3= Low Probe (AOM4), 
//       4= Tone (AOM3b), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Cryo Sync Flag, 17= Local Osc. shifter (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Optical monitor ,22= RF monitor, 23= Unused.

Start: 0b0010 0000 0000 0000 0000 0010, 1 ms
       0b0010 0000 0000 0000 1000 0010, 100 ns
       0b0010 0000 0000 0000 0000 0010, 10 s, branch, Start