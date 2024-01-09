% Initializing
Symmetric_ep_dist = zeros(1, size(Pixel_homog_1, 2));

% Looping through all point correspondences
for i = 1:size(Pixel_homog_1, 2)
    % Compute=ing the epipolar lines
    line_img2 = F * Pixel_homog_1(:, i); % Epipolar line in image 2 for point i in image 1
    line_img1 = F' * Pixel_homog_2(:, i); % Epipolar line in image 1 for point i in image 2

    % Computing the distances of points from the epipolar lines
    dist_img2 = abs(dot(line_img2,Pixel_homog_2(:,i))) / ...
                sqrt(line_img2(1)^2 + line_img2(2)^2);
    dist_img1 = abs(dot(line_img1,Pixel_homog_1(:,i))) / ...
                sqrt(line_img1(1)^2 + line_img1(2)^2);

    % Finding the Symmetric epipolar distance
    Symmetric_ep_dist(1,i) = dist_img1 + dist_img2;
end

% Computing the mean symmetric epipolar distance
mean_symmetric_epipolar_distance = mean(Symmetric_ep_dist);

% Displaying the result
fprintf('The mean error distance is: %f\n', mean_symmetric_epipolar_distance)