clear;clc
format compact
% rng default
A = rand(5,8); B = rand(5,8); b = rand(5,1);

disp('fmincon result')
% fminbnd
f=@(x) norm(B*x,1);
x0=A\b;
tic;
[xmin,fmin]=fmincon(f,x0,[],[],A,b)
toc;
error_cond=norm(A*xmin-b,2) % �����Ƿ����Լ�����������ƫ���С

disp(' ')

disp('ImplementIt result')
tic;
xmin2=ImplementIt(B,A,b)
fmin2=f(xmin2)
toc;
error_cond2=norm(A*xmin2-b,2) % �����Ƿ����Լ������

disp(' ')

disp('comparison')% �ɽ�rng default ��Ϊ rng shuffle�������ͬ
minc=abs(fmin-fmin2)
err_cond_comp=abs(error_cond-error_cond2)
