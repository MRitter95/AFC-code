// Frequency sweep test Bits 1= Sweep, 2=not used, 3=Burn, 4=Oscopetrig, 5=Spect Analyzer trig, 9 AD9959 trig
$loopnum = 1
$loopnumsc = 5000
$stopdelay1 = 15us
$stopdelay2 = 10us
$ondelay = 4000us

$ta = 2us
$tb = 4us
$td1 = 5us
$td2 = 10us
$td3 = 15us
$td4 = 20us
$td5 = 25us
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



label: 0b0000 0000 0000 0000 1000 1001, $ta // pi/2 pulse
       0b0000 0000 0000 0000 0000 0000, $td4  // delay
       0b0000 0000 0000 0000 0000 1001, $tb // pi pulse
       0b0000 0000 0000 0000 0000 0000, 4us
       0b0000 0000 0000 0000 0001 0010, 100us // gate on
       0b0000 0000 0000 0000 0000 0000, 4000us, branch, label