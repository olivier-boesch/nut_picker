/*

	Nut Picker
	Olivier Boesch (c) 2021
	
	published under CC BY-NC-SA v4 Licence
	https://creativecommons.org/licenses/by-nc-sa/4.0/

*/

use <threadlib/threadlib.scad>

$fn=$preview?40:150;

L = 150; //mm - length (x)
W = 100; //mm - width (y)
H = 100; //mm - height (z)

ep_matiere = 4; //mm - material thickness
ep_accroche = ep_matiere /2; //mm - fix thickness

//screw clearance
tol_vis = 0.3;

//fix clearance
tol_emboitement = 0.05;

//what to export on render
export = "nut"; // or "up", "down", "left", "right", "front", "rear"

module complete_nut(d=27, tol=tol_vis){
	N = 5;
	P = thread_specs(str("M",d,"-ext"))[0];
	H = P*N +2;
	difference(){
		union(){
			translate([0,0,1]) nut(str("M",d), turns=N, fn=$fn, tol=tol, Douter=22);
			translate([0,0,H]) cylinder(d=22,h=3);
		}
		for(a=[0:20:360]){
			rotate([0,0,a]) translate([22/2+0.5,0,-0.1]) cylinder(d=2, h=H+3+0.2);
		}
		translate([-4,2,H+3-0.5]) linear_extrude(1) text("N", valign="center", halign="center", size=8);
		translate([4,-2,H+3-0.5]) linear_extrude(1) text("P", valign="center", halign="center", size=8);
	}
}

module complete_bolt(d=27, tol = tol_vis){
	cylinder(d1=d+5, d2=d, h=5);
	translate([0,0,5.99]) bolt(str("M", d), turns=5, fn=$fn, tol=tol);
}

//---- box

module down(){
	translate([0,0]){
		difference(){
			linear_extrude(ep_matiere/2) square([L-2*ep_matiere,W-2*ep_matiere],center=true);
			translate([0,0,1]) rotate([180,0,0]) linear_extrude(2) text("NP", valign="center", halign="center", size=60);
			translate([L/4+5,W/4-4.5,1]) rotate([180,0,0]) linear_extrude(2) text("OB", valign="center", halign="center", size=15);
		}
		translate([0,0,ep_matiere/2]) difference(){
			linear_extrude(ep_matiere/2) square([L-ep_matiere,W-ep_matiere],center=true);
			translate([L/2-0.75*ep_matiere,W/2-0.75*ep_matiere,ep_matiere/4]) cube(ep_accroche+tol_emboitement, center=true);
			translate([-L/2+0.75*ep_matiere,W/2-0.75*ep_matiere,ep_matiere/4]) cube(ep_accroche+tol_emboitement, center=true);
			translate([-L/2+0.75*ep_matiere,-W/2+0.75*ep_matiere,ep_matiere/4]) cube(ep_accroche+tol_emboitement, center=true);
			translate([L/2-0.75*ep_matiere,-W/2+0.75*ep_matiere,ep_matiere/4]) cube(ep_accroche+tol_emboitement, center=true);
		}
	}
}


//-x
module xmin(){
	difference(){
		linear_extrude(ep_matiere) square([W,H],center=true);
		translate([W/2-0.75*ep_matiere,0,1]) cube([ep_matiere/2+tol_emboitement,W-ep_matiere+tol_emboitement,2.5], center=true);
		rotate([0,0,90]) translate([W/2-0.75*ep_matiere,0,1]) cube([ep_matiere/2+tol_emboitement,H-ep_matiere+tol_emboitement,2.5], center=true);
		rotate([0,0,-90]) translate([W/2-0.75*ep_matiere,0,1]) cube([ep_matiere/2+tol_emboitement,H-ep_matiere+tol_emboitement,2.5], center=true);
		rotate([0,0,180]) translate([W/2-0.75*ep_matiere,0,1]) cube([ep_matiere/2+tol_emboitement,W-ep_matiere+tol_emboitement,2.5], center=true);
	}
	translate([H/6,W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([-H/4,-W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
}

module xmax(){
		rotate([0,0,180]) difference(){
			xmin();
			translate([-H/2+ep_matiere/2,0,ep_matiere/2]) cube([ep_matiere+tol_emboitement,W+tol_emboitement,5], center=true);
		}
}

module ymin(){
	difference(){
		union(){
			linear_extrude(ep_matiere/2) square([L-ep_matiere,H],center=true);
			translate([0,0,ep_matiere/2]) linear_extrude(ep_matiere/2) square([L-2*ep_matiere,H],center=true);
		}
		translate([0,-H/2+0.75*ep_matiere,1]) cube([L+tol_emboitement,ep_matiere/2+tol_emboitement,2.5], center=true);
		translate([L/2-0.5*ep_matiere,W/2-0.25*ep_matiere,ep_matiere/2]) cube(ep_matiere+tol_emboitement, center=true);
		translate([-L/2+0.5*ep_matiere,W/2-0.25*ep_matiere,ep_matiere/2]) cube(ep_matiere+tol_emboitement, center=true);
		translate([-L/2+0.5*ep_matiere,-W/2+0.25*ep_matiere,ep_matiere/2]) cube(ep_matiere+tol_emboitement, center=true);
		translate([L/2-0.5*ep_matiere,-W/2+0.25*ep_matiere,ep_matiere/2]) cube(ep_matiere+tol_emboitement, center=true);
		translate([0,H/2-3*ep_matiere/4,ep_matiere/4]) cube([L,ep_matiere/2+tol_emboitement,ep_matiere/2+tol_emboitement], center=true);
	}
	translate([-L/3,-H/5+5,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([L/10,-H/5+5,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([L/3,H/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([-L/10,H/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
}

module ymax(){
	rotate([0,0,180]) ymin();
}

module up(){
	difference(){
		union(){
			linear_extrude(ep_matiere/2) square([L-ep_matiere/2,W-ep_matiere],center=true);
			translate([-ep_matiere/4,0,ep_matiere/2]) linear_extrude(ep_matiere/2) square([L-ep_matiere,W-2*ep_matiere],center=true);
			translate([-L/2+ep_matiere/2,0,ep_matiere/2]) cube([ep_matiere,W,ep_matiere], center=true);
		}
		translate([-L/2+10,0,12]) difference(){
			sphere(d=20);
			translate([-10.5,0]) cube(21, center=true);
		}
	}
	translate([-L/3,-W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([L/10,-W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([L/3,W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
	translate([-L/10,W/4,ep_matiere]){
		complete_bolt(d=16);
		if($preview) translate([0,0,30]) complete_nut(d=16);
	}
}

if($preview){
	down();
	translate([0,0,H/2]) rotate([0,90,0]) translate([0,0,L/2-ep_matiere]) xmin();
	translate([0,0,H/2]) rotate([0,-90,0]) translate([0,0,L/2-ep_matiere]) xmax();
	translate([0,0,H/2]) rotate([90,0,0]) translate([0,0,W/2-ep_matiere]) ymin();
	translate([0,0,H/2]) rotate([-90,0,0])translate([0,0,W/2-ep_matiere]) ymax();
	translate([-10,0,H-ep_matiere]) up();
}
else{
	if(export == "down") rotate([0,180,0]) down();
	if(export == "rear") xmin();
	if(export == "front") xmax();
	if(export == "left") ymin();
	if(export == "right") ymax();
	if(export == "up") up();
	if(export == "nut") rotate([0,180,0]) complete_nut(d=16);
}