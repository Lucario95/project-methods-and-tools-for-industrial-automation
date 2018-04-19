function [x_star, u_star, y] = kalman_filter(A, B, C, ~, eps, Qn, Rn, T, Kp, mu, big_eps, x0)

%KALMAN Summary of this function goes here
%   Detailed explanation goes here
    %Stima di x:
    x_cap = zeros(size(eps,1),length(T));
    y = zeros(size(C,1),length(T));
    y(:,1) = C*x0;
    epsilon = zeros(size(big_eps,1), size(big_eps,2), length(T));
    epsilon(:,:,1) = big_eps^(-1) + C'*Rn^(-1)*C;
    K = zeros(size(eps,1), size(eps,2), length(T));
    for i = 1:length(T)-1
        epsilon(:,:,i+1) = (A*epsilon(:,:,i)*A'+Qn)^(-1) + C'*Rn^(-1)*C;
        K(:,:,i) = epsilon(:,:,i)*C'*Rn^(-1);
    end
    x_cap(:,1) = mu + K(:,:,1)*(y(:,1) - C*mu);
    u(:,1) = Kp(:,:,1)*mu;
    for i = 1:length(T)-1
        u(:,i) = Kp(:,:,i)*x_cap(:,i);
        K(:,:,i) = epsilon(:,:,i)*C'*Rn^(-1);
        y(:,i) = C*x_cap(:,i);
        x_cap(:,i+1) = A*x_cap(:,i) + B*u(:,i) + K(:,:,i+1)*(C*mu- C*(A*x_cap(:,i) + B*u(:,i)));%y(:,i+1) - C*(A*x_cap(:,i) + B*u(:,i)));
    end
    x_star = x_cap;
    u_star = u;
end

