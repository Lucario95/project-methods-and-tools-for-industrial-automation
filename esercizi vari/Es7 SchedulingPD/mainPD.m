%Partenza del timer:
tic;
% Clear del workspace:
clc;
clear;

% Definizione dei jobs:
ID = (1:4)'; 
pt = [8 6 10 7]';   %processing time
dd = [14 9 16 16]'; %due date
start_time = 0;

%Calcolo le combinazioni:
X0 = 0;
X1 = combnk(ID,1);
X2 = combnk(ID,2);
X3 = combnk(ID,3);
X4 = combnk(ID,4);

%   FASE BACKWARD:  
% stadio 4
G4_0 = 0;

% stadio 3
%per ogni stato valuto la funzione di costo:
for i = 1:size(X3,1)
    start_time = 0;
    G3 = zeros(size(X3,1),1);
    for j = 1:size(X3,2)
        start_time = start_time + pt(X3(i,j));
    end
    %calcolo tardiness job di controllo
    controlli = setdiff(X4, X3(i,:));
    tardiness = [];
    for j = 1:length(controlli)
        tardiness(j) = max((start_time +...
            pt(controlli(j)) - dd(controlli(j))),0)...
            / length(ID); 
    end
    G3(i) = G4_0 + min(tardiness);
   
end
% stadio 2
%per ogni stato valuto la funzione di costo:
for i = 1:size(X2,1)
    start_time = 0;
    G2 = zeros(size(X2,1),1);
    for j = 1:size(X2,2)
        start_time = start_time + pt(X2(i,j));
    end
    %calcolo tardiness job di controllo
    controlli = setdiff(X3, X2(i,:));
    tardiness = [];
    for j = 1:length(controlli)
        tardiness(j) = max((start_time +...
            pt(controlli(j)) - dd(controlli(j))),0)...
            / length(ID); 
    end
    G2(i) = G3(controlli(j)) + min(tardiness);
   
end

% Fermo il timer
toc;