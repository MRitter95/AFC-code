// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 400 MHz
//
// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= SPAD GATE (AOM7), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH0 Trigger, 10= AD9959 B1CH1 Trigger, 11= AD9959 B3CH2 Trigger, 12= AD9959 B4CH3 Trigger,
//       13= Filter Burn1 (AOM5), 14= Filter Burn2 (AOM6), 15= FPGA Starts, 16= FPGA Counts,
//       17= Cryo Sync Flag, 18= Filter Sweep 1 (AOM5), 19= Filter Sweep 2 (AOM6), 20= AD9959 B3CH0 Trigger,
//       21= AD9959 B3CH1 Trigger, 22=Unused ,23= Gate, 24= Disconnected.


Start: 0b0000 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0000 0000 0000 0000 0000 0000, 1 us, WAIT

Burn:  0b0000 0000 0000 0010 0000 0010, 1us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 199 us, END_LOOP

Repump:0b0000 0000 0000 0000 0000 0100, 1ms

Oscope:0b0000 0000 0000 0000 1000 0000, 1us

Probe: 0b0000 0000 0000 0001 0000 0001, 1us
       0b0000 0000 0000 0000 0000 0001, 100 ms 

       0b0000 0000 0000 0000 0000 0000, 1us, branch, Start // All bits off for 500 ms, branch to label