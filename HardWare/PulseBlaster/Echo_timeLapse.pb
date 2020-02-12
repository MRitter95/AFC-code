// Measure echo using pulse triggered by pulseblaster. Comb is broken up
// into multiple segments to minize effect of cryo
// Bits: 0= Memory Pulse (AOM1), 1= Memory Burn (AOM2), 2= High Probe (AOM3a), 3= Low Probe (AOM4), 
//       4= Tone (AOM3b), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Shutter, 17= Local Osc. shifter (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Optical monitor ,22= RF monitor, 23= Unused.

       0b0100 0000 0000 1111 0000 1000, 100 ms 

Start: 0b0100 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0100 0000 0000 0000 0000 0000, 1 us, WAIT

Delay: 0b0100 0000 0000 0000 0000 0000, 20 ms
      
Comb:  0b0100 0000 0000 0000 0000 0000, 220 ms //no burn
       0b0100 0000 0000 0000 0000 0000, 40 ms

Comb2: 0b0100 0000 0000 0000 0000 0000, 95 ms  //no burn

       0b0100 0000 0000 0000 0000 0000, 105 ms

       0b0100 0000 0000 0000 0000 0000, 105 ms //no burn

       0b0100 0001 0000 0000 0000 0000, 20 ms

Pulse: 0b0100 0001 0000 0000 1100 0000, 100 ns //Trigger o-scope 
       0b0100 0001 0000 0000 0000 0001, 30 us //Echo pulse
       0b0100 0001 0000 0000 0000 0000, 240 ms, branch, Start