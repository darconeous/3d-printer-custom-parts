

module Corner() {
	include <3DR-Simple-Corner-Top-Reenforced.scad>
}

for(deg = [0,120,240]) rotate([0,0,deg]) {
	translate([0,-65.5,0])
	rotate([0,0,18])
	render()Corner();
}



