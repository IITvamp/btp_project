function [Z] = OMPforSubSampledData(Y, F1, F2)
    [sn, N] = size(F1);
    [sl, L] = size(F2);
    Residual_mat = Y;
    yVec = Y(:);
    size(Y);
    B = [];
    P_inv = [];
    support   = [];
    Z = [];
    deltaCorrThreshold = 1;

    maxIteration = 50;

    maxCorrValue = 1e-10;
    
    
    for iterator = 1 : maxIteration
        previousMaxCorrValue = maxCorrValue;
        
        corr_mat = F1' * Residual_mat * conj(F2);
        [maxCorrValue, max_index] = max(abs(corr_mat),[],'all');
        
        
        [row, col] =  ind2sub(size(corr_mat), max_index);
        deltaCorr = (abs(maxCorrValue - previousMaxCorrValue)/previousMaxCorrValue)*100;
     
     

        if(deltaCorr < deltaCorrThreshold)
            break;
        end

        support = [support max_index];
        kron_col = kron(F2(:, col), F1(:, row));

        if (iterator == 1)
            P_inv = 1/ (kron_col'* kron_col);
        else 
            P_inv = pseudoInverse(P_inv, B, kron_col);
        end

        
        B = [B kron_col]; 

        xk = (P_inv*B')*yVec;

        z = zeros(N*L,1);
        z(support) = xk;
        
        Z = reshape(z, N, L);
        Residual_mat = Y - F1*Z*transpose(F2);

        error = norm(Residual_mat, "fro");
        %fprintf('\n%s %d \t residual error = %d', 'iterator', iterator, error);

    end
         
end