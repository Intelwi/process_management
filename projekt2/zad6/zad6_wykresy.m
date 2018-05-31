%Michał Stolarz
%Zad nr 6
%wykresy

%Wykres dla PID
x = [1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2];
y = [1.5933 1.5197 1.4544 1.3955 1.3415 1.2915 1.2448 1.2009 1.1592 1.12 1.0826];

figure
hold on
plot(x,y); 
title("Obszary stabilności algorytmu PID")
ylabel("K_{0}/K_{0}^{nom}");
xlabel("T_{0}/T_{0}^{nom}");
hold off

%Wykres dla DMC
x = [1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2];
y = [3.437 3.2576 3.0972 2.9535 2.8215 2.7013 2.5912 2.49 2.396 2.3085 2.2275];

figure
hold on
plot(x,y); 
title("Obszary stabilności algorytmu DMC")
ylabel("K_{0}/K_{0}^{nom}");
xlabel("T_{0}/T_{0}^{nom}");
hold off
