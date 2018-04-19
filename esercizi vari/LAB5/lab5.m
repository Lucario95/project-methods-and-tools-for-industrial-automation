data1 = xlsread('data.xlsx', 'Esercizio 1');

figure(1);
controlchart(data1(:,3) / data1(:, 2), 'charttype', 'u');

data2 = xlsread('data.xlsx', 'Esercizio 2');
figure(2);
plot(1:40, data2);
legend('misura 1', 'misura 2', 'misura 3', 'misura 4', 'misura 5');
figure(3);
st = controlchart(data2, 'charttype', 'r', 'rules', 'we2');
% we2 rule:
hold on;
plot(st.mu + 2*(st.sigma./sqrt(st.n)), 'm');