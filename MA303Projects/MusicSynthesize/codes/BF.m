function id=BF(S,T)
ls=length(S);lt=length(T);
for i=1:ls-lt+1
   i_temp=i;
   flag=true;
   for j=1:lt
      if norm(S(i_temp,:)-T(j,:))>1e-4
          flag=false;
          break;
      end
      i_temp=i_temp+1;
   end
   if flag
       id=i;
       return;
   end
end
id=0;
end