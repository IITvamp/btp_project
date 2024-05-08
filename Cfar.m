function peak = Cfar(RangeDopplerDFT, chirpParams, radarParams, signal_cells, noise_cells)
    
    Z = (abs(RangeDopplerDFT));
    Z_mod = [Z(:, end/2+1:end), Z(:, 1:end/2)];
 
    N = radarParams.samplesPerChirp;
    L = radarParams.numChirps;
    max_snr =  -inf;
    for i = 1 + noise_cells : N - noise_cells
        for j = 1 + noise_cells : L - noise_cells
            total_power = 0;
            signal_power = 0;
            for p = i - noise_cells : i + noise_cells
                for q = j - noise_cells : j + noise_cells
                    total_power = total_power + Z_mod(p, q)^2;
                end
            end
            for p = i - signal_cells : i + signal_cells
                for q = j - signal_cells : j + signal_cells
                    signal_power = signal_power + Z_mod(p, q)^2;
                end
            end
            noise_power = total_power - signal_power;

            avg_signalPower = signal_power/((2*signal_cells + 1)*(2*signal_cells + 1));
            avg_noisePower = noise_power/((2*noise_cells + 1)*(2*noise_cells + 1) - (2*signal_cells + 1)*(2*signal_cells + 1));

            SNR = avg_signalPower/avg_noisePower;
            SNR = 10*log10(SNR);
            if(SNR > max_snr)
               max_snr = SNR;
                peak = [(i-1)*chirpParams.rangeRes, (j-1-L/2)*chirpParams.velocityRes];
           end
        end
    end

end