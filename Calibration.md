# Calibration

## Calibrate PID

The thermistor is configured with the `M305` command.  Make sure to use the right value for B and C for your setup.  For the E3D v6 and v6 lite, the correct setting for extruder 0 is:

```M305 P1 T100000 B4725 R4700 C7.06e-8 H30 L0```

https://duet3d.com/wiki/Tuning_the_heater_temperature_control

```M303 H1 S220```

Don't walk away!  Keep an eye on the temperature until the heater is turned off.  Save your settings with the `M307` command.

## Calibrate Z probe

Home all axes and then drive the end effector down to just touch the bed.  If you hit Z=0 before you reach the bed use `G92 Z10` to reset the Z axis and continue to move down with the jog controls.  Use a piece of paper to ensure that you are *just* touching the bed.  The paper should drag under the nozzle, but not be pinned down to the bed.

Once you are just touching the bed run `G92 Z0` to zero the Z axis.  Then move up 20mm, manually deploy the Z probe and run `G30 S-1`.  The end effector will move down slowly until the probe triggers.  Your probe offset will be printed to the gcode console.  It is recommended that you repeat this process several times until the value settles down.

Update the Z value in the G31 command in `config.g` to this number.  Restart the system to reload the config `M999`

## Auto level

Deploy the Z-probe and run the Auto Delta Calibration command `G32` or press the button in the interface.  You may want to run this a couple of times until the reported deviation settles down.

Run the `M665` and `M666` commands and inspect the output:

```
M665
Diagonal 300.000, delta radius 152.665, homed height 272.993, bed radius 135.0, X -0.231°, Y -0.860°, Z 0.000°
M666
Endstop adjustments X-0.35 Y-0.95 Z1.30, tilt X0.00% Y0.00%
```

These are the computed values for your delta geometry. You can either hard code these into your base configs, or save them to `config-overrides.g` with `M500`

### M500 and M501

* Note: Your Duet must be running ReprapFirmware 1.17 or higher for M500/M501 support

The `M500` command will write out your system configuration to `/sys/config-overrides.g`.  Running the `M501` command will load that file and set those parameters.  To simplify recalibration you can add the `M501` command to the end of your `config.g` file.  Any time you want to save your current settings run `M500` and they will be stored.

### Updating your configs

If you'd prefer, you can update your base config with these values.  Update the M665 and M666 commands in `config.g` with the values seen in the output above.

## Adjusting for varying probe offset

The probe offset likely changes slightly depending on where across the bed the printer is probing.  This can be caused by a number of factors, but it's relatively easy to compensate for.  Open `bed.g` and note the locations that your printer probes at.  At the end of each G30 command is an H0 operand.  That's the probe offset for that location.

First, home your printer and then use the `M561` command to cancel any existing bed compensation.  Next, jog the head to each location listed in `bed.g` and measure it according to the instructions below.  You can do this quickly with the `G01` command:

```G01 X45.47 Y26.25 Z1```

The above example command moves the nozzle to 1mm above the bed at the specified X,Y coordinates.  Carefully jog down 0.05mm at a time until a piece of paper just drags under the nozzle, just like when calibrating the z-probe.  Note the Z value of where this happens.  Invert this probe offset value and use it for the H value of this G30 line in `bed.g`.  Repeat for all locations and update/save your `bed.g` file.  For example:

```
; If you measure a Z value of 0.05 for this line:
G30 P1  X45.47 Y26.25 Z-99999 H0
; It should be updated to look something like this:
G30 P1  X45.47 Y26.25 Z-99999 H-0.05
```

Note: when moving from one X/Y location to another, it's a good idea to move up at least 1mm to avoid dragging the nozzle!

Hint: The web interface only has buttons for .1mm moves but you can create your own macros for "Move Up 0.05mm" and "Move Down 0.05mm" by using the following example gcode:

```
G91             ; change to relative moves
G1 Z0.05 F2000  ; or Z-0.05 to move down
G90             ; restore absolute moves
```

# First print

Print the [Calibration Square.stl](stl/Calibration%20Square.stl).  If you have set any slicer tweaks such as 'Inset surface' or 'Horizontal size compensation' you should disable them for now.  Once the print is complete, mark the front top with a marker for reference, and remove it from the print bed.

Measure the thickness at several points around the perimiter.  It should be 5mm thick.  Otherwise:

  * Consistently thin or thick
  
  Your probe offset is incorrect.  If the part is too thin, *reduce* the probe offset by how much thinner than 5mm the part is.  Then repeat the bed probe and save the values.
  
  * Inconsistent thickness
  
    * Doublecheck that you got the sign right on the H values when fine tuning probe offset
    * Make sure that your printer doesn't have any loose screws


## Compensate for X/Y shrinkage

Use `M579` to compensate for any growth or shrinkage in X and Y caused by innacuracies in the delta geometry.  For example if your printer consistently prints parts 1% too small, use: `G579 X1.01 Y1.01`