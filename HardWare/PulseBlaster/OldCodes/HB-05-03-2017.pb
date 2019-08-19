// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve
// Bits: 1= Probe (AOM1), 2= Local Oscillator (AOM2), 3= Burn (AOM3), 4= Repump (AOM4), 
//       5= Oscilloscope Trigger, 6= Write (AOM4), 7= Read (AOM3), 8= Spectrum Analyzer Trigger,
//       9= AD9959 CH1 Trigger, 10= AD9959 CH2 Trigger, 11= AD9959 CH3 Trigger, 12= AD9959 CH4 Trigger

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

// Burn trench and repump


Step1: 0b0000 0000 0000 0100 0000 0110, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0110, 199 us
       0b0000 0000 0000 0000 0000 0010, 1 us
       0b0000 0000 0000 0000 0000 1010, 15 us  // Repump
       0b0000 0000 0000 0000 0000 0010, 1 us, END_LOOP

Sweep: 0b0000 0000 0000 0001 0001 0011, 100 ms 
       0b0000 0000 0000 0000 0000 0010, 10 us 
       0b0000 0000 0000 0000 0000 0010, 100 ms, LOOP, 1
       0b0000 0000 0000 0000 0000 0010, 10 ms, END_LOOP
       0b0000 0000 0000 0000 0000 0010, 100 ms
       0b0000 0000 0000 0000 0000 0010, 10 ms, branch, Step1