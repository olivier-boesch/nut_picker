/*

	Nut Picker
	Olivier Boesch (c) 2021
	
	published under CC BY-NC-SA v4 Licence
	https://creativecommons.org/licenses/by-nc-sa/4.0/

*/

$fn=$preview?80:300;

//what to export on render
export = "body"; // "body", "round" or "cross"

module cross(off=0){
	linear_extrude(5+off){
		rotate([0,0,45]) square([8+off,3+off], center=true);
		rotate([0,0,-45]) square([8+off,3+off], center=true);
	}
}

module body(){
	difference(){
		intersection(){
			sphere(d=27);
			cube(20, center=true);
		}
		translate([0,0,4.8]) round(d_off=00.2, h_off=0.3);
		rotate([180,0,0]) translate([0,0,4.8]) round(d_off=00.2, h_off=0.3);
		rotate([90,0,0]) translate([0,0,4.8]) round(d_off=00.2, h_off=0.3);
		rotate([-90,0,0]) translate([0,0,4.8]) round(d_off=00.2, h_off=0.3);
		rotate([0,-90,0]) translate([0,0,4.9]) cross(off=0.2);
	}
}

module round(d_off=0, h_off=0){
	cylinder(d=8+d_off,h=5+h_off);
}

if($preview){
	color("#333333") body();
	color("red") translate([0,0,5]) round();
	color("#FFaaFF") rotate([180,0,0]) translate([0,0,5]) round();
	color("#FFFF00") rotate([90,0,0]) translate([0,0,5]) round();
	color("#aaFFaa") rotate([-90,0,0]) translate([0,0,5]) round();
	color("white") rotate([0,-90,0]) translate([0,0,5]) cross();
}
else{
	if (export == "body") rotate([0,90,0]) body();
	if (export == "cross") cross();
	if (export == "round") round();
}