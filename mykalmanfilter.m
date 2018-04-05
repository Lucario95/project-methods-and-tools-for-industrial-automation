function [X_star, U_star, Y_star, x] = mykalmanfilter(A, B, C, Kp, alfa, sigmaX, sigmaV, sigmaW, T, W, V)
    
    %Filtro di Kalman:
    %Inizializiamo:
    X_star = zeros(size(alfa,1),T);
    U_star = zeros(size(B,2),T-1);
    Y_star = zeros(size(C,1),T);
    MU = zeros(size(alfa,1),T);
    x = zeros(size(alfa,1),T);
    K = zeros (size(sigmaX,1), size(sigmaV,1),T);
    E = zeros(size(alfa,1), size(alfa,1),T);
    
    x(:,1) = alfa;
    Y_star(:,1) = C*alfa + V(:,:,1);
    E(:,:,1) = inv( inv(sigmaX) + C'*sigmaV*C);
    K(:,:,1) = E(:,:,1)*C'*sigmaV^(-1);
    MU(:,1) = alfa + K(:,:,1)*(Y_star(:,1) - C*alfa);
    
    %Calcoliamo i valori per la matrice delle varianze di X:
    for i = 1:T-1
       E(:,:,i+1) = inv( inv(A*E(:,:,i)*A' + sigmaW ) + C'*sigmaV^(-1)*C ); 
    end
    
    for i = 2:T
       K(:,:,i) = E(:,:,i)*C'*sigmaV^(-1);
    end
    
    %Simuliamo il sistema utilizzando il controllo ottimo e utilizziamo
    %l'uscita per stimare lo stato X:
    for i = 1:T-1
        U_star(:,i) = Kp(:,:,i) * MU(:,i);
        x(:,i+1) = A*x(:,i) + B*U_star(:,i) + W(:,:,i);
        Y_star(:,i+1) = C*x(:,i+1) + V(:,:,i+1);
        MU(:,i+1) = A*MU(:,i) + B*U_star(:,i) + K(:,:,i+1) * (Y_star(:,i+1) - C*(A*MU(:,i) + B*U_star(:,i) ) );
    end
    X_star = MU;
end

