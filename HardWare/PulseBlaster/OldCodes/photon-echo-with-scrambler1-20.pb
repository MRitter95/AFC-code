// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 1
$loopnumsc = 4000
$stopdelay1 = 70ns
$stopdelay2 = 5us
$ondelay = 4000us
$ta1 = 1us// Assign $var 10
$tb1 = 2us// Assign $var 10
$ta2 = 2us// Assign $var 10
$tb2 = 4us// Assign $var 10
$ta3 = 3us// Assign $var 10
$tb3 = 6us// Assign $var 10
$ta4 = 4us// Assign $var 10
$tb4 = 8us// Assign $var 10
$ta5 = 5us// Assign $var 10
$tb5 = 10us// Assign $var 10
$ta6 = 6us// Assign $var 10
$tb6 = 12us// Assign $var 10
$ta7 = 7us// Assign $var 10
$tb7 = 14us// Assign $var 10
$ta8 = 8us// Assign $var 10
$tb8 = 16us// Assign $var 10
$ta9 = 9us// Assign $var 10
$tb9 = 18us// Assign $var 10
$ta10 = 10us// Assign $var 10
$tb10 = 20us// Assign $var 10
$ta11 = 11us// Assign $var 10
$tb11 = 22us// Assign $var 10
$ta12 = 12us// Assign $var 10
$tb12 = 24us// Assign $var 10
$ta13 = 13us// Assign $var 10
$tb13 = 26us// Assign $var 10
$ta14 = 14us// Assign $var 10
$tb14 = 28us// Assign $var 10
$ta15 = 15us// Assign $var 10
$tb15 = 30us// Assign $var 10
$ta16 = 16us// Assign $var 10
$tb16 = 32us// Assign $var 10
$ta17 = 17us// Assign $var 10
$tb17 = 34us// Assign $var 10
$ta18 = 18us// Assign $var 10
$tb18 = 36us// Assign $var 10
$ta19 = 19us// Assign $var 10
$tb19 = 38us// Assign $var 10
$ta20 = 20us// Assign $var 10
$tb20 = 40us// Assign $var 10

label: 0b0000 0000 0000 0000 0010 1011, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta1  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction

       0b0000 0000 0000 0000 0010 1011, $ta2, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta2  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta3, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta3  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta4, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta4  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta5, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta6, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta6  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta7, LOOP, $loopnum // bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta7  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP
       
       0b0000 0000 0000 0000 0010 1011, $ta8, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta8  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction

       0b0000 0000 0000 0000 0010 1011, $ta9, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta9  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta10, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta10  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta11, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta11  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb11 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta12, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta12  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb12 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta13, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta13  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb13 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta14, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta14  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb14 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta15, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta15  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb15 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta16, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta16  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb16 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta17, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta17  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb17 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta18, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta18  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb18 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta19, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta19  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb19 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction
       
       0b0000 0000 0000 0000 0010 1011, $ta20, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $ta20  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $tb20 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 100 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction       

       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label