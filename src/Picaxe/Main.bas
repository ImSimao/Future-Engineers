
'#no_data
'#no_table

inici:
low c.3              'led testes
serout c.5, N2400,(00)  'COLOCA O SERVO VIRADO PARA A FRENTE
servo 0, 125             
pause 200
goto iniciar

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

iniciar:
for b0=1 to 256             'TEMPO PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub linha_frente
next b0

linha_frente:
if pinb.3=0 and pinb.2=0 then frente_sharp  'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then anti_relogio   'AZUL
if pinb.3=0 and pinb.2=1 then relogio        'LARANJA
 
frente_sharp:
readadc10 A.2,w6         'sharp da  frente
if w6<201 then frente_r_cores
if w6>200 then pergunta_cor



frente_r_cores:                    'ANDAR EM FRENTE A VER CORES
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_r       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita4_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda4_r




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


pergunta_cor:
gosub parar
pause 200
if pinb.7=1 then contornar_vermelho_in  'b.7 define a cor na placa "openmv"
if pinb.7=0 then contornar_verde_in




contornar_vermelho_in:
serout c.5, N2400,(20)   
servo 0,170                 'VIRA PARA DIREITA
pause 700
for b0=1 to 190             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub contorna_vermelho_linha
next b0
goto iniciar

contorna_vermelho_linha:
if pinb.3=0 and pinb.2=0 then esquerda3_r  'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then anti_relogio   'AZUL
if pinb.3=0 and pinb.2=1 then relogio 





contornar_verde_in:
serout c.5, N2400,(20)   
servo 0,90                 'VIRA PARA ESQUERDA
pause 950
for b0=1 to 200             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub contorna_verde_linha
next b0
goto iniciar


contorna_verde_linha:
if pinb.3=0 and pinb.2=0 then direita3_r  'PERGUNTA AO SENSOR RGB  b.3 azul    -    b.2 laranja 
if pinb.3=1 and pinb.2=0 then anti_relogio   'AZUL
if pinb.3=0 and pinb.2=1 then relogio 


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


anti_relogio:
high c.2   'envia informação do inverter a marcha para a placa do RGB
gosub parar
pause 200
low c.2
goto segue_parede_cantos        'ENTRA NO inicio1


relogio:
low c.2   'envia informação do inverter a marcha para a placa do RGB
gosub parar
pause 200
low c.2
goto seguir_parede_esq_4_canto  'ENTRA NO inicio4





'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


inicio:   'Anti relógio

if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_dir
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3


frente_contornar:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1      'SONAR da FRENTE
if w1<151 then recua_cores
if w1>150 and w1<421 then cores'5  '420
if w1>420 and w1<701 then frente_lento 
if w1>700 then frente_rapido



cores:
gosub parar
pause 100
if pinb.7=1 then contornar_vermelho  'b.7 define a cor na placa "openmv"
if pinb.7=0 then contornar_verde


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

seguir_parede_dir:                    
if pinb.1=1 then pergunta_flag        'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then pergunta_led_verde



pergunta_flag:
if b1=1 then inverter_marcha          'pergunta a FLAG b1                      c,3 é a flag
if b1=0 then pergunta_led_verde



pergunta_led_verde:
if pinb.3=0 then segue_parede_dir  'PERGUNTA AO SENSOR RGB do azul
if pinb.3=1 then  segue_parede_cantos  


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_rapido:
if pinb.1=1 then pergunta_flag  'pergunta led amarelo - se tem 2 voltas está ligado      
if pinb.1=0 then frente_rapido_1

frente_rapido_1:
serout c.5, N2400,(20)
servo 0, 125             '120
pause 1
goto frente_contornar'inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_lento:
serout c.5, N2400,(17)
servo 0, 125             '120
pause 1
goto frente_contornar


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

recua_cores:
high c.1                    
serout c.5, N2400,(20)   
servo 0,125    'frente
pause 700          
low c.1
goto frente_contornar

'frente_contornar6:
'if b1=1 then contornar_vermelho
'if b1=0 then contornar_verde

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




segue_parede_dir:         'Seguir a parede fora dos cantos
low c.7    
PULSOUT c.7, 5                       'SONAR DA DIREITA  
PULSIN c.7, 1, w2            
if w2<491 then esquerda5                 
if w2>490 and w2<511 then esquerda3     
if w2>510 and w2<531 then esquerda1   

