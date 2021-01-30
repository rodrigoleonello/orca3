# OpenSCAD files

How these files are organized:

* `scad/include/` contains modules and constants
  * `pcb.scad` contains modules and constants for creating PCB mockups
  * `adafruit.scad` contains mockups of Adafruit parts
  * `blue_robotics.scad` contains mockups of Blue Robotics parts
  * etc.
* `scad/` contains things that render
  * there is a file for every printable part, ready for printing
  * there are a bunch of files for debugging, such as `scad/external_camera.scad`

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
* Electronics sled: `scad/sled.scad`
* Top and bottom brackets holding everything in place in the tube: `scad/bracket.scad`
* Mounting bracket: TODO

Software: TODO