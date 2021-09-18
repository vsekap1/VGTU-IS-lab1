%% Naivaus Bayes'o klasifikatoriaus mokymas

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
P=transpose([x1;x2]);

% Sudaromas rezultato (išėjimo signalų vektorius)
% 1 - obuoliai
% 2 - kriauses
T=[1;1;1;1;1;1;1;1;1;-1;-1;-1;-1];

% Atvaizduojama isejimo galimybiu lentele
tabulate(Y)

% Atliekamas Naivaus Bayes'o klasifikatoriaus apmokymas
Mdl = fitcnb(P,T,'ClassNames',{'1', '-1'})

obuoliu_vidurkis = strcmp(Mdl.ClassNames,'1');
nuokrypis = Mdl.DistributionParameters{setosaIndex,1}

figure(3)
gscatter(P(:,1),P(:,2),T);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on
Params = cell2mat(Mdl.DistributionParameters); 
Sigma = zeros(2,2,3);
h.XLim = cxlim;
h.YLim = cylim;
title("Naivus Bayes'o klasifikatorius - obuoliai ir kriauses")
legend('kriauses', 'obuoliai')
grid on
hold off

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
%% šaltiniai:
% http://datareview.info/article/6-prostyih-shagov-dlya-osvoeniya-naivnogo-bayesovskogo-algoritma-s-primerom-koda-na-python/
% https://docs.exponenta.ru/stats/fitcnb.html