if w2>530 and w2<550 then frente     

if w2>549 and w2<571 then direita1  
if w2>570 and w2<591 then direita3     
if w2>590 then direita4  



'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



frente:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then frente_11   
if w1<201 then virar_na_parede


frente_11:
serout c.5, N2400,(30)
servo 0, 125                 '120 no centro
pause 1
goto inicio


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita11   
if w1<201 then virar_na_parede


direita11: 
serout c.5, N2400,(20)
servo 0,130            
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita2:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita22   
if w1<201 then virar_na_parede

direita22:
serout c.5, N2400,(20)
servo 0,135            
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita3:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita33   
if w1<201 then virar_na_parede

direita33:
serout c.5, N2400,(20)
servo 0,140            
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita44   
if w1<201 then virar_na_parede


direita44:
serout c.5, N2400,(20)
servo 0,150            
pause 1
goto inicio


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

'direita5:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita5_esquerda  
if w1<201 then virar_na_parede

direita5_esquerda:
serout c.5, N2400,(20)
servo 0,160            
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

'direita6:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then direita6_esquerda  
if w1<201 then virar_na_parede
goto inicio

direita6_esquerda:
serout c.5, N2400,(20)
servo 0,170            
pause 1
goto inicio


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda11   
if w1<201 then virar_na_parede

esquerda11:
serout c.5, N2400,(20)
servo 0, 120  
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda2:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda22   
if w1<201 then virar_na_parede

esquerda22:
serout c.5, N2400,(20)
servo 0, 115   
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda3:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda33   
if w1<201 then virar_na_parede

esquerda33:
serout c.5, N2400,(20)
servo 0, 110     
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda44   
if w1<201 then virar_na_parede

esquerda44:
serout c.5, N2400,(20)
servo 0, 100     
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda5:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda55   
if w1<201 then virar_na_parede

esquerda55:
serout c.5, N2400,(20)
servo 0, 90       
pause 1
goto inicio

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda6:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>200 then esquerda66   
if w1<201 then virar_na_parede

esquerda66:
serout c.5, N2400,(30)
servo 0, 80       
pause 1
goto inicio


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


virar_na_parede:      'VIRAR NA PAREDE
for b0=1 to 80             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub virar_na_parede1
next b0

for b0=1 to 100             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub virar_esquerda_parede
next b0
goto inicio



virar_na_parede1:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then recua_aaa
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3


recua_aaa:
high c.1                    
serout c.5, N2400,(20)   'direita  recuar
servo 0,170            
pause 1 '
low c.1
return


virar_esquerda_parede:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then esquerda4_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3





'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

segue_parede_cantos:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_dir_c'anto
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


seguir_parede_dir_c:                    
if pinb.1=1 then pergunta_flag_2        'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then seguir_parede_dir_canto



pergunta_flag_2:
if b1=1 then inverter_marcha          'pergunta a FLAG b1                      c,3 é a flag
if b1=0 then seguir_parede_dir_canto






seguir_parede_dir_canto:                    'SEGUIR PAREDE NOS CANTOS\
low c.7    
PULSOUT c.7, 5                  'SONAR DIREITA  
PULSIN c.7, 1, w2 
if w2<421 then esquerda622           
if w2>420 and w2<441 then esquerda522                 
if w2>440 and w2<461 then esquerda322     
if w2>460 and w2<481 then esquerda122   

if w2>480 and w2<500 then frente_virar_esquerda     

if w2>499 and w2<521 then direita122  
if w2>520 and w2<541 then direita322     
if w2>540 then direita322'direita422 



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda122:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE  550
if w1>100 then esquerda1_222  
if w1<101 then virar_no_canto

esquerda1_222:
serout c.5, N2400,(20)
servo 0,115            
pause 1
goto segue_parede_cantos


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda322:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda3_222  
if w1<101 then virar_no_canto

esquerda3_222:
serout c.5, N2400,(20)
servo 0,110            
pause 1
goto segue_parede_cantos

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda522:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda5_222  
if w1<101 then virar_no_canto

esquerda5_222:
serout c.5, N2400,(20)
servo 0,90            
pause 1
goto segue_parede_cantos

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda622:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda6_222  
if w1<101 then virar_no_canto

esquerda6_222: 
serout c.5, N2400,(20)
servo 0,80            
pause 1
goto segue_parede_cantos

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_virar_esquerda:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then frente_2_22   
if w1<101 then virar_no_canto

