function [FEATURE] = feat(ch1)

%% size
[m1 n1]=size(ch1);
%% Features
% 1 mean absolute value
[m1 n1]=size(ch1);
mav= mean(abs(ch1));
MAV=mav';
%% 2  WL    Waveform length
WL1=zeros(1,n1);
for i=1:n1
for k = 2:m1
   WL1(:,i) = WL1(:,i)+ abs(ch1(k,i) - ch1(k-1,i)); 
end
end
%% 3  Zero crossing
zcd = dsp.ZeroCrossingDetector;
zcdOut = zcd(ch1);
ZC=zcdOut';
%% 4Root mean square 
RMS=rms(ch1);
RMS=RMS';
%% 5 cardinality And  6 ssc
ch2=round(ch1,3)
 for i= 1:n1
      card(1,i) = length(unique(ch2(:,i))); 
 end
  for i= 1:n1
      SSC(1,i) = length(findpeaks(abs(ch1(:,i)))); 
      
 end 
card1=card';
SSC1=SSC';
 WL=WL1';


 %% 7 variance
 mu  = mean(ch1);
%  for i=1:n1
% VAR(:,i) = (1 / (m1 - 1)) * sum((ch1(:,i) - mu(:,i)) .^ 2);
% end
VAR=var(ch1);
Var=VAR';
%8 mean absolute deviation
Mad=mad(ch1);
MAD=Mad';
% for i=1:n1
% Mean_absolute_deviation(:,i) = (1 / m1) * sum(abs(ch1(:,i) - mu(:,i)))
% end 
%% 9 simple square integral
for i =1:n1
Ssi(:,i) = sum(ch1(:,i) .^ 2);
end
SSI=Ssi';
%% 10 Autoregressive coeffecient
arce = arburg(ch1,13); % First index is meaningless
AR=arce(:,2:4);
%% 11 average energy
ME = mean(ch1 .^ 2);

%% 12 skewness
SKEW = skewness(ch1);
%% 13  IEMG
for i=1:n1
IEMG(:,i) = sum(abs(ch1(:,i)));
end
%% 14 kurtosis
kurt = kurtosis(ch1);
%% 15 interquartile
IQ=iqr(ch1);
%% 16 Modified mean absolute value type 1 
mmav1= zeros(1,n1);
for i=1:n1
for j = 1:m1
  if j >= 0.25 * m1 &&  j <= 0.75 *m1
    w = 1; 
  else
    w = 0.5;
  end
  mmav1(:,i) = mmav1(:,i) + (w * abs(ch1(j,i)));
end
end

MMAV1 = (1 / m1) * mmav1;
%% 17 Temporal moment 3,4 ,5

TM3 = abs((1 /m1) * sum(ch1 .^ 3));
TM4= abs((1 /m1) * sum(ch1 .^ 4));
TM5= abs((1 /m1) * sum(ch1 .^ 5));
%% 18 V oder

vo = (1 / m1) * sum(ch1 .^ 2);
VO = vo.^ (1 / 2); 


%% 19 standard deviation
STD=std(ch1);
%% 20 log detector
  ld= exp(1/m1 * sum(log(abs(ch1)))); 
  LD=ld';
%% 21 integral absolute value
iav=sum(abs(ch1));
IAV=iav';
%% 22 difference absolute mean value
dmv = zeros(1,n1);
for i=1:n1
for k = 1 : m1 - 1
 dmv(:,i)= dmv(:,i) + abs(ch1(k+1,i) - ch1(k,i));
end
DAMV = dmv / (m1 - 1);
end
%% 23 difference absolute std
 
dasd = zeros(1,n1);
for i=1:n1
for j = 1 : m1 - 1
 dasd(:,i) = dasd(:,i) + (ch1(j+1,i) - ch1(j,i)) ^ 2;
end
DASDV(:,i) = sqrt(dasd(:,i) / (m1 - 1));
end
%% 24 difference variance value (DVARV)
dva = zeros(1,n1)
for i=1:n1
for j = 1 : m1 - 1
 dva(:,i) = dva(:,i) + (ch1(j+1,i) - ch1(j,i)) ^ 2;
