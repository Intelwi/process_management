%Michał Stolarz
%Zad nr 7

% Ciągłe ----------------------------------------

Numerator = [0 1 9 8];
Denominator = [1 12 -79 -990];
sys = tf(Numerator,Denominator) % transmitancja ciągła

% Dyskretne --------------------------------------

Ts = 0.25; % czas próbkowania
Tp= 0.25;
Ini = 0;
sysd = c2d(sys,Ts,'zoh') % transmitancja dyskretna, otrzymana przez ektrapolator zerowego rzędu

a_b = pole(sysd) % bieguny transmitancji dyskretnej
b_z = zero(sysd) % zera transmitancji dyskretnej

[num,den] = tfdata(sysd)

[A2,B2,C2,D2] = tf2ss(num{1},den{1}) %1 wariant metody bezpośredniej

% współczynniki dla 2 wariantu metody bezpośredniej
A3=A2.'
B3 = C2.'
C3 = B2.'


[b2,a2] = ss2tf(A3,B3,C3,D2) % przestrzń stanów dla drugiej metody

% Regulator
a=0.5%0.3
b=0.6%0.2
z1 = a + b*j
z2 = a - b*j

k=0.3
K = acker(A3,B3,[47.3787  -10.9824 -148.0853])

%najlepszy regulator
Q=eye(3)
R=1
[K,S,e] = lqr(A3,B3,Q,R)