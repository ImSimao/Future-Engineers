# WRO 2023 [SG-1]

## TEAM:
Jaime Rei (coach)

Eleonor Silva

Joana Silva

Simão Freire

***
## Content

* `t-photos` contains 2 photos of the team (an official one and one funny photo with all team members)
* `v-photos` contains 6 photos of the vehicle (from every side, from top and bottom)
* `video` contains the video.md file with the link to a video where driving demonstration exists
* `schemes` contains one or several schematic diagrams in form of JPEG, PNG or PDF of the electromechanical components illustrating all the elements (electronic components and motors) used in the vehicle and how they connect to each other.
* `src` contains code of control software for all components which were programmed to participate in the competition
* `models` is for the files for models used by 3D printers, laser cutting machines and CNC machines to produce the vehicle elements. If there is nothing to add to this location, the directory can be removed.
* `other` is for other files which can be used to understand how to prepare the vehicle for the competition. It may include documentation how to connect to a SBC/SBM and upload files there, datasets, hardware specifications, communication protocols descriptions etc. If there is nothing to add to this location, the directory can be removed.

## `SRC` Source code description
In the [`src`](/src) directory exits 2 subdirectories [`Picaxe`](/src/Picaxe) and [`camera`](/src/camera), in the subdirectory `Picaxe` there are 2 Programms writen in basic picaxe, in the subdirectory `camera` there is the programm that runs on the camera.

To run and programm with picaxe it is needed to install the Picaxe IDE from their website and install the drivers, then connect the cable to the robot and hit programm. In this robot we use picaxe 28x2/40x2 as the Main and a 14M2 as a slave to control the RGB sensor as well the motors.

To use and operate the camera we use OpenMV.
