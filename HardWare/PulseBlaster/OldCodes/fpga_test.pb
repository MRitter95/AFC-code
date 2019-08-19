// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive
// Set clock frequency = 100 MHz
//
// Bits: 17= Start, 18 = Det1, 19 = Det2

start: 0b0000 0001 0000 0000 0000 0000, 1us // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, 2s       
       0b0000 0010 0000 0000 0000 0000, 1us
       0b0000 0000 0000 0000 0000 0000, 2s
       0b0000 0000 0000 0000 0000 0000, 1us
       0b0000 0000 0000 0000 0000 0000, 1s, branch, start