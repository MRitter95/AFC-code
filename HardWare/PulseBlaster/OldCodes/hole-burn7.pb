// Frequency sweep test Bits 1= Sweep, 2=AOM gate, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig

Sweep: 0b0000 0000 0000 0100 0010 0100, 300 us, LOOP, 10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 10 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 1011, 100 ms // Sweep bit = #1 (pulse to RF switch) bit#4= Oscilloscope trig, bit#5 Spect Anal
       0b0000 0000 0000 0000 0000 0000, 10 us // All bits off for 10 ms, branch to label
       0b0000 0000 0000 0001 0001 0011, 100 ms, LOOP, 18// Sweep bit = #1 (pulse to RF switch) bit#4= Oscilloscope trig, bit#5 Spect Anal
       0b0000 0000 0000 0000 0000 0000, 10 us, END_LOOP // All bits off for 10 ms, branch to label
       0b0000 0000 0000 0001 0001 0011, 100 ms // Sweep bit = #1 (pulse to RF switch) bit#4= Oscilloscope trig, bit#5 Spect Anal
       0b0000 0000 0000 0000 0000 0000, 10 us, branch, Sweep // All bits off for 10 ms, branch to label