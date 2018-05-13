%Michał Stolarz
%Zad nr 1

K_0 = 4.7
T_0 = 5
T_1 = 1.89
T_2 = 5.27

% Ciągłe ----------------------------------------
s = tf('s')
sys = K_0* exp(-T_0*s)/((s*T_1+1)*(s*T_2+1)) % transmitancja

opt = stepDataOptions('InputOffset',0,'StepAmplitude',1); % ustawienia skoku

subplot(2,1,1)
step(sys,35,opt) % odpowiedź skokowa

K_c = dcgain(sys) % wzmocnienie statyczne


% Dyskretne --------------------------------------

Tp = 0.5; % czas próbkowania

sysd = c2d(sys,Tp,'zoh') % transmitancja dyskretna, otrzymana przez ektrapolator zerowego rzędu

subplot(2,1,2)
step(sysd,35,opt) % odpowiedź skokowa

K_d = dcgain(sysd) % wzmocnienie statyczne

