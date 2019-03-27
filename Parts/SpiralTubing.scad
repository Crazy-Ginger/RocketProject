module spiralTube(r = 5, outerD = 2, thickness = 0.2)
{
    difference()
    {
        difference()
        {
			for(i = [0:360])
			{
				translate([r*sin(i), r*cos(i), i/50])color("gray")sphere($fn = 2, outerD);
			}
            translate([-(outerD*2), r- (outerD/2 +1), -(outerD)])color("orange")cube(outerD*2);
        }
		
        for(i = [0:360])
        {
		  translate([r*sin(i), r*cos(i), i/50])color("green")sphere($fn = 2, outerD-thickness);
        }
    }
}


spiralTube();