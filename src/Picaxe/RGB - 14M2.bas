



setfreq m32


inici:

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3


'debug

if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then laranja_in

if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then azul_in

if w1<1000 and w2<1000 and w3<1000 then inici

goto inici




laranja_in:
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
pause 500  'tempo de passar em cima da cor
low 5
goto pergunta 



azul_in:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
pause 500  'tempo de passar em cima da cor
low c.1
goto pergunta


'#########################################################################

'################################################################################



pergunta:
if pinc.0=0 then relogio       'laranja
if pinc.0=1 then anti_relogio    'azul




relogio:
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
high c.1   'informação  azul para placa mãe no pino c.2 'lede verde
pause 60000 
low c.1 
low 5
goto inicio11




anti_relogio:
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
high c.1   'informação  azul para placa mãe no pino c.2 'lede verde
pause 60000 
low c.1 
low 5
goto inicio




'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################

inicio:     'ÁNTI RELÓGIO

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3

'debug


if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then laranja

if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then azul

if w1<1000 and w2<1000 and w3<1000 then inicio

goto inicio




laranja:
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
pause 3000  'tempo de passar em cima da cor
low 5
goto inicio 




azul:
let b0=b0+1
if b0=7  then informa   'anti relógio
'if b0<12 then contar_1
goto contar_1


contar_1:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
'high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 50000   'tempo de passar em cima da cor
low c.1
'low 3
low 5
low 2
goto inicio


informa:     'anti relógio
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
high 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
'high 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 8000   'tempo de passar em cima da cor
'low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto inicio2








'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################
'#########################################################################«############
'################################################################################


inicio11:     'RELÓGIO

low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3

'debug


if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then laranja_11

if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then azul_11

if w1<1000 and w2<1000 and w3<1000 then inicio11

goto inicio11




azul_11:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
pause 3000  'tempo de passar em cima da cor
low c.1
goto inicio11 




laranja_11:
let b0=b0+1
if b0=7  then informa_11
'if b0<12 then contar_1
goto contar_11


contar_11:
'high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 50000   'tempo de passar em cima da cor
low c.1
'low 3
low 5
low 2
goto inicio11


informa_11:
'high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
high 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
high 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 8000   'tempo de passar em cima da cor
'low c.1
low 3                                        'desliga o led amarelo
'low 5
low 2
goto inicio22





'#########################################################################
'#########################################################################«############
'################################################################################


'#########################################################################
'#########################################################################«############
'################################################################################

'#########################################################################
'#########################################################################«############
'################################################################################





inicio2:
let b0=0     'reset b0                     
if pinc.0=0 then parar_no_azul_1
if pinc.0=1 then parar_no_laranja_1



inicio22:
let b0=0        'reset b0   
if pinc.0=0 then parar_no_laranja_11
if pinc.0=1 then parar_no_azul_11


'#########################################################################«############
'################################################################################

  'vem do anti relógio

parar_no_azul_1:
let b1=0                                                             'coloca valor na b1
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
low 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 40000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_azul

'###########################

parar_no_laranja_1:
let b1=1                                                                 'coloca valor na b1
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
low 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 60000   'tempo de passar em cima da cor                            TEMPO DE DAE A VOLTA
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto prolonga_laranja_1'parar_no_laranja

prolonga_laranja_1:;
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
low 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 30000   'tempo de passar em cima da cor                            TEMPO DE DAE A VOLTA
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_laranja




'#########################################################################«############
'################################################################################

 'vem do relógio
 
 
parar_no_laranja_11:
let b1=0                                                            'coloca valor na b1
low c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
high 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 40000   'tempo de passar em cima da cor
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto parar_no_laranja



'#############################

parar_no_azul_11:
let b1=1                                                               'coloca valor na b1
low c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
high 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 60000   'tempo de passar em cima da cor                             TEMPO DE DAE A VOLTA
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto prolonga_azul_11' parar_no_azul

