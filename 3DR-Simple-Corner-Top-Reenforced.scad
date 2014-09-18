module cube_center(size,center_x=true,center_y=true) {
	translate([center_x?-size.x/2:0,center_y?-size.y/2:0,0])cube(size);
}


module TSlot(height=5, size=20, expand=0.5) {
	difference() {
		cube_center([size+expand,size+expand,height]);
		for(deg = [0,90,180,270]) rotate([0,0,deg]) {
			translate([size/4+size/8,0,-0.05])
			cube_center([size/4,size/4,height+0.1],center_x=false);
			translate([size/4,0,-0.05])
			cube_center([size/8+0.1,size/2,height+0.1],center_x=false);
		}
	}
	for(deg = [0,90]) rotate([0,0,deg+45]) {
		translate([0,0,-0.05])
		cube_center([size,size/8,height+0.1]);
	}
}


difference()
{
import("../3DR-Simple-Delta-Printer/STL/Top/3DR Bottom Motor Mount.STL");
translate([42,13.75,0])
TSlot(height=80, size=20, expand=0.5);
}

//color("red")
translate([59,45,0.2]) difference() {
	cube([18,4,20.9]);
	translate([9,0,2.9])rotate([90,0,0])cylinder(h=10, d=8, center=true, $fn=32);
	translate([5.5,0,13.4])rotate([90,0,0])cylinder(h=10, d=8, center=true, $fn=32);
}

translate([53,20,14]) {
	cube([6.5,7,10.1]);
	translate([-29,0,0])cube([6.5,7,10.1]);
}