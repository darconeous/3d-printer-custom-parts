
module OldCarriage() {
//	sphere(0);
	translate([-32.5,0,0])
	import("/Users/darco/Projects/3DR-Simple-Delta-Printer/STL/Carriage for LM8UU.STL");
}

RodType = "magnetic";
//RodType = "traxxas";

TraxxasNutHeight = 6.96;
TraxxasOffset = TraxxasNutHeight/2;

MountDistance = -15;
MagneticAngle = -45;
MagneticHeight = 8.5;
MagneticWidth = 30;

M3HoleDiameter = 3.6;
M3NutDiameter = 6.7;

MagnetOuterDiameter = 9.8;
MagnetInnerDiameter = 2.75;

SocketDiameter = MagnetOuterDiameter + 3;
BearingDiameter = 9.5;
Blah = 8;
BearingDialation = 0.175;

SnapOutHeight = 0.2;
HalfRodDistance = 45/2;
LinearBearingDiameter = 15;

SmoothRadius = 5;
TraxxasHeight = 6;

//%OldCarriage();

module cube_center(size,center_x=true,center_y=true) {
	translate([center_x?-size.x/2:0,center_y?-size.y/2:0,0])cube(size);
}

module MagneticSocketsOuter () {
	height=200;
	module Sub() {
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=13,d=SocketDiameter,$fn=48);
					}
				hull() {
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=9.6,d=SocketDiameter,$fn=48);
					}
					translate([0,0,-5-MagneticHeight])
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=9.6,d=SocketDiameter,$fn=48);
					}
					translate([0,-10,0])
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=9.6,d=SocketDiameter,$fn=48);
					}
				}
	}
	difference() {
		union() {
			translate([-MagneticWidth/2, -MountDistance, MagneticHeight]) {
				Sub();
/*
				hull() {
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=13,d=SocketDiameter,$fn=48);
					}
					translate([0,0,-5-MagneticHeight])
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=9.6,d=SocketDiameter,$fn=48);
					}
					translate([0,-10,0])
					rotate([MagneticAngle,0,0]) {
						translate([0, 0, -1])
						cylinder(h=9.6,d=SocketDiameter,$fn=48);
					}
				}
*/
			}
			translate([MagneticWidth/2, -MountDistance, MagneticHeight]) {
				Sub();
			}
		}
		translate([0,0,height*1.5])cube([100,100,height],center=true);
		translate([0,0,-height/2])cube([100,100,height],center=true);
	}
}

module MagneticSocketsInner() {
	module Sub() {
		union() {
		//translate([-MagnetOuterDiameter/2,-40,1.5])cube([MagnetOuterDiameter, 40, MagnetOuterDiameter*0.5*sin(-MagneticAngle)+2.9*cos(-MagneticAngle)]);
		rotate([MagneticAngle,0,0]) union() {
/*
			translate([0,0,3])
			cylinder(h=6,d=MagnetOuterDiameter-1,$fn=48);
			translate([0,0,1.5])
			cylinder(h=6.5,d=MagnetOuterDiameter,$fn=48);
*/
		translate([0,0,2]) {
		translate([0,0,9.3]) {
			sphere(d=BearingDiameter+BearingDialation, $fn=48);
			cylinder(h=BearingDiameter, d1=BearingDiameter+BearingDialation, d2=BearingDiameter*1.5, $fn=48);
		}
		translate([0,0,10.7-3])cylinder(h=2.35,d1=MagnetOuterDiameter-2,d2=BearingDiameter+1,$fn=48);
		translate([0,0,3])cylinder(h=6,d=MagnetOuterDiameter-2,$fn=48);

		translate([0,0,-7+Blah-13.25]) difference() {
			cylinder(h=Blah,d=MagnetOuterDiameter,$fn=48);
			for(ang = [0,120,240]) rotate([0,0,ang]) {
				translate([0,MagnetOuterDiameter/2]) cylinder(h=Blah,d1=0.1, d2=0.45,$fn=8);
			}
		}
		}

			hull()
			{
				translate([0,0,1.5])
				cylinder(h=3.5,d=MagnetOuterDiameter,$fn=48);
				translate([0,-40*sin(MagneticAngle+90),-40*cos(MagneticAngle+90)])
				translate([0,0,1.5])
				cylinder(h=3.5,d=MagnetOuterDiameter,$fn=48);
			}
		}
		}
	}
	translate([-MagneticWidth/2, -MountDistance, MagneticHeight]) {
		Sub();
	}
	translate([MagneticWidth/2, -MountDistance, MagneticHeight]) {
		Sub();
	}
}

