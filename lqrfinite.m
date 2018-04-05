function [Kp, P] = lqrfinite(A, B, Q, Qf, R, T)
    %%Funzione per ottenere il valore del guadagno in tempo finito Kp
    
    %Inizializziamo P:
    P = zeros(size(Qf,1),size(Qf,2), T+1);
    P(:,:,T+1) = Qf;
    %Inizializziamo Kp:
    Kp = zeros(size(B,2),size(B,1),T);
    
    %Fase backward:
    for i = T+1:-1:2
       P(:,:,i-1) = Q + A'*P(:,:,i)*A - A'*P(:,:,i)*B*(R + B'*P(:,:,i)*B)^(-1)*B'*P(:,:,i)*A;
    end
    
    %Fase forward:
    for i = 1:T
        Kp(:,:,i) = -(R + B'*P(:,:,i+1)*B)^(-1)*B'*P(:,:,i+1)*A;
    end
    
end

