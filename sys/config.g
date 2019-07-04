; Main configuration file for Kossel Pro MK3 using Duet WiFi

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; ! Don't edit this file directly, put your overrides in local.g !
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

; Communication and general
M111 S0                            	; Debug off

M555 P2                           	; Set output to look like Marlin
M575 P1 B57600 S1		              	; Comms parameters for PanelDue

G21                                	; Work in millimetres
G90                                	; Send absolute coordinates...
M83                                	; ...but relative extruder moves

; Axis and motor configuration
M569 P0 S0				; Drive 0 goes backwards
M569 P1 S0				; Drive 1 goes backwards
M569 P2 S0				; Drive 2 goes backwards
M569 P3 S1				; Drive 3 goes forwards
M569 P4 S1				; Drive 4 goes forwards
M574 X2 Y2 Z2 S1  ; set endstop configuration (all endstops at high end, active high)

; The homed height (H270) is deliberately set too high in the following line.
; Real values are stored in config-overrides.g by running M500 after calibration.
M665 L300.000 R153 H270 B135.0 X0 Y0 Z0	; set delta radius, diagonal rod length, printable radius and homed height
M666 X0 Y0 Z0 A0.00 B0.00		      ; put your endstop adjustments here, or let auto calibration find them

M350 X16 Y16 E16 I1    		      	; Set 16x microstepping with interpolation
M92 X80 Y80 Z80           				; Set axis steps/mm
M906 X1000 Y1000 Z1000 E800 I60		; Set motor currents (mA) and increase idle current to 60%
M201 X9000 Y9000 Z9000 E5000		  ; Accelerations (mm/s^2)
M203 X30000 Y30000 Z30000 E7200		; Maximum speeds (mm/min)
M566 X600 Y600 Z600 E150	      	; Maximum instant speed changes mm/minute

; Thermistors
M305 P0 T100000 B3950 R4700 H30 L0	          ; set the bed thermistor ADC correction
M305 P1 T100000 B4725 R4700 C7.06e-8 H30 L0	  ; set the first nozzle thermistor ADC correction

; Fans
M106 P1 T40:50 H1:2 			; enable thermostatic mode for fan 1

; Default tool definitions
M563 P0 D0 H1             ; Define tool 0
G10 P0 S0 R0              ; Set tool 0 operating and standby temperatures
M92 E92.6                 ; Set extruder steps per mm

; Z probe and compensation definition
M558 P5 I1 X0 Y0 Z0			  ; Z probe is a normally open switch on the nozzle, connected to probe input
G31 X0 Y0 Z0.25 P500			; Set the zprobe height and threshold
M208 S1 Z-0.2     				; set minimum Z

T0					              ; select first hot end

M98 Plocal.g              ; Load machine-specific settings (local.g)
M501                      ; Load machine-specific settings (config-overrides.g)
