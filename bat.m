%% 
clear all;
close all;
clc;

%% 
[y,fs] = audioread('Bechsteins.wav');  %reads tge audio
yamp = 20*y;  %preamplifier part
t = 0:0.01:10;
N = length (yamp);
Fs = N/25;
f = (Fs/N).*(0:N-1);
Y = fft(yamp,N);   %for frequency domain observation
Y = abs (Y(1:N)./(N/2));
Y(Y==0) = eps;
Y = 20*log10(Y);
plot (f,Y);
title('Input Audio'),
grid on,
xlabel('Frequency(Hz)'), ylabel('Gain')
figure();


%% 
FLO = 55e3;                % Local oscillator frequency (Hz)
ALO = 1;                    % Local oscillator amplitude
SLO = ALO*cos(2*pi*FLO*t);  % Local oscillator signal
Smix = yamp.*SLO;      %mixer
[b,a] = butter(5,20000/(fs/2),'high');  %high pass filter
Sfilt = filter(b, a, Smix);

%% 
Nd = length (Sfilt);
Fsd = Nd / 25;
fd = (Fsd/N).*(0:Nd-1);
Yd = fft(Sfilt,Nd);
Yd = abs (Yd(1:Nd)./(Nd/2));
Yd(Yd==0) = eps;
Yd = 20*log10(Yd);
plot (fd,Yd);
title('Output Audio'),
grid on,
xlabel('Frequency(Hz)'), ylabel('Gain')

grid on
