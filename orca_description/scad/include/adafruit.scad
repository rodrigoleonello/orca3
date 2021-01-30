include <pcb.scad>

// Adafruit Powerboost 1000 Charger
// https://www.adafruit.com/product/2465
module power_boost() {
  hole_x = 36.2 / 2 - 2.5;
  hole_y = 17.65 / 2;

  color("#0232c3") difference() {
    pcb(36.2, 22.86);
    pcb_hole(hole_x, hole_y, 1.5);
    pcb_hole(hole_x, - hole_y, 1.5);
  }

  pcb_component(micro_usb, 36.2 / 2 - 2, 0);
  pcb_component(jst2, 7.5, - 8, 90);
}

// Adafruit Lithium Ion Cylindrical Battery - 3.7v 2200mAh
// https://www.adafruit.com/product/1781
module battery() {
  color("#5252b4") cylinder(h = 69, r = 9);
}
