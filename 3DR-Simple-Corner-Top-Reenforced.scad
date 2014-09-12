import("../3DR-Simple-Delta-Printer/STL/Top/3DR Bottom Motor Mount.STL");

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