; Put local machine overrides in this file.  It is run after config.g, but before config-overrides.g

M550 PKosselPro	                      ; Machine name and Netbios name (can be anything you like)
M551 Preprap                        	; Machine password (used for FTP)
;*** If you have more than one Duet on your network, they must all have different MAC addresses, so change the last digits
M540 P0xBE:0xEF:0xDE:0xAD:0xFE:0xED 	; MAC Address
;*** Wifi Networking
; Uncomment this line to enable WiFi once the Duet is set up on your wifi network.
; M552 S1

;*** If you have a two-into-one extruder build, uncomment the next 3 lines
;M563 P1 D1 H2                      	; Define tool 1
;G10 P1 S0 R0                       	; Set tool 1 operating and standby temperatures
;M92 E92.6:92.6                       	; Set extruder steps per mm

;*** If you are using axis compensation, put the figures in the following command
M556 S78 X0 Y0 Z0                   	; Axis compensation here

; Compensate for delta inaccuracies
; Uncomment the following line and adjust the X and Y values to grow/shrink in the X/Y axes
;M579 X1.005 Y1.005 ; compensate for delta geometry, grow ~0.5% in X and Y
