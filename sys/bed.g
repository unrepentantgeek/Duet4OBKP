; Auto calibration routine for delta printers.

M561            ; clear any bed transform, otherwise homing may be at the wrong height
G31 X0 Y0       ; don't want any probe offset for this
G28             ; home the printer, just in case the user didn't

M98 Pdeployprobe.g  ; deploy probe if configured

; dummy probe because the first probe is usually inaccurate
G30 P0 X0.00 Y0.00 Z-99999 H0

; bed.g file for RepRapFirmware, generated by Escher3D calculator
; 16 points, 6 factors, probing radius: 105, probe offset (-23, -6)
G30 P0  X0.00   Y-105.00 Z-99999 H0
G30 P1  X67.49  Y-80.43  Z-99999 H0
G30 P2  X103.40 Y-18.23  Z-99999 H0
G30 P3  X90.93  Y52.50   Z-99999 H0
G30 P4  X35.76  Y98.24   Z-99999 H0
G30 P5  X-31.39 Y86.26   Z-99999 H0
G30 P6  X-74.55 Y43.04   Z-99999 H0
G30 P7  X-85.50 Y-15.08  Z-99999 H0
G30 P8  X-60.48 Y-72.08  Z-99999 H0
G30 P9  X0.00   Y-52.50  Z-99999 H0
G30 P10 X45.47  Y-26.25  Z-99999 H0
G30 P11 X45.47  Y26.25   Z-99999 H0
G30 P12 X0.00   Y43.85   Z-99999 H0
G30 P13 X-31.54 Y18.21   Z-99999 H0
G30 P14 X-33.43 Y-19.30  Z-99999 H0
G30 P15 X0      Y0       Z-99999 S6

G1 X0 Y0 Z150 F15000    ; get the head out of the way of the bed

M98 Pretractprobe.g     ; retract probe if configured
