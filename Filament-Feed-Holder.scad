


$fn=16;
Angle=60;

module Mount() {
	difference() {
		union() {
			translate([0,0,0])cube([20,30,5]);
			translate([7.5,0,0])cube([5,30,6]);
		}
		translate([10,8,-0.1])cylinder(h=10,d=4.5);
	}
}


difference() {
	translate([-8,-8,0])cube([28,16,14]);
	cylinder(h=20, d1=5,d2=2.5,center=true);
	translate([0,0,8])cylinder(h=20, d=9.75);

	translate([22,10,0])rotate([0,-Angle,180])cube([20,20,20]);
}

difference() {
	translate([20,22,-2.5])rotate([0,-Angle,180])Mount();
	translate([0,0,-5])cube([100,100,10],center=true);
}