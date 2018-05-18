K_0 = 4.7
T_0 = 5
T_1 = 1.89
T_2 = 5.27

% Ciągłe ----------------------------------------
s = tf('s')
sys = K_0* exp(-T_0*s)/((s*T_1+1)*(s*T_2+1)) % transmitancja

%Regulator PID

Kk = 0.4802 % Kp=0.4802 <- wzmocnienie krytyczne Tk = 20 sek  <- okres oscylacji
Tk = 20

%################################################
Kp=0.6*Kk*0.4
Ti=(0.5*Tk*0.7)
Td=0.12*Tk*0.5
%################################################
Pid = Kp*(1+(1/(Ti*s)) +Td*s)
%Pid = pid(Kp,Ki,Kd) % regulator

T = feedback(Pid*sys,1) % sprzężenie zwrotne
opt = stepDataOptions('InputOffset',0,'StepAmplitude',1); % ustawienia skoku
figure
hold on
step(T,50,opt) % skok
hold off

%dyskretny regulator

