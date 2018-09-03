clc;
clear;

domanda_annua = 2000;
giorni_anno = 250;
lotto = 200;
n = 1;                              % Numero di lotti ordinati.
domanda_giornaliera = 2000 / 250;
tempo_consegna = 10;

scorta_iniziale = n * lotto;
%Per quanto 'dura' l'inventario:
durata_ciclo_approvvigionamento = scorta_iniziale / domanda_giornaliera;
%Dobbiamo riordinare tempo_consegna giorni prima della fine delle scorte:
tempo_di_riordino = durata_ciclo_approvvigionamento - tempo_consegna;

% Prima parte:
scorta = zeros(1, giorni_anno);
scorta(1, 1) = scorta_iniziale;

%Simulazione:
for i = 2:giorni_anno

    scorta(1, i) = scorta(1, i - 1) - domanda_giornaliera;
    
    %Ogni ciclo di approvvigionamento viene rifornito l'inventario:
    %(L'ordine viene fatto tempo_consegna giorni prima)
    if mod(i - 1, durata_ciclo_approvvigionamento) == 0    
        scorta(1, i) = scorta(1, i) + n * lotto;
    end

end

subplot(2, 1, 1)
plot(1:giorni_anno, scorta);

disp("Parte 1");
disp("Primo punto d'ordine");
scorta(1, tempo_di_riordino + 1)

% Seconda parte:
n = 6;
media_domanda = 100;
deviazione_standard_domanda = 40;
% Corrisponde al 99.99% di livello di servizio. 
% In realtà se vogliamo al max 1/365 giorni di penuria basta il 99.97% di
% servizio (~ 3.2).
z = 3.9;

% Formula per domanda distribuita normalmente e tempo di riordino costante:
punto_ordine = media_domanda * tempo_consegna + z * deviazione_standard_domanda * sqrt(tempo_consegna); 

scorta_iniziale = punto_ordine;
scorta = zeros(1, giorni_anno);
scorta(1, 1) = scorta_iniziale;

rng(20.61051, 'twister');
domanda_casuale_norm = randn(giorni_anno, 1);
domanda_giornaliera = zeros(1, giorni_anno);
tempo_di_ordine = 0;
ordered = 0; %Vale 0 se non è in arrivo un ordine, 1 altrimenti.

% Generazione valori distribuiti normalmente con media e varianza note.
for i = 1:giorni_anno
    domanda_giornaliera(1, i) = deviazione_standard_domanda * domanda_casuale_norm(i, 1) + media_domanda;  
end

% Simulazione:
for i = 1:giorni_anno
    
    if i ~= 1
        scorta(1, i) = scorta(1, i - 1) - domanda_giornaliera(1, i);
    end
    
    if scorta(1, i) < punto_ordine && ordered == 0   
        tempo_di_ordine = i + tempo_consegna;
        ordered = 1;
    end
    
    if i == tempo_di_ordine
        scorta(1, i) = scorta(1, i) + n * lotto;
        ordered = 0;
    end

end

subplot(2, 1, 2)
plot(1:giorni_anno, scorta, 1:giorni_anno, punto_ordine*ones(1,giorni_anno));

disp("Parte 2");
disp("Punto d'ordine");
punto_ordine