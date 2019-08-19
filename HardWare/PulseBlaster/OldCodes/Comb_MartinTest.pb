// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 400 MHz
//
// Bits: 0= Memory Probe (AOM1), 1= Memory Burn (AOM2), 2= Repump (AOM3), 3= Function Gen. Trigger, 
//       4= Write (AOM3), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Cryo Sync Flag, 17= Filter Sweep 1 (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Unused ,22= AOM4, 23= Unused.


Start: 0b0000 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0000 0000 0000 0000 0000 0000, 1 us, WAIT

Burn:  0b0000 0000 0000 0010 0000 0010, 1us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 199 us, END_LOOP

Oscope:0b0000 0000 0000 0000 1000 0000, 1us

Probe: 0b0000 0000 0000 0001 0000 0001, 1us
       0b0000 0000 0000 0000 0000 0001, 100 ms 

       0b0000 0000 0000 0000 0000 0000, 1us, branch, Start // All bits off for 500 ms, branch to label