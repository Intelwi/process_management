
%Michał Stolarz
%Zad nr 1

% Ciągłe ----------------------------------------

Numerator = [0 1 9 8];
Denominator = [1 12 -79 -990];
sys = tf(Numerator,Denominator) % transmitancja ciągła

[A,B,C,D] = tf2ss(Numerator,Denominator) %1 wariant metody bezpośredniej

% współczynniki dla 2 wariantu metody bezpośredniej
A1=A.'
B1 = C.'
C1 = B.'

% Dyskretne --------------------------------------

Ts = 0.25; % czas próbkowania

sysd = c2d(sys,Ts,'zoh') % transmitancja dyskretna, otrzymana przez ektrapolator zerowego rzędu

a = pole(sysd) % bieguny transmitancji dyskretnej
b = zero(sysd) % zera transmitancji dyskretnej

[num,den] = tfdata(sysd)

[A2,B2,C2,D2] = tf2ss(num{1},den{1}) %1 wariant metody bezpośredniej

% współczynniki dla 2 wariantu metody bezpośredniej
A3=A2.'
B3 = C2.'
C3 = B2.'

% Zad no 3 ,otrzymanie transmitancji z obu przestrzeni stanów

[b1,a1] = ss2tf(A2,B2,C2,D2) % przestrzeń stanów dla pierwszej metody
[b2,a2] = ss2tf(A3,B3,C3,D2) % przestrzń stanów dla drugiej metody

% Zad no 5

Co = ctrb(A3,B3) % macierz sterownosci
Ob = obsv(A3,C3) % macierz obserwowalności

d_co = det(Co) % funkcja matlab
d_ob = det(Ob) % funkcja matlab

obserwacja = det([C3' (C3*A3)' (C3*A3^2)']) % ręcznie
sterownosc = det([B3 A3*B3 (A3^2)*B3]') % ręcznie

% Zad no 6
K = place(A3,B3,[0.09 0.08 0.06]) % nie da sie użyć trzeba ręcznie :-(

