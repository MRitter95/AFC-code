// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 400 MHz
//
// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= Local Oscillator (AOM4), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH1 Trigger, 10= AD9959 B2CH2 Trigger, 11= AD9959 B3CH3 Trigger, 12= AD9959 B4CH4 Trigger,
//       13= Filter Probe, 14= Filter Burn, 15-21= Unused, 22-24= must be kept '1'.

//     0b1110 0000 0000 1111 0000 0000, 500ms
       

       0b1110 0000 0000 1111 0000 0000, 500ns, LOOP, 500000 // All bits on for 500 ms, Continue to next instruction
       0b1110 0000 0000 1111 0000 0000, 500ns, END_LOOP // All bits on for 500 ms, Continue to next instruction

label: 0b1111 1111 1111 1111 1111 1111, 500ns, LOOP, 10000 // All bits on for 500 ms, Continue to next instruction
       0b1111 1111 1111 1111 1111 1111, 500ns, END_LOOP // All bits on for 500 ms, Continue to next instruction

       0b1110 0000 0000 0000 0000 0000, 500ns, LOOP, 20000 // All bits on for 500 ms, Continue to next instruction
       0b1110 0000 0000 0000 0000 0000, 500ns, END_LOOP // All bits on for 500 ms, Continue to next instruction
       0b1110 0000 0000 0000 0000 0000, 1us, branch, label // All bits off for 500 ms, branch to label