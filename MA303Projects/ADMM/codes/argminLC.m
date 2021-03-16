function xmin=argminLC(A,b,C,d)
[p,n]=size(C);
xz=[A'*A,C';C,zeros(p)]\[A'*b;d];
xmin=xz(1:n);
end