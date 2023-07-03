#no_data
#no_table

iniciar:
goto inicio2

inicio:

low c.3

if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_dir
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita_in
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda_in
goto inicio




frente_contornar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1
if w1<421 then cores                     'SONAR da FRENTE
if w1>420 and w1<701 then frente_lento_r 
if w1>700 then frente_frente_r
goto inicio




'frente_contornar3:
'readadc10 A.2,w21        'SHARP da frente
'if w21 <101 then frente_frente_r
'if w21 >100 and w21 <201 then frente_lento_r
'if w21 >200 then cores
'goto inicio

 
cores:
if pinb.1=1 then cores2
if pinb.1=0 then cores1
goto inicio

cores1:
if pinb.7=1 then contornar_vermelho 
if pinb.7=0 then contornar_verde
goto inicio


cores2:
if pinb.7=1 then contornar_verde 
if pinb.7=0 then contornar_vermelho
goto inicio


frente_frente_r:
serout c.5, N2400,(20)
servo 0, 120             '120
pause 1
goto inicio


frente_lento_r:
serout c.5, N2400,(15)
servo 0, 120             '120
pause 1
goto inicio


esquerda_in:
low c.0 
PULSOUT c.0, 5    
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1 >420  then esquerda2
if w1 <421 then cores'
goto inicio


direita_in:
low c.0 
PULSOUT c.0, 5    
PULSIN c.0, 1, w1                 'SONAR da FRENTE
if w1 >420  then direita2
if w1 <421 then cores'
goto inicio




seguir_parede_dir:
low c.7    
PULSOUT c.7, 5    'sonar da direita  
PULSIN c.7, 1, w2 
if w2<371 then esquerda6           
if w2>370 and w2<391 then esquerda5                 
if w2>390 and w2<411 then esquerda3     
if w2>410 and w2<431 then esquerda1   

if w2>430 and w2<450 then frente     

if w2>449 and w2<471 then direita1  
if w2>470 and w2<491 then direita3     
if w2>490 and w2<511 then direita4  '?????????????????
if w2>510 then direita4
goto inicio


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


frente:
serout c.5, N2400,(20)
servo 0, 120             '120 no centro
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1:
serout c.5, N2400,(20)
servo 0,125            
pause 1
goto inicio

direita2:
serout c.5, N2400,(20)
servo 0,130            
pause 1
goto inicio

direita3:
serout c.5, N2400,(20)
servo 0,135            
pause 1
goto inicio

direita4:
serout c.5, N2400,(20)
servo 0,145            
pause 1
goto inicio

direita5:
serout c.5, N2400,(20)
servo 0,155            
pause 1
goto inicio


direita6:
serout c.5, N2400,(20)
servo 0,165            
pause 1
goto inicio




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1:
serout c.5, N2400,(20)
servo 0, 115  
pause 1
goto inicio

esquerda2:
serout c.5, N2400,(20)
servo 0, 110   
pause 1
goto inicio

esquerda3:
serout c.5, N2400,(20)
servo 0, 105     
pause 1
goto inicio

esquerda4:
serout c.5, N2400,(20)
servo 0, 95     
pause 1
goto inicio

esquerda5:
serout c.5, N2400,(20)
servo 0, 85       
pause 1
goto inicio

esquerda6:
serout c.5, N2400,(30)
servo 0, 75       
pause 1
goto inicio



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

contornar_verde: 'Virar ESQUERDA

gosub virar_esquerda
pause 350

for b0=1 to 256                        
gosub Andar_frente_sharp_direita
next b0

goto inicio



Andar_frente_sharp_direita:
readadc10 A.0,w4             'SHARP DIREITA
if w4<201 then andar_frente_lento          
if w4>200 then contorna_objeto_verde    
return








contorna_objeto_verde:

for b0=1 to  100            'CONTORNA CEGO DA FRENTE 
gosub contornar_verde_cego
next b0

for b0=1 to  256              'CONTORNA 
gosub contornar_verde_cego_esq
next b0
goto inicio



contornar_verde_cego_esq:
low c.6    
PULSOUT c.6, 5    'SONAR ESQUERDA  
PULSIN c.6, 1, w3    
if w3>801 then contornar_verde_cego               
if w3<800 then inicio2 'inicio2_verde '              'ENCONTROU parede e  seguir pasrede esquerda   
return







virar_esquerda:
serout c.5, N2400,(30)
servo 0,85
pause 1           '145
return



virar_direita:
serout c.5, N2400,(30)
servo 0,165' 155
pause 1           '145
return



andar_frente_lento:
serout c.5, N2400,(20)
servo 0, 120           '120
pause 1
return



parado:
serout c.5, N2400,(0)
servo 0, 120             '120
pause 1
return



'##########################################
'###############################################
'##############################################
'
'
'#################################################


contornar_verde_cego:
readadc10 A.0,w4    'SHARP DIREITA
if w4<241 then direita6_r            
if w4>240 and w4<261 then direita5_r                 
if w4>260 and w4<281 then direita3_r      
if w4>280 and w4<301 then direita1_r   

