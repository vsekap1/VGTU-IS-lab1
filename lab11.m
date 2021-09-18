% Intilektualios sistemos
% Perceptrono mokymo algoritmas
% Pirmas laboratorinis darbas
% Vsevolod Kapustin


%% Įėjimo siganlo duomenų skaitymas ir apdorojimas
% Skaitomi obuolių paveiksleliai 
A1=imread('obuoliai/apple_04.jpg');
A2=imread('obuoliai/apple_05.jpg');
A3=imread('obuoliai/apple_06.jpg');
A4=imread('obuoliai/apple_07.jpg');
A5=imread('obuoliai/apple_11.jpg');
A6=imread('obuoliai/apple_12.jpg');
A7=imread('obuoliai/apple_13.jpg');
A8=imread('obuoliai/apple_17.jpg');
A9=imread('obuoliai/apple_19.jpg');

% Skaitomi kriaušių paveiksleliai
P1=imread('kriauses/pear_01.jpg');
P2=imread('kriauses/pear_02.jpg');
P3=imread('kriauses/pear_03.jpg');
P4=imread('kriauses/pear_09.jpg');

% Skaičiuojami apvalumas ir spalva
% Obuoliai
% pav. A1
hsv_value_A1=color_color(A1); % Spalva
metric_A1=apvalumas_roundness(A1); % Apvalumas
% pav. A2
hsv_value_A2=color_color(A2); % Spalva
metric_A2=apvalumas_roundness(A2); % Apvalumas
% pav. A3
hsv_value_A3=color_color(A3); % Spalva
metric_A3=apvalumas_roundness(A3); % Apvalumas
% pav. A4
hsv_value_A4=color_color(A4); % Spalva
metric_A4=apvalumas_roundness(A4); % Apvalumas
% pav. A5
hsv_value_A5=color_color(A5); % Spalva
metric_A5=apvalumas_roundness(A5); % Apvalumas
% pav. A6
hsv_value_A6=color_color(A6); % Spalva
metric_A6=apvalumas_roundness(A6); % Apvalumas
% pav. A7
hsv_value_A7=color_color(A7); % Spalva
metric_A7=apvalumas_roundness(A7); % Apvalumas
% pav. A8
hsv_value_A8=color_color(A8); % Spalva
metric_A8=apvalumas_roundness(A8); % Apvalumas
% pav. A9
hsv_value_A9=color_color(A9); % Spalva
metric_A9=apvalumas_roundness(A9); % Apvalumas

% Kriaušės
% pav. P1
hsv_value_P1=color_color(P1); % Spalva
metric_P1=apvalumas_roundness(P1); % Apvalumas
% pav. P2
hsv_value_P2=color_color(P2); % Spalva
metric_P2=apvalumas_roundness(P2); % Apvalumas
% pav. P3
hsv_value_P3=color_color(P3); % Spalva
metric_P3=apvalumas_roundness(P3); % Apvalumas
% pav. P4
hsv_value_P4=color_color(P4); % Spalva
metric_P4=apvalumas_roundness(P4); % Apvalumas

% Generuojama įėjimo signalų vektoriai 
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 ...
    hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 ...
    hsv_value_A8 hsv_value_A9 hsv_value_P1 hsv_value_P2 ...
    hsv_value_P3 hsv_value_P4];

x2=[metric_A1 metric_A2 metric_A3 metric_A4 metric_A5 ...
    metric_A6 metric_A7 metric_A8 metric_A9 metric_P1 ...
    metric_P2 metric_P3 metric_P4];

% Sudaroma dviejų įėjimo signalų matrica:
P=[x1;x2];

% Sudaromas rezultato (išėjimo signalų vektorius)
T=[1;1;1;1;1;1;1;1;1;-1;-1;-1;-1];

figure(1)

axis on

