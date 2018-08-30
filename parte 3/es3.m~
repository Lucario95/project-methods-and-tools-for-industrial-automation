clc;
clear;

consumo_anno = 9600;
costo_mantenimento_unita = 16;
costo_ordinazione_lotto = 75;
giorni_anno = 288;
consumo_giornaliero = int8(consumo_anno / giorni_anno);
media_tempo_riordino = 5;
deviazione_std_riordino = 2;
scorta_iniziale = 0;

scorta = zeros(1, giorni_anno);
scorta(1, 1) = scorta_iniziale;

z = 1.65;   % Garantisce livello di servizio pari al 95%.

% Calcoliamo Q*:
Q_star = sqrt( (2 * costo_ordinazione_lotto * consumo_anno) / (costo_mantenimento_unita) );

tempo_riordino = zeros(1, giorni_anno);
rng(1, 'twister');
tempo_riordino_norm = randn(giorni_anno, 1);
for i = 1:giorni_anno
    tempo_riordino(1, i) = int8(tempo_riordino_norm(i, 1) * deviazione_std_riordino + media_tempo_riordino);
end
tempo_riordino(1, 1:2) = 6;

ordered = 0;
tempo_consegna_ordine = 0;
j = 1;
punto_riordino = zeros(1, giorni_anno);
for i = 1:giorni_anno

    punto_riordino(1, i) = consumo_giornaliero * tempo_riordino(1, j) + z * consumo_giornaliero * deviazione_std_riordino; 
    
    if i ~= 1 && scorta(1, i - 1) - consumo_giornaliero > 0
        scorta(1, i) = scorta(1, i - 1) - consumo_giornaliero;
    end

    if scorta(1, i) < punto_riordino(1, i) && ordered == 0
        tempo_consegna_ordine = i + tempo_riordino(1, j);
        ordered = 1;
        j = j + 1;
    end
    
    if i == tempo_consegna_ordine
        scorta(1, i) = scorta(1, i) + Q_star;
        ordered = 0;
    end
    
end

plot(1:giorni_anno, scorta, 1:giorni_anno, punto_riordino, 1:giorni_anno, Q_star*ones(1, giorni_anno));