module FrameOuter() {
	union() {
		translate([HalfRodDistance,6.75,0])cylinder(h=24,d=LinearBearingDiameter+5,$fn=80);
		translate([-HalfRodDistance,6.75,0])cylinder(h=24,d=LinearBearingDiameter+5,$fn=80);
		translate([-HalfRodDistance,3.5,0])cube([HalfRodDistance*2,9.63,24]);

		translate([-7,10,0])cube([4,9.5,24]);
	}
}

module FrameInner() {

	translate([-HalfRodDistance,0,0])cube([HalfRodDistance*2,9.63,25]);

	translate([HalfRodDistance,6.75,0]) union() {
		cylinder(h=24,d=LinearBearingDiameter,$fn=64);
		difference() {
			union() {
				translate([0,0,2])cylinder(h=4,d=24,$fn=128);
				translate([0,0,18.5])cylinder(h=4,d=24,$fn=128);
			}
			cylinder(h=40,d=LinearBearingDiameter+5,$fn=128);
		}
		rotate([0,0,-45+180])translate([-10-4,0,0])cube([20,20,24]);
	}

	translate([-HalfRodDistance,6.75,0]) union() {
		cylinder(h=24,d=LinearBearingDiameter,$fn=64);
		difference() {
			union() {
				translate([0,0,2])cylinder(h=4,d=24,$fn=128);
				translate([0,0,18])cylinder(h=4,d=24,$fn=128);
			}
			cylinder(h=40,d=LinearBearingDiameter+5,$fn=128);
		}
		rotate([0,0,45+180])translate([-10+4,0,0])cube([20,20,24]);
	}

	union() {
		translate([-8,13.15,14])cube([6,3,6]);
		translate([-8,13.15,4])cube([6,3,6]);

		translate([-8,13.25,8])cube([6,6,SnapOutHeight]);
		translate([-8,13.25,10-SnapOutHeight])cube([6,6,SnapOutHeight]);

		translate([-8,13.25,14])cube([6,6,SnapOutHeight]);
		translate([-8,13.25,16-SnapOutHeight])cube([6,6,SnapOutHeight]);
	}
}

module LimitSwitchBolt(pos=[12,20,-0.01]) {
	translate(pos) {
		cylinder(h=6.25, d=M3HoleDiameter, $fn=16);
		translate([0,0,2]) hull() {
			cylinder(h=2.5, d=M3NutDiameter, $fn=6);
			translate([-3,0,0])cylinder(h=2.5, d=M3NutDiameter, $fn=6);
		}
	}
}

module TraxxasOuter () {
	difference() {
		union() {
			translate([0,13,0]) cube_center([34,13.25-TraxxasHeight/2,TraxxasHeight+SmoothRadius],center_y=false);
			translate([0,23.25,TraxxasHeight/2]) rotate([0,90,0]) cylinder(h=34,d=TraxxasHeight,center=true,$fn=64);
		}
		translate([0,13+SmoothRadius,TraxxasHeight+SmoothRadius]) rotate([0,90,0]) cylinder(h=34.1,r=SmoothRadius,center=true,$fn=64);
		translate([0,13+SmoothRadius,TraxxasHeight]) cube_center([35,15,TraxxasHeight+SmoothRadius],center_y=false);
		translate([0,13+SmoothRadius,0]) cube_center([34-6*2,15,TraxxasHeight+SmoothRadius],center_y=false);
		translate([0,13,0]) cube_center([34-6*2-SmoothRadius*2,15,TraxxasHeight+SmoothRadius],center_y=false);
		translate([(34-6*2-SmoothRadius*2)/2,13+SmoothRadius,0]) cylinder(h=34,r=SmoothRadius,$fn=64);
		translate([-(34-6*2-SmoothRadius*2)/2,13+SmoothRadius,0]) cylinder(h=34,r=SmoothRadius,$fn=64);
	}
}

module TraxxasInner () {
	translate([0,23.25,TraxxasHeight/2]) rotate([0,90,0]) cylinder(h=35,d=M3HoleDiameter,center=true,$fn=24);
}

render()
difference() {
	union() {
		if(RodType == "magnetic") {
			MagneticSocketsOuter();
		} else {
			TraxxasOuter();
		}
		FrameOuter();
	}

	union() {
		if(RodType == "magnetic") {
			LimitSwitchBolt();
			MagneticSocketsInner();
		} else {
			TraxxasInner();
		}
		FrameInner();
	}
}
