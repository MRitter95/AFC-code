// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 200
$stopdelay = 75ns
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
$ta21 = 100us// Assign $var 10
$tb21 = 200us// Assign $var 10
$ta22 = 104us// Assign $var 10
$tb22 = 208us// Assign $var 10
$ta23 = 108us// Assign $var 10
$tb23 = 216us// Assign $var 10
$ta24 = 112us// Assign $var 10
$tb24 = 224us// Assign $var 10
$ta25 = 116us// Assign $var 10
$tb25 = 232us// Assign $var 10
$ta26 = 120us// Assign $var 10
$tb26 = 240us// Assign $var 10
$ta27 = 124us// Assign $var 10
$tb27 = 248us// Assign $var 10
$ta28 = 128us// Assign $var 10
$tb28 = 256us// Assign $var 10
$ta29 = 130us// Assign $var 10
$tb29 = 260us// Assign $var 10
$ta30 = 132us// Assign $var 10
$tb30 = 264us// Assign $var 10
$ta31 = 136us// Assign $var 10
$tb31 = 272us// Assign $var 10
$ta32 = 140us// Assign $var 10
$tb32 = 280us// Assign $var 10
$ta33 = 144us// Assign $var 10
$tb33 = 288us// Assign $var 10
$ta34 = 148us// Assign $var 10
$tb34 = 296us// Assign $var 10
$ta35 = 150us// Assign $var 10
$tb35 = 300us// Assign $var 10
$ta36 = 154us// Assign $var 10
$tb36 = 308us// Assign $var 10
$ta37 = 158us// Assign $var 10
$tb37 = 316us// Assign $var 10
$ta38 = 162us// Assign $var 10
$tb38 = 324us// Assign $var 10
$ta39 = 166us// Assign $var 10
$tb39 = 332us// Assign $var 10
$ta40 = 170us// Assign $var 10
$tb40 = 340us// Assign $var 10
$ta41 = 174us// Assign $var 10
$tb41 = 348us// Assign $var 10
$ta42 = 178us// Assign $var 10
$tb42 = 356us// Assign $var 10
$ta43 = 182us// Assign $var 10
$tb43 = 364us// Assign $var 10
$ta44 = 186us// Assign $var 10
$tb44 = 372us// Assign $var 10
$ta45 = 190us// Assign $var 10
$tb45 = 380us// Assign $var 10
$ta46 = 194us// Assign $var 10
$tb46 = 388us// Assign $var 10
$ta47 = 198us// Assign $var 10
$tb47 = 396us// Assign $var 10
$ta48 = 400us// Assign $var 10
$tb48 = 800us// Assign $var 10



label: 0b0000 0000 0000 0000 0010 1011, $ta1, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb1  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta1 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta2, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb2  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta2 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta3, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb3  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta3 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta4, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb4  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta4 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta5, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta5 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta6, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb6  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta6 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta7, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb7  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta7 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta8, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb8  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta8 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta9, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb9  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta9 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta10, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb10  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta10 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta11, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb11  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta11 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta12, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb12  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta12 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta13, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb13  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta13 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta14, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb14  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta14 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta15, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb15  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta15 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta16, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb16  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta16 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta17, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb17  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta17 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta18, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb18  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta18 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP
     
       0b0000 0000 0000 0000 0010 1011, $ta19, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb19  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta19 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta20, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb20  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta20 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta21, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb21  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta21 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta22, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb22  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta22 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta23, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb23  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta23 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta24, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb24  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta24 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta25, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb25  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta25 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta26, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb26  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta26 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta27, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb27  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta27 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta28, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb28  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta28 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta29, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb29  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta29 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta30, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb30  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta30 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta31, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb31  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta31 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta32, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb32  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta32 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta33, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb33  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta33 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta34, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb34  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta34 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta35, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb35  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta35 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP   
  
       0b0000 0000 0000 0000 0010 1011, $ta36, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb36  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta36 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta37, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb37  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta37 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta38, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb38  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta38 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta39, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb39  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta39 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP   
  
       0b0000 0000 0000 0000 0010 1011, $ta40, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb40  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta40 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta41, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb41  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta41 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP  
   
       0b0000 0000 0000 0000 0010 1011, $ta42, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb42  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta42 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta43, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb43  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta43 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta44, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb44  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta44 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta45, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb45  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta45 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta46, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb46  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta46 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta47, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb47  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta47 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0010 1011, $ta48, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0010, $tb48  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0011, $ta48 // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay
       0b0000 0000 0000 0000 0000 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay, END_LOOP 
    
       0b0000 0000 0000 0000 0000 0010, 4000 us, branch, label