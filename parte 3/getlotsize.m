function [dimensione_lotto] = getlotsize(capienza_autob, costo_km, punto_vendita, distanza, costo_mantenimento_kl) 

    dimensione_lotto = 0;
    costo_unita_prodotto_min = 10000000000;
    for i = 1:size(punto_vendita, 1)
        [~, ~, ~, costo_unita_prodotto, ~] = silveremeal(punto_vendita, capienza_autob, costo_km, distanza, costo_mantenimento_kl, i); 
        media_costo_unita_prodotto = 0;
        for j = 1:size(costo_unita_prodotto, 2)
            for k = 1:size(costo_unita_prodotto,1)
                media_costo_unita_prodotto = media_costo_unita_prodotto + costo_unita_prodotto(k,j); 
            end
        end
        media_costo_unita_prodotto = media_costo_unita_prodotto / (size(costo_unita_prodotto, 2)*size(costo_unita_prodotto,1));
        if media_costo_unita_prodotto < costo_unita_prodotto_min
            dimensione_lotto = i;
            costo_unita_prodotto_min = media_costo_unita_prodotto;
        end
    end

end