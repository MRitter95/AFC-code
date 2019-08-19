// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve

// Bits: 1= Memory Probe (AOM1), 2= Memory Burn (AOM2), 3= Repump (AOM3), 4= SPAD GATE (AOM4), 
//       5= Write (AOM3), 6= Read (AOM2), 7= Spectrum Analyzer Trigger, 8= Oscilloscope Trigger, 
//       9= AD9959 B1CH1 Trigger, 10= AD9959 B2CH2 Trigger, 11= AD9959 B3CH3 Trigger, 12= AD9959 B4CH4 Trigger,
//       13= Filter Burn1 (AOM5), 14= Filter Burn2 (AOM6), 15-24= Unused.

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

// Burn trench and repump

Start: 0b0000 0000 0100 0000 0000 0000, 1 ms //Reset FPGA

Step1: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 199 us
       
   //  0b0000 0000 0001 0100 0000 0000, 1 us
   //  0b0000 0000 0001 0000 0000 0000, 199 us
       
       0b0000 0000 0000 0000 0000 0000, 1 us

       0b0000 0000 0000 0000 0000 0100, 10 us  // Repump
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

Step2: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 160.5 us 
       0b0000 0000 0000 0000 0000 0000, 13 us
       0b0000 0000 0000 0000 0000 0010, 31.5 us
       0b0000 0000 0000 0000 0000 0000, 1 us
       0b0000 0000 0000 0000 0000 0100, 10 us
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

Step3: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 160.5 us 
       0b0000 0000 0000 0000 0000 0000, 13 us
       0b0000 0000 0000 0000 0000 0010, 31.5 us

       0b0000 0000 0001 0000 0000 0000, 10 us
       0b0000 0000 0010 0000 0000 0000, 10 us
       
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

R&W:   0b0000 0000 0000 0000 0000 0000, 1 us // Delay
       0b0000 0000 0000 0000 0001 0000, 20 us // Turn WRITE ON
       0b0000 0000 0000 0000 0000 0000, 1 us // Delay
       0b0000 0000 0000 0000 0100 1000, 20 us// Herald
       0b0000 0000 0000 0000 0000 0000, 1 us // Delay
       0b0000 0000 0000 0000 0010 0000, 20 us // Turn READ ON
       0b0000 0000 0000 0000 0000 0000, 1 us // Delay
       0b0000 0000 0000 0000 0100 1000, 100 us // Retrieved 
       
       0b0000 0000 0000 0000 0000 0000, 10 ms 
Sweep: 0b0000 0000 0000 0001 1000 0001, 1 us 
       0b0000 0000 0000 0000 0000 0001, 100 ms
       0b0000 0000 0000 0000 0000 0000, 100 ms, branch, Start