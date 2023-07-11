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
## The Program - General

  1- Identify where the outer wall is, this will make the program know if it uses the orange line or blue line to turn and follow the wall again.
  
  2- Identify the objects and their respective colour to bypass them by the respective side.
    Using the camera, we detect the colours by selecting a threshold with the OpenMV software, then we send the information as bits to the Main processor.
  ![Screenshot (5)](https://github.com/ImSimao/Future-Engineers/assets/138500914/bc0c6cec-5bdb-462a-9902-3587a5821a8d)

  3- When it detects a blue or orange line (depending on the side it is using) turn to the respective side.
    We detect the lines using an RGB sensor connected to the slave processor 14M2, this processor has been programmed with the values of the colours of the lines and when it detects a line it sends the information as bits to the main. 
  
  4- The program knows when to stop by counting how many times it passed by the lines, after 12 times it moves forward a bit more and then completely stops.

### The Program - Main.bas

  The Main program starts by looping the sonars routine to keep checking and detecting for the outer wall

  >Inicio2:
>
  > if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_esq_2_1
>
  > if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_2
>
  > if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita_in_2
>
  > if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda_in_2
>
  >goto inicio2:

This routine checks the sonars from left, right and front to see if theres any obstacle or wall in front of the robot, then it starts following the outer wall.

When the front sonar detects and object within a predetermined distance it triggers the routine to bypass the object:

>frente_contornar_2:
>
>PULSOUT c.0, 1
>
>PULSIN c.0, 1, w1
>
>if w1<421 then cores_2
>                   
>if w1>420 and w1<701 then frente_lento_r_2
>
>if w1>700 then frente_frente_r_2
>
>goto inicio2

The routine "cores_2" checks if there are any lines to make the turn, if there isn't it, it will check again the distance, if it's near enought to begin the bypassing routine it will go to "frente_lento_r_2" and will slow down and then bypass it, if it's still far enought it will continue moving forward at the default speed.

The "contornar_verde_cego" and " contornar_vermelho_cego" routines will use the sharp to detect the objetc while bypassing it, beeing the only difference, if it bypasses it by the right or the left.

>contornar_verde_cego:
>
>readadc10 A.0,w4    'SHARP DIREITA
>
>if w4<241 then direita6_r
>    
>if w4>240 and w4<261 then direita5_r
>               
>if w4>260 and w4<281 then direita3_r
>     
>if w4>280 and w4<301 then direita1_r   
>
>if w4>300 and w4<351 then frente_r     
>
>if w4>350 then frente_r
>
>return


### RGB - 14M2.bas

This Program only controls the RGB sensor.

It starts with a loop to keep cheking for lines, if the values collected are in the threshhold of the colour of the line then it will count the time to check if it is not a false positive, if it is not a false positive then it will comunicate with the main processor informing it that there is a line.

>inicio:
>
>low 
>
>low 4
>
>count 3,50,w1
>
>high 4
>
>count 3,50,w2
>
>high 1
>
>count 3,50,w3
>
>debug
>
>'if w1>120 and w1<200 and w2>240 and w2<330 and w3>50 and w3<120 then laranja
>
>'if w1>50 and w1<110 and w2>110 and w2<200 and w3>30 and w3<90 then laranja
> 
>if w1>45 and w1<78 and w2>83 and w2<130 and w3>20 and w3<50 then laranja
>
>'if w1>70 and w1<130 and w2>500 and w2<590 and w3>170 and w3<230 then azul
>
>if w1<1000 and w2<1000 and w3<1000 then inicio
>
>goto inicio


 




  
  


