$fs = 0.1;
$fa = 5;

module outletF(thickness)
{
    rotate([0,90, 0])
    {
    color("red")cylinder(thickness + 0.2, 0.2, 0.2, true);
    }
}
//

module pipe (H, outerD, thickness)
{
	difference()
	{
		color ("grey") cylinder(H, r = outerD);
		translate([0,0,-0.1])
		{
			color("orange") cylinder(H + 1, r = (outerD-thickness));
	    }
	}
}
//

module aerospike(aH, aeroD, thickness)
{
    translate ([0,0,-2])
    {
        pipe(aH - 0.5, aeroD, thickness);
    }
    //should be automated but manual is ok for now
    translate([0,0,-12])
    {
        color("grey")cylinder(10, 0, aeroD);
    }
    
    //outflow pipes
    outletF(thickness);
}
//

module hemisphere(outerD, innerD)
{
    intersection()
	{
		difference()
		{
			color("grey") sphere(outerD);
			color("orange") sphere(innerD); 
		}
		translate([-outerD, -outerD, 0])
		{
			color("orange") cube([outerD*2, outerD*2, outerD]);
		}
    }
}
//

module chamber(cH, outerD, aeroD, thickness)
{
    aerospike((cH + (1.5*outerD)), aeroD, thickness);
    echo("AeroSpike: check");

    innerD = outerD - (thickness);
    //outer Chamber
    union()
    {
        pipe(cH, outerD, thickness);
        echo("Main chamber: check");
        translate ([0, 0, cH])
        {
            hemisphere(outerD, innerD);
        }
        echo("Upper hemisphere: check");
    
        rotate([0, 180, 0])
        {
            difference()
            {
                hemisphere(outerD, innerD);
                
                //area of throat controlled here
                translate([0, 0, -outerD*0.5])
                {
                    color("orange") cylinder(outerD*2.3, 0, outerD);
                }
            }
    
        }
        echo("Lower hemisphere: check");
    }
}
//
render(convexity = 2)
{
translate([0, 0, 0])
{
    difference()
    {   
        chamber(cH = 10,  outerD = 4, aeroD =2, thickness = 0.2, display =  false);
        translate([0, 0, 13])
        {
        color("orange") cylinder(1, 1, 1);
        }
    }
}
}
