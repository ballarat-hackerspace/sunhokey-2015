

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

/*
color([1,0,0])
translate([28.5,11,-0.5])
screwCutout();

color([1,0,0])
translate([8.45,11,-0.5])
screwCutout();

color([1,0,0])
translate([18.5,11,-0.5])
cylinder(7,4,4, $fn=20);

color([1,0,0])
translate([36.75,48.9,-0.5])
cubeCutout();

color([1,0,0])
translate([32,52.15,-0.5])
screwCutout();

color([1,0,0])
translate([51.45,66.9,-0.5])
cubeCutout();

color([1,0,0])
translate([21,48.9,-0.5])
cubeCutout();

color([1,0,0])
translate([54.2,61.15,-0.5])
screwCutout();

*/



/*
//measurements
color([0,1,0])
translate([22.5,9,4])
cube([4.25,4,6]);

color([0,1,0])
translate([10.2,9,4])
cube([4.25,4,6]);

color([0,1,0])
translate([17,0,4])
cube([4,7,6]);

color([0,1,0])
translate([43.45,50,4])
cube([16.25,3,6]);

color([0,1,0])
translate([33.75,50,4])
cube([3,3,6]);

color([0,1,0])
translate([30,53.9,4])
cube([4,26,6]);

color([0,1,0])
translate([27.25,50,4])
cube([3,3,6]);

color([0,1,0])
translate([55.95,59,4])
cube([4,4,6]);

color([0,1,0])
translate([22,55.15,4])
cube([4,24.75,6]);

color([0,1,0])
translate([0,50,4])
cube([21,4,6]);

color([0,1,0])
translate([52,62.9,4])
cube([4,4,6]);

color([0,1,0])
translate([57.7,70,4])
cube([2.25,2.25,6]);

color([0,1,0])
translate([50,73.15,4])
cube([6.75,6.75,6]);
*/