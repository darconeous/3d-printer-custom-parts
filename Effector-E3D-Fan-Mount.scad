


M3HoleDiameter = 3.6;
M3NutDiameter = 6.7;

PlateHeight = 3;
FanSize = 30;
FanScrewInset = 3;
FanScrewSize = 2.5;
FanHeightFromPlate = 1;
ShroudExtent = FanSize/2-2;
ShroudEnlargement = 1;
Rounding = 1;

$fn=64;

module cube_center(size,center_x=true,center_y=true) {
	translate([center_x?-size.x/2:0,center_y?-size.y/2:0,0])cube(size);
}

module OuterShape() {
if(0){
	intersection() {
		cylinder(h=PlateHeight,r=23);
		translate([0,5,0])cube_center([44,9.5,48],center_y=false);
	}

	cube_center([FanSize+ShroudEnlargement,ShroudExtent,FanSize+ShroudEnlargement+PlateHeight+FanHeightFromPlate],center_y=false);
}
if(1){
	intersection() {
	minkowski() {
		union() {
			intersection() {
				if(PlateHeight>Rounding) {
					cylinder(h=PlateHeight-Rounding,r=23);
				} else {
					cylinder(h=0.01,r=23);
				}
				translate([0,5,0])cube_center([44,9.5,48],center_y=false);
			}

			cube_center(
				[FanSize+ShroudEnlargement-Rounding,
				ShroudExtent,
				FanSize+ShroudEnlargement-Rounding+PlateHeight+FanHeightFromPlate]
				,center_y=false);
		}
		sphere(Rounding, $fn=10);
	}
	cube_center([60,60,60]);
	}
}
}

module InnerShape() {
	cylinder(h=PlateHeight+FanSize+ShroudEnlargement+10+FanHeightFromPlate,d=27);

	translate([0,ShroudExtent,PlateHeight+FanHeightFromPlate+ShroudEnlargement/2])
	rotate([90,0,0])
		for(pos = [[-FanSize/2+FanScrewInset,FanScrewInset],
				[FanSize/2-FanScrewInset,FanScrewInset],[FanScrewInset-FanSize/2,FanSize-FanScrewInset],[FanSize/2-FanScrewInset,FanSize-FanScrewInset]]) {
			translate([pos.x,pos.y,-0.01-ShroudEnlargement])cylinder(h=FanSize, d=FanScrewSize, $fn=32);

		}

	translate([0,0,PlateHeight+FanSize/2+ShroudEnlargement/2+FanHeightFromPlate])
		rotate([90,0,0]) {
			cylinder(h=60,d=FanSize*0.85,center=true);
			translate([0,FanSize*0.274,0])rotate([0,0,45])cube([FanSize*0.46,FanSize*0.46,60],center=true);
		}

		for(ang = [-60, 0, 60]) rotate([0, 0, 180+ang]) {
			translate([0, -18.9, 0]) {
				cylinder(h=50, d=M3HoleDiameter, $fn=32);
				translate([0,0,1]) cylinder(h=5, d=M3NutDiameter, $fn=6);
			}
		}
}



render() difference() {
	OuterShape();
	InnerShape();
}