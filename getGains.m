function [Kp, Ki] = getGains(A, B, C, X0, Q, Qf, R, horizon)
%   Detailed explanation goes here
    
   X_star = zeros(3,horizon);
   U_star = zeros(5,horizon);
   E = B*R^(-1)*B';
   V = C'*Q*C;
   W = C'*Q;
   
   Z = zeros(size(X_star,1),size(X_star,2));
   Z(:,horizon) = zeros(3,1);
   
   g = zeros(size(C,2),1,horizon);
   g(:,:,horizon) = C'*Qf*Z(:,horizon);
   
   P = zeros(size(C,2),size(C,2),horizon);
   P(:,:,horizon) = C'*Qf*C;
   Ip = eye(size(E,1),size(P,2));
   for k = 1:horizon-1
       P(:,:,k) = A'*P(:,:,k+1)*(Ip+E*P(:,:,k+1))^(-1)*A+V;
   end
end

