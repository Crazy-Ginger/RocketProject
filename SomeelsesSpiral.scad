f = 10; 
h = 1; 
r = 5;
length = 360; 
//
module bar(Rc, x1, y1, z1, x2, y2, z2) 
{ 
    hull() { 
    translate([x1, y1, z1]) sphere(r=Rc, $fn = 20); 
    translate([x2, y2, z2]) sphere(r=Rc, $fn = 20); 
        } 
} 
//
//module sprialTube(length = 180, h = 1, f = 10)
//{
//    for( i = [0 : length] ) 
//        { 
//        bar(2, i/h, cos(i*f)*10, sin(i*f)*10, (i+1)/h, cos((i+1)*f)*10, sin((i+1)*f)*10); 
//    } 
//}
//
//spiralTube(180, 1, 10, centre = true);
//    
//The way I tried to bend the shape into a circle is: 

module sphereCall (length, r)
{
    for( i = [0 : length] ) 
        { 
        bar(1, r* sin(i), r*cos(i), i/10, r* sin(i+1), r* cos(i+1), (i/10)+1); 
        } 
}

sphereCall(length, r);
//the rest = sin(i)*100, cos(i*f)*10, 0, sin(i+1)*100, cos((i+1)*f)*10, 0
//z1 = sin(i*f)*10+i
//z2 = sin((i+1)*f)*10+(i+1)