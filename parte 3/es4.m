clc;
clear;


% Parte 1
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


% Parte 2:
% Distanza in Km:
distanza = 200;
% Capienza autobotte in KL:
capienza_autob = 39;
costo_km = 0.5;
% Costo di mantenimento percentuale annuale:
costo_perc = 0.03;
% Prezzo di vendita unitario al litro, uno per ogni carburante:
P = [1.6, 1.9, 1.4];
costo_mantenimento_kl = P * 1000 * costo_perc / size(punto_vendita439, 1);
tempo_riordino = 14;
% Ipotizziamo domanda giornaliera costante. Calcoliamo la domanda per tempo_riordino giorni:
domanda439 = getmedia(punto_vendita439) * tempo_riordino;
domanda443 = getmedia(punto_vendita443) * tempo_riordino;
domanda445 = getmedia(punto_vendita445) * tempo_riordino;
domanda447 = getmedia(punto_vendita447) * tempo_riordino;
domanda452 = getmedia(punto_vendita452) * tempo_riordino;
domanda457 = getmedia(punto_vendita457) * tempo_riordino;
costo_ordinazione = costo_km * distanza;

lotto_economico_439 = sqrt(2 * costo_ordinazione * domanda439 ./ costo_mantenimento_kl(:, [1, 3]) * 1000);
costo_lotto_economico_439 = costo_mantenimento_kl(:, [1, 3]) ./ 1000 .* lotto_economico_439 ./ 2 + costo_ordinazione .* domanda439 ./ lotto_economico_439;

lotto_economico_443 = sqrt(2 * costo_ordinazione * domanda443 ./ costo_mantenimento_kl * 1000);
costo_lotto_economico_443 = costo_mantenimento_kl ./ 1000 .* lotto_economico_443 ./ 2 + costo_ordinazione .* domanda443 ./ lotto_economico_443;

lotto_economico_445 = sqrt(2 * costo_ordinazione * domanda445 ./ costo_mantenimento_kl * 1000);
costo_lotto_economico_445 = costo_mantenimento_kl ./ 1000 .* lotto_economico_445 ./ 2 + costo_ordinazione .* domanda445 ./ lotto_economico_445;

lotto_economico_447 = sqrt(2 * costo_ordinazione * domanda447 ./ costo_mantenimento_kl * 1000);
costo_lotto_economico_447 = costo_mantenimento_kl ./ 1000 .* lotto_economico_447 ./ 2 + costo_ordinazione .* domanda447 ./ lotto_economico_447;

lotto_economico_452 = sqrt(2 * costo_ordinazione * domanda452 ./ costo_mantenimento_kl * 1000);
costo_lotto_economico_452 = costo_mantenimento_kl ./ 1000 .* lotto_economico_452 ./ 2 + costo_ordinazione .* domanda452 ./ lotto_economico_452;

lotto_economico_457 = sqrt(2 * costo_ordinazione * domanda457 ./ costo_mantenimento_kl(:, [1, 3]) * 1000);
costo_lotto_economico_457 = costo_mantenimento_kl(:, [1, 3]) ./ 1000 .* lotto_economico_457 ./ 2 + costo_ordinazione .* domanda457 ./ lotto_economico_457;


% Esportiamo i dati puliti su un file excel, un foglio per ogni punto
% vendita:
% xlswrite("dati/pv439.xls", punto_vendita439);
% xlswrite("dati/pv443.xls", punto_vendita443);
% xlswrite("dati/pv445.xls", punto_vendita445);
% xlswrite("dati/pv447.xls", punto_vendita447);
% xlswrite("dati/pv452.xls", punto_vendita452);
% xlswrite("dati/pv457.xls", punto_vendita457);

% Parte 3:
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
