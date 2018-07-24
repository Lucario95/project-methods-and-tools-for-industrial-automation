function [vettore_medie] = getmedia(vettore)

    vettore_medie = zeros(1, size(vettore, 2));
    
    for i = 1 : size(vettore, 2)
    
        vettore_medie(1, i) = mean(vettore(:, i)); 
    
    end

end