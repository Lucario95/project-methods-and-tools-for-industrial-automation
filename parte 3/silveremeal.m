function [somma_giacenze, costo_ordinazione, costo_mantenimento, costo_unita_prodotto, costo_unita_tempo] = silveremeal(domanda, capienza_autob, costo_km, distanza, costo_stoccaggio_kl, tempo_approvvigionamento)

    i = 1;
    k = 1;
    
    % Esprimiamo la domanda in KL:
    domanda = domanda / 1000;
    
    while i < size(domanda, 1)
    
        % Quantità da ordinare (una per ogni carburante):
        domanda_periodo = zeros(1, size(domanda, 2));
        for j = i:i+tempo_approvvigionamento - 1
            if j <= size(domanda, 1)
                domanda_periodo = domanda_periodo + domanda(j, :);
            end
        end
        
        n_autobotti = ceil(domanda_periodo / capienza_autob);
        costo_ordinazione(k, :) = n_autobotti * costo_km * distanza;
        
        quantita_magazzino = domanda_periodo;
        
        costo_stoccaggio_periodo(k, :) = zeros(1, size(domanda, 2));
        somma_giacenze(k, :) = zeros(1, size(domanda, 2));
        for j = i:i + tempo_approvvigionamento - 1
            if j <= size(domanda, 1)
                quantita_magazzino = quantita_magazzino - domanda(j,:);
                somma_giacenze(k, :) = somma_giacenze(k, :) + quantita_magazzino;
                costo_stoccaggio_periodo(k, :) = costo_stoccaggio_periodo(k, :) + costo_stoccaggio_kl(1, :) .* quantita_magazzino(1, :);
            end
        end
       
        costo_mantenimento(k, :) = costo_stoccaggio_periodo(1, :);
        
        if domanda_periodo ~= 0
            costo_unita_prodotto(k, :) = (costo_ordinazione(k, :) + costo_mantenimento(k, :)) ./ domanda_periodo;
        else
            costo_unita_prodotto(k, :) = zeros(1, size(domanda, 2));
        end
        
        if tempo_approvvigionamento ~= 0
            if(tempo_approvvigionamento + i > size(domanda,1))
               
                costo_unita_tempo(k, :) = (costo_ordinazione(k, :) + costo_mantenimento(k, :)) / (tempo_approvvigionamento + i - size(domanda,1));
                
            else
            
                costo_unita_tempo(k, :) = (costo_ordinazione(k, :) + costo_mantenimento(k, :)) / tempo_approvvigionamento;
                
            end
            
        else
            costo_unita_tempo(k, :) = 0;
        end
        
        i = i + tempo_approvvigionamento;
        k = k + 1;
        
    end
    
end