frente_2_22:
serout c.5, N2400,(20)
servo 0, 125             '120 no centro
pause 1
goto segue_parede_cantos


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita122:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita1_222  
if w1<101 then virar_no_canto

direita1_222: 
serout c.5, N2400,(20)
servo 0, 130       
pause 1
goto segue_parede_cantos

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita322:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita3_222  
if w1<101 then virar_no_canto

direita3_222: 
serout c.5, N2400,(20)
servo 0, 140       
pause 1
goto segue_parede_cantos

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita422:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita4_222  
if w1<101 then virar_no_canto

direita4_222: 
serout c.5, N2400,(20)
servo 0, 150       
pause 1
goto segue_parede_cantos




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



virar_no_canto:
gosub cores_canto
pause 1600          '2100
goto inicio


cores_canto:
high c.1                    
serout c.5, N2400,(20)   'dirita  recuar
servo 0,180   '175
pause 1           
low c.1
return





'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


      
inverter_marcha:         'INVERTER A MARCHA  'INVERTER A MARCHA  'INVERTER A MARCHA  'INVERTER A MARCHA

high c.2   'informa??o do inverter a marcha para a placa do RGB 


gosub parar
pause 100

gosub frente_r
pause 2000
goto recua_r_esquerda




recua_r_esquerda:
for b0=1 to 200                   ' recua 200
gosub recua_r_esquerda2
next b0

for b0=1 to 250                  'frente 256
gosub frente_inverte3
next b0

goto inverter_marcha3        '?????????????????????????????






recua_r_esquerda2:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then recua_r_esquerda_3
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4

recua_r_esquerda_3:
high c.1
serout c.5, N2400,(20)
servo 0, 80             'esquerda6
pause 1
low c.1
return




frente_inverte3:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_inverte4
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4'
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4




frente_inverte4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then frente_r  
if w1<301 then inverter_marcha3



inverter_marcha3:
for b0=1 to 150             'recua a ver cores  200   
gosub recua_r_esquerda2
next b0

goto inicio4      'MANDA PARA INICIO4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



contornar_verde: 'Virar ESQUERDA
let b1=0         'FLAG a 0




gosub parar
pause 100

for b0=1 to  256             'DESVIA DA LATA  'Para sair da frente da lata
gosub verificar_esquerda
next b0

verificar_esquerda:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_esquerda_lata
if pinb.4=0 and pinb.5=1 and pinb.6=0  then esquerda6_r        
if pinb.4=0 and pinb.5=0 and pinb.6=1  then esquerda6_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda6_r


virar_esquerda_lata:
gosub parar
pause 200
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_esquerda_lata_1
goto verificar_esquerda


virar_esquerda_lata_1:
gosub parar
pause 100

for b0=1 to 255                        
gosub Andar_frente_sharp_direita     'PROCURA A LATA COM O SHARP
next b0


goto inicio




Andar_frente_sharp_direita:
readadc10 A.0,w4             'SHARP DIREITA
if w4<251 then frente_r'_lento          
if w4>250 then contorna_objeto_verde    






contorna_objeto_verde:
for b0=1 to  220            'CONTORNA CEGO DA FRENTE 
gosub contornar_verde_cego
next b0


for b0=1 to  256              'CONTORNA  COM O SONAR DA FRENTE
gosub contornar_verde_sonar_frente
next b0





contornar_verde_sonar_frente:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>630 then contornar_verde_cego  
if w1>300 and w1<631 then frente_rr
if w1<301 then virar_esquerda_noverde      



frente_rr:
for b0=1 to  230                
gosub mede_frente
next b0
goto inicio


mede_frente:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then frente_r
if w1<301 then virar_na_parede    'ENCONTROU PAREDE 






contornar_verde_cego:
readadc10 A.0,w4    'SHARP DIREITA
if w4<241 then direita6_r            
if w4>240 and w4<261 then direita5_r                 
if w4>260 and w4<281 then direita3_r      
if w4>280 and w4<301 then direita1_r   

if w4>300 and w4<351 then frente_r     

if w4>350 then esquerda1_r




virar_esquerda_noverde:
serout c.5, N2400,(20)        'PARA VIRAR   E CONTINUAR NO INICIO                             acertar com 30 e a seguir for b0
servo 0,90           
pause 500 
goto inicio





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
let b1=1            'carrega a FLAF B1=1




