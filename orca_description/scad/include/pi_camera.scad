include <pcb.scad>

// PCB
cam_x = 25;
cam_y = 23.86;
cam_z = 1;
cam_corner_r = 1.5;

// Mount holes
cam_hole_edge = 1.5;  // Distance from edge to center of mount hole
cam_hole_d = 1.8;
cam_hole_r = cam_hole_d / 2;
cam_hole_x = cam_x / 2 - cam_hole_edge;
cam_hole_y = cam_y / 2 - cam_hole_edge;
cam_holes = [for (i = [- cam_hole_x, cam_hole_x - 7], j = [- cam_hole_y, cam_hole_y]) [i, j]];

// Components, see pcb.scad::pcb_component()
csi_socket = [4, 20, 1.8, "Ivory"];
csi_clip = [1, 20, 1.8, "DimGray"];
camera = [8.4, 8.4, 4.5, "Gray"];

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
      pcb_hole(cam_hole[0], cam_hole[1], cam_hole_r, cam_z);
    }
  }

  pcb_component(csi_socket, 9, 0);
  pcb_component(csi_clip, 11.5, 0);
  pcb_component(camera, 4, 0, board_h = -4.5);  // On the bottom of the board
}
