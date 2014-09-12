
import("../3DR-Simple-Delta-Printer/STL/Simple Parts/3DR Bottom Motor Mount Simple.STL");

translate([56,22.1,25+7])
difference()
{
	union() {
	                    rotate([0,45,0])cube([23,6,8.1],center=true);
	translate([-29,0,0])rotate([0,-45,0])cube([23,6,8.1],center=true);
	}
	translate([-25,-4,-20])cube([22.5,8,40]);
	translate([9,0,-20])cylinder(h=21.8-7,d=9,$fn=32);
	translate([-36,0,-20])cylinder(h=21.8-7,d=9,$fn=32);
}