gosub parar
pause 100
 

for b0=1 to  256             'DESVIA DA LATA   'Para sair da frente da lata
gosub verificar_direita
next b0


verificar_direita:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_direita_lata
if pinb.4=0 and pinb.5=1 and pinb.6=0  then direita6_r      
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita6_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then direita6_r



virar_direita_lata:
gosub parar
pause 200
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_direita_lata_1
goto verificar_direita


virar_direita_lata_1:
gosub parar
pause 100


for b0=1 to 255                          
gosub Andar_frente_sharp_esquerda     'PROCURA A LATA COM O SHARP
next b0


goto inicio





Andar_frente_sharp_esquerda:
readadc10 A.1,w5             'SHARP ESQUERDA
if w5<251 then  frente_r'_lento         
if w5>250 then contorna_objeto_vermelho 



contorna_objeto_vermelho:
for b0=1 to   50              'CONTORNA CEGO DA FRENTE  
gosub contornar_vermelho_cego
next b0

for b0=1 to   256              'CONTORNA COM O SONAR DA DIREITA  
gosub contorn_vermelho_sonar_dir
next b0




contorn_vermelho_sonar_dir:
low c.7    
PULSOUT c.7, 5    'SONAR DA DIREITA  
PULSIN c.7, 1, w2    
if w2>800 then contornar_vermelho_cego               
if w2<801 then inicio               'ENCONTROU parede e  seguir pasrede direita   




contornar_vermelho_cego:
readadc10 A.1,w5    'SHARP ESQUERDA
if w5<271 then esquerda6_r            
if w5>270 and w5<281 then esquerda5_r             
if w5>280 and w5<291 then esquerda4_r    
if w5>290 and w5<301 then esquerda3_r   
if w5>300 and w5<311 then esquerda2_r   
if w5>310 and w5<321 then esquerda1_r   

if w5>320 and w5<371 then frente_r     
if w5>370 then direita1_r



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'########################################################
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



frente_r:
serout c.5, N2400,(20)
servo 0, 125             '120
pause 1
return

frente_r_lento:
serout c.5, N2400,(18)
servo 0, 125             '120
pause 3
return

recua_r:
high c.1
serout c.5, N2400,(20)
servo 0, 125             '120
pause 1
low c.1
return


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita1_r:
serout c.5, N2400,(18)
servo 0,130           
pause 1
return

direita2_r:
serout c.5, N2400,(18)
servo 0,135            
pause 1
return

direita3_r:
serout c.5, N2400,(18)
servo 0,140          
pause 1
return

direita4_r:
serout c.5, N2400,(18)
servo 0,150         
pause 1
return

direita5_r:
serout c.5, N2400,(18)
servo 0,160            
pause 1
return


direita6_r:
serout c.5, N2400,(18)
servo 0,170            
pause 1
return


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1_r:
serout c.5, N2400,(18)
servo 0, 120              
pause 1
return

esquerda2_r:
serout c.5, N2400,(18)
servo 0, 115             
pause 1
return

esquerda3_r:
serout c.5, N2400,(18)
servo 0, 110             
pause 1
return

esquerda4_r:
serout c.5, N2400,(18)
servo 0, 100              
pause 1
return
esquerda5_r:
serout c.5, N2400,(18)
servo 0, 90              
pause 1
return

esquerda6_r:
serout c.5, N2400,(18)
servo 0, 80              
pause 1
return



'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################
'########################################################




inicio4:        'RELÓGIO



if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_esq_4
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4      
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4



frente_contornar_4:
PULSOUT c.0, 1     
PULSIN c.0, 1, w1              'SONAR da FRENTE                   
if w1<151 then recua_cores1_4
if w1>150 and w1<421 then cores_4
if w1>420 and w1<701 then frente_lento_4
if w1>700 then frente_rapido_4


cores_4:
gosub parar
pause 100
if pinb.7=1 then contornar_vermelho_4  'b.7 define a cor
if pinb.7=0 then contornar_verde_4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


seguir_parede_esq_4:                    
if pinb.1=1 then pergunta_flag_4        'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then seguir_parede_esq_44


seguir_parede_esq_44:
if pinb.2=0 then seguir_parede_esq_4_2         'PERGUNTA AO SENSOR RGB  LARANJA
if pinb.2=1 then seguir_parede_esq_4_canto  ' 


