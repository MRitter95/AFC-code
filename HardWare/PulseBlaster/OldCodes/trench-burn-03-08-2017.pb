// Simplified Hole Burning Sequence
// Bits: 1= AOM1 Switch, 2= AOM2 Switch, 3= AOM3 Switch, 4= AOM4 Switch, 
//       5= Oscilloscope Trigger, 6= Unused, 7= Unused, 8= Unused,
//       9= AD9959 CH1 Trigger, 10= AD9959 CH2 Trigger, 11= AD9959 CH3 Trigger, 12= AD9959 CH4 Trigger

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

Step1: 0b0000 0000 0000 0100 0000 0100, 1 us, LOOP, 50
       0b0000 0000 0000 0000 0000 0100, 199 us
       0b0000 0000 0000 0000 0000 0000, 1 us
       0b0000 0000 0000 0000 0000 0000, 7 us
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

Probe: 0b0000 0000 0000 0001 0001 0001, 100 ms, LOOP, 1 
       0b0000 0000 0000 0000 0000 0000, 10 us, END_LOOP 
       0b0000 0000 0000 0000 0000 0000, 1 ms, branch, Step1