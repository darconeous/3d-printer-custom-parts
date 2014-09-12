



M3HoleDiameter = 3.7;

module Trigger() {
difference() {
union() {
	cylinder(h=2,d=6,$fn=16);
	translate([0,-3,0])cube([6,6,2]);
	translate([3.9,-3,0])rotate([0,6,0])cube([2,20,10]);
}
	cylinder(h=2.1,d=M3HoleDiameter,$fn=16);
	translate([-25,-25,-5])cube([50,50,5]);
	translate([0,-5,0])rotate([-45,0,0])translate([-10,-20,0])cube([20,20,20]);
	translate([-5,5,3])cube([20,11,0.2]);
	translate([-5,5,0])cube([20,1,3]);
}

}


for(i = [0,1,2]) {
	translate([12*i,0,0]) Trigger();
}