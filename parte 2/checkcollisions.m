function [schedule_times_on_M5] = checkcollisions(schedule_flow_1, schedule_flow_2)

    % schedule_flow_x contiene come prima colonna gli id dei job del flow
    % x, come seconda colonna i tempi di inzio alla macchina M5, come terza
    % colonna i tempi di fine alla macchina M5.
    % schedule_times_on_M5 è una matrice 10 * 3, la prima colonna contiene
    % gli id, la seconda i tempi di inizio alla macchina M5, la terza i
    % tempi di fine. È ordinato rispetto ai tempi di inizio alla macchina
    % M5.
    
    delayed = true;
    
    % Confrontiamo ogni coppia delle liste e se c'è almeno un conflitto
    % introduciamo un ritardo e ricominciamo la scansione.
    while delayed
        
        delayed = false;
        
        i = 1;
        while i <= 5
            
            j = 1;
            while j <= 5

                % Ritardiamo job j se comincia dopo il job i e arriva
                % prima del termine del job i.
                
                if schedule_flow_1(i, 2) <= schedule_flow_2(j, 2) && schedule_flow_1(i, 3) > schedule_flow_2(j, 2)
                
                    disp("coll1");
                    
                    % Ritardiamo il job j e tutti i suoi successori:
                    delay = schedule_flow_1(i, 3) - schedule_flow_2(j, 2);       % Tempo di fine del job i meno il tempo di inizio del job j
                    k = j;
                    while k <= 5
                        
                        schedule_flow_2(k, 2:3) = schedule_flow_2(k, 2:3) + delay;
                    
                        k = k + 1;
                        
                    end
                    
                    delayed = true;
                    
                end
                
                
                j = j + 1;
                
            end
            
            i = i + 1;
            
        end
        
        j = 1;
        while j <= 5
            
            i = 1;
            while i <= 5    
                
                if schedule_flow_2(j, 2) <= schedule_flow_1(i, 2) && schedule_flow_2(j, 3) > schedule_flow_1(i, 2)
                
                    disp("coll2");
                    
                    
                    % Ritardiamo il job j e tutti i suoi successori:
                    delay = schedule_flow_2(j, 3) - schedule_flow_1(i, 2);       % Tempo di fine del job i meno il tempo di inizio del job j
                    k = i;
                    while k <= 5
                        
                        schedule_flow_1(k, 2:3) = schedule_flow_1(k, 2:3) + delay;
                    
                        k = k + 1;
                        
                    end
                    
                    delayed = true;
                    
                end
                
                
                i = i + 1;
            
            end
            
            j = j + 1;
            
        end
        
    end
    
    schedule_times_on_M5 = [schedule_flow_1; schedule_flow_2];
    
    [~, order] = sort(schedule_times_on_M5(:, 2));
    schedule_times_on_M5 = schedule_times_on_M5(order, :);
    
end