// Sample program for SpinCore PulseBlaster Interpreter.
// Simple all on all off pattern.

label: 0b0000 0000 0000 0001 0000 1011, 1ms // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 1011, 2s, branch, label // All bits off for 500 ms, branch to label