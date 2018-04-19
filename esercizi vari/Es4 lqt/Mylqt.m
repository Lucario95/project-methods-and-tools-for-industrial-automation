function [X_star, U_star, L, Lg, g] = Mylqt(A, B, C, Z, Q, Qf, R, intervallo, x0)
   [~ , m] = size(C);
   P = zeros(m, m,length(intervallo));
   P(:,:,length(intervallo)) = C'*Qf*C;
   E = B*R^-1*B';
   I = eye(m);
   W = C'*Q;
   V = W*C;
   g = zeros(m, length(intervallo));
   g(:,length(intervallo)) = C'*Qf*Z(:,length(intervallo));
   %Calcolo backward delle matrici P,g,L,Lg:
   for k =length(intervallo)-1:-1:1
        P(:,:,k) = A'*P(:,:,k+1)*(I+E*P(:,:,k+1))^(-1)*A+V;
        g(:,k) = A'*(I - (P(:,:,k)^-1+E)^(-1)*E)*g(:,k+1)+W*Z(:,k);
        L(:,:,k) = (R + B'*P(:,:,k+1)*B)^(-1)*B'*P(:,:,k+1)*A;
        Lg(:,:,k) = (R + B'*P(:,:,k+1)*B)^(-1)*B';
   end
   
   %Calcolo forward di X* e U*:
   [~, m] = size(C);
   X_star = zeros(m,length(intervallo));
   [~, m] = size(B);
   U_star = zeros(m, length(intervallo));
   X_star(:,1) = x0;
   for k = 1:length(intervallo)-1
       U_star(:,k) = -L(:,:,k)*X_star(:,k)+Lg(:,:,k)*g(:,k+1);
       X_star(:,k+1) = (A - B*L(:,:,k))*X_star(:,k) + B*Lg(:,:,k)*g(:,k+1);
   end
       
   
end