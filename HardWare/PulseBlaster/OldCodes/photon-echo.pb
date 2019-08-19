// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig

label: 0b0000 0000 0000 0000 0000 1001, 100 us // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, 200 us // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label  // All bits off for 5 ms, Continue to next instruction