$fs = 0.05;
$fa = 5;

module outletF(thickness)
{
    color("red")cylinder(thickness, 0.2, 0.2, true);
}
//

module outletO(thickness)
{
    color("green")cylinder(thickness*2, 0.2, 0.2, true);
}
//

module pipe (H, outerD, thickness)
{
    union()
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
}
//

module aerospike(aH, aeroD, thickness)
{
    union()
    {
        translate ([0,0,-2])
        {
            difference()
            {
                pipe(aH - 0.5, aeroD, thickness);
                
                //outflow pipes
                translate([0,aeroD - (thickness/2), aH*0.8]){rotate([90,0,0]){outletF(thickness*1.5);}}
                translate([0,-(aeroD - (thickness/2)), aH*0.8]){rotate([90,0,0]){outletF(thickness*1.5);}}
                translate([aeroD - (thickness/2),0, aH*0.8]){rotate([0,90,0]){outletF(thickness*1.5);}}
                translate([-(aeroD - (thickness/2)),0, aH*0.8]){rotate([0,90,0]){outletF(thickness*1.5);}}
            }
        }
        //should be automated but manual is ok for now
        translate([0,0,-12])
        {
            color("grey")cylinder(10, 0, aeroD);
        }
    }
}
//

module hemisphere(outerD, innerD)
{
    union()
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
}
//

module chamber(cH, outerD, aeroD, thickness)
{
    union()
    {
    aerospike((cH + (1.5*outerD)), aeroD, thickness);
    echo("AeroSpike: check");

    innerD = outerD - (thickness);
    //outer Chamber

        pipe(cH, outerD, thickness);
        echo("Main chamber: check");
        
        //upper hemisphere with inlets
        translate ([0, 0, cH])
        {
            difference()
            {
                hemisphere(outerD, innerD);
                translate([aeroD + (0.3* (outerD-aeroD)),0, 0.5 * outerD]){outletO(outerD);}
                translate([-(aeroD + (0.3* (outerD-aeroD))),0, 0.5 * outerD]){outletO(outerD);}
                translate([0,aeroD + (0.3* (outerD-aeroD)), 0.5 * outerD]){outletO(outerD);}
                translate([0,-(aeroD + (0.3* (outerD-aeroD))), 0.5 * outerD]){outletO(outerD);}
            }
        }
        echo("Upper hemisphere: check");
        
        //lower hemisphere with exhaust
        rotate([0, 180, 0])
        {
            union()
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
        }
        echo("Lower hemisphere: check");
    }
}
//

union()
{
    scale([100])
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