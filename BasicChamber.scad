$fs = 0.1;
$fa = 5;

module aerospike(aH, aeroD, thickness)
{
    translate ([0,0,-20])
        {
            pipe(155, aeroD, thickness);
        }

        translate([0,0,-120])
        {
            color("grey")cylinder(100, 0, aeroD);
        }
}
module pipe (cH, outerD, thickness)
{
	difference()
	{
		color ("grey") cylinder(cH, r = outerD, centre = true);
		translate([0,0,-1])
		{
			color("orange") cylinder(cH + 2, r = (outerD-thickness*2), centre = true);
	    }
	}
}


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


module chamber(cH, aH, outerD, aeroD, thickness)
{
    if (2 * thickness > outerD)
    {
        echo("To THICK"); 
    }
    else 
    {   
        aerospike(aH, aeroD, thickness);
//        echo("lets continue");
//        innerD = outerD - (2 * thickness);
//        pipe(cH, outerD, thickness);
//    
//        translate ([0, 0, cH])
//        {
//            hemisphere(outerD, innerD);
//        }
//    
//        //this bit needs to be automated but doing manually is fine for now
//        rotate([0, 180, 0])
//        {
//            difference()
//            {
//                hemisphere(outerD, innerD);
//                translate([0,0,-outerD*0.5])
//                {
//                    color("orange") cylinder(outerD*2.3, 0, outerD);
//                }
//            }
//        }
    }
}

translate([0, 0, 0])
{
    difference()
    {   
        chamber(cH = 100, aH = 100, outerD = 40, aeroD = 20, thickness = 2);
        translate([0, 0, 130])
        {
        color("orange") cylinder(10, 10, 10);
        }
    }
}


