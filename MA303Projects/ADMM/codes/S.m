function res=S(k,a)
agk=(a>k).*(a-k);% a>k term
alnk=(a<-k).*(a+k);% a<-k term
aink=(abs(a)<=k).*0;% |a|<=k term
res=agk+alnk+aink;
end