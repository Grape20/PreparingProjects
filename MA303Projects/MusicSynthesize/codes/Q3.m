%% read
fs=44100;
f1=audioread('Music1.mp3');
f2=audioread('Music2.mp3');
f3=audioread('Music3.mp3');
f4=audioread('Music4.mp3');
f5=audioread('Music5.mp3');
fp1=audioread('musicpiece1.flac');
fp2=audioread('musicpiece2.flac');
fp3=audioread('musicpiece3.flac');
fp4=audioread('musicpiece4.flac');
fp5=audioread('musicpiece5.flac');
%% (1)
% piece 1
id11=BF(f1,fp1)
id12=BF(f2,fp1)
id13=BF(f3,fp1)
id14=BF(f4,fp1)
id15=BF(f5,fp1)

% piece 2
id21=BF(f1,fp2)
id22=BF(f2,fp2)
id23=BF(f3,fp2)
id24=BF(f4,fp2)
id25=BF(f5,fp2)

% piece 3
id31=BF(f1,fp3)
id32=BF(f2,fp3)
id33=BF(f3,fp3)
id34=BF(f4,fp3)
id35=BF(f5,fp3)

%% seconds
s=[id12,id25,id34]/fs