// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve

// Bits: 0= Memory Pulse (AOM1), 1= Memory Burn (AOM2), 2= High Probe (AOM3a), 3= Low Probe (AOM4), 
//       4= Tone (AOM3b), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Cryo Sync Flag, 17= Filter Sweep 1 (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Unused ,22= Unused, 23= Unused.

       0b0000 0000 0000 1111 0000 1000, 100 ms 

// Burn trench and repump

Start: 0b0000 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0000 0000 0000 0000 0000 0000, 1 us, WAIT

Delay :0b0000 0000 0000 0000 0000 0000, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0000, 199 us 
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

       0b0000 0000 0000 0000 0100 0000, 1 us
      
Comb:  0b0000 0000 0000 0000 0000 0010, 750 ms
       
       0b0000 0000 0000 0000 0000 0000, 10 ms

Sweep: 0b0000 0000 0000 0000 1100 0000, 100 ns //Trigger o-scope
       0b0000 0000 0000 0000 0001 0000, 1 ms //Calibration tones
       

       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 0000 0001 0000, 1 ms //Marks start of comb 1
       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 1111 0000 0000, 100 ns
       0b0000 0000 0000 0000 0000 1000, 125 ms
       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 0000 0001 0000, 1 ms //Marks end of comb 1

       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 0000 0001 0000, 1 ms //Marks start of Comb 2
       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 1111 0000 0000, 100 ns
       0b0000 0000 0000 0000 0000 0100, 150 ms
       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 0000 0001 0000, 1 ms //Marks end of comb 2

       0b0000 0000 0000 0000 0000 0000, 2 ms
       0b0000 0000 0000 0000 0001 0000, 1 ms
       0b0000 0000 0000 0000 0000 0000, 80 ms, branch, Start