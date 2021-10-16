use <threadlib/threadlib.scad>

$fn=200;

translate([30,0,0]){
	translate([0,0,4]) bolt("M6", turns=10, higbee_arc=20, fn=$fn, tol=0.1);
	cylinder(d=10, h=4, $fn=6);
}

difference(){
	cylinder(d=10, h=6, $fn=6);
	cylinder(d=6.2, h=7);
}

nut("M6", turns=5, Douter=8, higbee_arc=20, fn=$fn, tol=0.1);