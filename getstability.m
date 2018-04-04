function [isStable] = getstability(A)

eigenvalues = eig(A);
isStable = true;
multeplicity = 0;
for i = 1 : size(eigenvalues)
    if(abs(eigenvalues(i)) > 1)
       isStable = false;
       break;
    end
    if(abs(eigenvalues(i) == 1))
        multeplicity = multeplicity + 1;
    end
    if(multeplicity == 2)
       isStable = false;
       break;
    end
end
