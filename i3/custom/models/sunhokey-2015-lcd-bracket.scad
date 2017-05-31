$fn=32;

if (0) {
rotate([0, 0, -135])
    translate([-222, -1253, 0])
        import("/home/bhack/STL/SHK-M_LCD_L.stl", convexity=3);
}


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
// MX UTILITIES - END

module lug() {
    difference() {
        hull() {
            translate([0, 0, 4]) cube([8, 8, 8], center=true);
            
            translate([0, 0, -4]) 
            rotate([0, 90, 0])
                cylinder(d=8, h=8, center=true);
        }
        
        translate([0, 0, 4])
            rotate([90, 0, 0])
                cylinder(d=3, h=80, center=true);
        
        translate([0, -2.2, 4])
            rotate([90, 0, 0])
                #cylinder(r=5.5/2/cos(180/6)+0.05, h=2, $fn=6);
    }
}
    
module lugs(flip=false) {
    if (flip) {
        translate([0, 0, -8]) {
            rotate([0, 180, 0])
                lug();

            translate([50, 0, 0])
                rotate([0, 180, 0])
                    lug();
        }
    }
    else {
        lug();
    
        translate([50, 0, 0])
            lug();
    }
}

module hook() {
    union() {
        translate([0, 5+0.1, 0]) 
            cube([8, 10+0.2, 8], center=true);
        
        hull() {
            cylinder(d=8, h=8, center=true);
            translate([20, 0, 0]) cylinder(d=8, h=8, center=true);
        }
    }
}

module body() {
    difference() {
        hull() {
            cube([8, 8, 8], center=true);
            translate([-42.2, 40, 0]) cylinder(d=8, h=8, center=true);
            translate([0, 40, 0]) cylinder(d=8, h=8, center=true);
        }
        
        translate([-10, 30, 0])
            cylinder(d=16, h=8, center=true);
    }
}

module support_l() {
    union() {
        // body
        body();
        
        // hook
        rotate([0, 0, 90])
            translate([0, -16+1.8, 0])
                hook();
        
        // lugs
        translate([-6.6, -1, 4])
            rotate([0, 0, 135])
                lugs();
    }
}

module support_r() {
    union() {
        // body
        body();
        
        // hook
        rotate([0, 0, 90])
            translate([0, -16+1.8, 0])
                hook();
        
        // lugs
        translate([-6.6, -1, 4])
            rotate([0, 0, 135])
                lugs(flip=true);
    }
}


support_r();
