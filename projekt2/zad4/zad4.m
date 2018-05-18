%Michał Stolarz
%Zad nr 4

Kk = 0.4802 % Kp=0.4802 <- wzmocnienie krytyczne Tk = 20 sek  <- okres oscylacji
Tk = 20

%################################################
Kp=0.6*Kk*0.4
Ti=(0.5*Tk*0.7)
Td=0.12*Tk*0.5

%dyskretny regulator
Tp=0.5

r0 = Kp*(1+(Tp/(2*Ti))+(Td/Tp))
r1 = Kp*(-1-2*(Td/Tp)+Tp/(2*Ti))
r2 = (Kp*Td)/Tp