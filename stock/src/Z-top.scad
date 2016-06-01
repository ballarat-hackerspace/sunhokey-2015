
module buildTop() {
    difference() {
        topBase();
        translate([28.5,11,-0.5])
            screwCutout();
        translate([8.45,11,-0.5])
            screwCutout();
        translate([18.5,11,-0.5])
            cylinder(7,4.25,4.25, $fn=20);
        translate([36.8574,48.9,-0.5])
            cubeCutout();
        translate([32,52.15,-0.5])
            screwCutout();
        translate([51.45,66.9,-0.5])
            cubeCutout();
        translate([21,48.9,-0.5])
            cubeCutout();
        translate([54.2,61.15,-0.5])
            screwCutout();
    }
}

module topBase() {
    union() {
        difference() {
            hull() {
                translate([5,0,0])
                    rotate([0,0,45])
                        cube([7,7,6]);
                translate([55,70,0])
                    rotate([0,0,45])
                        cube([7,7,6]);
                translate([5,70,0])
                    rotate([0,0,45])
                        cube([7,7,6]);
                translate([32,0,0])
                    rotate([0,0,45])
                        cube([7,7,6]);
                translate([55,26,0])
                    rotate([0,0,45])
                        cube([7,7,6]);
            }
            translate([37,0,-0.5])
                cube([20,26,7]);
        }
        translate([37,21,0])
            rotate([0,0,45])
                cube([7,7,6]);
    }
}

module cubeCutout()
    cube([6.25,6.25,7]);

module screwCutout()
    cylinder(7,1.75,1.75, $fn=20);

buildTop();
