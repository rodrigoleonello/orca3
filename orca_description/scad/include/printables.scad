include <adafruit.scad>
include <blue_robotics.scad>
include <pi_camera.scad>
include <pi_zero.scad>

bracket_ring_h = 3;
bracket_cap_h = 2;
bracket_h = bracket_ring_h + bracket_cap_h;
bracket_r = tube_r_inside - 1;
bracket_w = 6;
bracket_bolt_h = 3;

power_tray_size = [tube_h - 2 * (flange_overlap_h + bracket_ring_h), 40, 2];
pi_tray_size = power_tray_size;
wide_tray_tab = 31;
narrow_tray_tab = 15;

cradle_h = 11;

// Mount the power_boost on the power tray
pb_mount = [20, 0];

// Mount the pi on the pi tray
pi_mount = [0, 0];

// How trays are positioned in the brackets, for external_camera.scad
power_tray_offset = - 5;
pi_tray_offset = 8;

// Adjust board positions to be center=true
power_tray_offset_adj = power_tray_offset - power_tray_size.z / 2;
pi_tray_offset_adj = pi_tray_offset - pi_tray_size.z / 2;

// Power tray 2d pattern
module power_tray_2d() {
  difference() {
    union() {
      square([power_tray_size.x, power_tray_size.y], center = true);

      // Tabs fit into bracket slots
      translate([(power_tray_size.x + bracket_ring_h) / 2, 0])
        square([bracket_ring_h, wide_tray_tab], center = true);
      translate([- (power_tray_size.x + bracket_ring_h) / 2, 0])
        square([bracket_ring_h, narrow_tray_tab], center = true);
    }

    for (pb_hole = pb_holes) {
      translate(pb_hole + pb_mount)
        circle(r = pb_hole_r);
    }
  }
}

// Pi tray 2d pattern
module pi_tray_2d() {
  // Tabs fit into the bracket slots
  tab_x = pi_tray_size.x - 2 * bracket_ring_h - 2 * bracket_bolt_h;
  tab_y = tube_r_inside * 2 - 2;

  difference() {
    union() {
      square([pi_tray_size.x, pi_tray_size.y], center = true);

      // Tabs fit into bracket slots
      translate([(pi_tray_size.x + bracket_ring_h) / 2, 0])
        square([bracket_ring_h, wide_tray_tab], center = true);
      translate([- (pi_tray_size.x + bracket_ring_h) / 2, 0])
        square([bracket_ring_h, wide_tray_tab], center = true);
    }

    for (pi_hole = pi_holes) {
      translate(pi_hole + pi_mount)
        circle(r = pi_hole_r);
    }
  }
}

// Crossbars to hold trays
module crossbars_2d(slot_w, bar_x = 2.5, bar_y = 42) {
  translate_x = (slot_w + bar_x) / 2;
  translate([translate_x, 0]) square([bar_x, bar_y], center = true);
  translate([- translate_x, 0]) square([bar_x, bar_y], center = true);
}

// Bracket ring 2d pattern
module bracket_ring_2d() {
  // Ring attaches to flange
  difference() {
    circle(r = bracket_r);
    circle(r = bracket_r - bracket_w);

    // Holes
    translate([0, flange_hole_offset]) circle(r = 1.5);
    translate([0, - flange_hole_offset]) circle(r = 1.5);
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
// TODO add top bottom brackets
module battery_cradle() {
  cradle_w = 5;

  difference() {
    cube([cradle_w, battery_d - 5, cradle_h], center = true);
    translate([0, 0, cradle_h / 2])
      rotate([0, 90, 0])
        cylinder(r = battery_r, h = cradle_w + 1, center = true);
  }
}

// Power tray
module power_tray() {
  cradle_offset = 23;

  linear_extrude(height = power_tray_size.z)
    power_tray_2d();

  translate([cradle_offset, 0, cradle_h / 2])
    battery_cradle();

  translate([- cradle_offset, 0, cradle_h / 2])
    battery_cradle();
}

// Pi tray
module pi_tray() {
  linear_extrude(height = pi_tray_size.z)
    pi_tray_2d();
}

// Bracket for the penetration flange
module pen_bracket() {
  linear_extrude(height = bracket_ring_h)
    union() {
      bracket_ring_2d();

      // Crossbars to hold power tray
      translate([power_tray_offset_adj, 0])
        crossbars_2d(power_tray_size.z);

      // Crossbars to hold pi tray
      translate([pi_tray_offset_adj, 0])
        crossbars_2d(pi_tray_size.z);
    }
}

// Bracket for the camera flange
module cam_bracket() {
  linear_extrude(height = bracket_ring_h)
    union() {
      bracket_ring_2d();

      // Crossbars to hold power tray, wider to support the camera mount
      translate([power_tray_offset_adj, 0])
        crossbars_2d(power_tray_size.z, bar_x = 8.5, bar_y = 37);

      // Crossbars to hold pi tray
      translate([pi_tray_offset_adj, 0])
        crossbars_2d(pi_tray_size.z);
    }

  // This translation is critical: the camera should be directly under the dome
  translate([- 6, 0, 0])
    linear_extrude(height = 20)
      cam_mount_2d();
}
