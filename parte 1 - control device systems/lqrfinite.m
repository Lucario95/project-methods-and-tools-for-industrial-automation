function [Kp, P] = lqrfinite(A, B, Q, Qf, R, T)
    
    % Calcola il guadagno proporzionale le equazioni di Riccati.
    
    % Calcolo di P (fase backward):
    P = zeros(size(Qf,1),size(Qf,2),T+1);
    P(:,:,T+1) = Qf;
    for i = T+1:-1:2
        P(:,:,i-1) = Q + A'*P(:,:,i)*A - A'*P(:,:,i)*B*(R + B'*P(:,:,i)*B)^(-1)*B'*P(:,:,i)*A;
    end
    
    % Calcolo di Kp (fase forward):
    Kp = zeros(size(B,2),size(B,1),T);
    for i = 1:T
        Kp(:,:,i) = -(R + B'*P(:,:,i+1)*B)^(-1)*B'*P(:,:,i+1)*A;
    end
    
end
