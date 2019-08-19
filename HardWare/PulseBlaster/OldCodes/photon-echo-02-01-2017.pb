// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 200
$ta1 = 1us// Assign $var 10
$tb1 = 2us// Assign $var 10
$ta2 = 2us// Assign $var 10
$tb2 = 4us// Assign $var 10
$ta3 = 6us// Assign $var 10
$tb3 = 12us// Assign $var 10
$ta4 = 8us// Assign $var 10
$tb4 = 16us// Assign $var 10
$ta5 = 10us// Assign $var 10
$tb5 = 20us// Assign $var 10
$ta6 = 12us// Assign $var 10
$tb6 = 24us// Assign $var 10
$ta7 = 14us// Assign $var 10
$tb7 = 28us// Assign $var 10
$ta8 = 16us// Assign $var 10
$tb8 = 32us// Assign $var 10
$ta9 = 18us// Assign $var 10
$tb9 = 36us// Assign $var 10
$ta10 = 20us// Assign $var 10
$tb10 = 40us// Assign $var 10
$ta11 = 30us// Assign $var 10
$tb11 = 60us// Assign $var 10
$ta12 = 32us// Assign $var 10
$tb12 = 64us// Assign $var 10
$ta13 = 34us// Assign $var 10
$tb13 = 68us// Assign $var 10
$ta14 = 36us// Assign $var 10
$tb14 = 72us// Assign $var 10
$ta15 = 38us// Assign $var 10
$tb15 = 76us// Assign $var 10
$ta16 = 40us// Assign $var 10
$tb16 = 80us// Assign $var 10
$tdelay = 40us
$stopdelay = 10us
$ondelay = 4000us
$stopdelay2 = 0.9s

label: 0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2

       0b0000 0000 0000 0001 0000 1000, 1 ms
       0b0000 0000 0000 0001 0000 0000, 1 ms
       0b0000 0000 0000 0001 0010 0001, $ta10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $tdelay  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0010 0001, $tb10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0001 0000 0000, $stopdelay// All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0001 0001 0010, $ondelay
       0b0000 0000 0000 0001 0000 0000, $stopdelay2


       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label