if w4>300 and w4<351 then frente_r     

if w4>350 then frente_r
return
 


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


frente_r:
serout c.5, N2400,(20)
servo 0, 120             '120
pause 1
return

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1_r:
serout c.5, N2400,(18)
servo 0,125           
pause 1
return

direita2_r:
serout c.5, N2400,(18)
servo 0,130            
pause 1
return

direita3_r:
serout c.5, N2400,(18)
servo 0,135          
pause 1
return

direita4_r:
serout c.5, N2400,(18)
servo 0,145         
pause 1
return

direita5_r:
serout c.5, N2400,(18)
servo 0,155            
pause 1
return


direita6_r:
serout c.5, N2400,(18)
servo 0,165            
pause 1
return




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1_r:
serout c.5, N2400,(18)
servo 0, 115              
pause 1
return

esquerda2_r:
serout c.5, N2400,(18)
servo 0, 110             
pause 1
return

esquerda3_r:
serout c.5, N2400,(18)
servo 0, 105             
pause 1
return

esquerda4_r:
serout c.5, N2400,(18)
servo 0, 95              
pause 1
return
esquerda5_r:
serout c.5, N2400,(18)
servo 0, 85              
pause 1
return

esquerda6_r:
serout c.5, N2400,(18)
servo 0, 75              
pause 1
return


'########################################################
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################


contornar_vermelho: 'Virar DIREITA

gosub virar_direita
pause 320

for b0=1 to 256                   'para contornar 110       
gosub Andar_frente_sharp_esquerda
next b0

goto inicio



Andar_frente_sharp_esquerda:
readadc10 A.1,w5             'SHARP ESQUERDA
if w5<251 then andar_frente_lento          
if w5>250 then contorna_objeto_vermelho 
return






contorna_objeto_vermelho:
for b0=1 to   30           'CONTORNA CEGO DA FRENTE  
gosub contornar_vermelho_cego
next b0

for b0=1 to   256              'CONTORNA   
gosub contornar_vermelho_cego_dir
next b0

goto inicio





contornar_vermelho_cego_dir:
low c.7    
PULSOUT c.7, 5    'SONAR DA DIREITA  
PULSIN c.7, 1, w2    
if w2>801 then contornar_vermelho_cego               
if w2<800 then inicio_vermelho               'ENCONTROU parede e  seguir pasrede esquerda   
return




inicio_vermelho:        'GARANTIR QUE N?O SE VIRA PARA DIREITA NA SA?DA DO PINO VERMELHO
low c.3

if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_dir_vermelho
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita_in
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda_in
goto inicio


seguir_parede_dir_vermelho:
low c.7    
PULSOUT c.7, 5    'sonar da direita  
PULSIN c.7, 1, w2 
if w2<371 then esquerda6           
if w2>370 and w2<391 then esquerda5                
if w2>390 and w2<411 then esquerda3      
if w2>410 and w2<431 then esquerda1   

if w2>430 and w2<450 then frente     

if w2>449 and w2<471 then frente_vermelho    
if w2>470 and w2<491 then frente_vermelho       
if w2>490 and w2<511 then frente_vermelho  '?????????????????
if w2>510 then frente_vermelho
goto inicio

frente_vermelho:
serout c.5, N2400,(20)
servo 0, 120             '120 no centro
pause 1
goto inicio_vermelho








contornar_vermelho_cego:
readadc10 A.1,w5    'SHARP ESQUERDA

if w5<271 then esquerda6_r            
if w5>270 and w5<281 then esquerda5_r             
if w5>280 and w5<291 then esquerda4_r    
if w5>290 and w5<301 then esquerda3_r   
if w5>300 and w5<311 then esquerda2_r   
if w5>310 and w5<321 then esquerda1_r   

if w5>320 and w5<371 then frente_r     
if w5>370 then frente_r
return









if w5<251 then esquerda6_r            
if w5>250 and w5<261 then esquerda5_r             
if w5>260 and w5<271 then esquerda4_r    
if w5>270 and w5<281 then esquerda3_r   
if w5>280 and w5<291 then esquerda2_r   
if w5>290 and w5<301 then esquerda1_r   

if w5>300 and w5<351 then frente_r     
if w5>350 then frente_r
return






'########################################################
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################




inicio2:

high c.3

if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_esq_2_1
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_2       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita_in_2
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda_in_2
goto inicio2


seguir_parede_esq_2_1:
if pinb.2=0 then seguir_parede_esq_2  'PERGUNTA AO SENSOR RGB
if pinb.2=1 then virar_dir_2  'parado_1'
goto inicio2




seguir_parede_esq_2:
low c.6    
PULSOUT c.6, 5    'SONAR DA ESQUERDA  
PULSIN c.6, 1, w3 

if w3<501 then direita6_2            
if w3>500 and w3<511 then direita5_2                
if w3>510 and w3<531 then direita3_2      
if w3>530 and w3<551 then direita1_2   

