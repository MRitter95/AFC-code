// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 1
$loopnumsc = 5000
$stopdelay1 = 10us
$stopdelay2 = 5us
$ondelay = 4000us

$ta = 2us
$tb = 2us
$td1 = 5us
$td2 = 10us
$td3 = 15us
$td4 = 20us
$td5 = 100us
$td6 = 30us
$td7 = 35us
$td8 = 40us
$td9 = 45us
$td10 = 50us
$td11 = 55us
$td12 = 60us
$td13 = 65us
$td14 = 70us
$td15 = 75us



label: 0b0000 0000 0000 0000 0010 1001, $ta, LOOP, $loopnum // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $td5  // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0010 0001, $tb // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 2 us // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0010 0001, $tb // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, $stopdelay1
       0b0000 0000 0000 0000 0100 0010, $ondelay // All bits off for 5 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, $stopdelay2, END_LOOP
Erase: 0b0000 0000 0000 0100 0010 0100, 500 us, LOOP, $loopnumsc // Burn bit = bit #3 (pulse to RF switch)
       0b0000 0000 0000 0000 0000 0000, 1 us, END_LOOP  // All bits off for 5 ms, Continue to next instruction       

       0b0000 0000 0000 0000 0000 0000, 4000 us, branch, label