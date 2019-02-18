$fs = 0.1;
$fa = 2.5;
difference(){
    color ("gray") cylinder(100, 40, 40, centre = false);
    translate([0,0,-1]){
    color("orange") cylinder(102, 30, 30, centre = false);
    }
}

translate ([0, 0, 100]) {
    hemisphere();
}

rotate([0, 180, 0]){
        hemisphere();
}

module hemisphere(){
    intersection(){
        difference(){
            color("gray") sphere(40);
            color("orange") sphere(30); 
        }
        translate([-40, -40, 0]){
            color("orange") cube([80, 80, 40]);
        }
    }
}