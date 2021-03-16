function [F,h,fd,f,ed,e,s,blkF,blkh,blkfd,blkf,blked,blke,blks]=Tone(Type,n,m)
%% Define Note
fs = 44100; % Standard sample rate
dt = 1/fs; % Standard sampling time interval
Beat=74; % √ø∑÷÷”Beat≈ƒ
T16 = dt*(fs/Beat*15-1); %To determine the time length of a  1/16 note, suggest as an odd number
t16 = 0:dt:T16;
[~,k] = size(t16);
t1 = linspace(0,16*T16,16*k);% An array with the same length as a full note
t2 = linspace(0,8*T16,8*k);
t4d = linspace(0,6*T16,6*k);%A special array represents a 1/4+1/8 note
t4 = linspace(0,4*T16,4*k);
t8d = linspace(0,3*T16,3*k);%A special array represents a 1/8+1/16 note
t8 = linspace(0,2*T16,2*k);
%% Define Frequency
f0 = 440/2^(5/12); % C3 tone
f0=f0*2^((n-3)*7/12); % Cn tone
ScaleTable = (2^(1/12).^(0:7*(m-n)-1))';%Other frequencies in [Cn,Cm)

          % full notes
[F,blkF]=Type(ScaleTable.*f0,t1);
F=@(n) F(n,:);

          % 1/2 notes          
[h,blkh]=Type(ScaleTable.*f0,t2);
h=@(n) h(n,:);

% 1/4+1/8 notes
[fd,blkfd]=Type(ScaleTable.*f0,t4d);
fd=@(n) fd(n,:);

% 1/4 notes
[f,blkf]=Type(ScaleTable.*f0,t4);
f=@(n) f(n,:);

% 1/8+1/16 notes
[ed,blked]=Type(ScaleTable.*f0,t8d);
ed=@(n) ed(n,:);

% 1/8 notes
[e,blke]=Type(ScaleTable.*f0,t8);
e=@(n) e(n,:);

% 1/16 notes
[s,blks]=Type(ScaleTable.*f0,t16);
s=@(n) s(n,:);


end