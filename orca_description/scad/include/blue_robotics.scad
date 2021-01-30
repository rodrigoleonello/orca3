include <tube.scad>

flange_h = 21.5;
flange_lip_h = 6;
flange_overlap_h = flange_h - flange_lip_h;

tube_h = 120;
tube_wall = 3.2;
tube_r_inside = 25.4;
tube_r_outside = tube_r_inside + tube_wall;

// BlueRobotics 2" flange
// TODO move calcs to constants
module flange() {
  color("gray") tube(h = flange_lip_h, r = 57 / 2, w = 7 / 2 + 12 / 2);
  translate([0, 0, flange_lip_h]) difference() {
    color("gray") tube(h = flange_overlap_h, r = 50 / 2, w = 12 / 2);
    translate([21.5, 0, 0]) cylinder(19, 1.5); // TODO wrong depth
    translate([- 21.5, 0, 0]) cylinder(19, 1.5);
    translate([0, 21.5, 0]) cylinder(19, 1.5);
    translate([0, - 21.5, 0]) cylinder(19, 1.5);
  }
}

// BlueRobotics 2" tube
module two_inch_tube() {
  color("gray", 0.4) tube(h = tube_h, r = tube_r_outside, w = tube_wall);
}

// Camera
// TODO holes
// TODO color
// TODO move calcs to constants
module camera() {
  union() {
    translate([- 25 / 2 + 2.5, - 10, 22.3]) cube([20, 5, 2.5]);
    translate([- 25 / 2, - 10, 22.3]) cube([25, 24.5, 1]);
    cylinder(h = 22.3, r = 8.3);
  }
}
