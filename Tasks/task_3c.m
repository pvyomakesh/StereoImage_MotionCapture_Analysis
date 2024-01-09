% Showing the image and getting the points from the user for both images
figure; imshow("im1corrected.jpg");
title("Select Points in Image 1");
pts_img1 = ginput;
pts_img1_t = pts_img1.'; 

figure; imshow("im2corrected.jpg");
title("Select Points in Image 2");
pts_img2 = ginput(size(pts_img1_t, 2));
pts_img2_t = pts_img2.';

% Pixel coordinates to Homogenous coordinates
pts_img1_t = [pts_img1_t; ones(1, size(pts_img1_t, 2))];
pts_img2_t = [pts_img2_t; ones(1, size(pts_img2_t, 2))];

% If the user only provides one point correspondance, then finding projected point 
if size(pts_img1_t, 2) == 1
    % Viewing ray for camera 1
    P1 = Rmat1.'*(inv(Kmat1))*pts_img1_t(:,1);
    P1 = P1/norm(P1); % Normalizing
    % Viewing raw for camera 2
    P2 = Rmat2.'*(inv(Kmat2))*pts_img2_t(:,1);
    P2 = P2/norm(P2); % Normalizing
    w = cross(P1,P2); % Finding the vector along which the midpoint lies
    A = [P1, -P2, w]; % Setting up the system of equations to solve for [a, b, c]
    paramas = A\T; % Solving for the parameters
    v1 = O1+(paramas(1)*P1); % Viewing ray 1 in 3D
    v2 = O2+(paramas(2)*P2); % Viewing ray 2 in 3D
    Projection = (v1+v2)/2; % Finding the midpoint
    fprintf("The 3D location of the porjected point is (%f, %f, %f)\n", Projection(1), Projection(2), Projection(3))
end

% If two points are given by the user, finding the Distance between the two
% points
Point_dst = zeros(3,2);
if size(pts_img1_t, 2) == 2
    for j = 1:size(pts_img1_t, 2)
        % Viewing ray for camera 1
        P1 = Rmat1.'*(inv(Kmat1))*pts_img1_t(:,j);
        P1 = P1/norm(P1); % Normalizing
        % Viewing raw for camera 2
        P2 = Rmat2.'*(inv(Kmat2))*pts_img2_t(:,j);
        P2 = P2/norm(P2); % Normalizing
        w = cross(P1,P2); % Finding the vector along which the midpoint lies
        A = [P1, -P2, w]; % Setting up the system of equations to solve for [a, b, c]
        paramas = A\T; % Solving for the parameters
        v1 = O1+(paramas(1)*P1); % Viewing ray 1 in 3D
        v2 = O2+(paramas(2)*P2); % Viewing ray 2 in 3D
        Projection = (v1+v2)/2; % Finding the midpoint
        Point_dst(:,j) = Projection;
    end
    Height = norm (Point_dst(:,1)-Point_dst(:,2));
    fprintf("The height of the object is %f(m)\n", Height/1000)
end