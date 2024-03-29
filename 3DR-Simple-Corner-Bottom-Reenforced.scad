
module cube_center(size,center_x=true,center_y=true) {
	translate([center_x?-size.x/2:0,center_y?-size.y/2:0,0])cube(size);
}


module TSlot(height=5, size=20, expand=0.5) {
	union() {
	difference() {
		cube_center([size+expand,size+expand,height]);
		for(deg = [0,90,180,270]) rotate([0,0,deg]) {
			translate([size/4+size/8,0,-0.05])
			cube_center([size/4+expand,size/4-expand,height+0.1],center_x=false);
			translate([size/4,0,-0.05])
			cube_center([size/8+0.1,size/2,height+0.1],center_x=false);
		}
	}
	for(deg = [0,90]) rotate([0,0,deg+45]) {
		translate([0,0,-0.05])
		cube_center([size,size/8,height+0.1]);
	}
	}
}


difference()
{
translate([-42,-13.75,0])
import("../3DR-Simple-Delta-Printer/STL/Simple Parts/3DR Bottom Motor Mount Simple.STL",convexity=4);
union() {
	TSlot(height=80, size=20, expand=0.5);
	hull() {
		rotate([0,45,0])cube([14.3,10,14.3],center=true);
		translate([0,0,8])rotate([0,45,0])cube([14.3,10,14.3],center=true);
	}

	hull() {
	hull() {
		rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
		translate([0,0,6])rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
	}
	translate([0,-4.75,0])
	hull() {
		rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
		translate([0,0,15])rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
	}
	}
	hull() {
	hull() {
		rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
		translate([0,0,6])rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
	}
	translate([0,4.75,0])
	hull() {
		rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
		translate([0,0,15])rotate([0,45,0])cube([14.3,0.1,14.3],center=true);
	}
	}
}
}


translate([-42,-13.75,0])
translate([56.5,22.1,25+7]) {
difference()
{
	union() {
		hull() {
			translate([  0+8.0,0.2,-10])cylinder(h=12.1-7,d=12,$fn=32);
			                    rotate([0,45,0])cube([23,6,8.1],center=true);
		}
		hull() {
			translate([-29-8.0,0.2,-10])cylinder(h=12.1-7,d=12,$fn=32);
			translate([-29,0,0])rotate([0,-45,0])cube([23,6,8.1],center=true);
		}
	}
	translate([-26,-4,-20])cube([23,9,80]);

	translate([  0+8,0,-20])cylinder(h=21.8-7,d=9,$fn=32);
	translate([-29-8,0,-20])cylinder(h=21.8-7,d=9,$fn=32);
}

translate([0,29.9,-3])
difference()
{
	union() {
	translate([  0+8,0,0])rotate([0,45,0])translate([8,0,0])cube([23,6,8],center=true);
	translate([-29-8,0,0])rotate([0,-45,0])translate([-8,0,0])cube([23,6,8],center=true);

	translate([  0+8,0,-10])translate([8,0,0])cube([23,6,9],center=true);
	translate([-29-8,0,-10])translate([-8,0,0])cube([23,6,9],center=true);
	}
//	translate([-25,-4,-20])cube([22.5,8,40]);
//	translate([  0+8,0,-20])cylinder(h=21.8-7,d=9,$fn=32);
	translate([  0+26.5,0,-10])rotate([0,0,15])cube([12,12,12],center=true);
	translate([-29-26.5,0,-10])rotate([0,0,-15])cube([12,12,12],center=true);
}
}
