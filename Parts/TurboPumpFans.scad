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
    intersection()
    {
        color("green")union() 
        {
            bot_r = 100/6;
            top_r = 100;
            delta_r = top_r - bot_r;
            
            exp_pow = 3;
            end_point = 1 - 1/exp(exp_pow*1); 
            offset_slicing = round(10*(1/((100-10)/100))); 
            layer_h = 20/offset_slicing;
            for (i=[0:offset_slicing-1])
            {
                if (i < 10) 
                { 
                    offset_r = delta_r*((1-1/exp(exp_pow*(i/10)))/end_point); //Normalised N
                    offset_r_increment = delta_r*((1-1/exp(exp_pow*((i+1)/10)))/end_point); //Normalised N+1  
                    translate([0,0,i*layer_h])
                    cylinder(layer_h, bot_r + offset_r, bot_r + offset_r_increment, center=false, $fn=20);
                }
                else 
                {
                    translate([0,0,i*layer_h])
                    cylinder(layer_h, top_r, top_r, center=false, $fn=20);
                }    
            }
        }
        
        linear_extrude(height=20, centre=false, convexity=10, twist=10, slices=10)
        {
            compositing();
        }
    }
}