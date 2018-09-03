clc;
clear;

consumo_anno = 9600;
costo_mantenimento_unita = 16;
costo_ordinazione_lotto = 75;
giorni_anno = 288;
% Consumo giornaliero approsimato ad un intero 
consumo_giornaliero = int8(consumo_anno / giorni_anno);
media_tempo_riordino = 5;
deviazione_std_riordino = 4;
% Scorta iniziale nulla
scorta_iniziale = 0;

scorta = zeros(1, giorni_anno);
scorta(1, 1) = scorta_iniziale;

z = 1.65;   % Garantisce livello di servizio pari al 95%.

% Calcoliamo Q* tramite la formula del lotto economico:
Q_star = sqrt( (2 * costo_ordinazione_lotto * consumo_anno) / (costo_mantenimento_unita) );

tempo_riordino = zeros(1, giorni_anno);
rng(1, 'twister');
tempo_riordino_norm = randn(giorni_anno, 1);
% Generazione tempi di riordino con distribuzione normale.
for i = 1:giorni_anno
%     Accettiamo solo tempi di riordino >= 0
    tempo_riordino(1, i) = abs(int8(tempo_riordino_norm(i, 1) * deviazione_std_riordino + media_tempo_riordino));
end
% I primi 2 tempi di riordino sono deterministici e valgono 6 giorni.
tempo_riordino(1, 1:2) = 6;

ordered = 0; %Vale 0 se non è in arrivo un ordine, 1 altrimenti.
tempo_consegna_ordine = 0;
j = 1;
punto_riordino = zeros(1, giorni_anno);
fine_secondo_periodo = 0;
for i = 1:giorni_anno

    punto_riordino(1, i) = consumo_giornaliero * media_tempo_riordino + z * consumo_giornaliero * deviazione_std_riordino; 
    
    if i ~= 1 && scorta(1, i - 1) - consumo_giornaliero > 0
        scorta(1, i) = scorta(1, i - 1) - consumo_giornaliero;
    end
    
    if scorta(1, i) < punto_riordino(1, i) && ordered == 0
        tempo_consegna_ordine = i + tempo_riordino(1, j);
        ordered = 1;
        j = j + 1;
        if j == 3 
            fine_secondo_periodo = tempo_consegna_ordine; %Per simulare i primi 2 cicli
        end
    end
    
    if i == tempo_consegna_ordine
        scorta(1, i) = scorta(1, i) + Q_star;
        ordered = 0;
    end
    
end

% Il plot commentato simula l'andamento di tutto l'orizzonte temporale, il
% secondo plot simula solo i primi 2 cicli come richiesto dal problema.
%plot(1:giorni_anno, scorta, 1:giorni_anno, punto_riordino, 1:giorni_anno, Q_star*ones(1, giorni_anno));
plot(1:fine_secondo_periodo, scorta(1, 1:fine_secondo_periodo), 1:fine_secondo_periodo, punto_riordino(1, 1:fine_secondo_periodo), 1:fine_secondo_periodo, Q_star*ones(1, fine_secondo_periodo));