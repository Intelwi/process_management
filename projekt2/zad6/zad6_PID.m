%Michał Stolarz
%Zad nr 6
%Testy dla algorytmu PID


%##############Obiekt####################
k=1,4%K_0/K_0_nom
t=1 %T_0/T_0_nom

K_0 = 4.7
T_0 = 5
T_1 = 1.89
T_2 = 5.27

% Ciągłe ----------------------------------------
s = tf('s')
sys = k*K_0* exp(-t*T_0*s)/((s*T_1+1)*(s*T_2+1)) % transmitancja ciągła
%Dyskretne --------------------------------------
Tp=0.5
sysd = c2d(sys,Tp,'zoh') % transmitancja dyskretna

[num,den] = tfdata(sysd,'v') % pobranie współczynników
delay = get(sysd,'OutputDelay'); % pobranie opóźnienia

%##############Regulator#################
Kk = 0.4802 % Kp=0.4802 <- wzmocnienie krytyczne 
Tk = 20 % Tk = 20 sek  <- okres oscylacji

Kp=0.6*Kk
Ti=(0.5*Tk)
Td=0.12*Tk

r0 = Kp*(1+(Tp/(2*Ti))+(Td/Tp))
r1 = Kp*(-1-2*(Td/Tp)+Tp/(2*Ti))
r2 = (Kp*Td)/Tp

%dyskretny obiekt

%inicjalizacja 
b0=1.677;
b1=-0.6981; 
c0=0.524; 
c1=0.04649; 


%##################Symulacja#####################
kk=200; %koniec symulacji 

x=1:kk
y=zeros(kk,1);
u=zeros(kk,1);
e=zeros(kk,1);
yzad = ones(kk,1)

%warunki pocztkowe 
u(1:delay+2)=0; 
y(1:delay+2)=0;  


for k=(delay+3):kk; %główna petla symulacyjna 
%symulacja obiektu 
     y(k)=(1/(den(1))) * ((-den(2))*y(k-1)+(-den(3))*y(k-2)+num(2)*u(k-(delay)-1)+num(3)*u(k-(delay)-2));
%uchyb regulacji 
     e(k)=yzad(k)-y(k); 
%sygnał sterujcy regulatora PID 
     u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); 
end; 


%sterowanie
figure;
hold on;
stairs(x,u); 
title("u");
ylabel("Amplitude");
xlabel("k");
hold off

%odpowiedź skokowa
figure; 
hold on
stairs(x,y)
hold on
stairs(x,yzad) 
title("y, y_{zad}")
ylabel("Amplitude");
xlabel("k") 
hold off


sysd