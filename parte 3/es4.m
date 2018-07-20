clc;
clear;

% Importiamo i dati dell'erogato:
[punto_vendita439, punto_vendita443, punto_vendita445, punto_vendita447, punto_vendita452, punto_vendita457] = importdata();

% Azzeriamo i dati negativi:
punto_vendita439 = removenegvalues(punto_vendita439);
punto_vendita443 = removenegvalues(punto_vendita443);
punto_vendita445 = removenegvalues(punto_vendita445);
punto_vendita447 = removenegvalues(punto_vendita447);
punto_vendita452 = removenegvalues(punto_vendita452);
punto_vendita457 = removenegvalues(punto_vendita457);

% Sostituiamo i valori NaN con il valore medio delle colonne 
% corrispondenti:
punto_vendita439 = removenanvalues(punto_vendita439);
punto_vendita443 = removenanvalues(punto_vendita443);
punto_vendita445 = removenanvalues(punto_vendita445);
punto_vendita447 = removenanvalues(punto_vendita447);
punto_vendita452 = removenanvalues(punto_vendita452);
punto_vendita457 = removenanvalues(punto_vendita457);

% Esportiamo i dati puliti su un file excel, un foglio per ogni punto
% vendita:
% xlswrite("dati/pv439.xls", punto_vendita439);
% xlswrite("dati/pv443.xls", punto_vendita443);
% xlswrite("dati/pv445.xls", punto_vendita445);
% xlswrite("dati/pv447.xls", punto_vendita447);
% xlswrite("dati/pv452.xls", punto_vendita452);
% xlswrite("dati/pv457.xls", punto_vendita457);

% Prezzo di vendita unitario al litro, uno per ogni carburante:
P = [1.6, 1.9, 1.4];
% Costo di mantenimento percentuale annuale:
costo_perc = 0.3;
costo_mantenimento_kl = P * 1000 * costo_perc / size(punto_vendita439, 1);
% Distanza in Km:
distanza = 200;
% Capienza autobotte in KL:
capienza_autob = 39;
costo_km = 0.5;

dimensione_lotto_439 = getlotsize(capienza_autob, costo_km, punto_vendita439, distanza, costo_mantenimento_kl(:, [1, 3]));
dimensione_lotto_443 = getlotsize(capienza_autob, costo_km, punto_vendita443, distanza, costo_mantenimento_kl);
dimensione_lotto_445 = getlotsize(capienza_autob, costo_km, punto_vendita445, distanza, costo_mantenimento_kl);
dimensione_lotto_447 = getlotsize(capienza_autob, costo_km, punto_vendita447, distanza, costo_mantenimento_kl);
dimensione_lotto_452 = getlotsize(capienza_autob, costo_km, punto_vendita452, distanza, costo_mantenimento_kl);
dimensione_lotto_457 = getlotsize(capienza_autob, costo_km, punto_vendita457, distanza, costo_mantenimento_kl(:, [1, 3]));

[somma_giacenze_439, costo_ordinazione_439, costo_mantenimento_439, costo_unita_prodotto_439, costo_unita_tempo_439] = silveremeal(punto_vendita439, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), dimensione_lotto_439);
[somma_giacenze_443, costo_ordinazione_443, costo_mantenimento_443, costo_unita_prodotto_443, costo_unita_tempo_443] = silveremeal(punto_vendita443, capienza_autob, costo_km, distanza, costo_mantenimento_kl, dimensione_lotto_443);
[somma_giacenze_445, costo_ordinazione_445, costo_mantenimento_445, costo_unita_prodotto_445, costo_unita_tempo_445] = silveremeal(punto_vendita445, capienza_autob, costo_km, distanza, costo_mantenimento_kl, dimensione_lotto_445);
[somma_giacenze_447, costo_ordinazione_447, costo_mantenimento_447, costo_unita_prodotto_447, costo_unita_tempo_447] = silveremeal(punto_vendita447, capienza_autob, costo_km, distanza, costo_mantenimento_kl, dimensione_lotto_447);
[somma_giacenze_452, costo_ordinazione_452, costo_mantenimento_452, costo_unita_prodotto_452, costo_unita_tempo_452] = silveremeal(punto_vendita452, capienza_autob, costo_km, distanza, costo_mantenimento_kl, dimensione_lotto_452);
[somma_giacenze_457, costo_ordinazione_457, costo_mantenimento_457, costo_unita_prodotto_457, costo_unita_tempo_457] = silveremeal(punto_vendita457, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), dimensione_lotto_457);

disp("Punto vendita 439");
somma_giacenze_439;
costo_ordinazione_439;
costo_mantenimento_439;
costo_unita_prodotto_439;
costo_unita_tempo_439;

disp("Punto vendita 443");
somma_giacenze_443;
costo_ordinazione_443;
costo_mantenimento_443;
costo_unita_prodotto_443;
costo_unita_tempo_443;

disp("Punto vendita 445");
somma_giacenze_445;
costo_ordinazione_445;
costo_mantenimento_445;
costo_unita_prodotto_445;
costo_unita_tempo_445;

disp("Punto vendita 447");
somma_giacenze_447;
costo_ordinazione_447;
costo_mantenimento_447;
costo_unita_prodotto_447;
costo_unita_tempo_447;

disp("Punto vendita 452");
somma_giacenze_452;
costo_ordinazione_452;
costo_mantenimento_452;
costo_unita_prodotto_452;
costo_unita_tempo_452;

disp("Punto vendita 457");
somma_giacenze_457;
costo_ordinazione_457;
costo_mantenimento_457;
costo_unita_prodotto_457;
costo_unita_tempo_457;
