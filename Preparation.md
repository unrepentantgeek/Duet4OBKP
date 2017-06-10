## Print the parts

## Strip the printer
Unplug power first and let it sit a few minutes at least.

To ease disassebly, you can cut the power input and heated bed output wires right at the Brainwave Pro motherboard.  We will
re-use these wires with new ends on them during assembly.

Disassembly:
  Remove end effector
  Remove delta arms
  Remove print glass & heated bed
  Remove power inlet/switch bulkhead and wires to the PSU
  Disconnect all wires and remove Brainwave Pro mainboard
  Remove extruder cold end assembly

If you didn't add the extra m3 nuts to the lower frame rails as recommended in the assembly guide, then you'll need to go back
now and add them.  This is an exercise left to the reader, but turning the printer upside down and removing one rail at a time
can be helpful.

## Install Duet

**VERY IMPORTANT: Move the jump for VFAN select to the 5v position.  24V will fry the LEDs in the end effector PCB!**

Install a 30mm fan on the Duet mount.  If this is a 24v fan, you will wire it to the PSU directly.  If it's a 5v fan, you can
wire it to one of the always-on fan headers on the mainboard.
