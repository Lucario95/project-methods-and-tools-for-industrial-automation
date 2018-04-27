%Partenza del timer:
tic;

% Clear del workspace:
clc;
clear;

% Definizione dei jobs:
ID = (1:10)'; 
pt = [8 6 10 7 14 6 19 3 11 10]';   %processing time
dd = [14 9 16 20 24 18 30 35 30 40]'; %due date


% FORZA BRUTA:
permutations = perms(ID);
cost = zeros(size(permutations,1),1);
ct = zeros(size(permutations,1),size(permutations,2));   %completion time
startTime = 0;

%Fase di generazione e calcolo:
for i=1:size(permutations,1)
   ct(i,permutations(i,1)) = startTime + pt(permutations(i,1));
   lateness = ct(i,permutations(i,1)) - dd(permutations(i,1),:);
   cost(i,:) = max(0, lateness);
   for j=2:size(permutations,2) 
       ct(i, permutations(i,j)) = ct(i, permutations(i,j-1)) + pt(permutations(i,j-1),:); 
       lateness = ct(i,permutations(i,j)) - dd(permutations(i,j),:);
       cost(i,:) = cost(i,:) + max(0,lateness);
   end
end
%Fase di ricerca del minimo:
[value, index] = min(cost);
display(strcat("Il valore di tardiness (raw) minimo è ", num2str(cost(index)),...
" e corrisponde alla sequenza ", num2str(permutations(index,:))));

%Stop del timer:
toc;