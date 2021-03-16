function [soundGuit,blk] = GuitarRy(f,t)
% 该函数周期为2，改变频率*2f
% harm=(-1./4.*sin(3.*pi.*2.*f.*t)+1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t));
% harm=-1./4.*sin(3.*pi.*2.*f.*t)+1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t)+1./2.*sin(2.*pi.*2.*f.*t);
% harm=-1./4.*sin(4.*pi.*2.*f.*t)-sqrt(3)./4.*sin(3.*pi.*2.*f.*t)+1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t)+1./2.*sin(2.*pi.*2.*f.*t);
% harm=-sqrt(3)./4.*sin(3.*pi.*2.*f.*t)+1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t)+1./2.*sin(2.*pi.*2.*f.*t);
% harm=1./4.*sin(3.*pi.*2.*f.*t+1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t));
% harm=1./4.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t)+1./2.*sin(2.*pi.*2.*f.*t)-1./4.*sin(3.*pi.*2.*f.*t);
harm=sqrt(3)./2.*sin(pi.*2.*f.*t)+sqrt(3)./2.*cos(pi.*2.*f.*t)+sqrt(3)./2.*sin(2.*pi.*2.*f.*t)+sqrt(3)./2.*cos(2.*pi.*2.*f.*t)-1./4.*sin(3.*pi.*2.*f.*t)-1./4.*cos(3.*pi.*2.*f.*t);

% a=-5;b=-10;
% A=exp(a*t)-exp(b*t)-(exp(a*t(end))-exp(b*t(end)));% amplitude

a=0.5*1e-3;k=5;
A=t.^a./exp(k.*t);

soundGuit=A.*harm;

soundGuit=soundGuit./max(soundGuit,2);
% soundP=soundP./max(soundP,2);
% fs=44100;
% sound(soundP(1,:),fs)
% plot(soundP(1,:))

blk = zeros(size(A));
end