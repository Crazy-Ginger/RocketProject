module testing1p1(length, width, height)
{
    radius = (pow(length,2) + 4*pow(height,2))/(8*height);
    translate([0,-radius+height,0])
    difference()
    {
        color("grey")circle(r=radius+width);
        color("orange")circle(r=(radius));
    }
}
//

module testing1p2(length, width, height)
{
    radius = (pow(length,2) + 4*pow(height,2))/(8*height);
    translate([-(radius+width),-(radius+width)*2,0,])
    color("green")square([(radius+width)*2,(radius+width)*2]);
}
//

module testing2(length, width, height)
{

    union() 
    {
        translate([-length,-height]) 
        square([length/2,height*2]);
        translate([length/2,-height])     
        square([length/2,height*2]);
    }
}
//

module myarc(length, width, height)
{
    //r = (l^2 + 4*b^2)/8*b 
    radius = (pow(length,2) + 4*pow(height,2))/(8*height);
    //echo(radius);
    translate([length/2,0,0])
    difference() 
    {
        difference() 
        {
            translate([0,-radius+height,0])
            difference() 
            {
                circle(r=radius+width);
                circle(r=(radius));
            }
            
            translate([-(radius+width),-(radius+width)*2,0,])
            square([(radius+width)*2,(radius+width)*2]);
        }
        union() 
        {
            translate([-length,-height]) 
            square([length/2,height*2]);
            translate([length/2,-height])     
            square([length/2,height*2]);
        }
    }
}
//

module compositing(length = 100, width = 4, height = 100)
{
    //myarc(100, 4, 100);//simulates this
    difference()
    {
        testing1p1(100, 4, 100);
        testing1p2(100, 4, 100);
        testing2(100, 4, 100);
    }    
}
//


union()
{        
    linear_extrude(height=20, centre=false, convexity=10, twist=10, slices=10)
    {
        translate([0, -1])
        {
            compositing();
        }
    }
}