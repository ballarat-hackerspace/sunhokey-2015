difference() {
    translate([1.5,1.5,0])
    minkowski() {
        cube([25,47,5]);
        cylinder(r=1.5,1,$fn=25);
    }
        translate([14,20,-0.5])
        cylinder(r=4.25,7,$fn=25);
}