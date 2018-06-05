function [scheduled_jobs] = johnson(processing_time_id_1, processing_time_id_2)

    % processing_time_id_x è una matrice 5*2: la prima colonna contiene gli 
    % ID, la seconda contiene i processing time corrispondenti, sulla 
    % macchina x.
    
    % Ordiniamo le matrici dei processing time.
    [~, order] = sort(processing_time_id_1(:, 2));
    processing_time_id_1 = processing_time_id_1(order, :);
    
    [~, order] = sort(processing_time_id_2(:, 2));
    processing_time_id_2 = processing_time_id_2(order, :);

    % Indici per la lista scheduled_jobs:
    k = 1;
    l = 5;
    % Indici per le matrici dei proc. time:
    i = 1;
    j = 1;
    
    scheduled_jobs = zeros(1, 5);
    
    while any(scheduled_jobs(1, :) == 0) 
        
        if j > 5 

            while i <= 5
            
                if ~any(scheduled_jobs(1, :) == processing_time_id_1(i, 1))
                    scheduled_jobs(1, k) = processing_time_id_1(i, 1);
                    k = k + 1;
                end
                i = i + 1;
            
            end
            
        elseif i > 5

            while j <= 5
               
                if ~any(scheduled_jobs(1, :) == processing_time_id_2(j, 1))
                    scheduled_jobs(1, l) = processing_time_id_2(j, 1);
                    l = l - 1;
                end
                j = j + 1;
                
            end
        
        else

            if processing_time_id_1(i, 2) < processing_time_id_2(j, 2)
                if ~any(scheduled_jobs(1, :) == processing_time_id_1(i, 1))
                    scheduled_jobs(1, k) = processing_time_id_1(i, 1);
                    k = k + 1;
                end
                i = i + 1;
            else
                if ~any(scheduled_jobs(1, :) == processing_time_id_2(j, 1))
                    scheduled_jobs(1, l) = processing_time_id_2(j, 1);
                    l = l - 1;
                end
                j = j + 1;
            end
           
        end
    end
    
end