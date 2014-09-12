
MagneticAngle = 30;
MagnetOuterDiameter = 9.8;
MagnetInnerDiameter = 2.75;
MagneticHeight = 15;
height = 8;
SocketDiameter = MagnetOuterDiameter + 3;
BearingDiameter = 9.5;
BearingDialation = 0.175;

Blah = 13.25;
difference() {
	union() {
		rotate([MagneticAngle,0,0]) {
			translate([0, 0, -3])
			cylinder(h=13,d=SocketDiameter,$fn=48);
		}
		translate([-5,-1,0])cube([10,10,8]);
	}
	translate([0,0,-height/2])cube([100,100,height],center=true);

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
