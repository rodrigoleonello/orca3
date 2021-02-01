include <pcb.scad>

// PCB
cam_x = 25;
cam_y = 23.2;
cam_z = 1;
cam_corner_r = 1.5;

// Mounting holes are tricky because they are not on the 4 corners of the board
cam_hole_edge = 1.5;  // Distance from edge to center of mount hole
cam_hole_d = 1.8;
cam_hole_r = cam_hole_d / 2;
cam_hole_x = cam_x / 2 - cam_hole_edge;
cam_hole_y = cam_y / 2 - cam_hole_edge;
cam_offset_x = 9.5;

cam_holes = [
    [- cam_hole_x, - cam_hole_y],
    [- cam_hole_x, cam_hole_y],
    [cam_hole_x - cam_offset_x, - cam_hole_y],
    [cam_hole_x - cam_offset_x, cam_hole_y]];

//echo("x sep should be ~12.5, is ", cam_holes[2].x - cam_holes[0].x);
//echo("y sep should be ~20.2, is ", cam_holes[1].y - cam_holes[0].y);

cam_origin = [1.5, 0];

// Components, see pcb.scad::pcb_component()
csi_socket = [4, 20, 1.8, "Ivory"];
csi_clip = [1, 20, 1.8, "DimGray"];
camera = [8, 8, 4.5, "Gray"];

// Old version
module pi_camera_0() {
  union() {
    translate([- 25 / 2 + 2.5, - 10, 22.3]) cube([20, 5, 2.5]);
    translate([- 25 / 2, - 10, 22.3]) cube([25, 24.5, 1]);
    cylinder(h = 22.3, r = 8.3);
  }
}

module pi_camera() {
  color("LimeGreen") difference() {
    pcb(cam_x, cam_y, cam_z, cam_corner_r);

    for (cam_hole = cam_holes) {
      pcb_hole(cam_hole.x, cam_hole.y, cam_hole_r, cam_z);
    }
  }

  pcb_component(csi_socket, 9, 0, board_h = cam_z);
  pcb_component(csi_clip, 11.5, 0, , board_h = cam_z);

  // Camera is on the underside, facing down
  pcb_component(camera, cam_origin.x, cam_origin.y, board_h = - 4.5);
}
