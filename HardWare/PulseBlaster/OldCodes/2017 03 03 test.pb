// Sample program for SpinCore PulseBlaster Interpreter.
// Simple all on all off pattern.

label: 0b0000 0000 0000 0000 0010 0000, 500ms // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 1010 0000, 60ns
       0b0000 0000 0000 0000 0010 0000, 100us, branch, label // All bits off for 500 ms, branch to label