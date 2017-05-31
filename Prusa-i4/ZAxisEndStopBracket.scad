// Z Axis End Stop for a Sinhokey Prusa I4

$fn=60;

longLength=57.6;
shortLength=19.3;
height=8.3;
thickeness=5.43;
smallDiameter=3.1;
largeDiameter=3.6;

difference() {
    cube(size=[longLength,thickeness,height]);
      rotate([90,0,0]){
        translate( [39.1, height/2,-6])
            cylinder(r=smallDiameter/2,h=7);
        translate( [48.7,height/2,-6])
            cylinder(r=smallDiameter/2,h=7);
          
        }
}

difference (){
    cube(size=[5.4,shortLength,8.3]);
      rotate([0,90,0]){
        translate( [-height/2, 8.3+largeDiameter/2,-1])
            cylinder(r=largeDiameter/2,h=7);
      }
}