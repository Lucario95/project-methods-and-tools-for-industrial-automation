%Controllore PID per il sistema1:

%Definisco i guadagni:
Kp = 0.13;
Ki = -0.018;
Kd = 0;

%Inizializzo le variabili:
T = 0.5;
t = 1:T:100;
[m, n] = size(t);
x = zeros(1,n);
I = 0;
u = zeros(1,n);
y = zeros(1,n);
e = zeros(1,n);

%Stato iniziale:
x(1) = 1; 
r = 0; %INPUT

for j =1:3
    I = 0;
    %Simulo il sistema:
    for i = 1:n
        y(:,i) = x(:,i);
        e(:,i) = r - y(:,i);
        I = I + e(:,i);
        if j == 1
            u(:,i) = Kp*e(:,i);
        end
        
        if j == 2
            u(:,i) = Kp*e(:,i) + Ki*0.1*I;
        end
        
        if j == 3
            if i == 1
                u(:,i) = Kp*e(:,i) + Ki*0.1*I;
            else
                u(:,i) = Kp*e(:,i) + Ki*0.1*I + Kd*(e(:,i) - e(:,i-1))/T;
            end
        end
        
        x(i+1) = sistema(x(:,i), u(:,i));
    end
    
    subplot(3,1,j);
    plot(t,y);
    if j == 1
        title("controllo P");
    end
    if j == 2
        title("controllo PI");
    end
    if j == 3
        title("controllo PID");
    end
end
