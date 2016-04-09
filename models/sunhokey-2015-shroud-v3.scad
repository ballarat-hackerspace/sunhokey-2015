$fn=75;

// MX UTILITIES
function mX_dia(s=3) = s+0.2;
function mX_head_dia(s=3) = s+3;

module mX_slot_thread(size=3, depth=5) {
    cylinder(d=size, h=depth, center=true);
}
    
module mX_slot(size=3, width=10, depth=5, recess=2, adjust=0) {
    union() {
      hull() {
        cylinder(d=mX_dia(size), h=depth, center=true);
        translate([adjust, 0, 0]) cylinder(d=mX_dia(size), h=depth, center=true);
      }
        
      translate([0, 0, (depth-recess)/2])
        hull() {
          cylinder(d=mX_head_dia(size), h=recess, center=true);
          translate([adjust, 0, 0])
            cylinder(d=mX_head_dia(size), h=recess, center=true);
        }
    }   
  
}

module m3_t_slot() {
    union() {
        cube([10, 3.8, 7], center=true);
        cube([2.65, 6, 7], center=true);
    }
}


module air_holes() {
  for (s = [0 : 15 : 360])
    rotate([0, 0, s]) translate([0, 0, -8]) rotate([75, 0, 0])
      cylinder(d=2.5, h=29);
}


module shroud_torus_inner() {
  // inner inverted circle ring cutout
  difference() {
    rotate_extrude() translate([16, -3, 0]) square([10, 3]);
    rotate_extrude() translate([17, 0, 0]) circle(d=6.6);
  }  
}

module shroud_torus_outer($diff=false) {
  // outer ring
  if ($diff) {
    difference() {
      rotate_extrude() translate([26, 0, 0]) hull() {
        translate([0, 1, 0]) circle(d=8);
        translate([-3, 0, 0]) circle(d=6);
      }
  
      rotate([90, 0, 0]) cylinder(r1=0, r2=40, h=50, centre=true);
    }
  }
  else {
    rotate_extrude() translate([26, 0, 0]) hull() {
      translate([0, 1, 0]) circle(d=8);
      translate([-3, 0, 0]) circle(d=6);
    }
  }
}

module shroud_torus_void($diff=false) {
  // internal ring void
  if ($diff) {
    difference() {
      rotate_extrude() translate([26, 0, 0]) hull() {
        translate([0, 1, 0])  circle(d=5);
        translate([-3, 0, 0]) circle(d=4);
      }
  
      translate([0, 4, 0]) rotate([90, 0, 0]) cylinder(r1=0, r2=40, h=50, centre=true);
    }
  }
  else {
    rotate_extrude() translate([26, 0, 0]) hull() {
      translate([0, 1, 0]) circle(d=6);
      translate([-3, 0, 0]) circle(d=4);
    }
  }
}

module shroud_torus() {
  shroud_torus_inner();
  shroud_torus_outer();
}

module fan_attachment() {
  $h=12;

  translate([1, 0.7+29.6+10, $h/2+2])
   rotate([0, 90, 90]) {
    // inner bit
     hull() {
       cylinder(d=2, h=$h, center=true);
         translate([15, 11, 0]) cylinder(d=2, h=$h, center=true);
         translate([15, 0, 0]) cylinder(d=2, h=$h, center=true);
         translate([0, 11, 0]) cylinder(d=2, h=$h, center=true);
       }
  
      // outer bit
       translate([0, 0, -7])
         hull() {
           cylinder(d=6, h=$h, center=true);
           translate([16, 11, 0]) cube([6, 6, $h], center=true);
           translate([16, 0, 0])  cube([6, 6, $h], center=true);
           translate([0, 11, 0])  cylinder(d=6, h=$h, center=true);
         }
    }
      
  // base joint to shroud
  translate([11, -6, -7]) {
    rotate([0, 90, 0])
    hull() {
      cylinder(d=8, h=20, center=true);
      translate([0, 28.6, 0]) cube([8, 12, 48], center=true);
    }
  }   
}


module shroud_attachment($diff) {
  if ($diff) {
    difference() {
      hull() {
        cube([32, 6, 6], center=true);
        translate([0, 0, 24]) cube([48, 6, 12], center=true);
      }
    
      translate([-16, 0, 25]) rotate([-90, 90, 0]) mX_slot(depth=6, adjust=10);
      translate([0, 0, 25]) rotate([-90, 90, 0])   mX_slot(depth=6, adjust=10);
      translate([16, 0, 25]) rotate([-90, 90, 0])  mX_slot(depth=6, adjust=10);
  }
  }
  else {
    hull() {
      cube([7, 7, 18], center=true);
      translate([0, 0, 15]) cube([7, 7, 7], center=true);
    }
    translate([0, 0, -3]) rotate([0, 90, 0]) cylinder(d=$m3_hole, h=40, center=true);
    translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(d=$m3_hole, h=40, center=true);
  }
}

module shroud() {
  intersection() {
    shroud_torus();
    shroud_torus_outer(true);
  }

  // fan attachment
  translate([-12.5, 31.5, 8])
    fan_attachment();
    
  // zprobe (type=0: square, type=1: 18mm circle)
  z_probe_attachment(1);
  
  // scaffolding attachment
  translate([0, 55.8, 8]) shroud_attachment(true);
}

