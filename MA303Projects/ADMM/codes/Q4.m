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
error_cond=norm(A*xmin-b,2) % 计算是否符合约束条件，结果偏差很小

disp(' ')

disp('ImplementIt result')
tic;
xmin2=ImplementIt(B,A,b)
fmin2=f(xmin2)
toc;
error_cond2=norm(A*xmin2-b,2) % 计算是否符合约束条件

disp(' ')

disp('comparison')% 可将rng default 改为 rng shuffle，结果相同
minc=abs(fmin-fmin2)
err_cond_comp=abs(error_cond-error_cond2)
