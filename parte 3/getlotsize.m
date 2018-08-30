function [tempo_appr1, tempo_appr2] = getlotsize(capienza_autob, costo_km, punto_vendita, distanza, costo_mantenimento_kl) 

    % Con silver e meal
    tempo_appr1 = 0;
    % con minimo costo totale
    tempo_appr2 = 0;
    
    costo_unita_tempo_min = 10000000000;
    distanza_costi_min = 100000000;
    
    for i = 1:size(punto_vendita, 1)
        
        [~, costo_ordinazione, costo_mantenimento, ~, costo_unita_tempo] = silveremeal(punto_vendita, capienza_autob, costo_km, distanza, costo_mantenimento_kl, i); 
        
        media_costo_unita_tempo = 0;
        for j = 1:size(costo_unita_tempo, 2)
            for k = 1:size(costo_unita_tempo,1)
                media_costo_unita_tempo = media_costo_unita_tempo + costo_unita_tempo(k,j); 
            end
        end
        media_costo_unita_tempo = media_costo_unita_tempo / (size(costo_unita_tempo, 2)*size(costo_unita_tempo,1));
        
        media_costo_ordinazione = 0;
        media_costo_mantenimento = 0;
        for j = 1:size(costo_ordinazione, 2)
            for k = 1:size(costo_ordinazione, 1)
                media_costo_ordinazione = media_costo_ordinazione + costo_ordinazione(k,j);
                media_costo_mantenimento = media_costo_mantenimento + costo_mantenimento(k,j);
            end
        end
        media_costo_ordinazione = media_costo_ordinazione / (size(costo_ordinazione, 2)*size(costo_ordinazione,1));
        media_costo_mantenimento = media_costo_mantenimento / (size(costo_ordinazione, 2)*size(costo_ordinazione,1));
        
        if media_costo_unita_tempo < costo_unita_tempo_min
            tempo_appr1 = i;
            costo_unita_tempo_min = media_costo_unita_tempo;
        end
        
        if abs(media_costo_ordinazione - media_costo_mantenimento) < distanza_costi_min
            tempo_appr2 = i;
            distanza_costi_min = abs(media_costo_ordinazione - media_costo_mantenimento);
        end
        
    end

end