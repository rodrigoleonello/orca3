# External cameras

The down-facing stereo camera is made up of two camera assemblies mounted to the sides of the AUV.
The baseline between the 2 camera assemblies is ~36cm.

Each camera assembly consists of the following:

* [Blue Robotics 2" tube](https://bluerobotics.com/product-category/watertight-enclosures/2-series/)
* [Blue Robotics 2" flange with dome](https://bluerobotics.com/product-category/watertight-enclosures/2-series/)
* [Blue Robotics 2" flange with penetrations](https://bluerobotics.com/product-category/watertight-enclosures/2-series/)
* [Blue Robotics switch](https://bluerobotics.com/store/comm-control-power/switch/switch-10-5a-r1/)
* [Blue Robotics enclosure vent and plug](https://bluerobotics.com/store/cables-connectors/penetrators/vent-asm-r1/)
* [Adafruit PowerBoost 1000 Charger](https://www.adafruit.com/product/2465)
* [Adafruit Lithium Ion Cylindrical Battery - 3.7v 2200mAh](https://www.adafruit.com/product/1781)
* Raspberry Pi camera with wide angle lens
* Raspberry Pi Zero W
* LED and a 100 ohm resistor

Printed parts:
* Power tray: `scad/power_tray.scad`
* Pi tray: `scad/pi_tray.scad`
* Camera bracket: `scad/cam_bracket.scad`
* Penetration bracket: `scad/pen_bracket.scad`
* Mounting bracket: TODO

Software: TODO

# OpenSCAD files

How these files are organized:

* `scad/include/` contains modules and constants, including:
  * `pcb.scad` contains modules and constants for creating PCB vitamins (_vitamins_ are non-printable parts in RepRap terminology)
  * `adafruit.scad` contains Adafruit vitamins
  * `blue_robotics.scad` contains Blue Robotics vitamins
  * `pi_camera.scad` Pi Camera V1.2 vitamin
  * `pi_zero.scad` Pi Zero W vitamin
  * `printables.scad` contains printable parts
* `scad/` contains things that render
  * there is a file for every printable part, ready for printing
  * there are a bunch of files for debugging, such as `scad/external_camera.scad`
