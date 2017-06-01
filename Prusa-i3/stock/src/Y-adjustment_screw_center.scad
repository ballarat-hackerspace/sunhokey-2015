module frame() {
  polyhedron(
   [[ 0, 0, 0],
    [23, 0, 0],
    [15.5,13, 0],
    [7.5,13, 0],
    [ 0, 0, 6],
    [23,0, 6],
    [15.5,13, 6],
    [7.5,13, 6]]
    ,
   [[0,1,2,3],
    [4,5,1,0],
    [7,6,5,4],
    [5,6,2,1],
    [6,7,3,2],
    [7,4,0,3]]);
}
module screwHole() {
    translate([1.75,1.75,-1])
    color("red")
      cylinder(9,1.75,1.75, $fn=20);
};
module screwHeadHold() {
    union() {
      translate([-1.5,7,-1])
        cube([6,3,9]);
      translate([0,-1,-1])
        cube([3,8,9]);
    };
};

difference() {
  minkowski(){
    translate([5,5,0])
      frame();
    cylinder(r=5,1,$fn=25);
  }
  
  translate([15,0,0])
    screwHeadHold();

  translate ([27,3,0])
    screwHole();
  translate([3,3,0])
    screwHole();
}
