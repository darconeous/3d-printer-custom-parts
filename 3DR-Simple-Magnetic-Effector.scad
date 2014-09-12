
M3HoleDiameter = 3.6;
M3NutDiameter = 6.7;
WithZSensor = false;
With3DRSimpleMountCompatibility = false;
HotEndCaptiveNut = true;

module NewPlatform(flipped=false) {
	height = 8;
	MountDistance = 20.2;
	MagneticAngle = 30;
	MagneticHeight = -1.6;
	MagneticWidth = 30;

	MagnetOuterDiameter = 9.8;
	MagnetInnerDiameter = 2.75;
	SocketDiameter = MagnetOuterDiameter + 3;
	BearingDiameter = 9.5;
	Blah = 13.25;
	BearingDialation = 0.2;

	module screwhole(withNut=true, flip=false, both=false) {
		union() {
		cylinder(h = height+2, d = M3HoleDiameter, $fn = 16);
		if(withNut) {
			if(flip || both) {
				rotate([0, 0, 0]) translate([0,0,(height)]) cylinder(h = 5, d = M3NutDiameter, center = true, $fn = 6);
			}
			if(!flip || both) {
				rotate([0, 0, 0]) cylinder(h = 5, d = M3NutDiameter, center = true, $fn = 6);
			}
		}
		}
	}

	module ZSensorMountOuter() {
		rotate([0,0,180])
		translate([0, -31.5, 0]) {
			union(){
			translate([-5, 0, 0]) cube([10, 9.5, height]);
			cylinder(h = height, d = 17, $fn = 32);
			}
		}
	}

	module ZSensorMountInner() {
		rotate([0,0,180])
		translate([0, -31.5, 0]) {
			cylinder(h = height+1, d = 13, $fn = 32);
			translate([0, 0, 4])
				cylinder(h = height, d = 18.5, $fn = 32);
		}
	}

	module OuterShape() {
		difference() {
			union () {
				difference() {
					cylinder(h = height, r = 26);
					for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
						translate([-40/2, -27, 0]) {
							cube([40, 10, 10]);
						}
					}
				}

				for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
						union () {
							translate([-25, -17, 0]) {
								translate([0, height/8, height/2]) rotate([0, 90, 0])
								intersection() {
									cylinder(h = 50, d = height*1.25, $fn = 32);
									translate([-height/2,-15,0])cube([height,100,50]);
								}
							}
					}

					difference() {
						union() {
							translate([-MagneticWidth/2, -MountDistance, MagneticHeight]) {
								rotate([MagneticAngle,0,0]) {
									translate([0, 0, -3])
									cylinder(h=13,d=12,$fn=48);
								}
							}
							translate([MagneticWidth/2, -MountDistance, MagneticHeight]) {
								rotate([MagneticAngle,0,0]) {
									translate([0, 0, -3])
									cylinder(h=13,d=12,$fn=48);
								}
							}
						}
						translate([0,0,-height/2])cube([100,100,height],center=true);
					}

				}

				for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
					translate([0, -18.9, 0]) {
						cylinder(h = height, r = 6, $fn = 32);
					}
				}

				// Arms
				for(ang = [0, 120, 240]) rotate([0, 0, ang + 60]) {
					hull()translate([0, -32.2, 0]) {
						translate([-5, 3, 0]) cube([10, 12.2, height]);
						cylinder(h = height, r = 5, $fn = 32);
					}
				}

/*
				if(WithZSensor) {
					ZSensorMountOuter();
				}
*/
			}

			// Curvy bits
