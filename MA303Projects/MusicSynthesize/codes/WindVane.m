%% WindVane
%% Combine
fs=44100;

RythmPart=Rhythm();
MelodPart=Melody();


% RythmPart=0;
% MelodPart=0;


s=RythmPart+MelodPart;
s=s./max(s,2);

%% Experiment
sound(s,fs)

%% output
audiowrite('WindVane.mp4',s,fs)