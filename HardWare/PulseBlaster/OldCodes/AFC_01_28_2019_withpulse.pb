// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve

// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= SPAD GATE (AOM7), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH0 Trigger, 10= AD9959 B2CH1 Trigger, 11= AD9959 B3CH2 Trigger, 12= AD9959 B4CH3 Trigger,
//       13= Filter Burn1 (AOM5), 14= Filter Burn2 (AOM5), 15= FPGA Starts, 16= FPGA Counts,
//       17= Cryo Sync Flag, 18= Filter Sweep 1 (AOM5), 19= Filter Sweep 2 (AOM6), 20= AD9959 B3CH0 Trigger,
//       21= AD9959 B3CH1 Trigger, 22=unused,23= Gate, 24= Disconnected.

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

Sweep: 0b0000 0000 0000 0000 1100 0000, 100 ns 
      // 0b0000 0000 0000 0000 0100 0000, 100 ns 
     //  0b0000 0000 0000 0000 0000 0000, 10 us 
    //   0b0000 0000 0000 0000 0000 0000, 2 us
       0b0000 0000 0000 0000 0000 0001, 10 us
       0b0000 0000 0000 0000 0000 0000, 100 ms, branch, Start