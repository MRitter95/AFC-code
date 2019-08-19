// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 100 MHz
//
// Bits: 17= Start, 18 = Det1, 19 = Det2

Starts:0b0000 0000 0100 0000 0000 0000, 1us
       0b0000 0000 0000 0000 0000 0000, 10ms, branch, Starts
     



