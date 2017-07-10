; Think3DPrint3D configuration file for Mini Kossel for testing Duet WiFi

; Communication and general
M111 S0                             	; Debug off
M550 PKosselPro		; Machine name and Netbios name (can be anything you like)
M551 Preprap                        	; Machine password (used for FTP)
;*** If you have more than one Duet on your network, they must all have different MAC addresses, so change the last digits
M540 P0xBE:0xEF:0xDE:0xAD:0xFE:0xED 	; MAC Address
;*** Wifi Networking
; Uncomment this line to enable WiFi once the Duet is set up on your wifi network.
; M552 S1

M555 P2                           	; Set output to look like Marlin
M575 P1 B57600 S1			; Comms parameters for PanelDue

G21                                 	; Work in millimetres
G90                                	; Send absolute coordinates...
M83                                 	; ...but relative extruder moves

; Axis and motor configuration
M569 P0 S0				; Drive 0 goes backwards
M569 P1 S0				; Drive 1 goes backwards
M569 P2 S0				; Drive 2 goes backwards
M569 P3 S0				; Drive 3 goes backwards
M569 P4 S0				; Drive 4 goes backwards
M574 X2 Y2 Z2 S1			; set endstop configuration (all endstops at high end, active high)
;*** The homed height (H270) is deliberately set too high in the following line.
;*** You will adjust it during calibration (higher number is closer to the bed).
M665 L300.000 R153 H270 B135.0 X0 Y0 Z0	; set delta radius, diagonal rod length, printable radius and homed height
M666 X0 Y0 Z0 A0.00 B0.00		; put your endstop adjustments here, or let auto calibration find them
M350 X16 Y16 E16 I1    			; Set 16x microstepping with interpolation
M92 X80 Y80 Z80				; Set axis steps/mm
M906 X1000 Y1000 Z1000 E800 I60		; Set motor currents (mA) and increase idle current to 60%
M201 X1000 Y1000 Z1000 E1000		; Accelerations (mm/s^2)
M203 X20000 Y20000 Z20000 E3600		; Maximum speeds (mm/min)
M566 X1200 Y1200 Z1200 E1200		; Maximum instant speed changes mm/minute

; Thermistors
M305 P0 T100000 B3950 R4700 H30 L0	; Put your own H and/or L values here to set the bed thermistor ADC correction
M305 P1 T100000 B4725 R4700 C7.06e-8 H30 L0	; Put your own H and/or L values here to set the first nozzle thermistor ADC correction
M305 P2 T100000 B3974 R4700 H30 L0	; Put your own H and/or L values here to set the second nozzle thermistor ADC correction
;M570 S180				; Hot end may be a little slow to heat up so allow it 180 seconds

; PID - Run calibration, uncomment this and put your vaules here
;M307 H1 A377.3 C149.2 D4.5 S1.00 B0

; Fans
M106 P1 H-1 				; disable thermostatic mode for fan 1

; Tool definitions
M563 P0 D0 H1                       	; Define tool 0
G10 P0 S0 R0                        	; Set tool 0 operating and standby temperatures
;*** If you have a single-nozzle build, comment the next 2 lines
;M563 P1 D1 H2                      	; Define tool 1
;G10 P1 S0 R0                       	; Set tool 1 operating and standby temperatures
M92 E92.6:92.6                       	; Set extruder steps per mm

; Z probe and compensation definition
;*** If you have a switch instead of an IR probe, change P1 to P4 in the following M558 command
M558 P4 X0 Y0 Z0			; Z probe is a mechanical probe and is not used for homing any axes
; Update Z value based on M30 probe report
G31 X0 Y0 Z11.959 P500			; Set the zprobe height and threshold (put your own values here)

;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   	; Axis compensation here

M208 S1 Z-0.2				; set minimum Z
;
T0					; select first hot end

; Compensate for delta inaccuracies
; Uncomment the following line and adjust the X and Y values to grow/shrink in the X/Y axes
;M579 X1.005 Y1.005 ; compensate for delta geometry, grow ~0.5% in X and Y

; Uncomment to load values from config-overrides.g at boot
;M501

