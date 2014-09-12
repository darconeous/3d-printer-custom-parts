
M3HoleDiameter = 3.5;
M3NutDiameter = 6.8;
WithZSensor = true;

module NewPlatform(flipped=true) {
	height = 8;

	module screwhole(withNut=true) {
		cylinder(h = height+2, d = M3HoleDiameter, $fn = 16);
		if(withNut)rotate([0, 0, 30]) cylinder(h = 3, d = M3NutDiameter, center = true, $fn = 6);
	}

	module ZSensorMount() {
		translate([0, -32.0, 0]) {
			difference() {
			union(){
			translate([-5, 0, 0]) cube([10, 15, height]);
			cylinder(h = height, d = 18, $fn = 32);
			}
			cylinder(h = height+1, d = 13, $fn = 32);
			}
		}
	}

	module OuterShape() {
		union () {
			difference() {
				cylinder(h = height, r = 26);
				for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
					translate([-11, -30, 0]) {
						cube([22, 10, 10]);
					}
				}
			}
			for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
				difference() {
					union () {
						translate([-17, -23, 0]) cube([34, 9, height]);
						translate([-17, -23, height/2]) rotate([0, 90, 0]) cylinder(h = 34, d = height, $fn = 32);
					}
					translate([-11, -29, 0]) {
						cube([22, 15, height+2]);
					}
				}
			}

			for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
				translate([0, -18.9, 0]) {
					cylinder(h = height, r = 5, $fn = 32);
				}
			}

			// Arms
			for(ang = [0, 120, 240]) rotate([0, 0, ang + 60]) {
				translate([0, -32.2, 0]) {
					translate([-5, 3, 0]) cube([10, 12.2, height]);
					cylinder(h = height, r = 5, $fn = 32);
				}
			}

			if(WithZSensor)
				ZSensorMount();
		}
	}

	module InnerShape() {
		// Arm holes
		for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
			translate([0, -22.5, height/2]) rotate([0, 90, 0]) {
				difference() {
					// Make room for the bolt head.
					cylinder(h = 70, d = 6, center = true, $fn = 16);
					cylinder(h = 40, d = 10, center = true, $fn = 6);
				}
				difference() {
					union () {
						// Bolt guide
						cylinder(h = 28, d = M3NutDiameter, center = true, $fn = 6);
						cylinder(h = 40, d = M3HoleDiameter, center = true, $fn = 16);
					}
					cylinder(h = 21, d = 10, center = true, $fn = 6);
				}
				translate([0,-0.8,2.9])rotate([-20,0,0])
					cylinder(h = 6, d2 = M3HoleDiameter*1.4, d1 = M3HoleDiameter*0.8, center = true, $fn = 16);
				translate([0,-0.8,-2.9])rotate([20,0,0])
					cylinder(h = 6, d1 = M3HoleDiameter*1.4, d2 = M3HoleDiameter*0.8, center = true, $fn = 16);
			}

			// Fan screw holes (no captive bolts)
			rotate([0, 0, 60])translate([0, -32.2, 0]) screwhole(withNut=false);

			// Curvy bits
			rotate([0, 0, 60])translate([7, -27.6, 0]) cylinder(h=height,d=6.9,$fn=32);
			rotate([0, 0, 60])translate([-7, -27.6, 0]) cylinder(h=height,d=6.9,$fn=32);
		}

		for(ang = [0, 60, 120, 180, 240, 300]) rotate([0, 0, ang]) {
			translate([0, -18.9, 0]) screwhole();
		}

		// For compatibility with 3DR Simple platform
		rotate([0, 0, 240 + 60])translate([-4.0, -18.2, 0]) screwhole();
		rotate([0, 0, 0 + 60])translate([4.0, -18.2, 0]) screwhole();

		// Center hole
		cylinder(h = height + 1, r = 15);
	}

	rotate([flipped?180:0, 0, 0]) translate([0, 0, flipped?-height:0])
	render()difference() {
		OuterShape();
		InnerShape();
	}
}


NewPlatform();
