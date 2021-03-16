function [est_theta,est_len]=ThetaLengthEstimate(g,ifplotfft,ifSrcBestS)

if nargin==1
    ifplotfft=false;
    ifSrcBestS=false;
elseif nargin==2
    ifSrcBestS=false;
end

g=double(g);

[N,~]=size(g);% get the size of g. g is square by default. 
G=fft2(g);
G=fftshift(G);% fftshift is needed, or this function will return 0
lnG=log(abs(G));
% create zeros entries around g in order to integral numerically for convenience
lnG_ext=zeros(2*N);lnG_ext(N/2+1:3/2*N,N/2+1:3/2*N)=lnG;% means extend of lnG

d=N/sqrt(2); % the farthest point from the origin (0,0)
drho=0.1; % ! set the accuracy of separation of lines
rho=(0:drho:d)'; % set the distance of lines from the origin (0,0)
t=180; % !! set accuracy of theta, t=36 <=> 180/36=5 degree per interval
theta=linspace(0,pi/t*(t-1),t);

%% Calculate matrix R=R(lnG,rho,theta), each entry correspond to(rho,theta)
lrho=length(rho);
S=zeros(lrho,t); % integral sum
ds=1;
% integrate step
for s=-d:ds:d
    x=rho.*cos(theta)-s.*sin(theta);
    y=rho.*sin(theta)+s.*cos(theta);
    colid=ceil(x+N);
    rowid=ceil(N-y);
    lin_id=sub2ind(size(lnG_ext),rowid,colid);
    S=S+lnG_ext(lin_id);
end
clear x y colid rowid lin_id
R=S.*ds; % the result of integral

%% Use R to estimate theta
%% Method of find the largest variance
% VarRrho=var(R);
% [~,est_the_id]=max(VarRrho);
% est_theta=pi/t*(est_the_id-1);

%% Method of find the largest range, proposed by myself
% range=max(R)-min(R);
% [~,est_the_id]=max(range);
% est_theta=pi/t*(est_the_id-1);

%% Method of sum the largest 5 entries of each coloum,i.e. each theta
% refer to Felix Krahmer
Rsort=sort(R,'descend');
v=sum(Rsort(1:5,:));
 
% The estimate of angle theta is which has the max v
[~,est_the_id]=max(v);
est_theta=pi/t*(est_the_id-1);
% Given length of 20 motion, this estimate has a accuracy of 10:5:165 
% and 0 of course , given circular boundary condition

%% Estimate Length
% This algorithm refers to the Joao P. A. Oliveira. Although there are some
% mistakes in the algorithm in the paper, I correct and improve it. The
% notations are same to the paper. 

% using the estimated theta, integrate for different distance from origin
PI=R(:,est_the_id); 
% standardized steps for the integral
Delta=diff(PI);
Delta_star=Delta;
p=3;
Delta_star(Delta>0)=p.*Delta(Delta>0);
S=cumsum(Delta_star);

% smooth to find desired minimal points
for ii=1:10
    S=smooth(S);
end
minD=10/drho; % set the minimum of distance of closest minimal points
[~,id_peaks]=findpeaks(-S,'MinPeakDistance',minD); % find minimal points
% plot S
% figure;plot(S);hold on;plot(id_peaks,S(id_peaks),'r.','markersize',5);hold off;
id_peaks_dist=diff(id_peaks); % calculate distance, or called diff
d=median(id_peaks_dist(1:5)); % select the median of the first 5 distance
d=d*drho; % don't forget to multiply sample distance to obtain the true distance
est_len=floor(N/d); % estimate length
% est_len=round(N/d)-1; 

if ifplotfft
    figure
    imshow(uint8(abs(G)))
end

if ifSrcBestS % Search Best S curve
    est_the_id=est_the_id-5:est_the_id+5;
    est_len=zeros(1,length(est_the_id));
    for kk=1:length(est_the_id)
        PI=R(:,est_the_id(kk));
        
        Delta=diff(PI);
        Delta_star=Delta;
        p=3;
        Delta_star(Delta>0)=p.*Delta(Delta>0);
        S=cumsum(Delta_star);
        
        for ii=1:10
            S=smooth(S);
        end
        minD=10/drho; % set the minimum of distance of closest minimal points
        [~,id_peaks]=findpeaks(-S,'MinPeakDistance',minD); % find minimal points
        figure;plot(S);hold on;plot(id_peaks,S(id_peaks),'r.','markersize',5);hold off;
        id_peaks_dist=diff(id_peaks); % calculate distance, or called diff
        d=median(id_peaks_dist(1:5)); % select the median of the first 5 distance
        d=d*drho; % don't forget to multiply sample distance to obtain the true distance
        est_len(kk)=floor(N/d); % estimate length
    end
    est_theta=pi/t*(est_the_id-1);
end
end
