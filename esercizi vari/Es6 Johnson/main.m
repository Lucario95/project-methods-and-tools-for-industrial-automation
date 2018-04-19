%Pulisco il workspace:
clear;
clc;

%Valori costanti:
N_JOBS = 7;

%Estraiamo i jobs dal file xls:
sourceA = strcat('B4:B',int2str(4+N_JOBS-1));
sourceB = strcat('E4:E',int2str(4+N_JOBS-1));
A = xlsread('Jobs.xlsx','Foglio1', sourceA);
B = xlsread('Jobs.xlsx','Foglio1', sourceB);
ID = 1:N_JOBS;
JOBS =  [ID; A'; B'];

%Ordino i jobs secondo i process time su M1 ed M2:
[~, order] = sort(JOBS(2,:));
orderA = JOBS(:,order);

[~, order] = sort(JOBS(3,:));
orderB = JOBS(:,order);

sequence = zeros(N_JOBS,1);
j = 1;
k = 1;
head = 1;
tail = N_JOBS;
while(any(sequence(:,:) == 0))
    if(orderA(2,j) < orderB(3,k))
      id = orderA(1,j);
      if(~any(sequence(:,:) == id))
        sequence(head,1) = id;
        head = head + 1;
      end
      j = j + 1;
   else
       id = orderB(1,k);
       if(~any(sequence(:,:) == id))
        sequence(tail,1) = id;
        tail = tail - 1;
       end
       k = k + 1;
       
    end
    
end