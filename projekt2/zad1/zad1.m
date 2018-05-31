%Michał Stolarz
%Zad nr 1

% Ciągłe ----------------------------------------
s = tf('s')
sys = (4.7*exp(-5*s))/((s*1.89+1)*(s*5.27+1)) % transmitancja

opt = stepDataOptions('InputOffset',0,'StepAmplitude',1); % ustawienia skoku

subplot(2,1,1)
step(sys,50,opt) % odpowiedź skokowa
title("Odpowiedź skokowa G(s)");
xlabel("Czas[s]");
ylabel("Amplituda")

K_c = dcgain(sys) % wzmocnienie statyczne


% Dyskretne --------------------------------------

Tp = 0.5; % czas próbkowania

sysd = c2d(sys,Tp,'zoh') % transmitancja dyskretna, otrzymana przez ektrapolator zerowego rzędu

subplot(2,1,2)
step(sysd,50,opt) % odpowiedź skokowa
title("Odpowiedź skokowa G(z)");
xlabel("Czas");
ylabel("Amplituda")


K_d = dcgain(sysd) % wzmocnienie statyczne
