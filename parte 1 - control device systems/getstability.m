function [isStable] = getstability(A)
%%Restituisce false se gli autovalori del sistema portano instabilità

%Otteniamo gli autovalori della matrice A:
eigenvalues = eig(A);
isStable = true;
multeplicity = 0;
for i = 1 : size(eigenvalues)
    if(abs(eigenvalues(i)) > 1)
       isStable = false;
       break;
    end
    %Se gli autovalori hanno modulo 1 e molteplicità > 1 , il sistema è
    %instabile
    if(abs(eigenvalues(i) == 1))
        multeplicity = multeplicity + 1;
    end
    if(multeplicity == 2)
       isStable = false;
       break;
    end
end