end
DVARV(:,i) = dasd(:,i) / (m1 - 2);
end
%% 25 msr
msr=(1/m1 *sum(sqrt(ch1)));
%% 26 Maximum fractal length MFL
mfl = zeros(1,n1);
for i=1:n1
for j = 1 : m1 - 1
  mfl(:,i) = mfl(:,i) + (ch1(j+1,i) - ch1(j,i)) ^ 2;
end
MFL(:,i) = log10(sqrt(mfl(:,i)));
end
% %% 
% coeffs = cepstralCoefficients(ch1)
 %% 27 myopulse percentage rate
myp = zeros(1,n1);
for i=1:n1
for j = 1:m1
  if abs(ch1(:,i)) >= 0
    myp(:,i) = myp(:,i) + 1;
  end
end
end
MYOP = myp / m1;
%% 28 Modified mean absolute value 2
mmv=zeros(1,n1)
mmav2= zeros(1,n1);
for i=1:n1
for j = 1:m1
  if j >= 0.25 * m1  &&  j <= 0.75 * m1
    w = 1;
  elseif j < 0.25 * m1
    w = (4 * j) / m1;
  else
    w = 4 * (j - m1) / m1;
  end
  mmav2(:,i) = mmav2(:,i) + (w * abs(ch1(j,i)));
end
end
MMAV2 = (1 / m1) * mmav2;
%% 29 wilson amplitude
wa = zeros(1,n1);
for i=1:n1
for j = 1:m1-1
  if abs(ch1(j,i) - ch1(j+1,i)) >= 0
    wa(:,i) = wa(:,i) + 1;
  end
end
end
%% 30 mean absolute value slope
for k=1:n1-1
    MAVSLPk(:,k) =mav(k+1)-mav(k);
end
%% 31 multiple hamming window 
w=hamming(m1);
mhw=sum(w.*ch1);
%% 32 Average amplitude change
AAC=zeros(1,n1);
for i=1:n1
    for j=1:m1-1 

  AAC(:,i) =AAC(:,i)+ abs(ch1(j + 1,i) - ch1(j,i));
end
AAC = AAC  / m1;
end
%% 33 histogram 
emghist=hist(ch1,9);
% %% 34 mean frequency
mf=meanfreq(ch1);
%% 35 median frequency
mdf=medfreq(ch1);
%% 
% yf = fft(ch1);   
% fs = 1925.8
% f = (0:length(yf)-1)*fs/length(yf);
% plot(f,abs(yf));
% % power at each frequency
% pow = yf.*conj(yf);ps=pspectrum(ch1);
%% 36 total power
pj= periodogram(ch1);
Pf=max(pj);
% 37 mean power
Mp=1/m1*(sum(pj));
%% 38 Hjorth mobility parameter (HMob)
deri=var(diff(ch1));
vari=var(ch1);
for i=1:n1
Hmob(:,i)=sqrt(deri(:,i)/vari(:,i));
end
%% 39 coefficent of variation
for i=1:n1
Cv(:,i) = std(ch1(:,i)) / mean(ch1(:,i)); 
end
%% 40 mean value of sqrt
MSR = (1 / n1) * sum(ch1 .^ (1/2));
%% 41 AbsoluteValueOfTheSummationOfSquareRoot
ASS = abs(sum(ch1 .^ (1/2)));

%% 42 LogDifference Absolute Mean Value
ldmv=zeros(1,n1)
for i=1:n1
for j = 1 : m1- 1
 ldmv(:,i) = ldmv(:,i) + abs((ch1(j+1,i) - ch1(j,i)));
end
end
LDAMV = log(ldmv / m1);
%% 43  Log Difference Absolute Standard DeviationValue
ldas= zeros(1,n1);
for i=1:n1
for J = 1 : m1 - 1
  ldas(:,i) =ldas(:,i) + (ch1(j+1,i) - ch1(j,i)) ^ 2;
end
end
LDASDV = log(sqrt(ldas / (m1 - 1)));

