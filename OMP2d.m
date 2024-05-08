function [x_est] = OMP2d(Y, Fr, Fd)

    [N, L] = size(Y);

    x_est = zeros(N, L);
    residual_mat = Y;
    error = norm(residual_mat);

    threshold = 1;
    AhermY = Fr * Y * transpose(Fd);
    
    for iterator = 1 : N
        
        corr_mat = Fr * residual_mat * transpose(Fd);
        [~, index] = max(abs(corr_mat),[],'all');
        [row, col] =  ind2sub([N, L], index);
        a_k = AhermY(row, col);
        x_est(row, col) = a_k;

        residual_mat = residual_mat - (a_k * conj(Fr(:, row)) * Fd(:, col)' );
        error = norm(residual_mat, "fro");
        if(error < threshold)
            break
        end
    end 
      
end