pergunta_flag_4:
if b1=1 then inverter_marcha_4          'pergunta a FLAG b1
if b1=0 then seguir_parede_esq_44


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

recua_cores1_4:
high c.1                    
serout c.5, N2400,(20)   
servo 0,125  'frente
pause 700          
low c.1
goto frente_contornar_4



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


frente_lento_4:
serout c.5, N2400,(17)
servo 0, 125             '
pause 1
goto frente_contornar_4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_rapido_4:
if pinb.1=1 then pergunta_flag_4        'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then frente_rapido_44

frente_rapido_44:
serout c.5, N2400,(20)
servo 0, 125            
pause 1
goto frente_contornar_4'inicio4



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


seguir_parede_esq_4_2:
low c.6    
PULSOUT c.6, 5    'SONAR DA ESQUERDA  
PULSIN c.6, 1, w3           
if w3<491 then direita5_4                 
if w3>490 and w3<511 then direita3_4     
if w3>510 and w3<531 then direita1_4   

if w3>530 and w3<550 then frente4_4     

if w3>549 and w3<571 then esquerda1_4  
if w3>570 and w3<591 then esquerda3_4     
if w3>590 then esquerda4_4  
 



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
 

frente4_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then frente1_4   
if w1<301 then virar_na_parede_recuar_4

frente1_4: 
serout c.5, N2400,(30)
servo 0, 125             '120 no centro
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


direita1_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita11_4   
if w1<301 then virar_na_parede_recuar_4

direita11_4: 
serout c.5, N2400,(20)
servo 0,130            
pause 1
goto inicio4

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita2_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita22_4   
if w1<301 then virar_na_parede_recuar_4

direita22_4: 
serout c.5, N2400,(20)
servo 0,135            
pause 1
goto inicio4

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita3_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita33_4   
if w1<301 then virar_na_parede_recuar_4

direita33_4: 
serout c.5, N2400,(20)
servo 0,140            
pause 1
goto inicio4

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita4_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita44_4   
if w1<301 then virar_na_parede_recuar_4

direita44_4: 
serout c.5, N2400,(20)
servo 0,150            
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita5_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita55_4   
if w1<301 then virar_na_parede_recuar_4

direita55_4: 
serout c.5, N2400,(20)
servo 0,160            
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita6_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then direita66_4   
if w1<301 then virar_na_parede_recuar_4

direita66_4: 
serout c.5, N2400,(20)
servo 0,170            
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


esquerda1_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda11_4   
if w1<301 then virar_na_parede_recuar_4

esquerda11_4: 
serout c.5, N2400,(20)
servo 0, 120  
pause 1
goto inicio4

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda2_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda22_4   
if w1<301 then virar_na_parede_recuar_4

esquerda22_4:
serout c.5, N2400,(20)
servo 0, 115   
pause 1
goto inicio4 

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda3_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda33_4   
if w1<301 then virar_na_parede_recuar_4

esquerda33_4:
serout c.5, N2400,(20)
servo 0, 110     
pause 1
goto inicio4

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda4_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda44_4   
if w1<301 then virar_na_parede_recuar_4

esquerda44_4:
serout c.5, N2400,(20)
servo 0, 100     
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

'esquerda5_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda55_4   
if w1<301 then virar_na_parede_recuar_4

esquerda55_4:
serout c.5, N2400,(20)
servo 0, 90       
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

'esquerda6_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then esquerda66_4   
if w1<301 then virar_na_parede_recuar_4

esquerda66_4:
serout c.5, N2400,(15)
servo 0, 80       
pause 1
goto inicio4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


virar_na_parede_recuar_4:

for b0=1 to 80             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub virar_na_parede1_4
next b0

for b0=1 to 100             '120 TEMPO DO VIRAR   PARA  ESQUERDA NO CANTO  A VER AS CORES      
gosub virar_esquerda_parede_4
next b0
goto inicio4



virar_na_parede1_4:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then recua_bbb
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4



recua_bbb:
high c.1                    
serout c.5, N2400,(20)   
servo 0,80            
pause 1   '800 ' 
low c.1
return


virar_esquerda_parede_4:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then direita4_r
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


seguir_parede_esq_4_canto:                                                    'SEGUIR PAREDE ESQUERDA NO CANTO
if pinb.4=0 and pinb.5=0 and pinb.6=0  then seguir_parede_esq4_v
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar_4       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3_4
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3_4




