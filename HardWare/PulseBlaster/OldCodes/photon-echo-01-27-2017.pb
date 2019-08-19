// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 500
$stopdelay = 14 us
$ondelay = 4000us
$ta1 = 2us
$tb1 = 20us
$ta2 = 4us

label: 0b0000 0000 0001 0000 0000 1000, 1 ms
       0b0000 0000 0001 0000 0000 0000, 1 ms
       0b0000 0000 0001 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0001 0000 0000 0000, $tb1 // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0001 0000 0010 0001, $ta2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0001 0000 0000 0000, $stopdelay 
       0b0000 0000 0001 0000 0001 0010, $ondelay // Gate on
       0b0000 0000 0001 0000 0000 0000, $stopdelay
       0b0000 0000 0001 0000 0000 0100, 1 s
       0b0000 0000 0001 0000 0000 0000, 500 us, branch, label