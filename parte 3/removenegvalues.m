function [table] = removenegvalues(table)

    for i = 1:size(table, 1)

        for j = 1:size(table, 2)

            if table(i, j) < 0

                table(i, j) = 0;

            end

        end

    end
    
end