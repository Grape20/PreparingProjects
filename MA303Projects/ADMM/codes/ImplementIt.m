function xmin=ImplementIt(B,A,b)
%ImplementIt Algorithem completed! Implement it! 
% 推荐参数列表
% rho=2,errrel=1e-8,errabs=1e-8,uold=rand(p,1) 这组效果和fmincon差不多,
% 不过好像也没有比fmincon更好的参数，fmincon nb！

[p,n]=size(B);% substitute B as A is the same
rho=2;% rho avail 可调参数
errrel=1e-8;% errrel avail
errabs=1e-8;% errabs avail
x=A\b;zold=B*x;
uold=rand(p,1);% uold avail
iter=0;iterN=100000;
while iter<iterN % 人为控制迭代次数上限
    iter=iter+1;
    x=argminLC(B,zold-uold,A,b);
    znew=S(1./rho,B*x+uold);
    unew=uold+B*x-znew;
    snew=-rho.*B'*(znew-zold);
    rnew=B*x-znew;
    errdual=sqrt(n).*errabs+errrel.*norm(B'.*rho*unew,2);
    errpri=sqrt(p).*errabs+errrel.*max(norm(B*x,2),norm(znew,2));
    if norm(snew)<=errdual && norm(rnew)<=errpri % 终止条件
        break;
    end
    zold=znew;uold=unew;
    if iter==iterN % debug
        disp([norm(snew),errdual , norm(rnew),errpri]);
    end
end
fprintf('iter=%6.1f\n',iter);
xmin=x;
end