include <adafruit.scad>
include <blue_robotics.scad>
include <pi_camera.scad>
include <pi_zero.scad>

// TODO battery and boost are very tight
// TODO boost usb is blocked

bracket_ring_h = 4;
bracket_cap_h = 2;
bracket_h = bracket_ring_h + bracket_cap_h;
bracket_r = tube_r_inside - 1;
bracket_w = 6;
bracket_bolt_h = 3;

sled_h = 3;

cradle_h = 17;

// Mount the power_boost on the sled
sled_pb_mount = [0, 0];

// Mount the pi on the sled
sled_pi_mount = [0, 8];

// Electronics sled 2d pattern
module sled_2d() {
  // Usable sled is as wide as the tube, and runs from bracket ring to bracket ring
  usable_x = tube_h - 2 * flange_overlap_h;
  usable_y = (flange_r_inside - 1) * 2;

  // Tabs fit into the bracket slots
  // TODO need additional knockouts for camera bracket
  tab_x = usable_x - 2 * bracket_ring_h - 2 * bracket_bolt_h;
  tab_y = tube_r_inside * 2 - 2;

  difference() {
    union() {
      square([usable_x, usable_y], center = true);
      square([tab_x, tab_y], center = true);
    }

    for (pb_hole = pb_holes) {
      translate(pb_hole + sled_pb_mount)
        circle(r = pb_hole_r);
    }

    for (pi_hole = pi_holes) {
      translate(pi_hole + sled_pi_mount)
        circle(r = pi_hole_r);
    }
  }
}

// Bracket 2d pattern
module bracket_2d() {
  // Ring attaches to flange
  difference() {
    circle(r = bracket_r);
    circle(r = bracket_r - bracket_w);

    // Holes
    translate([0, flange_hole_offset]) circle(r = 1.5);
    translate([0, - flange_hole_offset]) circle(r = 1.5);
  }

  // Crossbars to hold sled
  bar_x = 3;
  bar_y = 45;
  union() {
    translate([sled_h, 0]) square([bar_x, bar_y], center = true);
    translate([- sled_h, 0]) square([bar_x, bar_y], center = true);
  }
}

// Camera mount 2d pattern
// TODO create very thin walls with rounded inside corners, similar to topside fathomx holder
module cam_mount_2d() {
  wall = 6;
  difference() {
    square([cam_x - cam_offset_x, cam_y], center = true);
    square([cam_x - cam_offset_x - wall, cam_y - wall], center = true);

    // Holes
    for (cam_hole = cam_holes) {
      translate([cam_hole.x + cam_offset_x / 2, cam_hole.y]) circle(r = cam_hole_r);
    }
  }
}

// Battery cradle pushes battery away from sled
module battery_cradle() {
  cradle_w = 5;

  difference() {
    cube([cradle_w, battery_d - 5, cradle_h], center = true);
    translate([0, 0, cradle_h / 2])
      rotate([0, 90, 0])
        cylinder(r = battery_r, h = cradle_w + 1, center = true);
  }
}

// Electronics sled
module sled() {
  cradle_offset = 23;

  linear_extrude(height = sled_h)
    sled_2d();

  translate([cradle_offset, 0, cradle_h / 2])
    battery_cradle();

  translate([- cradle_offset, 0, cradle_h / 2])
    battery_cradle();
}

// Bracket for the penetration flange
module pen_bracket() {
  linear_extrude(height = bracket_ring_h)
    bracket_2d();
}

// Bracket for the camera flange
// TODO provide a bigger base to hold the camera box
module cam_bracket() {
  pen_bracket();

  // This translation is critical: the camera should be directly under the dome
  translate([- 6, 0, 0])
    linear_extrude(height = 20)
      cam_mount_2d();
}
