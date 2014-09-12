
module Platform() {
	flipped=false;
	include <New-3DR-Simple-Platform.scad>
}

module BlowerMount() {
	rotate([0,-90,0])
	//translate([0,-32.2,0])
	{
		difference() {
			hull()
			{
				translate([0,0,-4])cylinder(h=16,r=5);
				translate([-10,-4,12])rotate([180,0,0])cube([15,18,16]);
				//translate([0,-37,-13])rotate([0,90,0])cylinder(h=20,d=50,center=true);
			}
			translate([0,0,-0.1])cylinder(h=8.2,r=9);
			translate([0,0,-10])cylinder(h=30,d=3.6,$fn=16);
			translate([-10,-10,-38])cube([20,20,34]);
			translate([-15/2,-62.1,-38.05])cube([15,50.1,50.1]);
				translate([0,-37,-13])rotate([0,90,0])cylinder(h=15,d=60,center=true);
//			translate([0,-36,-13])rotate([0,90,0])cylinder(h=30,d=35,center=true);
			translate([0,-17,7])rotate([0,90,0])cylinder(h=30,d=3.6,center=true,$fn=16);
			translate([-8,2.5,-10])cube([15,15,15]);
		}
	}
}

//%Platform();
BlowerMount();
