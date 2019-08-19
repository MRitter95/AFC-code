// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 1
$stopdelay1 = 15000ns
$stopdelay2 = 8000ns
$ondelay = 4000us
$ta1 = 20us// Assign $var 10
$tb1 = 40us// Assign $var 10
$ta2 = 24us// Assign $var 10
$tb2 = 48us// Assign $var 10
$ta3 = 28us// Assign $var 10
$tb3 = 56us// Assign $var 10
$ta4 = 32us// Assign $var 10
$tb4 = 64us// Assign $var 10
$ta5 = 36us// Assign $var 10
$tb5 = 72us// Assign $var 10
$ta6 = 40us// Assign $var 10
$tb6 = 80us// Assign $var 10
$ta7 = 44us// Assign $var 10
$tb7 = 88us// Assign $var 10
$ta8 = 48us// Assign $var 10
$tb8 = 96us// Assign $var 10
$ta9 = 52us// Assign $var 10
$tb9 = 104us// Assign $var 10
$ta10 = 56us// Assign $var 10
$tb10 = 112us// Assign $var 10
$ta11 = 60us// Assign $var 10
$tb11 = 120us// Assign $var 10
$ta12 = 64us// Assign $var 10
$tb12 = 128us// Assign $var 10
$ta13 = 68us// Assign $var 10
$tb13 = 136us// Assign $var 10
$ta14 = 72us// Assign $var 10
$tb14 = 144us// Assign $var 10
$ta15 = 76us// Assign $var 10
$tb15 = 152us// Assign $var 10
$ta16 = 80us// Assign $var 10
$tb16 = 160us// Assign $var 10
$ta17 = 84us// Assign $var 10
$tb17 = 168us// Assign $var 10
$ta18 = 88us// Assign $var 10
$tb18 = 176us// Assign $var 10
$ta19 = 92us// Assign $var 10
$tb19 = 184us// Assign $var 10
$ta20 = 96us// Assign $var 10
$tb20 = 192us// Assign $var 10

label: 0b0000 0000 0000 0000 0010 1001, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb1  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction

       0b0000 0000 0000 0000 0010 1001, $ta2, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb2  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta3, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb3  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta4, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb4  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta5, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta6, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb6  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta7, LOOP, $loopnum // bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb7  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP
       
       0b0000 0000 0000 0000 0010 1001, $ta8, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb8  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction

       0b0000 0000 0000 0000 0010 1001, $ta9, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb9  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta10, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb10  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta11, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb11  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta11 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta12, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb12  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta12 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta13, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb13  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta13 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta14, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb14  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta14 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta15, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb15  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta15 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta16, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb16  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta16 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta17, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb17  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta17 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta18, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb18  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta18 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta19, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb19  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta19 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1001, $ta20, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $tb20  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $ta20 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, 5000 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction       

       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label