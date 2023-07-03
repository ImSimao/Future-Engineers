
setfreq m32

inicio:

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2
high 1
count 3,50,w3

debug


'if w1>120 and w1<200 and w2>240 and w2<330 and w3>50 and w3<120 then laranja
'if w1>50 and w1<110 and w2>110 and w2<200 and w3>30 and w3<90 then laranja  
if w1>45 and w1<78 and w2>83 and w2<130 and w3>20 and w3<50 then laranja

'if w1>70 and w1<130 and w2>500 and w2<590 and w3>170 and w3<230 then azul

if w1<1000 and w2<1000 and w3<1000 then inicio
goto inicio


 
 


laranja:
let b0=b0+1

if b0=8  then informa

if b0>11 then parar
if b0<12 then contar_1
goto inicio


contar_1:
'low 3    'informa??o para placa n?e no alterar ascores  pino b,1 'luz amarelo
high 5    'informa??o  laranja para placa n?e no pino b,2 'luz vermelho
'high 2    'rel? de parar
pause 1500   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto inicio


informa:
high 3    'informa??o para placa n?e no pino b,1 'luz amarelo
high 5    'informa??o para placa n?e no pino b,2 'luz vermelho
'high 2     'rel? de parar
pause 1500   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto inicio


parar:
high 3    'informa??o para placa n?e no pino b,1 'luz amarelo
high 5    'informa??o para placa n?e no pino b,2 'luz vermelho
'high 2     'rel? de parar
pause 1500   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto parar2


parar2:
low 2
pause 25000
high 2       'rel? de parar
'pause 1000
pause 10000
goto inicio