%% 44 approximate entropy
for i=1:n1
approxEnt(:,i) = approximateEntropy( ch1(:,i));
end
% % 
% % %% 45 spectral moment 1 2 3
% % SM1 = tfsmoment(ch1,1928.5,1);
% % SM2 = tfsmoment(ch1,1928.5,2);
% % SM3 = tfsmoment(ch1,1928.5,3);
% % %% 46 modified median frequency
% for i=1:n1
% Y(:,i) = fft(ch1(:,i));
% P2(:,i) = abs(Y(:,i)/m1);
% P1(:,i) = P2(1:m1/2+1,i);P1(2:end-1,i) = 2*P1(2:end-1,i);%amplitude spectrum
% f = 1925.8*(0:(m1/2))/m1;
% end
% plot(P1) 
% title("Single-Sided Amplitude Spectrum of ch1(t)")
% xlabel("f (Hz)")
% ylabel("|P1(f)|")
% MMDF=1/2*sum(P1); % feature;
% %% 47 modified mean frequency
% fmdf=fft(MMDF);
% mfd=(MMDF.*fmdf );
% for i=1:n1
% MMF(:,i)=mfd(:,i)/MMDF(:,i);
% end
%% 48 total power
TP=max(pj);
%% 49 Frequency ratio
maxf=max(pj);
minf=min(pj);
for i=1:n1
fr(:,i)=minf(:,i)/maxf(:,i);
end
% %% 50 log Coefficient Of Variation

mea  = mean(ch1); 
sd   = std(ch1);
for i=1:n1
LCOV(:,i) = log(sd(:,i) / mea(:,i) );
end
%% feature transpose
% LCOV1=LCOV';ME1=ME';IEMG1=IEMG';SKEW1=SKEW'
% kurt1=kurt';IQ1=IQ';MMAv1=MMAV1';Tm3=TM3';Tm4=TM4';Tm5=TM5';
% Vo=VO';Std=STD';Damv=DAMV';Dasdv=DASDV';Dvarv=DVARV'
% MSR=msr';Mfl=MFL';Myop=MYOP';Mmav2=MMAV2';WA=wa';
% Aac=AAC';MF=mf';MDF=mdf';PF=Pf';MP=Mp';AEnt=approxEnt;Mmf=MMF';
% Tp=TP';FR=fr',HMOB=Hmob';CV1=Cv';Msr=MSR;Ass=ASS';Ldamv=LDAMV;

FEATURE(:,1)=MAV;FEATURE(:,2)=WL1;FEATURE(:,3)=ZC';FEATURE(:,4)=RMS;
FEATURE(:,5)=card1;FEATURE(:,6)=SSC1;FEATURE(:,7)=Var;FEATURE(:,8)=MAD;
FEATURE(:,9)=SSI;FEATURE(:,10)=TP';FEATURE(:,11)=ME';FEATURE(:,12)=IEMG';FEATURE(:,13)=SKEW';FEATURE(:,14)=kurt';FEATURE(:,15)=IQ';FEATURE(:,16)=MMAV1';FEATURE(:,17)=TM3';FEATURE(:,18)=TM4';FEATURE(:,19)=TM5';FEATURE(:,20)=VO';FEATURE(:,21)=STD';FEATURE(:,22)=LD;FEATURE(:,23)=IAV;FEATURE(:,24)=DAMV';FEATURE(:,25)=DASDV';FEATURE(:,26)=DVARV';
FEATURE(:,27)=fr;FEATURE(:,28)=MFL';FEATURE(:,29)=MYOP';FEATURE(:,30)=MMAV2';FEATURE(:,31)=wa';FEATURE(:,32)=AAC';FEATURE(:,34)=mdf';FEATURE(:,33)=mf';FEATURE(:,35)=Pf';FEATURE(:,36)=Mp';
FEATURE(:,37)=Hmob';FEATURE(:,38)=Cv';FEATURE(:,39)=approxEnt';FEATURE(:,40)=ASS';FEATURE(:,41)=LDAMV';FEATURE(:,42)=LDASDV';
% %save('featuress1e1m2ch3.mat','MAV',"WL1",'ZC','RMS',"card1","SSC1","Var","MAD","SSI","LCOV1","ME1","IEMG1","SKEW1","kurt1","IQ1","MMAv1","Tm3","Tm4","Tm5","Vo","Std","LD","IAV","Damv","Dasdv",'Dvarv',"MSR","Mfl","Myop","Mmav2","WA","Aac","MdF","MF","PF","MP",'Hmob','CV1','Msr','Ass','Ldamv','LDASDV','AEnt''Mmf','Tp',"FR")         

 
end