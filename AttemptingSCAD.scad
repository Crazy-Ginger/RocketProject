$fs = 0.1;
$fa = 5;


module pipe (cH, outD, innerD)
{
	difference()
	{
		color ("gray") cylinder(cH, r = outD, centre = true);
		translate([0,0,-1])
		{
			color("orange") cylinder(cH + 2, r = innerD, centre = true);
	    }
	}
}


module hemisphere(outerD, innerD)
{
    intersection()
	{
		difference()
		{
			color("gray") sphere(outerD);
			color("orange") sphere(innerD); 
		}
		translate([-outerD, -outerD, 0])
		{
			color("orange") cube([outerD*2, outerD*2, outerD]);
		}
    }
}


module chamber(cH, outerD, thickness)
{
	if (2 * thickness > outerD) 
	{
		echo("To THICK"); 
	}
	else 
		echo("lets continue");
		innerD = outerD - (2 * thickness);
		pipe(cH, outerD, innerD);
				
		translate ([0, 0, cH])
		{
			
		    hemisphere(outerD, innerD);
		}
		
		rotate([0, 180, 0])
		{
			hemisphere(outerD, innerD);
		}
	
}



translate([0, 0, -50])
{
	chamber(100, 40, 5);
}


