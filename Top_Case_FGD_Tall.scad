
module OriginalTop() {
	translate([-141,-54,-10.59])import("../Case_for_the_Full_Graphic_Smart_LCD_Controller/Top_Case_FGD.stl");
}

//OriginalTop();

module TallerTop(amount=1.75) {
	SplitHeight = 11;

	module Split() {
		cube([110,97,SplitHeight]);
	}

	render()union() {
		intersection() {
			OriginalTop();
			Split();
		}
		translate([0,0,SplitHeight])scale([1,1,amount])
		intersection() {
			cube([110,97,1]);
			translate([0,0,-SplitHeight])difference() {
				OriginalTop();
				Split();
			}
		}
	
		translate([0,0,amount])difference() {
			OriginalTop();
			Split();
		}
	}
}

module TallerSpacer() {
	render()difference() {
		cylinder(h=4.55,d=8.5,$fn=6);
		cylinder(h=4.55,d=3.6,$fn=32);
	}
}

TallerTop();

//*
translate([55,55,0])
{
	translate([-8,-8,0])TallerSpacer();
	translate([8,-8,0])TallerSpacer();
	translate([-8,8,0])TallerSpacer();
	translate([8,8,0])TallerSpacer();
}
//*/