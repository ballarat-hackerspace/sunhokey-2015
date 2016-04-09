difference() {
    // Sunhokey Z-axe End Stop
    // http://www.thingiverse.com/thing:833226/#files
    #import("/home/bhack/STL/sunhokey-2015-z-endswitch.stl", convexity=3);
        
    #translate([-50, 0, 25])
        cube([50,50,50]);
    
}