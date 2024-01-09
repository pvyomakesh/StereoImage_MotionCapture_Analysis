% Showing the image and getting 3 points from the user for both images
figure; imshow("im1corrected.jpg");
title("Select Points in Image 1");
pts_img1 = ginput(3);
pts_img1_t = pts_img1.'; 

figure; imshow("im2corrected.jpg");
title("Select Points in Image 2");
pts_img2 = ginput(size(pts_img1_t, 2));
pts_img2_t = pts_img2.';

% Pixel coordinates to Homogenous coordinates
pts_img1_t = [pts_img1_t; ones(1, size(pts_img1_t, 2))];
pts_img2_t = [pts_img2_t; ones(1, size(pts_img2_t, 2))];

% Finding the 3D projected point of the input points
Projected_points = zeros(3,size(pts_img1_t, 2));
for j = 1:size(pts_img1_t, 2)
    % Calculating viewing ray for camera 1
    P1 = Rmat1.'*(inv(Kmat1))*pts_img1_t(:,j);
    P1 = P1/norm(P1); % Normalizing
    % Calculating viewing raw for camera 2
    P2 = Rmat2.'*(inv(Kmat2))*pts_img2_t(:,j);
    P2 = P2/norm(P2); % Normalizing
    w = cross(P1,P2); % Finding the vector along which the midpoint lies
    A = [P1, -P2, w]; % Setting up the system of equations to solve for [a, b, c]
    paramas = A\T; % Solving for the parameters
    v1 = O1+(paramas(1)*P1); % Viewing ray 1 in 3D
    v2 = O2+(paramas(2)*P2); % Viewing ray 2 in 3D
    Projection = (v1+v2)/2;
    Projected_points(:,j) = Projection;
end

% Finding the plane that fits the 3 points
v1 = Projected_points(:,1) - Projected_points(:,2);% Vector along Point 1 and 2
v2 = Projected_points(:,1) - Projected_points(:,3);% Vector along Point 2 and 3 
n = cross(v1, v2); % Normal vecrtor to v1 and v2
n = n/norm(n); % Normalizing the normal vector
D = -dot(n, Projected_points(:,1));% Calculating the constant part of the equantion

% Incase our z component comes out to be negative
if n(3) < 0
    n = -n;
    D = -D;
end

Plane_eqn = [n; D];

fprintf("Equation of the plane is (%f)x + (%f)y + (%f)z + (%f)\n", n(1), n(2), n(3), D)

