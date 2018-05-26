%Michał Stolarz
%Zad nr 4

Kk = 0.4802 % Kp=0.4802 <- wzmocnienie krytyczne Tk = 20 sek  <- okres oscylacji
Tk = 20

%nastawy
Kp=0.6*Kk
Ti=(0.5*Tk)
Td=0.12*Tk

Kp=Kp*0.4
Ti=Ti*0.7
Td=Td*0.5

%dyskretny regulator
Tp=0.5

r0 = Kp*(1+(Tp/(2*Ti))+(Td/Tp))
r1 = Kp*(-1-2*(Td/Tp)+Tp/(2*Ti))
r2 = (Kp*Td)/Tp

%dyskretny obiekt


%inicjalizacja 
b0=1.677;
b1=-0.6981; 
c0=0.524; 
c1=0.04649; 




%###########PID##############
kk=200; %koniec symulacji 

x=1:kk
y=zeros(kk,1);
u=zeros(kk,1);

%warunki pocztkowe 
u(1:12)=0; 
y(1:12)=0; 
yzad(1:12)=1; 
yzad(13:kk)=1; 
e(1:12)=0; 

for k=13:kk; %główna ptla symulacyjna 
%symulacja obiektu 
     y(k)=1.677*y(k-1)-0.6981*y(k-2)+0.0524*u(k-11)+0.04649*u(k-12);
%uchyb regulacji 
     e(k)=yzad(k)-y(k); 
%sygnał sterujcy regulatora PID 
     u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1); 
end; 

%wyniki symulacji
figure;
hold on;
stairs(x,u); 
title("PID u");
xlabel("k");
hold off

figure; 
hold on
stairs(x,y)
hold on
stairs(x,yzad) 
title("PID yzad, y")
xlabel("k") 
hold off




%##########Odpowiedź skokowa obiektu###############

kk=200; %koniec symulacji 

x=1:kk
y=zeros(kk,1);
u=zeros(kk,1);

%warunki pocztkowe 
u(1:12)=0; 
y(1:12)=0; 
u(1:12)=1; 
u(13:kk)=1;  

for k=13:kk; %główna petla symulacyjna 
%symulacja obiektu 
     y(k)=1.677*y(k-1)-0.6981*y(k-2)+0.0524*u(k-11)+0.04649*u(k-12); 
end; 

%wyniki symulacji
figure;
stairs(x,y); 
title("y");
xlabel("k");
hold off


%########## DCM ###############

% Wektor z rzędnymi odpowiedzi skokowych obiektu

s = y;

% Horyzonty

D=25;
N=25;
Nu=15;

% Współczynnik kary za przyrosty sterowania

lambda=1000;

% Generacja macierzy

M=zeros(N,Nu);
for i=1:N
   for j=1:Nu
      if (i>=j)
         M(i,j)=s(i-j+1);
      end;
   end;
end;

MP=zeros(N,D-1);
for i=1:N
   for j=1:D-1
      if i+j<=D
         MP(i,j)=s(i+j)-s(j);
      else
         MP(i,j)=s(D)-s(j);
      end;      
   end;
end;

% Obliczanie parametrów regulatora

I=eye(Nu);
K=((M'*M+lambda*I)^-1)*M';
%ku=K(1,:)*MP;
%ke=sum(K(1,:));

%formatka = '%f,';
%fprintf(formatka, ku)
kk=400
y_zad = ones(kk,1)
y_model = zeros(kk,1)
d_u=zeros(N,1)
d_u_stare = zeros(N,1)
u = zeros(Nu,1)

for k=13:kk; %główna petla symulacyjna 
   
   y_model(k)=1.677*y_model(k-1)-0.6981*y_model(k-2)+0.524*u(k-11)+0.04649*u(k-12); %odpowiedź modelu na sterowanie 
  
   d_u = K*(y_zad(1)*ones(N,1)- y_model(k)*ones(N) -MP*d_u_stare(1:N-1)); %zmiana sterowania
   
   d_u_stare(2:end)=d_u_stare(1:end-1)%przesuniecie
   d_u_stare(1) = d_u(1);
   
   u(k)=u(k-1)+d_u(1); %sterowanie
   
   
end; 

%wyniki symulacji
figure
hold on
stairs(y_model);
stairs(y_zad) 
title("DMC");
xlabel("k");
hold off

