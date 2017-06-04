; Probe deployment routine for Kossel Pro
;G28                         ; home all axes should happen in parent script
M564 S0                     ; don't apply limits
G1 X-110 Y-125 Z100 F15000  ; put probe arm next to belt
G1 X45 Y-125 F2500          ; Move right to trigger deploy pin
G1 X0 Y0 F15000             ; move to somewhere sensible
M564 S1                     ; apply limits again
