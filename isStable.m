function [stable] = isStable(A)
lambda = eig(A);
stable = 1;
for i = 1:size(A)
    if(abs(lambda(i)) > 1)
       stable = 0;
       break;
    end
    if(stable)
        stable = 1;
    end
end