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
[tempo_appr_439_sm, tempo_appr_439_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita439, distanza, costo_mantenimento_kl(:, [1, 3]));
[tempo_appr_443_sm, tempo_appr_443_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita443, distanza, costo_mantenimento_kl);
[tempo_appr_445_sm, tempo_appr_445_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita445, distanza, costo_mantenimento_kl);
[tempo_appr_447_sm, tempo_appr_447_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita447, distanza, costo_mantenimento_kl);
[tempo_appr_452_sm, tempo_appr_452_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita452, distanza, costo_mantenimento_kl);
[tempo_appr_457_sm, tempo_appr_457_mtc] = getlotsize(capienza_autob, costo_km, punto_vendita457, distanza, costo_mantenimento_kl(:, [1, 3]));

[somma_giacenze_439_sm, costo_ordinazione_439_sm, costo_mantenimento_439_sm, costo_unita_prodotto_439_sm, costo_unita_tempo_439_sm] = silveremeal(punto_vendita439, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), tempo_appr_439_sm);
[somma_giacenze_443_sm, costo_ordinazione_443_sm, costo_mantenimento_443_sm, costo_unita_prodotto_443_sm, costo_unita_tempo_443_sm] = silveremeal(punto_vendita443, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_443_sm);
[somma_giacenze_445_sm, costo_ordinazione_445_sm, costo_mantenimento_445_sm, costo_unita_prodotto_445_sm, costo_unita_tempo_445_sm] = silveremeal(punto_vendita445, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_445_sm);
[somma_giacenze_447_sm, costo_ordinazione_447_sm, costo_mantenimento_447_sm, costo_unita_prodotto_447_sm, costo_unita_tempo_447_sm] = silveremeal(punto_vendita447, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_447_sm);
[somma_giacenze_452_sm, costo_ordinazione_452_sm, costo_mantenimento_452_sm, costo_unita_prodotto_452_sm, costo_unita_tempo_452_sm] = silveremeal(punto_vendita452, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_452_sm);
[somma_giacenze_457_sm, costo_ordinazione_457_sm, costo_mantenimento_457_sm, costo_unita_prodotto_457_sm, costo_unita_tempo_457_sm] = silveremeal(punto_vendita457, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), tempo_appr_457_sm);

[somma_giacenze_439_mtc, costo_ordinazione_439_mtc, costo_mantenimento_439_mtc, costo_unita_prodotto_439_mtc, costo_unita_tempo_439_mtc] = silveremeal(punto_vendita439, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), tempo_appr_439_mtc);
[somma_giacenze_443_mtc, costo_ordinazione_443_mtc, costo_mantenimento_443_mtc, costo_unita_prodotto_443_mtc, costo_unita_tempo_443_mtc] = silveremeal(punto_vendita443, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_443_mtc);
[somma_giacenze_445_mtc, costo_ordinazione_445_mtc, costo_mantenimento_445_mtc, costo_unita_prodotto_445_mtc, costo_unita_tempo_445_mtc] = silveremeal(punto_vendita445, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_445_mtc);
[somma_giacenze_447_mtc, costo_ordinazione_447_mtc, costo_mantenimento_447_mtc, costo_unita_prodotto_447_mtc, costo_unita_tempo_447_mtc] = silveremeal(punto_vendita447, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_447_mtc);
[somma_giacenze_452_mtc, costo_ordinazione_452_mtc, costo_mantenimento_452_mtc, costo_unita_prodotto_452_mtc, costo_unita_tempo_452_mtc] = silveremeal(punto_vendita452, capienza_autob, costo_km, distanza, costo_mantenimento_kl, tempo_appr_452_mtc);
[somma_giacenze_457_mtc, costo_ordinazione_457_mtc, costo_mantenimento_457_mtc, costo_unita_prodotto_457_mtc, costo_unita_tempo_457_mtc] = silveremeal(punto_vendita457, capienza_autob, costo_km, distanza, costo_mantenimento_kl(:, [1, 3]), tempo_appr_457_mtc);


disp("Punto vendita 439");
somma_giacenze_439_sm;
costo_ordinazione_439_sm;
costo_mantenimento_439_sm;
costo_unita_prodotto_439_sm;
costo_unita_tempo_439_sm;

somma_giacenze_439_mtc;
costo_ordinazione_439_mtc;
costo_mantenimento_439_mtc;
costo_unita_prodotto_439_mtc;
costo_unita_tempo_439_mtc;

disp("Punto vendita 443");
somma_giacenze_443_sm;
costo_ordinazione_443_sm;
costo_mantenimento_443_sm;
costo_unita_prodotto_443_sm;
costo_unita_tempo_443_sm;

somma_giacenze_443_mtc;
costo_ordinazione_443_mtc;
costo_mantenimento_443_mtc;
costo_unita_prodotto_443_mtc;
costo_unita_tempo_443_mtc;

disp("Punto vendita 445");
somma_giacenze_445_sm;
costo_ordinazione_445_sm;
costo_mantenimento_445_sm;
costo_unita_prodotto_445_sm;
costo_unita_tempo_445_sm;

somma_giacenze_445_mtc;
costo_ordinazione_445_mtc;
costo_mantenimento_445_mtc;
costo_unita_prodotto_445_mtc;
costo_unita_tempo_445_mtc;

disp("Punto vendita 447");
somma_giacenze_447_sm;
costo_ordinazione_447_sm;
costo_mantenimento_447_sm;
costo_unita_prodotto_447_sm;
costo_unita_tempo_447_sm;

somma_giacenze_447_mtc;
costo_ordinazione_447_mtc;
costo_mantenimento_447_mtc;
costo_unita_prodotto_447_mtc;
costo_unita_tempo_447_mtc;

disp("Punto vendita 452");
somma_giacenze_452_sm;
costo_ordinazione_452_sm;
costo_mantenimento_452_sm;
costo_unita_prodotto_452_sm;
costo_unita_tempo_452_sm;

somma_giacenze_452_mtc;
costo_ordinazione_452_mtc;
costo_mantenimento_452_mtc;
costo_unita_prodotto_452_mtc;
costo_unita_tempo_452_mtc;

disp("Punto vendita 457");
somma_giacenze_457_sm;
costo_ordinazione_457_sm;
costo_mantenimento_457_sm;
costo_unita_prodotto_457_sm;
costo_unita_tempo_457_sm;

somma_giacenze_457_mtc;
costo_ordinazione_457_mtc;
costo_mantenimento_457_mtc;
costo_unita_prodotto_457_mtc;
costo_unita_tempo_457_mtc;
