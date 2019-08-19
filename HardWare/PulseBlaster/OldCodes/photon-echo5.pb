// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 500
$stopdelay = 70 ns
$ondelay = 4000us
$ta1 = 1us// Assign $var 10
$tb1 = 2us// Assign $var 10
$tb2 = 3us// Assign $var 10
$tb3 = 4us// Assign $var 10
$tb4 = 5us// Assign $var 10
$tb5 = 6us// Assign $var 10
$tb6 = 7us// Assign $var 10
$tb7 = 8us// Assign $var 10
$tb8 = 9us// Assign $var 10
$tb9 = 10us// Assign $var 10

label: 0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb1  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay 
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
       
       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb2  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
       
       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb3  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb4  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb6  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb7  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb8  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP

       0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb9  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
    
       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label