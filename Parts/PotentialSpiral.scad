//#!C:\Users\matty\AppData\Local\Programs\Python\Python36-32
//# -*- coding: utf-8 -*-
//
//import math
//
//# define parameters
//rr = 26                     # radius of rotation
//r1 = 10                     # outer radius of tube                      
//r2 = 8                      # inner radius of tube
//scale = 2                   # scalefactor over rotation
//segments = 90               # segments of base circle   -> resolution
//rAngle = 180                # angle of rotation
//rSegments = 45              # segments of rotation      -> resolution
//
//def polyhedron(rr,radius,scale, segments, rAngle, rSegments):
//    stepAngle = 360/segments
//    rotAngle = rAngle/rSegments
//    points = '['                # string with the vector of point-vectors
//    faces = '['                 # string with the vector of face-vectors
//    sprs = (scale-1)/rSegments                  # scale per rSegment
//
//    # construct all points
//    for j in range(0,rSegments+1):
//        angle = j*rotAngle
//        for i in range(0,segments):
//            xflat = (math.sin(math.radians(i*stepAngle))*radius)            # x on base-circle
//            xscaled = xflat*(1 + sprs*j) + rr                       # x scaled (+ rr -> correction of centerpoint
//            xrot = math.cos(math.radians(angle))*xscaled                # x rotated
//            yflat = (math.cos(math.radians(-i*stepAngle))*radius)           # y on base-circle
//            yscaled = yflat*(1 + sprs*j)                        # y scaled
//            z = math.sin(math.radians(angle))*xscaled                   # z rotated
//            string  = '[{},{},{}],'.format(xrot,yscaled,z)
//            points += string
//
//    points += ']' 


use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <list-comprehension-demos/skin.scad>

fn=32;
$fn=60;

r1 = 25;
r2 = 10;
R = 40;
th = 2;

module tube()
{
    difference()
    {
        skin([for(i=[0:fn]) 
              transform(rotation([0,180/fn*i,0])*translation([-R,0,0]), 
                        circle(r1+(r1-r2)/fn*i))]);
        assign(r1 = r1-th, r2 = r2-th)
        skin([for(i=[0:fn]) 
              transform(rotation([0,180/fn*i,0])*translation([-R,0,0]), 
                        circle(r1+(r1-r2)/fn*i))]);
    }
}

tube();