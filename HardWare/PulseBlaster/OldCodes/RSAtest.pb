// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 400 MHz
//
// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= SPAD GATE (AOM7), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH0 Trigger, 10= AD9959 B2CH1 Trigger, 11= AD9959 B3CH2 Trigger, 12= AD9959 B4CH3 Trigger,
//       13= Filter Burn1 (AOM5), 14= Filter Burn2 (AOM5), 15= FPGA Starts, 16= FPGA Counts,
//       17= Cryo Sync Flag, 18= Filter Sweep 1 (AOM5), 19= Filter Sweep 2 (AOM6), 20= AD9959 B3CH0 Trigger,
//       21= AD9959 B3CH1 Trigger, 22,23= Unused, 24= Disconnected.


       0b0000 0000 0000 1111 0000 0000, 500ms

label: 0b0000 0000 0000 0000 0100 1001, 1us // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 0100 1001, 10us
       0b0000 0000 0000 0000 0100 1000, 100us
       0b0000 0000 0000 0000 0000 0000, 5us, branch, label // All bits off for 500 ms, branch to label