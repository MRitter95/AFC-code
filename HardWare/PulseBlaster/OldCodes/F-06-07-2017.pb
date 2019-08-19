// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve

// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= Local Oscillator (AOM4), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= Memory Probe Sweep (AOM1), 10= Memory Burn Sweep (AOM2), 11= Filter Probe Sweep (AOM5), 12= Filter Burn Sweep (AOM6)

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

// Burn trench and repump

Filter:0b1110 0000 0010 1000 0000 0001, 10 us, LOOP, 500
       0b1110 0000 0010 0000 0000 0000, 180 us
       0b1110 0000 0010 0000 0000 0001, 10 us
       0b1110 0000 0000 0000 0000 0001, 1 us
       0b1110 0000 0000 0000 0000 0001, 1 us, END_LOOP

       0b1110 0000 0000 0000 0000 0000, 100 ms

Sweep: 0b1110 0000 0001 0100 1000 0001, 100 ms 
       0b1110 0000 0000 0000 0000 0001, 10 us 
       0b1110 0000 0001 1000 0000 0001, 100 ms, LOOP, 1
       0b1110 0000 0000 0000 0000 0001, 10 ms, END_LOOP
       0b1110 0000 0001 1000 0000 0001, 100 ms
       0b1110 0000 0000 0000 0000 0001, 10 ms, branch, Filter