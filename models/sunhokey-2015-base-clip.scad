//#translate([-16, -15 ,0]) import("/home/bhack/STL/Lock_Down_Clip.stl", convexity=3);

$fn = 32; // detail

$width = 26; // how long / wide the object is
$basewidth = 33; // how big the feet are

$height = 23.3;  // Woot! This is awesome.


module screwhole () {
    union() {
        //cylinder(r2 = 3.5, r1 = 1, h=2, center=true);
        translate([0, 0, 1.75]) #cylinder(d=7.2, h=2.5, center=true); // used to be 2, for a large top gap
        translate([0, 0, -3.5]) cylinder(d=3.5, h=7, center=false); // inner screw hole
    }
}


difference() {
    // Main Body
    union() {
        translate([0, 0, $height-4]) rotate([0, 90, 90]) cylinder(d=16, h=$width, center=true);
        translate([-7.5, -$width/2, 0]) cube([15, $width, $height-4], center=false) ;

        // Bottom Plate
        translate([-$basewidth/2, -$width/2, 0]) cube([$basewidth, $width, 6.5], center=false) ;
    }

    // Main body cutout 
    union() {
        translate([0, 0, $height-4]) rotate([0, 90, 90]) cylinder(d=8, h=40, center=true);
        #translate([-$width/6.5, -$width/1.5, 0]) cube([8, $width*2, $height-4], center=false) ;
        // Height Minus the center point of the Cylinder at the top
    }
    
    translate([12, $width/3-.5, 3.5]) screwhole();
    translate([12, -$width/3+.5, 3.5]) screwhole();
    
    translate([-12, $width/3-.5, 3.5]) screwhole();
    translate([-12, -$width/3+.5, 3.5]) screwhole();
}





    