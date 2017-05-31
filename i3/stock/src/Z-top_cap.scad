difference() {
    hull(){
        translate([4,4,0])
            cylinder(6,4,4);
        translate([33, 4, 0])
            cylinder(6,4,4);
        translate([4.25, 12.25, 0])
            rotate([0,0,45])
            cube(6);
        translate([32.75,12.25,0])
            rotate([0,0,45])
            cube(6);
    }
    translate([9,9,-.5])
        cylinder(7,1.75,1.75, $fn=20);
    translate([28.5,9,-.5])
        cylinder(7,1.75,1.75, $fn=20);
}