
$fn=24;

render()difference() {
	union() {
		hull() {
			cylinder(h=2, d=8);
			translate([10,0])cylinder(h=2, d=8);
		}
		translate([10,0])cylinder(h=10, d=8);
	}

	cylinder(h=2, d=3.7);
!	translate([10,0]) {
		hull() {
			cylinder(h=5, d=3.7);
			cylinder(h=8, d=3.7, $fn=5);
		}
		translate([0,0,8])cylinder(h=2.1, d1=3.7, d2=3.6, $fn=5);
	}
}