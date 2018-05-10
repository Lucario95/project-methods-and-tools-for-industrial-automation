function [X_star, U_star, x] = mykalmanfilter(A, B, C, Kp, alfa, sigmaX, sigmaV, sigmaW, T, W, V)
    
    % Calcola lo stato stimato e il controllo ottimo, e restituisce lo
    % stato reale.
    
    x = zeros(size(alfa,1),T);                  % Stato reale.
    MU = zeros(size(alfa,1),T);                 % Stato stimato.
    U_star = zeros(size(B,2),T-1);              % Controllo ottimo.
    Y_star = zeros(size(C,1),T);                % Uscita reale.
    K = zeros(size(sigmaX,1),size(sigmaV,1),T); % Termine K nella forma ricorsiva (forward) del filtro di Kalman.
    E = zeros(size(alfa,1),size(alfa,1),T);     % Termine sigma nella forma ricorsiva (forward) del filtro di Kalman.
    
    % Valori iniziali:
    rng(2, 'twister');
    x(:,1) = alfa + sigmaX*randn(size(alfa,1), 1);
    Y_star(:,1) = C * alfa + V(:,:,1);
    E(:,:,1) = inv(inv(sigmaX) + C' * sigmaV * C);
    K(:,:,1) = E(:,:,1) * C' * sigmaV^(-1);
    MU(:,1) = alfa + K(:,:,1) * (Y_star(:,1) - C * alfa);
    
    % Calcolo del termine sigma (varianza della distribuzione normale di
    % X):
    for i = 1:T-1
        E(:,:,i+1) = inv(inv(A * E(:,:,i) * A' + sigmaW) + C' * sigmaV^(-1) * C ); 
    end
    % Calcolo del termine K:
    for i = 2:T
       K(:,:,i) = E(:,:,i) * C' * sigmaV^(-1);
    end
    
    %Simuliamo il sistema utilizzando il controllo ottimo e utilizziamo
    %l'uscita per stimare lo stato X:
    
    for i = 1:T-1
        % Calcolo del controllo ottimo:
        U_star(:,i) = Kp(:,:,i) * MU(:,i);
        % Calcolo dello stato reale:
        x(:,i+1) = A * x(:,i) + B * U_star(:,i) + W(:,:,i);
        % Calcolo dell'uscita reale:
        Y_star(:,i+1) = C * x(:,i+1) + V(:,:,i+1);
        MU(:,i+1) = A * MU(:,i) + B * U_star(:,i) + K(:,:,i+1) * (Y_star(:,i+1) - C * (A * MU(:,i) + B * U_star(:,i)));
    end
    % Ritorna lo stato stimato:
    X_star = MU;
    
end
