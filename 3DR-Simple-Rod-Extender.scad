RodDiameter = 8;
Tol = 0.2;

SnapOutHeight = 0.2;
RodDistance = 45;
LinearBearingDiameter = 15;

HalfRodDistance = RodDistance/2;


ExtendRodLength = 70;

RodInset = 22.5;
BodyHeight = max(ExtendRodLength,RodInset+2.5);


/*color("red")translate([-42,-22.2,0]){
	intersection() {
	import("../3DR-Simple-Delta-Printer/STL/Simple Parts/3DR Bottom Motor Mount Simple.STL");
//	cube([100,100,20]);
	}
}
*/

module cube_center(size,center_x=true,center_y=true) {
	translate([center_x?-size.x/2:0,center_y?-size.y/2:0,0])cube(size);
}


module FrameOuter() {
	difference() {
		hull()
		union() {
			translate([HalfRodDistance,0,0])cylinder(h=BodyHeight,d=RodDiameter+5,$fn=80);
			translate([-HalfRodDistance,0,0])cylinder(h=BodyHeight,d=RodDiameter+5,$fn=80);
			translate([0,-18.75,0])cube_center([25,22,BodyHeight],center_y=false);
		}
		translate([0,-18.75+20.5/2,0]) difference() {
			cube_center([20.5,20.5,BodyHeight+0.1]);
			translate([0,10.25,0])cube_center([5+Tol,2.5,BodyHeight+0.1]);
			translate([10.25,0,0])cube_center([2.5,5+Tol,BodyHeight+0.1]);
			translate([-10.25,0,0])cube_center([2.5,5+Tol,BodyHeight+0.1]);
		}
	}

	for(pos = [HalfRodDistance,-HalfRodDistance]) {
		translate([pos,0,BodyHeight]) {
			cylinder(h=RodInset/2,d1=RodDiameter-Tol,d2=RodDiameter-Tol,$fn=64);
			for(deg = [0:60:360]) {
				rotate([0,0,deg])
				translate([(RodDiameter-Tol)/2,0])
				cylinder(h=RodInset/2,d1=0.2+Tol,d2=0.0,$fn=8);
			}
		}
	}
}

module FrameInner() {
	module ScrewHole(screwholeheight) {
		translate([0,-18.75+20.5/2,screwholeheight]) {
			for(ang = [0,90,-90]) rotate([-90,0,ang]) {
				cylinder(h=200,d=4.5, $fn=32);
				translate([0,0,13])cylinder(h=20,d=9, $fn=32);
			}
		}
	}

	for(pos = [HalfRodDistance,-HalfRodDistance]) translate([pos,0,0]) difference(){
		cylinder(h=RodInset,d=RodDiameter+0.5,$fn=64);
		for(deg = [0:60:360]) {
			rotate([0,0,deg])translate([(RodDiameter+0.5)/2,0])cylinder(h=RodInset,d1=0.0,d2=0.5,$fn=8);
		}
	}

	if(BodyHeight<40) {
		for(screwholeheight = [BodyHeight/2]) {
			ScrewHole(screwholeheight);
		}
	} else {
		for(screwholeheight = [15,BodyHeight-15]) {
			ScrewHole(screwholeheight);
		}
	}
	translate([0,(RodDiameter+5)/2+0.6,0])scale([1,0.1,1])cylinder(h=BodyHeight, r=HalfRodDistance, $fn=64);
}

module Extender() {
difference() {
	union() {
		FrameOuter();
	}

	union() {
		FrameInner();
	}
}
}

/*/
for(ang = [0,120,240]) rotate([0,0,ang+90])translate([0,30,0]) {
Extender();
}
/*/
Extender();
/*/