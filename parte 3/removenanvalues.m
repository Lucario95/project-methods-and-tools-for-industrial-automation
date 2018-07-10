function [table] = removenanvalues(table)

    for j = 1:size(table, 2)
        
        table(:, j) = repnan(table(:, j));

    end
    
end