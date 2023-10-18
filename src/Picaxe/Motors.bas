inicio:
serin C.7, N2400, b1
pause 1
if pinc.4=0 then frente
if pinc.4=1 then recua
goto inicio


frente:
low b.7
high b.6
pwmout c.1,10,b1
goto inicio



recua:
high b.7
low b.6
pwmout c.1,10,b1
goto inicio
