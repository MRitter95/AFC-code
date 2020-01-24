// Burn comb and probe with two AOMS (low frequency sweep followed by high frequency sweep).
// Comb is split up to match up with quieter cycles of cryo

// Bits: 0= Memory Pulse (AOM1), 1= Memory Burn (AOM2), 2= High Probe (AOM3a), 3= Low Probe (AOM4), 
//       4= Tone (AOM3b), 5= Read (AOM2), 6= Function Gen. Trigger, 7= Oscilloscope Trigger, 
//       8= AD9959 B1CH0 Trigger, 9= AD9959 B1CH1 Trigger, 10= AD9959 B1CH2 Trigger, 11= AD9959 B1CH3 Trigger,
//       12= Filter Burn1 (AOM5), 13= Filter Burn2 (AOM6), 14= FPGA Starts, 15= FPGA Counts,
//       16= Shutter, 17= Local Osc. shifter (AOM5), 18= Filter Sweep 2 (AOM6), 19= AD9959 B3CH0 Trigger,
//       20= AD9959 B3CH1 Trigger, 21=Optical monitor ,22= RF monitor, 23= Unused.

       0b0100 0000 0000 1111 0000 1000, 100 ms 

Start: 0b0100 0000 0000 0000 0000 0000, 1 ms 

Cryo:  0b0100 0000 0000 0000 0000 0010, 1 us, WAIT

Burn1: 0b0100 0000 0000 0000 0000 0010, 300 ms

Sweep: 0b0100 0001 0000 0000 0000 0000, 20 ms        
       0b0100 0001 0000 0000 1100 0000, 100 ns       
//     0b0100 0001 0000 0000 0001 0000, 10 us //Calibration tones
       0b0100 0001 0000 0000 0000 1000, 10 us //AOM 4 Calibration tones
       0b0100 0001 0000 0000 0000 0000, 20 us
//     0b0100 0001 0000 0000 0001 0000, 10 us //Marks start of probe 1
       0b0100 0001 0000 0000 0000 1000, 10 us //AOM 4 Calibration tones
       0b0100 0001 0000 0000 0000 0000, 200 us
       0b0100 0001 0000 1111 0000 0000, 100 ns
       0b0100 0001 0000 0000 0000 0100, 4 ms
       0b0100 0001 0000 0000 0000 0000, 200 us
//     0b0100 0001 0000 0000 0001 0000, 10 us //Marks end of probe 1
       0b0100 0001 0000 0000 0000 1000, 10 us //AOM 4 Calibration tones
       0b0100 0001 0000 0000 0000 0000, 20 us
//     0b0100 0001 0000 0000 0001 0000, 10 us //Calibration tones
       0b0100 0001 0000 0000 0000 1000, 10 us //AOM 4 Calibration tones
       
       0b0100 0001 0000 0000 0000 0000, 40 ms, branch, Start