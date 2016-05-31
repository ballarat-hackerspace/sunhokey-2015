$fn=100;

// MX UTILITIES
function mX_dia(s=3) = s+0.2;
function mX_head_dia(s=3) = s+3;

module mX_slot_thread(size=3, depth=5) {
    cylinder(d=size, h=depth, center=true);
}
    
module mX_slot(size=3, width=10, depth=5, recess=5) {
    union() {
        cylinder(d=mX_dia(size), h=depth, center=true);
        translate([0, 0, (depth-recess)/2])
            cylinder(d=mX_head_dia(size), h=recess, center=true);
    }
}

module m3_t_slot() {
    union() {
        cube([10, 3.8, 7], center=true);
        cube([2.65, 6, 7], center=true);
    }
}

module m4_rail_holes() {
    translate([-9, 0, -12]) rotate([90, 0, 0]) cylinder(d=5.2, h=7, center=true);
    translate([-9, 0, 12]) rotate([90, 0, 0]) cylinder(d=5.2, h=7, center=true);
    translate([9, 0, -12]) rotate([90, 0, 0]) cylinder(d=5.2, h=7, center=true);
    translate([9, 0, 12]) rotate([90, 0, 0]) cylinder(d=5.2, h=7, center=true);
}

module foo() {
    union() {
        difference() {
            cube([60, 40, 6], center=true);
            cylinder(r1=7, r2=12, h=6, center=true);
            
            translate([-25.5, 0, 0]) cylinder(r1=3, r2=4, h=6, center=true);
            translate([25.5, 0, 0]) cylinder(r1=3, r2=4, h=6, center=true);
            
            translate([25, -11, 0]) m3_t_slot();
            
            translate([25, 11, 0]) m3_t_slot();
        }
        
        translate([0, -23, -3]) difference() {
            cube([60, 6, 12], center=true);
            translate([-16, 0, -3]) rotate([90, 0, 0]) cylinder(d=3.2, h=7, center=true);
            translate([16, 0, -3]) rotate([90, 0, 0]) cylinder(d=3.2, h=7, center=true);
        }
    }
}

module carriage_arm() {
    difference() {
        cube([12, 23.6, 6], center=true);
        
        //translate([0, 3.7, 0]) cylinder(d=3.2, h=7, center=true);
        translate([0, -6.9, 0]) rotate([0, 0, 90]) m3_t_slot();
    }
}

module carriage() {
    difference() {
        union() {
            // main back
            cube([60, 6, 80], center=true);
            
            translate([-24, -9, 37])  carriage_arm();
            translate([24, -9, 37])   carriage_arm();
            translate([-24, -9, -37]) carriage_arm();
            translate([24, -9, -37])  carriage_arm();
        }
        
        translate([0, 0, -0.2]) {
            // hotend carriage hole
            rotate([90, 0, 0]) cylinder(d=3.6, h=7, center=true);
            
            // hotend carriage slots
            translate([-15.5, 0, 0]) cube([15.3, 7, 6.4], center=true);  // left
            translate([15.5, 0, 0]) cube([15.3, 7, 6.4], center=true);   // right
        }
            
        // rail holes
        translate([0, 0, -21.5]) m4_rail_holes();  // bottom
        translate([0, 0, 23.5]) m4_rail_holes();   // top
        
        // direction arrow
        translate([0, 0, -22.5]) rotate([0, 90, 90]) cylinder(8, 5, 5, $fn=3, center=true);

        
        // edge cutouts
        for (s = [-32, 16, 32]) {
            translate([25, 0, s]) rotate([90, 0, 0]) m3_t_slot();
        }
        for (s = [-32, -16, 16, 32]) {
            translate([-25, 0, s]) rotate([90, 0, 0]) m3_t_slot();
        }
    }        
}

module carriage_back() {
    difference() {
        union() {
            // main back
            cube([60, 6, 80], center=true);
            
            translate([-24, 3, 32]) cube([12, 12, 4], center=true);
            translate([24, 3, 32])  cube([12, 12, 4], center=true);
            translate([-24, 3, -32])  cube([12, 12, 4], center=true);
            translate([24, 3, -32])  cube([12, 12, 4], center=true);
        }
    
        // mount holes
        translate([-24, 2, 37])  rotate([90, 0, 0]) mX_slot(depth=16);
    
   translate([24,  2, 37])  rotate([90, 0, 0]) mX_slot(depth=16);
        translate([-24, 2, -37]) rotate([90, 0, 0]) mX_slot(depth=16);
        translate([24,  2, -37]) rotate([90, 0, 0]) mX_slot(depth=16);
        
        // spare holes
        for (s = [-37, -8, 8, 37]) {
            translate([16, 0, s])  rotate([90, 0, 0]) mX_slot_thread(depth=16);
            translate([0, 0, s])  rotate([90, 0, 0]) mX_slot_thread(depth=16);
            translate([-16, 0, s]) rotate([90, 0, 0]) mX_slot_thread(depth=16);
        }
        
        // edge cutouts
        for (s = [-16, 16]) {
            translate([25, 0, s]) rotate([90, 0, 0]) m3_t_slot();
            translate([-25, 0, s]) rotate([90, 0, 0]) m3_t_slot();
        }
        
        // rails coutouts
        translate([0, 48, 23.5]) cube([34, 100, 20], center=true);
        translate([0, 48, -21.5]) cube([34, 100, 20], center=true);
        translate([0, 50, 0]) cube([50, 100, 10], center=true);
        
        // direction arrow
        translate([0, 0, -22.5]) rotate([0, 90, 90]) cylinder(8, 5, 5, $fn=3, center=true);
    }    
}


//carriage();

//translate([0, -35, 0])
    carriage_back();