module z_probe_attachment(type) {
  if (type == 0) {
    translate([-2.5, 59, -3]) difference() {
      difference() {
        cube([25, 25, 15]);

        // m3 clamp holes
        translate([13, 21.5, 4])  rotate([0, 90, 0]) mX_slot(depth=26, recess=2);
        translate([13, 21.5, 11]) rotate([0, 90, 0]) mX_slot(depth=26, recess=2);
     
        translate([-0.5, 21.5, 4]) rotate([0, 90, 0])  cylinder(r=5.5/2/cos(180/6)+0.05, h=2, $fn=6);
        translate([-0.5, 21.5, 11]) rotate([0, 90, 0]) cylinder(r=5.5/2/cos(180/6)+0.05, h=2, $fn=6);
          
        translate([3.8, 2, -1]) cube([17.4, 25, 17]);
      }
    }
  }
  else if (type == 1) {
    translate([-2.5, 59, -3]) difference () {
      difference() {
        cube([25, 28, 22]);
        translate([8.5, 10, -1]) cube([9, 25, 32]);
        
        // m3 clamp holes
        translate([13, 24, 6])  rotate([0, 90, 0]) mX_slot(depth=26, recess=2);
        translate([13, 24, 16]) rotate([0, 90, 0]) mX_slot(depth=26, recess=2);
     
        translate([-0.5, 24, 6]) rotate([0, 90, 0])  cylinder(r=5.5/2/cos(180/6)+0.05, h=2, $fn=6);
        translate([-0.5, 24, 16]) rotate([0, 90, 0]) cylinder(r=5.5/2/cos(180/6)+0.05, h=2, $fn=6);
      }
      
      translate([13, 12, 0]) cylinder(d=18, h=30);
    }
  }
}

module hotend_shroud() {
  difference() {
    shroud();

    // internal ring void
    shroud_torus_void(true);

    air_holes();

    // fan attachment joint void
    translate([-15.5, 23, 0-10])
      hull() {
        rotate([0, 90, 0]) cylinder(d=4, h=28);
        translate([0-8, 10+40, 0]) rotate([0, 90, 0]) cylinder(d=4, h=15);
      }

    // fan inlet to shroud void
    translate([-13, 30.2+30, 2])
      union() {
        translate([-4, 14, 6]) cube([10, 8, 13], center=true);
        
        hull() {
          cube([8, 1, 5], center=true);
          translate([-4, 10, 6]) cube([10, 1, 13], center=true);
        }
                
        translate([-2, 0, 0]) rotate([90, 0, 12]) cylinder(d=4, h=36);
        translate([2, 0, 0])  rotate([90, 0, 28]) cylinder(d=4, h=40);
      }
  }
}

module rounded_cube($x, $y, $z, $r) {
    hull() {
        translate ([0,  0,  0]) rotate([90, 0, 0]) cylinder(r=$r, h=$y);
        translate ([0,  0, $z]) rotate([90, 0, 0]) cylinder(r=$r, h=$y);
        translate ([$x, 0, $z]) rotate([90, 0, 0]) cylinder(r=$r, h=$y);
        translate ([$x, 0,  0]) rotate([90, 0, 0]) cylinder(r=$r, h=$y);
    }
}

module scaffolding_base() {
    translate([-17, 3.25, 24]) rounded_cube(34, 6.5, 16, 5);
    translate([0, 0, 1]) cube([34, 6.5, 37], center=true);
}

module hotend_attachment_e3dv6() {
  // scaffolding attachment
  translate([0, 24, 9]) {
    difference() {
      difference() {
        translate([0, 0, 26]) {
          // main body
          difference() {
            scaffolding_base();

            // head attachment slits
            translate([-16, 0, 25]) hull() {
              rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
              translate([0, 0, 15])
                rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
            }
            translate([16, 0, 25]) hull() {
              rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
              translate([0, 0, 15])
                rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
            }

            // shave out excess width
            translate([-7.5, 5, 43]) rotate([0, 90, 90]) rounded_cube(48, 15, 10, 5);
            translate([-7, 5, 48]) rotate([90, 0, 90]) rounded_cube(5, 46, 14, 5);
          }
        }

        shroud_attachment(false);
      }

      // shroud attachment cutouts
      translate([12, 5, 0]) rounded_cube(10, 10, 40, 5);
      translate([-22, 5,0]) rounded_cube(10, 10, 40, 5);
    }
  }
}

module hotend_attachment_sunhokey() {
  // scaffolding attachment
  translate([0, 24, 9]) {
    difference() {
      difference() {
        translate([0, 0, 26]) {

          difference() {
            translate([-5.5, 0, 8])
              union() {
                  // main body
                  cube([51, 6.5, 60], center=true);

                  // fan arm
                  translate([-20-3.25, -25+3.25, 20])
                      cube([6.5, 50, 20], center=true);
              }

            // head attachment slits
            translate([-16, 0, 15]) hull() {
              rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
              translate([0, 0, 15])
                rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
            }

            translate([16, 0, 15]) hull() {
              rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
              translate([0, 0, 15])
                rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
            }
            // head attachment slits - end

            // fan attachment slits
            translate([-28.25, -23.25, 8])
            rotate([0, 0, 90]) {
                translate([-16, 0, 15]) hull() {
                  rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
                  translate([0, 0, 10])
                    rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
                }

                translate([16, 0, 15]) hull() {
                  rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
                  translate([0, 0, 10])
                    rotate([90, 0, 0]) cylinder(d=$m3_hole, h=10, center=true);
                }
            }
            // fan attachment slits - end
          }
        }

        shroud_attachment(false);
      }
      
      translate([15, 0, 11])       cube([10, 10, 40], center=true);
      translate([-15-5.5, 0, 11])  cube([10+11, 10, 40], center=true);
    }
  }
}

hotend_shroud();
// hotend_attachment_e3dv6();
// hotend_attachment_sunhokey();
