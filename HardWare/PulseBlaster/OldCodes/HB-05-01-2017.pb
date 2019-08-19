// Simplified Hole Burning Sequence
// Bits: 1= AOM1 Switch, 2= AOM2 Switch, 3= AOM3 Switch, 4= AOM4 Switch, 
//       5= Oscilloscope Trigger, 6= Unused, 7= Unused, 8= Unused,
//       9= AD9959 CH1 Trigger, 10= AD9959 CH2 Trigger, 11= AD9959 CH3 Trigger, 12= AD9959 CH4 Trigger

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

// Burn with Read
Step1: 0b0000 0000 0000 0000 0000 0100, 100 us
       
// Burn with Write
Step2: 0b0000 0000 0000 0000 0000 1000, 100 us
       
Sweep: 0b0000 0000 0000 0001 0001 0001, 100 ms 
       0b0000 0000 0000 0000 0000 0000, 10 us 
       0b0000 0000 0000 0000 0000 0000, 100 ms, LOOP, 1
       0b0000 0000 0000 0000 0000 0000, 10 ms, END_LOOP
       0b0000 0000 0000 0000 0000 0000, 100 ms
       0b0000 0000 0000 0000 0000 0000, 10 ms, branch, Step1