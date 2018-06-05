function [schedule_times] = runjobs(processing_times)

    % processing_times presenta come prima colonna gli id in ordine di 
    % scheduling, seconda colonna i tempi di processo nella prima macchina 
    % della cascata, terza colonna per la seconda macchina, quarta colonna 
    % per la macchina M5.
    % schedule_times presenta come prima colonna gli id in ordine di
    % scheduling, seconda colonna il tempo di fine alla prima macchina,
    % terza colonna il tempo di inizion alla seconda macchina,
    % quarta colonna il tempo di fine alla seconda macchina, quinta 
    % colonna il tempo di inizio alla macchina M5,
    % sesta colonna il tempo di fine alla macchina M5.
    
    % schedule_times(i, 3) indica il tempo di completamento alla seconda
    % macchina in cascata
    
    schedule_times = zeros(5, 5);
    
    t = 0;
    i = 1;
    while i <= 5 
    
        schedule_times(i, 1) = processing_times(i, 1);
        schedule_times(i, 2) = t + processing_times(i, 2);
        if i > 1
            schedule_times(i, 3) = max(schedule_times(i, 2), schedule_times(i - 1, 4));
            schedule_times(i, 4) = max(schedule_times(i, 2), schedule_times(i - 1, 4)) + processing_times(i, 3);
        else
            schedule_times(i, 3) = schedule_times(i, 2);
            schedule_times(i, 4) = schedule_times(i, 2) + processing_times(i, 3);
        end
       
        if i > 1
            schedule_times(i, 5) = max(schedule_times(i, 4), schedule_times(i - 1, 6));
            schedule_times(i, 6) = max(schedule_times(i, 4), schedule_times(i - 1, 6)) + processing_times(i, 4);
        else
            schedule_times(i, 5) = schedule_times(i, 4);
            schedule_times(i, 6) = schedule_times(i, 4) + processing_times(i, 4);
        end
        
        t = t + processing_times(i, 2);
        i = i + 1;
        
    end
    
    

end