plot(P(1, 1:9), P(2, 1:9), '.r', 'MarkerSize', 20)
hold on
plot(P(1, 9:13), P(2, 9:13), '.b', 'MarkerSize', 20)
axis([0 1 0 1])
grid on
xlabel('Spalva')
ylabel('Apvalumas')
title('Užduotis (įėjimo vektoriai)')
legend('rez 1 - obuoliai','rez -1 - kriaušės')

figure(2)
plot(P(1, 1:9), P(2, 1:9), '.r', 'MarkerSize', 20)
hold on
plot(P(1, 10:13), P(2, 10:13), '.b', 'MarkerSize', 20)


axis([0 1 0 1])
grid on
xlabel('Spalva')
ylabel('Apvalumas')
title('Užduotis (įėjimo vektoriai)')
legend('rez 1 - obuoliai','rez -1 - kriaušės')

hold off



%% Apmokamas vieno lygmens perceptronas su dviems įėjimais ir vienu išėjimu

% generuojami atsitktinių svorių ir trikdžių vektoriai apmokymui
w1 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
w2 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
b = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
% paruošiamas klaidos vektoriaus kintamasis
e = []

% Generuoja suma

% 1 ----------------------------------------------------------------------

v1 = x1(1)*w1(1) + x2(1)*w2(1) + b(1)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v1 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(1) = T(1) - y;

% 2 ----------------------------------------------------------------------

v2 = x1(2)*w1(2) + x2(2)*w2(2) + b(2)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v2 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(2) = T(2) - y;

% 3 ----------------------------------------------------------------------

v3 = x1(3)*w1(3) + x2(3)*w2(3) + b(3)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v3 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(3) = T(3) - y;

% 4 ----------------------------------------------------------------------

v4 = x1(4)*w1(4) + x2(4)*w2(4) + b(4)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v4 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(4) = T(4) - y;

% 5 ----------------------------------------------------------------------

v5 = x1(5)*w1(5) + x2(5)*w2(5) + b(5)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v5 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(5) = T(5) - y;

% 6 ----------------------------------------------------------------------

v6 = x1(6)*w1(6) + x2(6)*w2(6) + b(6)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v6 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(6) = T(6) - y;

% 7 ----------------------------------------------------------------------

v7 = x1(7)*w1(7) + x2(7)*w2(7) + b(7)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v7 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(7) = T(7) - y;

% 8 ----------------------------------------------------------------------

v8 = x1(8)*w1(8) + x2(8)*w2(8) + b(8)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v8 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(8) = T(8) - y;

% 9 ----------------------------------------------------------------------

v9 = x1(9)*w1(9) + x2(9)*w2(9) + b(9)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v9 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(9) = T(9) - y;

% 1 ----------------------------------------------------------------------

v10 = x1(10)*w1(10) + x2(10)*w2(10) + b(10)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v10 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(10) = T(10) - y;

% 11 ----------------------------------------------------------------------

v11 = x1(11)*w1(11) + x2(11)*w2(11) + b(11)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v11 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(11) = T(11) - y;

% 12 ----------------------------------------------------------------------

v12 = x1(12)*w1(12) + x2(12)*w2(12) + b(12)

if v12 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(12) = T(12) - y;

% 13 ----------------------------------------------------------------------

v13 = x1(13)*w1(13) + x2(13)*w2(13) + b(13)

if v13 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(13) = T(13) - y;

% Visu kaidu suma 
e_s = abs(e(1)) + abs(e(2)) + abs(e(3)) + abs(e(4)) + abs(e(5)) + ...
    abs(e(6)) + abs(e(7)) + abs(e(8)) + abs(e(9)) + abs(e(10)) + ...
    abs(e(11)) + abs(e(12)) + abs(e(13));

% mokymo algoritmo rasymas
while e_s ~= 0 % executes while the total error is not 0
 
% generuojami atsitktinių svorių ir trikdžių vektoriai apmokymui
w1 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
w2 = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
b = [randn(1) randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)...
    randn(1) randn(1) randn(1) randn(1) randn(1) randn(1)];
