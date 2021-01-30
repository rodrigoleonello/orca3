include <tube.scad>
include <blue_robotics.scad>

bracket_ring_h = 4;
bracket_cap_h = 2;
bracket_h = bracket_ring_h + bracket_cap_h;
bracket_r = tube_r_inside - 1;
bracket_w = 6;

// TODO very large overhang
// TODO holes
// TODO might need to inset the holes to provide room for screws
// TODO hole / slot for ribbon cable and switch wires
// TODO may split this into bottom_bracket and top_bracket
// TODO holders for electronics sled
module bracket() {
  union() {
    tube(h = bracket_ring_h, r = bracket_r, w = bracket_w);
    translate([0, 0, bracket_ring_h]) cylinder(h = bracket_cap_h, r = bracket_r);
  }
}

// TODO holes for power boost
// TODO bracket to hold battery
module sled() {
  cube([tube_h - 2 * flange_overlap_h - 2 * bracket_h, tube_r_inside * 2 - 2, 3], center = true);
}

