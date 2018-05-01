function [Kp ,Ki, g] = mylqt(A, B, C, Q, Qf, R, T, Z, X0)

    % Calcola la componente proporzionale e quella integrale per il
    % controllo ottimo.

    % Matrici ausiliarie:
    E = B * R^(-1) * B';
    W = C' * Q;
    V = C' * Q * C;
    
    % Inizializzazione matrici:
    P = zeros(size(C,2), size(C,2), T);
    I = eye(size(E,1), size(P,2));
    g = zeros(size(W,1), T);
    Kp = zeros(size(B,2), size(X0,1), T);
    Ki = zeros(size(B,2), size(g,1), T);
    
    % Valori finali:
    P(:,:,T) = C' * Qf * C;
    g(:,T) = C' * Qf * Z(:,T);
    
    % Calcolo del termine P (equazione di Riccati):
    for i = T-1:-1:1
        P(:,:,i) = A' * P(:,:,i+1) * (I + E * P(:,:,i+1) )^(-1) * A + V;
    end
    % Calcolo del termine integrale g:
    for i = T-1:-1:1
        g(:,i) = A' * (I - (P(:,:,i+1)^(-1) + E )^(-1) * E) * g(:,i+1)+ W * Z(:,i);
    end
    % Calcolo di Kp e Kg:
    for i = 1:T-1
        Kp(:,:,i) = (R + B' * P(:,:,i+1) * B)^(-1) * B' * P(:,:,i+1) * A;
        Ki(:,:,i) = (R + B' * P(:,:,i+1) * B)^(-1) * B';
    end
    
end
