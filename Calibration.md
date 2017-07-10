# Calibration

## Calibrate PID

The thermistor is configured with the `M305` command.  Make sure to use the right value for B and C for your setup.  For the E3D v6 and v6 lite, the correct setting for extruder 0 is `M305 P1 T100000 B4725 R4700 C7.06e-8 H30 L0`

To start a PID tune, run the following command on the gcode console:

```M303 H1 S220 P1```

**Don't walk away!**  Keep an eye on the temperature until the heater has turned off.  If the firmware reports that the heater is overpowered, then wait for the heater to cool and re-run the `M303` command above with a lower value for P i.e.: `M303 H1 S220 P0.5`

Save the PID tuning values with `M500`

For more information on heater control and tuning see https://duet3d.com/wiki/Tuning_the_heater_temperature_control

## Calibrate Z probe

Home all axes and then drive the end effector down to just touch the bed.  If you hit Z=0 before you reach the bed use `G92 Z10` to reset the Z axis and continue to move down with the jog controls.  Use a piece of paper to ensure that you are *just* touching the bed.  The paper should drag under the nozzle, but not be pinned down to the bed.

Once you are just touching the bed run `G92 Z0` to zero the Z axis.  Then move up 20mm, manually deploy the Z probe and run `G30 S-1`.  The end effector will move down slowly until the probe triggers.  Your probe offset will be printed to the gcode console.  It is recommended that you repeat this process several times until the value settles down.

Update the probe offset with the G31 command.  For example `G31 Z12.345`  Then run `M500` to store the config.

## Auto level

Deploy the Z-probe and run the Auto Delta Calibration command `G32` or press the button in the interface.  You may want to run this a couple of times until the reported deviation settles down.  If the printer reports untriggered probe points then increase the `H` parameter of the `M665` command in config-override.g by 5 at a time until all probe points trigger.

Run the `M665` and `M666` commands and inspect the output:

```
M665
Diagonal 300.000, delta radius 152.665, homed height 272.993, bed radius 135.0, X -0.231°, Y -0.860°, Z 0.000°
M666
Endstop adjustments X-0.35 Y-0.95 Z1.30, tilt X0.00% Y0.00%
```

These are the computed values for your delta geometry.  Save them by issuing an `M500` command.  You might also want to copy these values to local.g so that you have a sane base config to go back to should you incorrectly overwrite config-overrides.g.

## Adjusting for varying probe offset

The probe offset likely changes slightly depending on where across the bed the printer is probing.  This can be caused by a number of factors, but it's relatively easy to compensate for.  Open `bed.g` and note the locations that your printer probes at.  At the end of each G30 command is an H0 operand.  That's the probe offset for that location.

First, home your printer and then use the `M561` command to cancel any existing bed compensation.  Next, jog the head to each location listed in `bed.g` and measure it according to the instructions below.  You can do this quickly with the `G01` command:

```G01 X45.47 Y26.25 Z1```

The above example command moves the nozzle to 1mm above the bed at the specified X,Y coordinates.  Carefully jog down 0.05mm at a time until a piece of paper just drags under the nozzle, just like when calibrating the z-probe.  Note the Z value of where this happens.  **Invert** this probe offset value and use it for the H value of this G30 line in `bed.g`.  Repeat for all locations and update/save your `bed.g` file.  For example:

```
; If you measure a Z value of 0.05 for this line:
G30 P1  X45.47 Y26.25 Z-99999 H0
; It should be updated to look something like this:
G30 P1  X45.47 Y26.25 Z-99999 H-0.05
```

Note: when moving from one X/Y location to another, it's a good idea to move up at least 1mm to avoid dragging the nozzle!

Hint: By default the web interface has buttons for .1mm moves but you can change this to 0.05mm by checking the 'Half Z Movements' checkbox under the 'User Interface' tab in the system settings.  If you'd like even more fine grained control you can create your own macros for "Move Up 0.01mm" and "Move Down 0.01mm" by using the following example gcode:

```
G91             ; change to relative moves
G1 Z0.01 F2000  ; or Z-0.01 to move down
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
