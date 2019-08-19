// Frequency sweep test

label: 0b0000 0000 0000 0001 0000 1001, 0.015 ms // All bits on for 500 ms, Continue to next instruction
       0b0000 0000 0000 0000 0000 0001, 0.005 ms, branch, label // All bits off for 500 ms, branch to label