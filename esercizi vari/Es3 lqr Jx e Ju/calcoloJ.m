function [Jx, Ju] = calcoloJ(horizon, x0, A, B, C, T, Q, sample_time, ro)
    
    Jx = 0; 
    
    [Kd,~, ~] = lqrd(A,B,Q,ro, sample_time);
    %Simulo il nuovo sistema:
    sys_closed_infinite_horizon=ss(A-B*Kd,B,C,0,sample_time);
    U=zeros(1,length(T));
    [~, ~, X] = lsim(sys_closed_infinite_horizon,U,T,x0);

    for i = 1:sample_time:horizon-1
        Jx = Jx + X(i,:)*Q*X(i,:)';
    end
    Jx = Jx + X(horizon,:)*X(horizon,:)';

    
    Ju = 0;

    for i = i:sample_time:horizon-1
        Ju = Ju + ro*Kd*X(i,:)';
    end

    end