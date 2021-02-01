include <pcb.scad>

pb_z = 1.5;
pb_hole_r = 1.5;
pb_hole_x = 36.2 / 2 - 2.5;
pb_hole_y = 17.65 / 2;
pb_holes = [for (j = [- pb_hole_y, pb_hole_y]) [pb_hole_x, j]];

battery_d = 18;
battery_r = battery_d / 2;
battery_h = 69;

// Adafruit Powerboost 1000 Charger
// https://www.adafruit.com/product/2465
module power_boost() {
  color("#0232c3") difference() {
    pcb(36.2, 22.86);

    for (pb_hole = pb_holes) {
      pcb_hole(pb_hole.x, pb_hole.y, pb_hole_r, pb_z);
    }
  }

  pcb_component(micro_usb, 36.2 / 2 - 2, 0);
  pcb_component(jst2, 7.5, - 8, 90);
}

// Adafruit Lithium Ion Cylindrical Battery - 3.7v 2200mAh
// https://www.adafruit.com/product/1781
module battery() {
  color("#5252b4") cylinder(h = battery_h, r = battery_r);
}
