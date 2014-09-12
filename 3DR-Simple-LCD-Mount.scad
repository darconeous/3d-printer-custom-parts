
BracketHeight=3.5;
tol=0.2;
M3HoleDiameter = 3.5;
M3NutDiameter = 6.7;
Diameter = 10;
Extend = 2;

MountHoleDistance=92.96;
//MountHoleDistance=93.8;

module LCDMount() {
	MountHoleDistance=71.5;
	$fn=32;
	difference() {
		hull() {
			translate([-MountHoleDistance/2,0,0]) cylinder(h=BracketHeight, d=Diameter);
			translate([ MountHoleDistance/2,0,0]) cylinder(h=BracketHeight, d=Diameter);
		}
		translate([-MountHoleDistance/2,0,0]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter);
		translate([ MountHoleDistance/2,0,0]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter);
		translate([-MountHoleDistance/2,0,BracketHeight]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter*2);
		translate([ MountHoleDistance/2,0,BracketHeight]) cylinder(h=BracketHeight+Diameter, d=8);
	}

	difference() {
		union() {
			translate([0,0,Diameter/2+Extend+BracketHeight])rotate([0,90,0])cylinder(h=60,d=Diameter,center=true);
			translate([-60/2,-Diameter/2,BracketHeight])cube([60,Diameter,Diameter/2+Extend],center=false);
		}
		translate([0,0,Diameter/2+Extend+BracketHeight])rotate([0,90,0])cylinder(h=100,d=M3HoleDiameter,center=true);
		translate([0,0,Diameter-6+BracketHeight])cube([50+tol/2,Diameter+2,Diameter*2+Extend*2+10],center=true);
	}
}

module TDRSimpleMount() {
	$fn=32;
	CurveFactor=2;
	difference() {
		hull() {
			translate([-MountHoleDistance/2,0,0]) cylinder(h=BracketHeight, d=Diameter+1);
			translate([ MountHoleDistance/2,0,0]) cylinder(h=BracketHeight, d=Diameter+1);
			translate([-50/2+tol/4,-Diameter/2,0])cube([50-tol/2,Diameter,Diameter],center=false);
		}
		translate([-MountHoleDistance/2,0,0]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter);
		translate([ MountHoleDistance/2,0,0]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter);
		translate([-MountHoleDistance/2,0,BracketHeight]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter*2);
		translate([ MountHoleDistance/2,0,BracketHeight]) cylinder(h=BracketHeight+Diameter, d=M3HoleDiameter*2);
		translate([-MountHoleDistance/2,0,-0.01]) cylinder(h=2, d=8.1);
		translate([ MountHoleDistance/2,0,-0.01]) cylinder(h=2, d=8.1);
	}

	difference() {
		union() {
			translate([0,Diameter/CurveFactor+Extend,Diameter/2])rotate([0,90,0])cylinder(h=50-tol/2,d=Diameter*CurveFactor,center=true);
//			translate([0,Diameter+Extend,Diameter/2])rotate([0,90,0])cylinder(h=50-tol/2,d=Diameter,center=true);
			translate([-50/2+tol/4,-Diameter/2,0])cube([50-tol/2,Diameter+Diameter/2+Extend,Diameter],center=false);
		}
		translate([-MountHoleDistance,-MountHoleDistance,-Diameter])cube([MountHoleDistance*2,MountHoleDistance*2,Diameter]);
		translate([-MountHoleDistance,-MountHoleDistance,Diameter])cube([MountHoleDistance*2,MountHoleDistance*2,Diameter]);
		translate([0,Diameter+Extend,Diameter/2])rotate([0,90,0])cylinder(h=50,d=M3HoleDiameter,center=true);
		translate([-40/2+tol/4,Diameter/2,0])cube([40-tol/2,Diameter+Diameter/2+Extend,Diameter*4],center=false);
		translate([0,Diameter+Extend,Diameter/2])rotate([0,90,0])cylinder(h=44,d=M3NutDiameter,$fn=6,center=true);
	}
}


translate([0,25+Extend,0])LCDMount();

TDRSimpleMount();