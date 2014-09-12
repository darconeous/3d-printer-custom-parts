

M3HoleDiameter = 3.5;
M3NutDiameter = 6.8;
M3BoltDiameter = 6.5;
height = 9;

module HotEndMount(flipped=true, part) {

	module E3Dv5() {
		translate([0,0,2]){
			cylinder(h=10,d=12,$fn=32);
			translate([0,0,7])cylinder(h=3.75,d=16,$fn=32);
			translate([0,0,7-5.6-4])cylinder(h=4,d=16,$fn=32);
		}
	}

	module screwhole(withNut=true, d = M3HoleDiameter) {
		cylinder(h = height+2, d = d, $fn = 16);
		if(withNut)rotate([0, 0, 30]) cylinder(h = 3, d = M3NutDiameter, center = true, $fn = 6);
	}

	module OuterShape() {
		union () {
			cylinder(h = height, r = 23,$fn=72);
		}
	}

	module InnerShape() {
		for(side = [1, -1])
		{
			translate([0,9*side,height/2+0.7])rotate([0,90,0]){
				cylinder(h=60,d=M3HoleDiameter,center=true,$fn=32);
				translate([0,0,6])rotate([0,0,30])cylinder(h=30,d=M3NutDiameter,center=false,$fn=6);
				rotate([0,180,0])translate([0,0,6])cylinder(h=30,d=M3NutDiameter,center=false,$fn=32);
			}
		}

		for(ang = [0, /*60,*/ 120, /*180,*/ 240/*, 300*/]) rotate([0, 0, ang+30]) {
			translate([0, -18.9, 0]) {
				// bolt hole is tapered at the bottom
				// to avoid snagging on threads. Top (err, bottom?) part of
				// bolt should be smooth and not snag.
				cylinder(h = height+2, d1 = M3HoleDiameter, d2 = M3HoleDiameter*1.5, $fn = 16);
			}
		}

		for(ang = [210, 330, 450]) {
			rotate([0, 0, ang+10.5]) {
				translate([0, -18.9, 0]) {
					screwhole(withNut=false,d=M3HoleDiameter);
					translate([0,0,height-1+0.1])cylinder(h=1,d=M3BoltDiameter,$fn=32);
				}
			}
			rotate([0, 0, ang-10.5]) {
				translate([0, -18.9, 0]) {
					screwhole(withNut=false,d=M3HoleDiameter);
					translate([0,0,height-1+0.1])cylinder(h=1,d=M3BoltDiameter,$fn=32);
				}
			}
		}

		minkowski() {
			E3Dv5();
			cylinder(h=0.1, d=0.15);
		}

		if (part == 0) {
			translate([-0.1,-24,-0.5])cube([24,24*2,height+1]);
		} else if(part == 1) {
			translate([0.1-24,-24,-0.5])cube([24,24*2,height+1]);
		}

		// Center hole
		//cylinder(h = height + 1, r = 15);
	}

	rotate([flipped?180:0, 0, 0]) translate([0, 0, flipped?-height:0])
	render()difference() {
		OuterShape();
		InnerShape();
	}
}


translate([-3,0,0])rotate([0,0,0])HotEndMount(part=0);
translate([3,0,0])rotate([0,0,0])HotEndMount(part=1);
