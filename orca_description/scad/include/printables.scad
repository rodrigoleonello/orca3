include <tube.scad>
include <pi_camera.scad>
include <blue_robotics.scad>

bracket_ring_h = 4;
bracket_cap_h = 2;
bracket_h = bracket_ring_h + bracket_cap_h;
bracket_r = tube_r_inside - 1;
bracket_w = 6;

slope_poly = [[0, 4], [4, 4], [4, 0], [2, 0]];
slope_poly_z = 4;

// Bracket for the camera flange
// TODO how to attach sled?
// TODO camera mounting holes
// TODO uses quite a bit of material
module cam_bracket() {
  difference() {
    // Attach to flange
    cylinder(h = bracket_ring_h, r = bracket_r);

    // Holes
    translate([0, flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);
    translate([0, - flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);

    // Cutouts
    intersection() {
      translate([0, 0, - 1]) cylinder(h = bracket_ring_h + 2, r = (bracket_r - bracket_w));
      translate([0, 0, 0]) cube([80, 20, 20], center = true);
    }
  }

  // Camera mount
  translate([- 3.5, 0, - 8]) cube([cam_x - 7, cam_y, 24], center = true);
}

// Bracket for the penetration flange
// TODO no support under cross supports
module pen_bracket() {
  difference() {
    // Ring attaches to flange
    tube(h = bracket_ring_h, r = bracket_r, w = bracket_w);

    // Holes
    translate([0, flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);
    translate([0, - flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);
  }

  // Cross supports guide and hold sled
  translate([0, 0, bracket_ring_h]) intersection() {
    cylinder(h = slope_poly_z, r = bracket_r);
    union() {
      translate([0, 2, 4]) rotate([0, 90, 0])
        linear_extrude(60, center = true) polygon(slope_poly);
      translate([0, - 2, 4]) rotate([180, 90, 0])
        linear_extrude(60, center = true) polygon(slope_poly);
    }
  }
}

// TODO holes for power boost
// TODO bracket to hold battery
module sled() {
  cube([tube_h - 2 * flange_overlap_h - 2 * bracket_ring_h, tube_r_inside * 2 - 2, 3], center = true
  );
}

