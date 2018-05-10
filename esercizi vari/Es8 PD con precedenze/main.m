% Pulisco la workspace:
clc;
clear;

% Definizione stato iniziale e Jobs:
X0 = 0;
jobs = 1:5;
steps = length(jobs);

% Matrice delle precedenze:
M = zeros(length(jobs));
M(1,2) = 1;
M(1,3) = 1;
M(4,5) = 1;

% Assegno gli stati:

for i = 1:steps
   X{i} = combnk(jobs, i); 
end

% Per ogni stadio:
for i = 1:steps-1
%     U{i} = zeros(size(X{i},1),size(X{i+1},1));
    for j = 1:length(X{i}(:,1))
       for k = 1:length(X{i+1}(:,1))
           if(ismember(X{i}(j,:), X{i+1}(k,:)))
                U{i}(j,k) = setdiff(X{i+1}(k,:),X{i}(j,:));
           end
       end
    end
end

for i = 1:steps-1
    for j = 1:length(U{i}(:,1))
        for k = 1:length(U{i}(1,:))
            if(U{i}(j,k) ~= 0)
                for q = 1:steps
                   for l = 1:steps
                      if(M(q,l) == 1)
                          if(ismember(l,U{i}(j,k)))
                              if(~ismember(q,X{i}(j,:)))
                                  U{i}(j,k) = 0;
                              end
                          end
                      end
                   end
                end
            end
        end
    end
end