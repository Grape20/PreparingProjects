function [soundF,blk] = Fork(f,t)
A = sin(pi*t/t(end));
% Defining a basic amplitude function (So that the sound won't suddenly occur or vanish
soundF=A.*cos(2.*pi.*f.*t);
blk = zeros(size(A));
end