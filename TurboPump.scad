$fa = 5;
$fs = 0.01;

difference()
{
    union()
    {
        cylinder(2, 17, 17, true);
        translate ([0, 0, 1])
        {
            color("grey")cylinder(10, 2.5, 2.5);
        }
    }
    translate([0,0,-2])
    {
        color("orange")cylinder(14, 1.5, 1.5, $fn = 3);
    }
}