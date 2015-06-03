hloc = 0.1;
Point(1) = {0, 0, 0, hloc};
Point(2) = {7, 0, 0, hloc};
Point(3) = {10, 0, 0, hloc};
Point(4) = {10, -3, 0, hloc};
Point(5) = {12, -3, 0, hloc};
Point(6) = {12,  0, 0, hloc};
Point(7) = {15,  0, 0, hloc};
Point(8) = {22,  0, 0, hloc};
Point(9) = {22,  2, 0, hloc};
Point(10) = {15,  2, 0, hloc};
Point(11) = {7,  2, 0, hloc};
Point(12) = {0,  2, 0, hloc};

Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,6};
Line(6) = {6,7};
Line(7) = {7,8};
Line(8) = {8,9};
Line(9) = {9,10};
Line(10) = {10,11};
Line(11) = {11,12};
Line(12) = {12,1};
Line(13) = {2,11};
Line(14) = {7,10};

Line Loop(1) = {1,13,11,12};
Line Loop(2) = {2,3,4,5,6,14,10,-13};
Line Loop(3) = {7,8,9,-14};

Plane Surface(1) = {1} ;   //main channel inlet zone
Plane Surface(2) = {2} ;   //junction zone
Plane Surface(3) = {3} ;   //main channel outlet zone

angle = 45.0;  //don't use 90 since it will allow degenerated quads, which are invalid in SRH-2D
Mesh.RecombinationAlgorithm = 1;
Recombine Surface {1,2,3} = angle;

Physical Line(1) = {12};   //main channel inlet boundary
Physical Line(2) = {4};   //branch inlet boundary
Physical Line(3) = {8};   //outlet
//Physical Line(4) = {1,2,3,5,6,7,9,10,11};   //wall

Physical Surface(1) = {1};  //main channel inlet zone
Physical Surface(2) = {2};  //junction zone
Physical Surface(3) = {3};  //main channel outlet zone
