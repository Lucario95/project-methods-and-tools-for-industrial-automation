function [P, Kp, x_star, u_star] = MyLQG(A, B, C, D, Q, R, Qf, T, eps, Qn, Rn, mu, big_eps, x0)
%LQG Summary of this function goes here
%   Detailed explanation goes here
    P = zeros(size(Qf,1), size(Qf,2), length(T));
    P(:,:,length(T)) = Qf;
    
    for i = length(T):-1:2
        P(:,:,i-1) = Q + A'*P(:,:,i)*A - A'*P(:,:,i)*B*(R + B'*P(:,:,i)*B)^(-1)*B'*P(:,:,i)*A;
    end
    Kp = zeros(size(B,2),size(A,2),length(T));
    for i = 1:length(T)-1
       Kp(:,:,i) = -(R + B'*P(:,:,i+1)*B)^(-1)*B'*P(:,:,i+1)*A; 
    end
    [x_star, u_star] = kalman_filter(A, B, C, D, eps, Qn, Rn, T, Kp, mu, big_eps, x0);
end

