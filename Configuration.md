# Configuration

## Offline

Power down your printer and remove the micro-SD card from the Duet and connect it to your computer.  Copy the files in [sys](sys) to /sys on the SD card, overwriting files of the same name.

## Online

Follow the [directions to get your Duet online](https://duet3d.com/wiki/Getting_connected_to_the_Duet_WiFi) and use the web interface (settings tab) to update the contents of the corresponding files in [sys](sys).

### M500 and M501

* Note: Your Duet must be running ReprapFirmware 1.17 or higher for M500/M501 support.  [How to check your firmware version](https://duet3d.com/wiki/Checking_the_firmware_versions_and_updating_the_firmware)

The `M500` command will write out your system calibration to `/sys/config-overrides.g`.  Running the `M501` command will load that file and set those parameters.  To simplify recalibration we have added the `M501` command to the end of the `config.g` file.  Any time you want to save your current settings run `M500` and they will be stored for loading at the next reset.  The settings stored by `M500` are:

  * Delta parameters (`M666` and `M665`)
  * Heater paramters (`M307`)
  * Z probe parameters (`G31`)

The rest of the instructions assume that you will use `M500` to store these settings.

### Updating your configs

You can update config.g directly, or write overrides into local.g which is executed at the end of config.g, but before the calibration settings are loaded with `M501`.  If you use local.g then you can easily update config.g from this repository while maintaining your own changes.
