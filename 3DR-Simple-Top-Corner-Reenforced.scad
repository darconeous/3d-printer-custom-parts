

//import("/Users/darco/Projects/3DR-Delta-Printer/stl/3DR_LCD_Adapter_RichRap_V2_001_RTP.stl");
//import("/Users/darco/Projects/3DR-Delta-Printer/stl/3DR_LCDXXL_Base_RichRap_V2_001_RTP.stl");

//translate([0,3,20])rotate([-90,0,-90])color("red")cylinder(h=92.6,$fn=24);


//rotate([0,0,-0.75])translate([-46.2,-1,0])rotate([0,0,-45]){
//import("/Users/darco/Projects/3DR-Simple-Delta-Printer/STL/Top/Wings.STL");
//import("/Users/darco/Projects/3DR-Simple-Delta-Printer/STL/Top/Wing Mirror Long Top.STL");
//}

import("/Users/darco/Projects/3DR-Simple-Delta-Printer/STL/Top/3DR Bottom Motor Mount.STL");



//color("red")
translate([59,45,0.2]) difference() {
	cube([18,4,20.9]);
	//translate([9,0,0])rotate([0,45,0])cube([10,10,10],center=true);
	translate([9,0,2.9])rotate([90,0,0])cylinder(h=10, d=8, center=true, $fn=32);
	translate([5.5,0,13.4])rotate([90,0,0])cylinder(h=10, d=8, center=true, $fn=32);
}

translate([53,20,14]) {
	cube([6.5,7,10.1]);
	translate([-29,0,0])cube([6.5,7,10.1]);
}