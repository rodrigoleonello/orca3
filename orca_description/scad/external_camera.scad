// Mockup of an external camera assembly, showing how all of the parts fit together

// OpenSCAD is unitless, as are stl files, but most slicers interpret units as mm

include <include/adafruit.scad>
include <include/blue_robotics.scad>
include <include/pi_camera.scad>
include <include/pi_zero.scad>
include <include/printables.scad>

top = 132;
mount_h = 4;

// Hi-def render
$fn = 60;

// Build the assembly with the camera facing down
// Camera flange is at z=0, the dome (not shown) is hanging below
// Focal point should be at z=0

// Camera
translate([- cam_origin.x, cam_origin.y, 3]) pi_camera();

// Camera bracket
color("#5252b4") translate([0, 0, flange_h + bracket_ring_h]) rotate([180, 0, 0]) cam_bracket();

// Electronics sled
color("#b452af") translate([sled_h / 2, 0, tube_h / 2 + flange_lip_h]) rotate([0, - 90, 0]) sled();

// Pi Zero is mounted on the underside of the sled
translate([mount_h, sled_pi_mount.y, sled_pi_mount.x + 66]) rotate([0, 90, 0]) pi_zero();

// Battery
translate([- 19, 0, 28]) battery();

// Power boost is mounted on top of the sled
translate([- mount_h, sled_pb_mount.y, sled_pb_mount.x + 66]) rotate([0, - 90, 0]) power_boost();

// Penetration bracket
color("#5252b4") translate([0, 0, top - flange_h - bracket_ring_h]) pen_bracket();

// Flanges and tube are transparent, so they go last
color("#5252b4", 0.4) translate([0, 0, top]) rotate([0, 180, 0]) flange();
color("#5252b4", 0.4) flange();
translate([0, 0, flange_lip_h]) two_inch_tube();

