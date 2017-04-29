# Duet4OBKP
Duet Wifi upgrades for the OpenBeam Kossel Pro

## Introduction

## Parts required

  * Duet Wifi or Duet Ethernet (untested, should fit?)
  * E3D v6 or v6 Lite
  * USB extension
  * 30mm 5v fan (4.3CFM)
  * PanelDue (optional)
  * PEI/Ultem print surface (recommended)
  
## Printed parts

  * Duet holder
  * Duet cover
  * Bulkhead
  * End effector top
  * Cable clamp
  * Display enclosure (optional)

### Optional touch screen

## Assembly



## Configuration

copy base configs to card

## Calibration

### Calibrate Z probe
Home all axes and then drive the end effector down to just touch the bed.  If you hit Z=0 before you reach the bed use `G92 Z10` to reset the Z axis and continue to move down with the jog controls.  Use a piece of paper to ensure that you are *just* touching the bed.  The paper should drag under the nozzle, but not be pinned down to the bed.

Once you are just touching the bed run `G92 Z0` to zero the Z axis.  Then move up 20mm, manually deploy the Z probe and run `G32 S-1`.  The end effector will move down slowly until the probe triggers.  Your probe offset will be printed to the gcode console.  It is recommended that you repeat this process several times until the value settles down.

Update the Z value in the G31 command in config.g

### Auto level
save output of M666 and M665

### Should I use M500/M501?
###fine-tuning with bed compensation
