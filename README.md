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
* `schemes` contains one or several schematic diagrams in the form of JPEG, PNG or PDF of the electromechanical components illustrating all the elements (electronic components and motors) used in the vehicle and how they connect to each other.
* `src` contains the code of control software for all components which were programmed to participate in the competition
* `models` is for the files for models used by 3D printers, laser cutting machines and CNC machines to produce the vehicle elements. If there is nothing to add to this location, the directory can be removed.
* `other` is for other files which can be used to understand how to prepare the vehicle for the competition. It may include documentation on how to connect to a SBC/SBM and upload files there, datasets, hardware specifications, communication protocols descriptions etc. If there is nothing to add to this location, the directory can be removed.
***
## `SRC` Source code description
In the [`src`](/src) directory exits 2 subdirectories [`Picaxe`](/src/Picaxe) and [`camera`](/src/camera), in the subdirectory `Picaxe` there are 2 Programs written in basic picaxe, in the subdirectory `camera` there is the program that runs on our camera.

To run and program with Picaxe it is needed to install the Picaxe IDE from their website and install the drivers, then connect the cable to the robot and hit program. In this robot, we use a pickaxe 28x2 as the Main and a 14M2 as a slave to control the RGB sensor and another picaxe 28x2 for the motors.

To use and operate the camera we use OpenMV, we use a program made in Python, and all the libraries used are installed simultaneously with the OpenMV software. This program will identify the colour red or green and send it in bits to our main controller.
***
## The Program

  1- Identify where the outer wall is, this will make the program know if it uses the orange line or blue line to turn and follow the wall again
  
  2- Identify the objects and their respective colour to bypass them by the respective side.
    Using the camera, we detect the colours by selecting a threshold with the OpenMV software, then we send the information as bits to the Main processor.
  ![Screenshot (5)](https://github.com/ImSimao/Future-Engineers/assets/138500914/bc0c6cec-5bdb-462a-9902-3587a5821a8d)

  3- When it detects a blue or orange line (depending on the side it is using) turn to the respective side.
    We detect the lines using an RGB sensor connected to the slave processor 14M2, this processor has been programmed with the values of the colours of the lines and when it detects a line it sends the information as bits to the main. 
  
  4- The program knows when to stop by counting how many times it passed by the lines, after 12 times it moves forward a bit more and then completely stops
  
  


