// Burn comb and send pulse from function generator

// Bits: 0= Memory Pulse (AOM1), 1= Memory Burn (AOM2), 2= High Probe (AOM3a), 3= Low Probe (AOM4), 
//       4= Tone (AOM3b), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Cryo Sync Flag, 17= Local Osc. shifter (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Optical monitor ,22= RF monitor, 23= Unused.


       0b0000 0000 0000 1111 0000 1000, 100 ms 


Start: 0b0000 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0000 0000 0000 0000 0000 0000, 1 us, WAIT

Delay :0b0000 0000 0000 0000 0000 0000, 1 us, LOOP, 500
       0b0000 0000 0000 0000 0000 0000, 199 us 
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP

       0b0000 0000 0000 0000 0000 0000, 1 us
      
Comb:  0b0000 0000 0000 0000 0000 0010, 750 ms //Burn
       
       0b0000 0000 0000 0000 0000 0000, 10 ms

Pulse: 0b0000 0000 0000 0000 1100 0000, 100 ns 
       0b0000 0000 0000 0000 0000 0001, 1 us //Echo pulse
       0b0000 0000 0000 0000 0000 0000, 100 ms, branch, Start