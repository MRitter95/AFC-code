// Sample program for SpinCore PulseBlaster Interpreter.
// Select channel to drive


       0b0000 0000 0000 1111 0000 0000, 500ms

label: 0b0000 0000 0000 0000 1000 0000, 10us // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0000, 1s, branch, label // All bits off for 500 ms, branch to label