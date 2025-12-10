load('s1.mat')
subj1=[]
for j = 1:6
CH1=movements{j};
%%notch filter to elimnate power line noise
notch_f = fdesign.notch(4,0.05,10); %notch filter (50Hz)
D = design(notch_f );
notch_EMG_CH = filter(D,CH1);
% BAND PASS BUTTERWORTH FILTER 4TH ORDER
fn=2048;%sampling freq
flow=500;%cutoff freq
fhigh=20;%cutoff freq
[b,a]=butter(4,[fhigh,flow]/fn,"bandpass");%butterworth 4thorder bandpass
filt_CH=filtfilt(b,a,notch_EMG_CH);
FEATURE1=[];
for i= 1:11
ch1 = buffer(filt_CH(:,i),600,300);
[Features] = feat(ch1);
FEATURE1=[FEATURE1 Features];
end
[m n]=size(ch1);
label=j*ones(n,1)
features=[FEATURE1 label] ;
subj1=[subj1;features]
save subj1 subj1 -mat
end
