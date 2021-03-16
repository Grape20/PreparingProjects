function [soundGuit,blk] = GuitarMe(f,t)
% 该函数周期为2，改变频率*2f
harm=-1./4.*sin(3.*pi.*2.*f.*t)+1./2.*sin(2.*pi.*2.*f.*t)+...
    1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t);

a=0.5*1e-3;k=5;
A=t.^a./exp(k.*t);

soundGuit=A.*harm;

soundGuit=soundGuit./max(soundGuit,2);

blk = zeros(size(A));
end