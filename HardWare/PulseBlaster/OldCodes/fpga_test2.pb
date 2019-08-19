// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 100 MHz
//
// Bits: 17= Start, 18 = Det1, 19 = Det2

Starts:0b0000 0000 0100 0000 0000 0000, 1us, LOOP, 200

Counts:0b0000 0000 1000 0000 0000 0000, 400ns, LOOP, 300
       0b0000 0000 0000 0000 0000 0000, 10us, END_LOOP
       
       0b0000 0000 0000 0000 0000 0000, 10us, END_LOOP
       STOP
      