/*
			for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
				rotate([0, 0, 60])translate([7, -27.6, 0]) cylinder(h=height,d=6.9,$fn=32);
				rotate([0, 0, 60])translate([-7, -27.6, 0]) cylinder(h=height,d=6.9,$fn=32);
			}
*/
		}
	}

	module InnerShape() {
		module MagnetHolder() {
/*
				rotate([MagneticAngle,0,0]) {
					translate([0,0,3])
					cylinder(h=6,d=MagnetOuterDiameter-1,$fn=48);
					translate([0,0,-7]) difference() {
						cylinder(h=13.25,d=MagnetOuterDiameter,$fn=48);
						for(ang = [0,120,240]) rotate([0,0,ang]) {
							translate([0,MagnetOuterDiameter/2]) cylinder(h=13.25,d=0.5,$fn=8);
						}
					}
				}
*/
			rotate([MagneticAngle,0,0]) {
				translate([0,0,9.3]) {
					sphere(d=BearingDiameter+BearingDialation, $fn=48);
					cylinder(h=BearingDiameter, d1=BearingDiameter+BearingDialation, d2=BearingDiameter*1.5, $fn=48);
				}
				translate([0,0,10.7-3])cylinder(h=2.35,d1=MagnetOuterDiameter-2,d2=BearingDiameter+1,$fn=48);
				translate([0,0,3])cylinder(h=6,d=MagnetOuterDiameter-2,$fn=48);
				translate([0,0,-7]) difference() {
					cylinder(h=Blah,d=MagnetOuterDiameter,$fn=48);
					for(ang = [0,120,240]) rotate([0,0,ang]) {
						translate([0,MagnetOuterDiameter/2]) cylinder(h=Blah,d1=0.1, d2=0.45,$fn=8);
					}
				}
			}
		}

		// Arm holes
		for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
			translate([-MagneticWidth/2, -MountDistance, MagneticHeight]) MagnetHolder();
			translate([MagneticWidth/2, -MountDistance, MagneticHeight]) MagnetHolder();

			// Zip-tie holes.
			translate([-8,-17,0])translate([-2,-1,-1])cube([4,2,height+2]);
			translate([8,-17,0])translate([-2,-1,-1])cube([4,2,height+2]);
			translate([-22,-17,0])translate([-2,-1,-1])cube([4,2,height+2]);
			translate([22,-17,0])translate([-2,-1,-1])cube([4,2,height+2]);

			// Fan screw holes (no captive bolts)
			rotate([0, 0, 60])translate([0, -32.2, 0]) screwhole(withNut=false);
		}

		for(ang = [0, 120, 240]) rotate([0, 0, ang]) {
			translate([0, -18.9, 0]) screwhole(withNut=HotEndCaptiveNut,flip=false,both=false);

/*
			// Zip-tie holes.
			translate([0, -26, 0]) {
				translate([0, 0, height/2])
				difference() {
					cylinder(h=4,d=9,center=true,$fn=32);
					cylinder(h=5,d=5,center=true,$fn=32);
				}
			}
*/
		}

		for(ang = [60, 180, 300]) rotate([0, 0, ang]) {
			translate([0, -18.9, 0]) screwhole(withNut=HotEndCaptiveNut,flip=false,both=true);
			translate([0, -25, 0]) cylinder(h=height+1, d=5, $fn=32);
		}

		if(With3DRSimpleMountCompatibility) {
			// For compatibility with 3DR Simple platform
			rotate([0, 0, 240 + 60])translate([-4.0, -18.2, 0]) screwhole(withNut=false);
			rotate([0, 0, 0 + 60])translate([4.0, -18.2, 0]) screwhole(withNut=false);
		}

		// Center hole
		cylinder(h = height + 1, r = 15, $fn=64);

/*
		if(WithZSensor) {
			ZSensorMountInner();
		}
*/
	}

	if(WithZSensor) {
		rotate([flipped?180:0, 0, 0]) translate([0, 0, flipped?-height:0])
		render() difference() {
			union() {
				difference() {
					OuterShape();
					InnerShape();
				}
				ZSensorMountOuter();
			}
			ZSensorMountInner();
		}
	} else {
		rotate([flipped?180:0, 0, 0]) translate([0, 0, flipped?-height:0])
		render()
		difference() {
			OuterShape();
			InnerShape();
		}
	}
}


NewPlatform();
