function [isStable] = getstability(A)

eigenvalues = eig(A);
isStable = true;

for i = 1 : size(eigenvalues)
    if(abs(eigenvalues(i)) > 1)
       isStable = false;
       break;
    end
end
