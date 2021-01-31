// Mockup of an external camera assembly, showing how all of the parts fit together

// OpenSCAD is unitless, as are stl files, but most slicers interpret units as mm

// My conventions:
// -- build pretty much everything with center=true
// -- part mockups are colored in the module file, printables are colored in the render file

include <include/adafruit.scad>
include <include/blue_robotics.scad>
include <include/pi_camera.scad>
include <include/pi_zero.scad>
include <include/printables.scad>

top = 132;

// Hi-def render
$fn = 60;

// Build the assembly with the camera facing down
// Camera flange is at z=0, the dome (not shown) is hanging below
// Focal point should be at z=0

// Camera
translate([0, 0, - 2]) pi_camera();

// Camera bracket
color("#5252b4") translate([0, 0, flange_h]) cam_bracket();

// Pi Zero
translate([- 8, 4, 68]) rotate([0, 90, 90]) pi_zero();

// Battery
translate([12, - 15, 32]) battery();

// Power boost
translate([- 8, - 4, 68]) rotate([90, - 90, 0]) power_boost();

// Electronics sled
color("#b452af") translate([0, 0, tube_h / 2 + flange_lip_h]) rotate([90, 90, 0]) sled();

// Penetration bracket
color("#5252b4", 0.4) translate([0, 0, top - flange_h]) rotate([0, 180, 0]) pen_bracket();

// Flanges and tube are transparent, so they go last
color("#5252b4", 0.4) translate([0, 0, top]) rotate([0, 180, 0]) flange();
color("#5252b4", 0.4) flange();
translate([0, 0, flange_lip_h]) two_inch_tube();

