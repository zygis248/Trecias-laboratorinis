close all;
clear;
clc;
x = 0:1/22:1; %Taškų vektorius
func = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2; %Aproksimuojama funkcija
figure
plot(x, func); grid on; title('Aproksimuojama funkcija');
%Centrai ir spinduliai
% c1 = 0.1918 - 0.002;
% c2 = 0.9131 + 0.002;
c1 = 0.191;
c2 = 0.916;
r1 = 0.166;
r2 = 0.176;

%Gauso funkcijos duotiems centrams ir spinduliams
t1 = gauss(x, c1, r1);
t2 = gauss(x, c2, r2)
figure
plot(x,t1, x, t2, x, func); grid on; title('Gauso funkcijos');
%Svorių inicializavimas
w0 = randn(1);
w1 = randn(1);
w2 = randn(1);
num_iter = 0;
step = 0.1; %mokymo žingsnis

%Funkcijos aproksimavimas
for j = 1:100
  E(j) = 0;  
  for i = 1:length(x)
  % RBV išėjimo skaičiavimas
  y = gauss(x(i), c1, r1)*w1 + gauss(x(i), c2, r2)*w2 + w0; %Svorinė suma
  % Klaidos skaičiavimas ir svorių atnaujinimas
  e = func(i) - y;
  E(j) = E(j) + abs(e);
  w1 = w1 + step * e * gauss(x(i), c1, r1);
  w2 = w2 + step * e * gauss(x(i), c2, r2);
  w0 = w0 + step * e;
  end
end
%Klaidos kitimoir galutinio rezultato atvaizdavimas
t = 1:j;
figure
plot(t, E); grid on; title('Klaidos kitimas');
y = gauss(x, c1, r1)*w1 + gauss(x, c2, r2)*w2 + w0; 
figure
plot(x, func, x, y, x, y - func); grid on; title('Palyginimas'); legend('Tikroji funkcija', 'Aproksimuota funkcija', 'Skirtumas');

%Gauso funkcija
function func = gauss(x, c, r)
func = exp(-(x - c).^2/(2*r^2));
end
