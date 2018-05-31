%Michał Stolarz
%Zad nr 6
%Testy dla algorytmu DMC


%##############Obiekt####################
k0=2.2275;%K_0/K_0_nom
t=2; %T_0/T_0_nom

K_0 = 4.7;
T_0 = 5;
T_1 = 1.89;
T_2 = 5.27;

% Ciągłe ----------------------------------------
S = tf('s');
sys = k0*K_0* exp(-t*T_0*S)/((S*T_1+1)*(S*T_2+1)); % transmitancja ciągła
%Dyskretne --------------------------------------
Tp=0.5;
sysd = c2d(sys,Tp,'zoh'); % transmitancja dyskretna

[num,den] = tfdata(sysd,'v'); % pobranie współczynników
delay = get(sysd,'OutputDelay'); % pobranie opóźnienia

%##############Regulator#################
kk=4000; %koniec symulacji 

x=1:kk;
y=zeros(kk,1);
u=ones(kk,1);

for k=13:kk; %główna petla symulacyjna 
%symulacja obiektu 
     y(k)=1.677*y(k-1)-0.6981*y(k-2)+0.0524*u(k-11)+0.04649*u(k-12); 
end; 

% Wektor z rzędnymi odpowiedzi skokowych obiektu
s = y;

% Horyzonty
D=80;
N=18;
Nu=1;

% Współczynnik kary za przyrosty sterowania
lambda=400;%dla 400 jest ok 
%zbadać dla 100, 1000, 500, 400, 300

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

y_zad = ones(kk,1);
y_model = zeros(kk,1);
d_u=zeros(N,1);
d_u_stare = zeros(D,1);
u = zeros(kk,1);

for k=(delay+3):kk; %główna petla symulacyjna 
   
   y_model(k)=(1/(den(1))) * ((-den(2))*y_model(k-1)+(-den(3))*y_model(k-2)+num(2)*u(k-(delay)-1)+num(3)*u(k-(delay)-2)); %odpowiedź modelu na sterowanie 
  
   d_u = K*(y_zad(1)*ones(N,1)- y_model(k)*ones(N,1) -MP*d_u_stare(1:D-1)); %zmiana sterowania
   
   d_u_stare(2:end)=d_u_stare(1:end-1);%przesuniecie
   d_u_stare(1) = d_u(1);
   
   u(k)=u(k-1)+d_u(1); %sterowanie
   
end

%wartość zadana
figure;
hold on;
stairs(y_model);
stairs(y_zad) ;
title("y, y_{zad}");
ylabel("Amplitude");
xlabel("k");
hold off;


%sterowanie
figure
hold on
stairs(u); 
title("u")
ylabel("Amplitude");
xlabel("k");
hold off