
module OriginalMount(part = 0) {
translate([-13.5,10,0])
union () {
if(part == 0 || part == 1)translate([27,0,0]) rotate([90,0,180])import("helpers/Hot End Plate.STL",convexity=3);
if(part == 0 || part == 2)rotate([90,0,0])import("helpers/Hot End Holder.STL",convexity=3);
if(part == 0 || part == 3)translate([35,-20,0]) rotate([90,0,180])
	import("helpers/Hot End Holder Tabs.STL",convexity=3);
}
}

module OriginalPlatform() {
translate([-30.7,-26.5,0])
	import("helpers/Platform.STL");

}

module E3Dv5Placeholder() {
translate([-12.5,-12.5,-54.5])
translate([-56.5,-43.5,0])
	import("helpers/E3D_Hot_end.stl");

}

module E3Dv5Mount(part = 0) {
	module E3Dv5() {
	cylinder(h=15,d=12);
	translate([0,0,15-3.75])cylinder(h=3.75,d=16);
	translate([0,0,15-3.75-5.6-3])cylinder(h=3,d=16);
	cylinder(h=1,d=16);
	}

	difference() {
	union() {
	OriginalMount(part);
	cylinder(h=20,d=16);
	}
	minkowski() {
		E3Dv5();
		sphere(r=0.3); // This is the tolerance.
	}
	translate([0,0,14])cylinder(h=15, d=40);
	translate([-9.75,-6,9])rotate([90,30,0])cylinder(h=5, d=6.8, $fn=6);
	translate([9.75,-6,9])rotate([90,30,0])cylinder(h=5, d=6.8, $fn=6);
	}
}


module E3Dv5MountHolderTabs() {
	intersection() {
		translate([0,-2.5,10]) rotate([90,0,0]) E3Dv5Mount(3);
		cylinder(h=10,d=200);
	}
}

module E3Dv5MountHolder() {
	intersection() {
		translate([0,2.5,10]) rotate([-90,0,0]) E3Dv5Mount(2);
		cylinder(h=10,d=200);
	}
}

module E3Dv5MountHolderPlate() {
	intersection() {
	translate([0,35,-10]) rotate([90,0,0]) E3Dv5Mount(1);
		cylinder(h=20,d=200);
	}
}

module NewPlatform()
{

module screwhole() {
union(){cylinder(h=10,d=3.4,$fn=16);
		rotate([0,0,30])cylinder(h=3,d=6.8,center=true,$fn=6);
	}
}

difference() {
union() {
difference() {
cylinder(h=8,r=23);
for(ang=[0,120,240]) rotate([0,0,ang]) {
		translate([ -11,-30,0]) {
		cube([22,10,10]);
		}
}
}
for(ang=[0,120,240]) rotate([0,0,ang]) {
	difference() {
		union() {
			translate([-17,-23,0])cube([34,9,8]);
			translate([-17,-23,4])rotate([0,90,0])cylinder(h=34,d=8,$fn=32);
		}
		translate([ -11,-29,0]) {
		cube([22,15,10]);
		}
	}
}

for(ang=[0,120,240]) rotate([0,0,ang]) {
		translate([ 0,-18.9,0]) {
		cylinder(h=8,r=5,$fn=32);
		}
}
for(ang=[0,120,240]) rotate([0,0,ang+60]) {
		translate([ 0,-32.2,0]) {
		translate([-4,0,0])cube([8,32.2,8]);
		cylinder(h=8,r=5,$fn=32);
		}
}
}

for(ang=[0,120,240]) rotate([0,0,ang]) {
		translate([ 0,-22.5,4])rotate([0,90,0]) {
			difference(){
				// Make room for the bolt head.
				cylinder(h=70,d=6,center=true,$fn=16);
				cylinder(h=40,d=10,center=true,$fn=6);
			}
			difference(){
				union() {
					// Bolt guide
					cylinder(h=28,d=6.8,center=true,$fn=6);
					cylinder(h=40,d=3.3,center=true,$fn=16);
				}
				cylinder(h=21,d=10,center=true,$fn=6);
			}
		}
}

for(ang=[0,60,120,180,240,300]) rotate([0,0,ang]) {
	translate([ 0,-18.9,0])screwhole();
	translate([ 0,-32.2,0])screwhole();

}
for(ang=[0,120,240]) rotate([0,0,ang+60]) {

	translate([ -4.0,-18.2,0])screwhole();
	translate([ 4.0,-18.2,0])screwhole();
}

cylinder(h=8.1,r=15);
}
}


module rcube(Size=[20,20,20],b=2,center=false)
{
	translate((center==false)?[Size[0]/2,Size[1]/2,Size[2]/2]:[0,0,0])
	hull() {
		for(x=[-(Size[0]/2-b),(Size[0]/2-b)]) {
			for(y=[-(Size[1]/2-b),(Size[1]/2-b)]) {
				for(z=[-(Size[2]/2-b),(Size[2]/2-b)]) {
					translate([x,y,z])
						sphere(r=b);
				}
			}
		}
	}
}


