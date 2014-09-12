


boardHeight = 75.33;
boardWidth = 135;

screwHoleDiameter = 3.5;

height = 8;

bracketScrewHoleWidth = (121.72+126.96)/2;

screwHoles = [
	[ 1.88+1.75, 2.4+1.75],
	[ 1.88+1.75, 2.4+1.75+70.85-3.5],
	[ 1.88+1.75+124.23+3.5, 2.4+1.75],
	[ 1.88+1.75+124.23+3.5, 2.4+1.75+33.25+3.5],
	[boardWidth/2-bracketScrewHoleWidth/2,-5],
	[boardWidth/2+bracketScrewHoleWidth/2,-5],
];

crossSupportList = [
	[ 0, 1 ],
	[ 1, 2 ],
	[ 1, 3 ],
	[ 3, 2 ],
	[ 0, 3 ],
	[ 0, 4 ],
	[ 4, 5 ],
	[ 2, 5 ],
];


module InnerScrew() {
	union(){
		hull() {
			cylinder(h=height-5, d=3.6, $fn=16);
			cylinder(h=height-2, d=3.6, $fn=5);
		}
		translate([0,0,height-2])cylinder(h=2.1, d1=3.6, d2=3.3, $fn=5);
	}
}

module OuterPart() {

	hull()
	{
		for (screwHole = screwHoles) {
			translate(screwHole)
			cylinder(h=2, d=10, $fn=16);
			translate([boardWidth-screwHole.x,screwHole.y])
			cylinder(h=2, d=10, $fn=16);
		}
/*
		for (screwHole = screwHoles) {

			for (screwHole2 = screwHoles) {
				hull() {
					translate(screwHole)
					cylinder(h=2, d=10, $fn=16);
					translate(screwHole2)
					cylinder(h=2, d=10, $fn=16);
				}
				hull() {
					translate([boardWidth-screwHole.x,screwHole.y])
					cylinder(h=2, d=10, $fn=16);
					translate([boardWidth-screwHole2.x,screwHole2.y])
					cylinder(h=2, d=10, $fn=16);
				}
			}
		}
*/
		translate([boardWidth/2-bracketScrewHoleWidth/2,-5,0])
			cylinder(h=2, d=10, $fn=16);
		translate([boardWidth/2+bracketScrewHoleWidth/2,-5,0])
			cylinder(h=2, d=10, $fn=16);
	}

//	cube([boardWidth, boardHeight, 2]);

//	translate([boardWidth/2, boardHeight/2+4, 1])
//	cube([boardWidth+20, 10, 2],center=true);

	for (screwHole = screwHoles) {
		translate([boardWidth-screwHole.x,screwHole.y])
		cylinder(h=height, d=7, $fn=16);


	}
	for (indexes = crossSupportList) {
		hull() {
			translate([boardWidth-screwHoles[indexes[0]].x,screwHoles[indexes[0]].y])
			cylinder(h=height, d=2, $fn=16);
			translate([boardWidth-screwHoles[indexes[1]].x,screwHoles[indexes[1]].y])
			cylinder(h=height, d=2, $fn=16);
		}
	}

	translate([boardWidth/2-bracketScrewHoleWidth/2,-5,0])
		cylinder(h=height, d=10, $fn=16);
	translate([boardWidth/2+bracketScrewHoleWidth/2,-5,0])
		cylinder(h=height, d=10, $fn=16);


}

module InnerPart() {
	for (screwHole = screwHoles) {
		translate([boardWidth-screwHole.x,screwHole.y])
		InnerScrew();
	}
	translate([boardWidth/2-bracketScrewHoleWidth/2,-5,height-2])
		cylinder(h=height, d=8, $fn=16);
	translate([boardWidth/2+bracketScrewHoleWidth/2,-5,height-2])
		cylinder(h=height, d=8, $fn=16);

}


difference() {
	OuterPart();
	InnerPart();
}