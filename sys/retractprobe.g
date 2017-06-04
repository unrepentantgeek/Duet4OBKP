; Probe store routine for Kossel Pro + e3d Lite
M564 S0                 ; don't apply limits
G1 X125 Y-55 Z75        ; move over the corner of the bed
G1 X125 Y-55 Z-9 F1500  ; push probe down on post
G1 Z75 F15000           ; raise head again
M564 S1                 ; apply limits again
