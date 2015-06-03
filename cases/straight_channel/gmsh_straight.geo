c1 = 0.2;
Point(1) = {0, 0, 0, c1};
Point(2) = {10, 0, 0, c1};
Point(3) = {10, 2, 0, c1};
Point(4) = {0, 2, 0, c1};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Line Loop(1) = {1, 2, 3, 4};

Plane Surface(1) = {1};

Physical Line(7) = {4};
Physical Line(8) = {2};
Physical Line(9) = {1};
Physical Line(10) = {3};

Physical Surface(1) = {1};
