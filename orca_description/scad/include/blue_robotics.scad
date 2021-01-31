include <tube.scad>

flange_h = 21.5;
flange_lip_h = 6;
flange_overlap_h = flange_h - flange_lip_h;
flange_hole_offset = 21.5;

tube_h = 120;
tube_wall = 3.2;
tube_r_inside = 25.4;
tube_r_outside = tube_r_inside + tube_wall;

// BlueRobotics 2" flange
// TODO move calcs to constants
module flange() {
  // Cap
  color("gray") tube(h = flange_lip_h, r = 57 / 2, w = 7 / 2 + 12 / 2);

  // Inside tube
  translate([0, 0, flange_lip_h]) difference() {
    color("gray") tube(h = flange_overlap_h, r = 50 / 2, w = 12 / 2);

    // Holes
    translate([flange_hole_offset, 0, 0]) cylinder(19, 1.5); // TODO wrong depth
    translate([- flange_hole_offset, 0, 0]) cylinder(19, 1.5);
    translate([0, flange_hole_offset, 0]) cylinder(19, 1.5);
    translate([0, - flange_hole_offset, 0]) cylinder(19, 1.5);
  }
}

// BlueRobotics 2" tube
module two_inch_tube() {
  color("gray", 0.4) tube(h = tube_h, r = tube_r_outside, w = tube_wall);
}
