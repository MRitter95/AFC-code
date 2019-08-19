// Simplified Hole Burning Sequence and Write-Herald-Read-Retrieve

// Bits: 0= Memory Probe (AOM1), 1= Memory Burn (AOM2), 2= Repump (AOM3), 3= Function Gen. Trigger, 
//       4= Write (AOM3), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Cryo Sync Flag, 17= Filter Sweep 1 (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Unused ,22= AOM4, 23= Unused.

       0b0000 0000 0000 1111 0000 0000, 100 ms // Load AD Board

// Burn trench and repump

Start: 0b0000 0000 0000 0000 0000 0000, 1 ms //Reset FPGA

Cryo:  0b0000 0000 0000 0000 0000 0000, 1 us, WAIT

Step1: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 199 us
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP
       0b0000 0000 0000 0000 0000 0000, 1 us

Step2: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 159.5 us 
       0b0000 0000 0000 0000 0000 0000, 5 us
       0b0000 0000 0000 0000 0000 0010, 34.5 us
       0b0000 0000 0000 0000 0000 0000, 1 us
       0b0000 0000 0000 0000 0000 0100, 10 us //Repump
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

Step3: 0b0000 0000 0000 0010 0000 0010, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0010, 151.5 us 
       0b0000 0000 0000 0000 0000 0000, 21 us
       0b0000 0000 0000 0000 0000 0010, 26.5 us
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

       0b0000 0000 0000 0000 0000 0000, 10 ms 
Sweep: 0b0100 0000 0000 0001 1000 0001, 1 us 
       0b0100 0000 0000 0000 0000 0001, 100 ms
       0b0000 0000 0000 0000 0000 0000, 100 ms, branch, Start