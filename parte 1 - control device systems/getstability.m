function [isStable] = getstability(A)
%%Restituisce false se gli autovalori del sistema portano instabilit�

%Otteniamo gli autovalori della matrice A:
eigenvalues = eig(A);
isStable = true;
multeplicity = 0;
for i = 1 : size(eigenvalues)
    if(abs(eigenvalues(i)) > 1)
       isStable = false;
       break;
    end
    %Se gli autovalori hanno modulo 1 e molteplicit� > 1 , il sistema �
    %instabile
    if(abs(eigenvalues(i) == 1))
        multeplicity = multeplicity + 1;
    end
    if(multeplicity == 2)
       isStable = false;
       break;
    end
end