% paruošiamas klaidos vektoriaus kintamasis
e = []

% Generuoja suma

% 1 ----------------------------------------------------------------------

v1 = x1(1)*w1(1) + x2(1)*w2(1) + b(1)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v1 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(1) = T(1) - y;

% 2 ----------------------------------------------------------------------

v2 = x1(2)*w1(2) + x2(2)*w2(2) + b(2)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v2 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(2) = T(2) - y;

% 3 ----------------------------------------------------------------------

v3 = x1(3)*w1(3) + x2(3)*w2(3) + b(3)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v3 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(3) = T(3) - y;

% 4 ----------------------------------------------------------------------

v4 = x1(4)*w1(4) + x2(4)*w2(4) + b(4)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v4 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(4) = T(4) - y;

% 5 ----------------------------------------------------------------------

v5 = x1(5)*w1(5) + x2(5)*w2(5) + b(5)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v5 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(5) = T(5) - y;

% 6 ----------------------------------------------------------------------

v6 = x1(6)*w1(6) + x2(6)*w2(6) + b(6)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v6 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(6) = T(6) - y;

% 7 ----------------------------------------------------------------------

v7 = x1(7)*w1(7) + x2(7)*w2(7) + b(7)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v7 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(7) = T(7) - y;

% 8 ----------------------------------------------------------------------

v8 = x1(8)*w1(8) + x2(8)*w2(8) + b(8)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v8 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(8) = T(8) - y;

% 9 ----------------------------------------------------------------------

v9 = x1(9)*w1(9) + x2(9)*w2(9) + b(9)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v9 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(9) = T(9) - y;

% 1 ----------------------------------------------------------------------

v10 = x1(10)*w1(10) + x2(10)*w2(10) + b(10)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v10 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(10) = T(10) - y;

% 11 ----------------------------------------------------------------------

v11 = x1(11)*w1(11) + x2(11)*w2(11) + b(11)

% Skaičiojamas dabartinis perceptrono išėjimas 

if v11 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(11) = T(11) - y;

% 12 ----------------------------------------------------------------------

v12 = x1(12)*w1(12) + x2(12)*w2(12) + b(12)

if v12 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(12) = T(12) - y;

% 13 ----------------------------------------------------------------------

v13 = x1(13)*w1(13) + x2(13)*w2(13) + b(13)

if v13 > 0
	y = 1;
else
	y = -1;
end
% Skaičiuojama klaida
e(13) = T(13) - y;

% Visu kaidu suma 
e_s = abs(e(1)) + abs(e(2)) + abs(e(3)) + abs(e(4)) + abs(e(5)) + ...
    abs(e(6)) + abs(e(7)) + abs(e(8)) + abs(e(9)) + abs(e(10)) + ...
    abs(e(11)) + abs(e(12)) + abs(e(13));

end

v = [v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13]
figure(2)
plot(v)
hold on
plot(b)
plot(w1)
plot(w2)

legend('suma - v', 'trikdžiai - b', 'svoriai - w1', 'svoriai - w2')

grid on


function metric = apvalumas_roundness(Im)

BW = im2bw(rgb2gray(Im),0.95);
BW = imfill(~BW,'holes');
BW = imopen(BW,strel('disk',12));
BWpr = regionprops(double(BW),{'perimeter','area'});
metric = 4*pi*BWpr(1).Area/BWpr(1).Perimeter^2;
end



function hsv_value=color_color(Im)
% im - vaizdas, nuskaitytas su imread
% bw - binarinis vaizdas (nurodo sritį, kurioje yra skaičiuojamas 
% spalvos vidutinė reikšmė)
% atsakymas hsv_value - spalva HSV skalėje

BW = im2bw(rgb2gray(Im),0.95);
BW = imfill(~BW,'holes');
BW = imopen(BW,strel('disk',12));
hsv_im=rgb2hsv(Im);
hsv=hsv_im(:,:,1);
hsv_value=mean(mean(hsv(BW)));

end