seguir_parede_esq4_v:                    
if pinb.1=1 then pergunta_flag_44        'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then seguir_parede_esq4_virar



pergunta_flag_44:
if b1=1 then inverter_marcha_4          'pergunta a FLAG b1                      c,3 é a flag
if b1=0 then seguir_parede_esq4_virar





seguir_parede_esq4_virar:              'SEGUIR PAREDE NO CANTO
low c.6    
PULSOUT c.6, 5    'SONAR DA ESQUERDA       'TODAS COM SONAR DA FRENTE PARA VIRAR NO CANTO
PULSIN c.6, 1, w3 
if w3<421 then direita6_22_4            
if w3>420 and w3<441 then direita5_22_4                
if w3>440 and w3<461 then direita3_22_4      
if w3>460 and w3<481 then direita1_22_4   

if w3>480 and w3<501 then frente_virar_dir_4

if w3>500 and w3<521 then esquerda1_22_4  
if w3>520 and w3<541 then esquerda3_22_4     
if w3>540 then esquerda3_22_4'esquerda4_22_4  

                                             
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

frente_virar_dir_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then frente_2_r_4   
if w1<101 then virar_no_canto_4

frente_2_r_4:
serout c.5, N2400,(20)
servo 0, 125             '120 no centro
pause 1
goto seguir_parede_esq_4_canto



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


direita1_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita1_222_4  
if w1<101 then virar_no_canto_4

direita1_222_4:
serout c.5, N2400,(20)
servo 0,130            
pause 1
goto seguir_parede_esq_4_canto


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita3_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita3_222_4  
if w1<101 then virar_no_canto_4


direita3_222_4:
serout c.5, N2400,(20)
servo 0,140            
pause 1
goto seguir_parede_esq_4_canto


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita5_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita5_222_4  
if w1<101 then virar_no_canto_4

direita5_222_4:
serout c.5, N2400,(20)
servo 0,160            
pause 1
goto seguir_parede_esq_4_canto

'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

direita6_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then direita6_222_4  
if w1<101 then virar_no_canto_4


direita6_222_4:
serout c.5, N2400,(20)
servo 0,170            
pause 1
goto seguir_parede_esq_4_canto



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda1_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda1_222_4  
if w1<101 then virar_no_canto_4

esquerda1_222_4: 
serout c.5, N2400,(20)
servo 0, 120       
pause 1
goto seguir_parede_esq_4_canto


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda3_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda3_222_4  
if w1<101 then virar_no_canto_4

esquerda3_222_4: 
serout c.5, N2400,(20)
servo 0, 110       
pause 1
goto seguir_parede_esq_4_canto


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

esquerda4_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda4_222_4  
if w1<101 then virar_no_canto_4

esquerda4_222_4: 
serout c.5, N2400,(20)
servo 0, 100       
pause 1
goto seguir_parede_esq_4_canto



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



esquerda6_22_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>100 then esquerda6_222_4  
if w1<101 then virar_no_canto_4

esquerda6_222_4: 
serout c.5, N2400,(20)
servo 0, 80       
pause 1
goto seguir_parede_esq_4_canto



'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


virar_no_canto_4:
gosub cores_canto_4
pause 1600

goto inicio4



cores_canto_4:
high c.1                    
serout c.5, N2400,(20)   'dirita a recuar
servo 0,80   
pause 1           
low c.1
return




'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


      
inverter_marcha_4:         'INVERTER A MARCHA  'INVERTER A MARCHA  'INVERTER A MARCHA  'INVERTER A MARCHA 

high c.2   'informa??o do inverter a marcha para a placa do RGB 


gosub parar
pause 100

gosub frente_r
pause 2000
goto  recua_r_direita


recua_r_direita:
for b0=1 to 200                   ' recua 200
gosub recua_r_direita2
next b0


for b0=1 to 250                  'frente 256
gosub frente_inverte3_4
next b0

goto inverter_marcha3_4



recua_r_direita2:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then recua_r_direita_3
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar    'inicio     
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3

recua_r_direita_3:
high c.1
serout c.5, N2400,(20)
servo 0, 170           ' direita6
pause 1
low c.1
return




frente_inverte3_4:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then frente_inverte4_4
if pinb.4=0 and pinb.5=1 and pinb.6=0  then frente_contornar       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita3
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda3




frente_inverte4_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then frente_r  
if w1<301 then inverter_marcha3_4



