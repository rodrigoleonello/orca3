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
module cam_bracket() {
  difference() {
    union() {
      // Flange attachment
      difference() {
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
      translate([- 3.5, 0, - 8])
        difference() {
          cube([cam_x - 7, cam_y, 24], center=true);

          // Holes
          for (cam_hole = cam_holes) {
            translate([cam_hole[0] + 3.5, cam_hole[1], -13]) cylinder(h = 6, r = cam_hole_r);
          }

          // Cutout
          cube([cam_x - 7 - 6, cam_y - 6, 26], center=true);
        }
    }

    // Slot for sled
    translate([0, 0, bracket_ring_h]) cube([100, 3, 3], center = true);
  }
}

// Bracket for the penetration flange
// Perhaps add a circular support to stablize the sled?
module pen_bracket() {
  difference() {
    // Ring attaches to flange
    tube(h = bracket_ring_h, r = bracket_r, w = bracket_w);

    // Holes
    translate([0, flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);
    translate([0, - flange_hole_offset, - 1]) cylinder(bracket_ring_h + 2, 1.5);

    // Slot for sled
    translate([0, 0, bracket_ring_h]) cube([100, 3, 3], center = true);
  }
}

// TODO holes for power boost
// TODO bracket to hold battery
module sled() {
  cube([tube_h - 2 * flange_overlap_h - 2 * bracket_ring_h + 3, tube_r_inside * 2 - 2, 3], center = true
  );
}