module rcylinder(h=10,r1=10,r2=10,b=2,center=false)
{
	translate([0,0,(center==true)?-h/2:0]) {
		rotate_extrude()
		hull() {
			translate([r1-b,   b, 0]) circle(r = b);
			translate([r2-b, h-b, 0]) circle(r = b);
			square([r1-b,b]);
			translate([0, h-b, 0])
			square([r2-b,b]);
		}
	}
}

//%OriginalPlatform();
//render()NewPlatform();

module PlaceholderFan(size=30,depth=10) {
	roundRadius=3;
	translate([0,0,depth/2])
	difference() {
		union() {
			difference() {
				hull() {
					for(i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
						translate([i[0]*(size/2-roundRadius),i[1]*(size/2-roundRadius),0])cylinder(h=depth,r=roundRadius,center=true,$fn=16);
					}
				}
				cube([size+0.1,size+0.1,depth-4],center=true);
			}
			for(i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
				translate([i[0]*(size/2-roundRadius),i[1]*(size/2-roundRadius),0])cylinder(h=depth,r=roundRadius,center=true,$fn=16);
			}
			cylinder(h=depth, d=size, center=true);
		}
		cylinder(h=depth+0.1, d=size*0.9-1.0, center=true);

		for(i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
			translate([i[0]*(size/2-roundRadius),i[1]*(size/2-roundRadius),0])cylinder(h=depth+0.1,d=3.3,center=true,$fn=16);
		}
	}
}

module 	E3Dv5MountHolderv2()
{
	module E3Dv5() {
	cylinder(h=15,d=12);
	translate([0,0,15-3.75])cylinder(h=3.75,d=16);
	translate([0,0,15-3.75-5.6-3])cylinder(h=3,d=16);
	cylinder(h=1,d=16);
	}
	fanSize=30;
	roundRadius=3;
	fanPlacementRadius=15;
	render() intersection() {
		difference() {
			union() {
				for(ang=[0,120,240]) {
					rotate([0,0,ang+60])
					translate([0,0,15])rotate([90,0,0])
						translate([-15,-15,0])cube([fanSize,fanSize+8,fanPlacementRadius]);
					rotate([0,0,ang])translate([0,-18.9,0]){
						cylinder(h=5,r=5,$fn=32);
						translate([0,2,30])rotate([45,0,0])cube(11,center=true);
					}
				}
//				translate([0,0,30])cylinder(h=10,r=18);

			}
union(){
			cylinder(h=30,r=15);
	translate([0,0,25])minkowski() {
		E3Dv5();
		sphere(r=0.3); // This is the tolerance.
	}
//			translate([0,0,30])cylinder(h=10,r=12);
			for(ang=[0,120,240]) {
				rotate([0,0,ang+60])
				translate([0,0,15])rotate([90,0,0]) {
					cylinder(h=fanPlacementRadius+0.1,d=27);
		for(i=[[1,1],[1,-1],[-1,1],[-1,-1]]) {
			// Screw holes
			translate([i[0]*(fanSize/2-roundRadius),i[1]*(fanSize/2-roundRadius),0]){
				// M3 hole
				translate([0,0,fanPlacementRadius-7]) {
				cylinder(h=7+0.1,d=3.3,$fn=16);
				}
				// M3 nut holder
				translate([0,0,fanPlacementRadius-4.5]) {
					cylinder(h=3,d=6.4,$fn=6);
					translate([-i[0]*5,0,1.5])cube([10,5.5,3],center=true);
				}
			}
				}
				}
				rotate([0,0,ang])translate([0,-18.9,0]){
					translate([0,0,5])cylinder(h=18,d=5,$fn=16);
					cylinder(h=5,d=3.3,$fn=16);
				}
			}
		}
}
		cylinder(h=40,r2=11,r1=44);
	}

	%translate([0,0,25]){
		E3Dv5();
	}

	%for(ang=[0,120,240]) rotate([0,0,ang+60]) {
		translate([0,-fanPlacementRadius,15])rotate([90,0,0])PlaceholderFan();
	}
}


if(1) {
	E3Dv5MountHolderPlate();
	E3Dv5MountHolder();
	E3Dv5MountHolderTabs();
} else {
	rotate([0,0,180]) union() {
//	E3Dv5Mount();
	E3Dv5MountHolderv2();
//	%rotate([0,0,90])translate([0,0,25])E3Dv5Placeholder();
//	%translate([0,0,-12])OriginalPlatform();
	translate([0,0,-8])render()NewPlatform();
	}
}


//rotate([180,0,0])translate([0,0,-8])render()NewPlatform();

//rotate([180,0,0])render()NewPlatform();
/*
translate([-33,-28.5,0])
import("/Users/darco/Projects/3DR-Delta-Printer/stl/3DR_micro_platform_V2_001_RTP.stl");
*/