prolonga_azul_11:
low c.1 'informação  azul para placa mãe no pino c.2 'lede verde
low 3    'informação para placa nãe no pino b,1 'luz amarelo 2 voltas
high 5    'informação para placa nãe no pino b,2 'luz vermelho
'high 2     'relé de parar
pause 30000   'tempo de passar em cima da cor                             TEMPO DE DAE A VOLTA
low c.1
low 3                                        'desliga o led amarelo
low 5
low 2
goto  parar_no_azul

'#########################################################################«############
'################################################################################



parar_no_laranja:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3



if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then laranja_2

if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then azul_2

if w1<1000 and w2<1000 and w3<1000 then parar_no_laranja

goto parar_no_laranja




azul_2:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
pause 3000  'tempo de passar em cima da cor
low c.1
goto parar_no_laranja 




laranja_2:
if b1=0 then laranja_2a
if b1=1 then laranja_2b



laranja_2a:
let b0=b0+1
if b0=4  then parar_laranja
'if b0<12 then contar_1
goto contar_2


laranja_2b:
let b0=b0+1
if b0=3  then parar_laranja
'if b0<12 then contar_1
goto contar_2


contar_2:
low c.1 'informação  azul para placa mãe no pino c.2 'lede verde
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 50000   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto parar_no_laranja

parar_laranja:
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
high 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 3000   'tempo de passar em cima da cor
'low 3
low 5
low 2
goto parar'_final_azul


'#########################################################################


'parar_final_azul:
'low 1
'low 4
'count 3,50,w1
'high 4
'count 3,50,w2'
'high 1
'count 3,50,w3



'if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then parar 'azul_final

'if w1<1000 and w2<1000 and w3<1000 then parar_final_azul

'goto parar_final_azul






'#########################################################################
'#########################################################################«############
'################################################################################





parar_no_azul:
low 1
low 4
count 3,50,w1
high 4
count 3,50,w2'
high 1
count 3,50,w3


if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then laranja_3

if w1>0 and w1<20 and w2>65 and w2<90 and w3>10 and w3<30 then azul_3

if w1<1000 and w2<1000 and w3<1000 then parar_no_azul

goto parar_no_azul




laranja_3:
high 5 'informação para placa nãe no pino b,2 'luz vermelho
pause 3000  'tempo de passar em cima da cor
low 5
goto parar_no_azul



azul_3:
if b1=0 then azul_2a
if b1=1 then azul_2b


azul_2a:
let b0=b0+1
if b0=4 then parar_azul
'if b1<10 then contar_2
goto contar_3


azul_2b:
let b0=b0+1
if b0=3 then parar_azul
'if b1<10 then contar_2
goto contar_3


contar_3:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
'low 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 50000   'tempo de passar em cima da cor
low c.1 
'low 3
low 5
low 2
goto parar_no_azul

parar_azul:
high c.1 'informação  azul para placa mãe no pino c.2 'lede verde
'low 3    'informação para placa nãe no alterar ascores  pino b,1 'luz amarelo
'low 5    'informação  laranja para placa nãe no pino b,2 'luz vermelho
'high 2    'relé de parar
pause 3000   'tempo de passar em cima da cor
low c.1 
'low 3
low 5
low 2
goto parar'_final_laranja


'#########################################################################
'#########################################################################

'parar_final_laranja:
'low 1
'low 4
'count 3,50,w1
'high 4
'count 3,50,w2'
'high 1
'count 3,50,w3



'if w1>40 and w1<78 and w2>90 and w2<130 and w3>23 and w3<50 then parar 'laranja_final


'if w1<1000 and w2<1000 and w3<1000 then parar_final_laranja

'goto parar_final_laranja

'#########################################################################
'#########################################################################«############
'################################################################################
'#########################################################################«############
'################################################################################





parar: 'PARAR
low c.1 ' led azul
low 5   'led vermelho
low 2     
pause 60000 ' TEMPO A AJUSTAR ANTES DE PARAR     !!!!!!!!!!!(máximo 60000)


low c.1 ' led azul
low 5   'led vermelho
low 2     
pause 1000 ' TEMPO A AJUSTAR ANTES DE PARAR     !!!!!!!!!!!(máximo 60000)



high 2       'relé de parar
pause 10000
end



















  