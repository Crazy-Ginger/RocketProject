$fs = 0.1;
$fa = 2.5;

module outlet(thickness)
{
    rotate([0,90, 0])
    {
    color("red")cylinder(thickness + 0.5, 0.5, 0.5,true);
    }
}
//


H = 8;
outerD = 5;
thickness = 1;
difference()
    {
color ("grey") cylinder(H, r = outerD);
translate([0,0,-1]){	color("orange") cylinder(H + 2, r = (outerD-thickness)); }

translate([4.5,0,4]){outlet(0.8);}
translate([-4.5,0,4]){outlet(0.8);}
translate([0,4.5,4]){rotate([0,0,90]){outlet(0.8);}}
translate([0,-4.5,4]){rotate([0,0,90]){outlet(0.8);}}

}

