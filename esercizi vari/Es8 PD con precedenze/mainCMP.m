% Pulisco la workspace
clc;
clear;

nodi = 1:6;
ES = zeros(1,length(nodi));
LC = zeros(1,length(nodi));
CT = [3 5 4 7 1 3 0 0]';

% Matrice di adiacenza
adiacenza = zeros(6);
adiacenza(1,2) = 1;
adiacenza(1,4) = 2;
adiacenza(2,5) = 3;
adiacenza(2,3) = 4;
adiacenza(4,6) = 5;
adiacenza(5,6) = 6;
adiacenza(3,4) = 7;
adiacenza(3,5) = 8;

% % Precondizioni:
% PC{1} = [];
% PC{2} = [];
% PC{3} = 1;
% PC{4} = 1;
% PC{5} = [2, 4]';
% PC{6} = [3 4]';
% PC{7} = 4;
% PC{8} = 4;
 
% FASE FORWARD:
ES(1) = 0;
for i=2:length(nodi)
    for j=i:length(nodi)
        if(adiacenza(i,j)>0)
            CT(adiacenza(i,j),1)
            if(CT(adiacenza(i,j),1)+ES(i)>ES(j))
                ES(j) = ES(i) + CT(adiacenza(i,j));
            end
        end
    end
end