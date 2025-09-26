function [GSP,lamda,lamda_last,Up_first,dU] = LoadParameter(Up,Ur,i,j,Up_lastFirst, ...
    lamda_last,Up_initial,Up_first,GSP,lamda_initial)
% ----------------------------------------
% Generalized displacement control method
% ----------------------------------------
if (j == 1)
    GSP = Up_initial' * Up_initial / (Up_lastFirst' * Up_first);
    if (i == 1)
        lamda = lamda_last;
        GSP   = 1;
    else
        lamda = sign(lamda_last) * sign(GSP) * lamda_initial * sqrt(Up_initial' * Up_initial / (Up_first' * Up_first));   % MGDC 
        % lamda = sign(lamda_last) * sign(GSP) * lamda_initial * sqrt(abs(GSP));  
    end
    lamda_last = lamda;
else
    lamda = -(Up_first' * Ur) / (Up_first' * Up);
end
dU = Up * lamda + Ur;