if w3>550 and w3<571 then frente_2

if w3>570 then esquerda6_2                                               
goto inicio2





virar_dir_2:
low c.3

if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_esq_2_2
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_2       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita_in_2
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda_in_2
goto virar_dir_2


seguir_parede_esq_2_2:
low c.6    
PULSOUT c.6, 5    'SONAR DA ESQUERDA  
PULSIN c.6, 1, w3 

if w3<501 then direita6_22            
if w3>500 and w3<511 then direita5_22                
if w3>510 and w3<531 then direita3_22      
if w3>530 and w3<551 then direita1_22   

if w3>550 and w3<571 then frente_virar_dir

if w3>570 then esquerda6_22                                               
goto virar_dir_2



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1_22:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>550 then direita1_222  
if w1<551 then virear_2_in2
goto virar_dir_2


direita1_222:
serout c.5, N2400,(20)
servo 0,125            
pause 1
goto virar_dir_2


direita3_22:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>550 then direita3_222  
if w1<551 then virear_2_in2
goto virar_dir_2

direita3_222:
serout c.5, N2400,(20)
servo 0,135            
pause 1
goto virar_dir_2



direita5_22:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>550 then direita5_222  
if w1<551 then virear_2_in2
goto virar_dir_2


direita5_222:
serout c.5, N2400,(20)
servo 0,155            
pause 1
goto virar_dir_2


direita6_22:
serout c.5, N2400,(20)
servo 0,165            
pause 1
goto virar_dir_2

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_virar_dir:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>550 then frente_2_r   
if w1<551 then virear_2_in2
goto virar_dir_2


frente_2_r:
serout c.5, N2400,(20)
servo 0, 120             '120 no centro
pause 1
goto virar_dir_2


virear_2_in2:
serout c.5, N2400,(20)        'PARA VIRAR e CONTINUAR NO INICIO 2
servo 0,165            
pause 1200
goto inicio2

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda6_22:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>550 then esquerda6_222  
if w1<551 then virear_2_in2
goto virar_dir_2



esquerda6_222: 
serout c.5, N2400,(20)
servo 0, 75       
pause 1
goto virar_dir_2


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  





frente_contornar_2:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1
if w1<421 then cores_2'                     'SONAR da FRENTE
if w1>420 and w1<701 then frente_lento_r_2
if w1>700 then frente_frente_r_2
goto inicio2












cores_2:
if pinb.1=1 then cores22
if pinb.1=0 then cores11
goto inicio2

cores11:
if pinb.7=1 then contornar_vermelho 
if pinb.7=0 then contornar_verde
goto inicio2


cores22:
if pinb.7=1 then contornar_verde 
if pinb.7=0 then contornar_vermelho
goto inicio2









if pinb.7=1 then contornar_vermelho 
if pinb.7=0 then contornar_verde
goto inicio2



frente_frente_r_2:
serout c.5, N2400,(20)
servo 0, 120             '120
pause 1
goto inicio2


frente_lento_r_2:
serout c.5, N2400,(15)
servo 0, 120             '120
pause 1
goto inicio2


esquerda_in_2:
low c.0 
PULSOUT c.0, 5    
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>420  then esquerda2_2
if w1<421 then cores_2'
goto inicio2



direita_in_2:
low c.0 
PULSOUT c.0, 5    
PULSIN c.0, 1, w1                 'SONAR da FRENTE
if w1>420  then direita2_2
if w1<421 then cores_2'
goto inicio2










'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


frente_2:
serout c.5, N2400,(20)
servo 0, 120             '120 no centro
pause 1
goto inicio2

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1_2:
serout c.5, N2400,(20)
servo 0,125            
pause 1
goto inicio2

direita2_2:
serout c.5, N2400,(20)
servo 0,130            
pause 1
goto inicio2

direita3_2:
serout c.5, N2400,(20)
servo 0,135            
pause 1
goto inicio2

direita4_2:
serout c.5, N2400,(20)
servo 0,145            
pause 1
goto inicio2

direita5_2:
serout c.5, N2400,(20)
servo 0,155            
pause 1
goto inicio2


direita6_2:
serout c.5, N2400,(20)
servo 0,165            
pause 1
goto inicio2




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1_2:
serout c.5, N2400,(20)
servo 0, 115  
pause 1
goto inicio2

esquerda2_2:
serout c.5, N2400,(20)
servo 0, 110   
pause 1
goto inicio2 

esquerda3_2:
serout c.5, N2400,(20)
servo 0, 105     
pause 1
goto inicio2

esquerda4_2:
serout c.5, N2400,(20)
servo 0, 95     
pause 1
goto inicio2

esquerda5_2:
serout c.5, N2400,(20)
servo 0, 85       
pause 1
goto inicio2

esquerda6_2:
serout c.5, N2400,(15)
servo 0, 75       
pause 1
goto inicio2



  

'########################################################
'########################################################


parado_1:
serout c.5, N2400,(00)
servo 0, 120             
pause 1
end







