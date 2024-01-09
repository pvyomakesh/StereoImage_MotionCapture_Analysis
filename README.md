# Stereo Imaging and Motion Capture Analysis
## Project Overview
This project focuses on exploring 3D scene reconstruction using stereo image pairs and motion capture data. Leveraging MATLAB, the project involves processing images with motion capture markers and applying various image processing and triangulation techniques to analyze the scene in three dimensions.

## Data Files
All data files are located in the [Data](Data) folder:

* **[im1corrected.jpg](Data/im1corrected.jpg) and [im2corrected.jpg](Data/im2corrected.jpg)**: Stereo image pair.
* **[Parameters_V1_1.mat](Data/Parameters_V1_1.mat) and [Parameters_V2_1.mat](Data/Parameters_V2_1.mat)**: Intrinsic and Extrinsic camera parameters.
* **[mocapPoints3D.mat](Data/mocapPoints3D.mat)**: Contains 3D motion capture point measurements of 39
markers on the person’s body. These are given in the world coordinate system with (0, 0, 0)
being the middle of the floor, positive Z-axis is up, and the units are in millimeters.

## Tasks
The MATLAB scripts for each task are located in the [Tasks](Tasks) folder:

* **[task1.m](Tasks/task_1.m)**: Projects 3D mocap points into 2D pixel locations.
* **[task2.m](Tasks/task_2.m)**: Performs triangulation to recover 3D points and compares accuracy using mean square error.
* **[task3a.m](Tasks/task_3a.m)**: Measures 3D locations on the floor and fits a 3D plane.
* **[task3b.m](Tasks/task_3b.m)**: Measures 3D locations on a wall with white vertical stripes and fits a plane.
* **[task3c.m](Tasks/task_3c.m)**: Additional measurements including doorway height, person height, and camera center location.
* **[task4.m](Tasks/task4.m)**: Computes the Fundamental matrix using the 8-point algorithm.
* **[task5.m](Tasks/task5.m)**: Calculates the accuracy of the epipolar lines using Symmetric Epipolar Distance.

## Running the Tasks
To run a task, navigate to the Tasks folder in MATLAB and execute the corresponding script. For example, to run Task 1, use:
run('Tasks/task1.m')

## Results and Analysis
Each script outputs the results of the task along with relevant visualizations and calculations. The scripts are designed to be self-contained demonstrations that showcase the methods used and the insights gained.

## Contributing
Contributions to this project are welcome. Please adhere to the existing code structure and document any changes or additions you make.
