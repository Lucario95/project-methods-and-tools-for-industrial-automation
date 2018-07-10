clc;
clear;

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

% Prezzo di vendita unitario al litro:
P = 1.6;
% Costo di mantenimento percentuale annuale:
costo_perc = 0.3;
costo_mantenimento_kl = P * 1000 * costo_perc / size(punto_vendita439, 1);
distanza = 10000;
capienza_autob = 39;
costo_km = 0.5;

dimensione_lotto_439 = getlotsize(punto_vendita439, distanza, costo_mantenimento_kl);
dimensione_lotto_443 = getlotsize(punto_vendita443, distanza, costo_mantenimento_kl);
dimensione_lotto_445 = getlotsize(punto_vendita445, distanza, costo_mantenimento_kl);
dimensione_lotto_447 = getlotsize(punto_vendita447, distanza, costo_mantenimento_kl);
dimensione_lotto_452 = getlotsize(punto_vendita452, distanza, costo_mantenimento_kl);
dimensione_lotto_457 = getlotsize(punto_vendita457, distanza, costo_mantenimento_kl);

[somma_giacenze_439, costo_ordinazione_439, costo_mantenimento_439, costo_unita_prodotto_439, costo_unita_tempo_439] = silveremeal(punto_vendita439, capienza_autob, costo_km, distanza, costo_stoccaggio_kl, dimensione_lotto_439);