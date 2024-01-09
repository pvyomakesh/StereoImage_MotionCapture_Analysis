%Load parameters
load mocapPoints3D.mat;
Parameters_1 = load("Parameters_V1_1.mat", "Parameters");
Parameters_2 = load("Parameters_V2_1.mat", "Parameters");

%Loading Camera 1 parameters
Pmat1 = Parameters_1.Parameters.Pmat;
Rmat1 = Parameters_1.Parameters.Rmat;
Kmat1 = Parameters_1.Parameters.Kmat;

%Loading Camera 2 parameters
Pmat2 = Parameters_2.Parameters.Pmat;
Rmat2 = Parameters_2.Parameters.Rmat;
Kmat2 = Parameters_2.Parameters.Kmat;

%3D to homogeneous
Points_homog = [pts3D; ones(1, size(pts3D, 2))];

%World Homogenous coordinates to Pixel Homogeneous coordintes for Camera 1
Pixel_homog_1 = zeros(3, 39);
for i = 1:size(Points_homog, 2)
    %Extracting point from Points matrix
    point = Points_homog(:,i);
    %Projecting point
    Projected_point = Kmat1*Pmat1*point;
    %Appending point to Points matrix
    Pixel_homog_1(:,i) = Projected_point;
    Pixel_homog_1(:,i) = Pixel_homog_1(:,i)/Pixel_homog_1(3,i);
end

%World Homogenous coordinates to Pixel Homogenous coordintes for Camera 2
Pixel_homog_2 = zeros(3,39);
for i = 1:size(Points_homog, 2)
    %Extracting point from Points matrix
    point = Points_homog(:,i);
    %Projecting point
    Projected_point = Kmat2*Pmat2*point;
    %Appending point to Points matrix
    Pixel_homog_2(:,i) = Projected_point;
    Pixel_homog_2(:,i) = Pixel_homog_2(:,i)/Pixel_homog_2(3,i);
end

%Pixel Homogenous coordinate to Pixel coordinate
Pixel_coord_1 = [Pixel_homog_1(1:2,:)];
Pixel_coord_2 = [Pixel_homog_2(1:2,:)];

%Plotting the points onto the image 1
image_1 = imread("im1corrected.jpg");
figure;
imshow(image_1);
title("Plotted image 1")
axis on;
hold on;
x_1 = Pixel_coord_1(1,:);
y_1 = Pixel_coord_1(2,:);
image_1 = plot(x_1,y_1,'ro');
hold off;

%Plotting the points onto the image 2
image_2 = imread("im2corrected.jpg");
figure;
imshow(image_2);
title("Plotted image 2");
axis on;
hold on;
x_1 = Pixel_coord_2(1,:);
y_1 = Pixel_coord_2(2,:);
image_2 = plot(x_1,y_1,'ro');
hold off;
