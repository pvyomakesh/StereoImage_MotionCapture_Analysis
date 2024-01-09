% Loading the locations of camera 1 and camera 2
O1 = transpose(Parameters_1.Parameters.position);
O2 = transpose(Parameters_2.Parameters.position);
T = O2 - O1;

% Calculating the Triangulated 3D points
pts3D_calc = zeros(3,39);
% Looping theough each pair of points
for j = 1:size(Points_homog,2)
    % Viewing ray for camera 1
    P1 = Rmat1.'*(inv(Kmat1)*Pixel_homog_1(:,j));
    P1 = P1/norm(P1); % Normalizing
    % Viewing raw for camera 2
    P2 = Rmat2.'*(inv(Kmat2)*Pixel_homog_2(:,j));
    P2 = P2/norm(P2); % Normalizing
    w = cross(P1,P2); % Finding the vector along which the midpoint lies
    A = [P1, -P2, w]; % Setting up the system of equations to solve for [a, b, c]
    paramas = A\T; % Solving for the parameters
    v1 = O1+(paramas(1)*P1); % Viewing ray 1 in 3D
    v2 = O2+(paramas(2)*P2); % Viewing ray 2 in 3D
    midpoints = (v1+v2)/2;
    pts3D_calc(:,j) = midpoints;
end

% Solving for mse
squareddiff = (pts3D_calc - pts3D).^2;
mse = sum(squareddiff, "all")/size(pts3D, 2);

fprintf("The mean square error is: %f\n", mse)

