K_0 = 4.7
T_0 = 5
T_1 = 1.89
T_2 = 5.27

% Ciągłe ----------------------------------------
s = tf('s')
sys = K_0* exp(-T_0*s)/((s*T_1+1)*(s*T_2+1)) % transmitancja

%################################################
Kp=0.4802  % Kp=0.4802 <- wzmocnienie krytyczne
Ki=0
Kd=0
%################################################

Pid = pid(Kp,Ki,Kd) % regulator

T = feedback(Pid*sys,1) % sprzężenie zwrotne
step(T) % skok
