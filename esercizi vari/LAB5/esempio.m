clc;
clear;

%creazione grafico pareto
s='A':'F';
X=[];
for i=1:length(s)
    X=[X,rand(1)*100];
    int8(rand(1)*100);
end
P=int8(X);
title('Pareto chart');
pareto(P,{'A','B','C','D','E','F'});

%%
% carte controllo XR
load parts
st = controlchart(runout,'charttype',{'xbar' 'r'});

%% carte controllo con Western Electric Control Rule
load parts
st = controlchart(runout,'rules','we2');
x = st.mean;
cl = st.mu;
se = st.sigma./sqrt(st.n);
hold on
plot(cl+2*se,'m')
% definisce quali campioni hanno determinato l'anomalia
R = controlrules('we2',x,cl,se);
I = find(R)




    