inverter_marcha3_4:
for b0=1 to 150             'recua a ver cores  200    
gosub recua_r_direita2
next b0

goto inicio      'MANDA PARA INICIO



'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


contornar_verde_4: 'Virar ESQUERDA
let b1=0         'FLAG a 0              METER A FLAG a 0

gosub parar
pause 100


for b0=1 to  256            
gosub verificar_esquerda4      'Para sair da frente da lata
next b0






verificar_esquerda4:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_esquerda_lata_4
if pinb.4=0 and pinb.5=1 and pinb.6=0  then esquerda6_r       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then esquerda6_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then esquerda6_r




virar_esquerda_lata_4:
gosub parar
pause 200
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_esquerda_lata_4_1
goto verificar_esquerda4


virar_esquerda_lata_4_1:
gosub parar
pause 100


for b0=1 to 255                        
gosub Andar_frente_sharp_direita_44
next b0

goto inicio4


Andar_frente_sharp_direita_44:
readadc10 A.0,w4             'SHARP DIREITA
if w4<251 then frente_r_lento                   
if w4>250 then contorna_objeto_verde_4    





contorna_objeto_verde_4:
for b0=1 to  50            'CONTORNA CEGO DA FRENTE 
gosub contornar_verde_cego
next b0

for b0=1 to  256              'CONTORNA 
gosub contornar_verde_cego_esq_4
next b0




contornar_verde_cego_esq_4:
low c.6    
PULSOUT c.6, 5    'SONAR ESQUERDA  
PULSIN c.6, 1, w3    
if w3>801 then contornar_verde_cego               
if w3<800 then inicio4 '              'ENCONTROU parede e  seguir pasrede esquerda   



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


contornar_vermelho_4: 'Virar DIREITA
let b1=1         'FLAG a 1\

gosub parar
pause 100

for b0=1 to  255            'Para sair da frente da lata
gosub verificar_direita4
next b0

goto inicio4


verificar_direita4:
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_direita_lata_4
if pinb.4=0 and pinb.5=1 and pinb.6=0  then direita6_r       
if pinb.4=0 and pinb.5=0 and pinb.6=1  then direita6_r
if pinb.4=1 and pinb.5=0 and pinb.6=0  then direita6_r




virar_direita_lata_4:
gosub parar
pause 200
if pinb.4=0 and pinb.5=0 and pinb.6=0  then virar_direita_lata_1_4
goto verificar_direita4



virar_direita_lata_1_4:
gosub parar
pause 100

for b0=1 to 255                   'para contornar 110       
gosub Andar_frente_sharp_esquerda_44
next b0

goto inicio4


Andar_frente_sharp_esquerda_44:
readadc10 A.1,w5             'SHARP ESQUERDA
if w5<251 then frente_r_lento        
if w5>250 then contor_vermelho_sonar_frente






contor_vermelho_sonar_frente:
for b0=1 to   200           'CONTORNA CEGO DA FRENTE     
gosub contornar_vermelho_cego_4
next b0

for b0=1 to   256              'CONTORNA COM SONAR DA FRENTE  
gosub contornar_vermelho_cego_dir_4
next b0






contornar_vermelho_cego_dir_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>630 then contornar_vermelho_cego_4                      'CONTORNAR O VERMELHO A VER CORES
if w1>300 and w1<631 then frente_rr_4
if w1<301 then virar_direita_novermelho_4      




frente_rr_4:
for b0=1 to  230                
gosub mede_frente_4
next b0
goto inicio4

mede_frente_4:
low 0
PULSOUT c.0, 1     
PULSIN c.0, 1, w1                     'SONAR da FRENTE
if w1>300 then frente_r
if w1<301 then virar_direita_novermelho_4      



contornar_vermelho_cego_4:
if pinb.1=1 then pergunta_flag_44       'pergunta led amarelo - se tem 2 voltas está ligado
if pinb.1=0 then contornar_vermelho_cego


contornar_vermelho_cego_cego:
'########################################################

virar_direita_novermelho_4:
serout c.5, N2400,(20)        'PARA VIRAR   E CONTINUAR NO INICIO4                       
servo 0,170          
pause 600           
goto inicio4




'########################################################
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'
'$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
'########################################################
'########################################################

parado_1:
serout c.5, N2400,(00)
servo 0, 125             
pause 1
end

parar:
serout c.5, N2400,(00)
servo 0, 125             
pause 1
return

