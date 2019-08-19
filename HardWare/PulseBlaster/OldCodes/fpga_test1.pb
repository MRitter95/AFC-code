// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 100 MHz
//
// Bits: 17= counts, 18 = Det1, 19 = Det2

 
start:	 0b0000 0000 0000 0000 0000 0000, 1s
detA:	 0b0000 0010 0000 0000 0000 0000, 1us
countsA: 0b0000 0001 0000 0000 0000 0000, 1us, LOOP, 50
         0b0000 0000 0000 0000 0000 0000, 100ms, END_LOOP
         0b0000 0000 0000 0000 0000 0000, 2s
detB:	 0b0000 0100 0000 0000 0000 0000, 1us
countsB: 0b0000 0001 0000 0000 0000 0000, 1us, LOOP, 75
         0b0000 0000 0000 0000 0000 0000, 100ms, END_LOOP
         0b0000 0000 0000 0000 0000 0000, 2s, branch, start