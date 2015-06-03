lc = 0.5;

Point(1) = {0, 0, 0, lc};
Point(2) = {1, 0.0, 0, lc};
Point(3) = {5, -1,  0, lc} ; //Ellipse center point
Point(4) = {5, 1, 0, lc} ;  // Ellipse top point
Point(5) = {9, 0.0, 0, lc};
Point(6) = {10,  0.0, 0, lc} ;
Point(7) = {10, 3, 0, lc};
Point(8) = {9,  3, 0, lc} ;
Point(9) = {5, 2,  0, lc} ;  //Ellipse top point
Point(10) = {5, 4, 0, lc} ;  //Ellipse center point
Point(11) = {1, 3, 0, lc};
Point(12) = {0, 3, 0, lc} ;

Line(1) = {1,2};
Ellipse(2) = {4,3,3,2} ;
Ellipse(3)={4,3,3,5} ;
Line(4) = {5,6} ;
Line(5) = {6,7};
Line(6) = {7,8};
Ellipse(7) = {9,10,10,8} ;
Ellipse(8) = {9,10,10,11} ;
Line(9) = {11,12};
Line(10) = {12,1} ;

Line Loop(11) = {1,-2,3,4,5,6,-7,8,9,10} ;

Plane Surface(1) = {11} ;  

Physical Line(1) = {10};   //inlet
Physical Line(2) = {5};   //outlet
//Physical Line(3) = {1,-2,3,4};   //lower wall
//Physical Line(4) = {6,-7,8,9};   //upper wall

Physical Surface(1) = {1} ;