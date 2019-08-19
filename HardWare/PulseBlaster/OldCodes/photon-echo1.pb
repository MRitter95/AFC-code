// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 200
$ta1 = 10us// Assign $var 10
$tb1 = 20us// Assign $var 10
$ta2 = 12us// Assign $var 10
$tb2 = 24us// Assign $var 10
$ta3 = 14us// Assign $var 10
$tb3 = 28us// Assign $var 10
$ta4 = 16us// Assign $var 10
$tb4 = 32us// Assign $var 10
$ta5 = 18us// Assign $var 10
$tb5 = 36us// Assign $var 10
$ta6 = 20us// Assign $var 10
$tb6 = 40us// Assign $var 10
$ta7 = 22us// Assign $var 10
$tb7 = 44us// Assign $var 10
$ta8 = 24us// Assign $var 10
$tb8 = 48us// Assign $var 10
$ta9 = 26us// Assign $var 10
$tb9 = 52us// Assign $var 10
$ta10 = 28us// Assign $var 10
$tb10 = 56us// Assign $var 10
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


label: 0b0000 0000 0000 0000 0000 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb1  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta2, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb2  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta3, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb3  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta4, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb4  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta5, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta6, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb6  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta7, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb7  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta8, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb8  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta9, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb9  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta10, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb10  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta11, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb11  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb11 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta12, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb12  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb12 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta13, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb13  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb13 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta14, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb14  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb14 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta15, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb15  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb15 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1001, $ta16, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb16  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, $tb16 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 4000 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label