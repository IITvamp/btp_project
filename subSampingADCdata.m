function [D1, D2, subSampledData] = subSampingADCdata(subsamplingFactor, ADCdata, radarParams)
    N = radarParams.samplesPerChirp;
    L = radarParams.numChirps;
    if mod(N, subsamplingFactor.fast) ~= 0
    error('InvalidSamplingRate:NonZeroModulus', 'The subSamplingFactor_slow must evenly divide the number of samples per chirp');
    end

    if mod(L, subsamplingFactor.slow) ~= 0
    error('InvalidSamplingRate:NonZeroModulus', 'The subSamplingFactor_fast must evenly divide the number of chirp');
    end

    D1 = zeros(N/subsamplingFactor.fast, N);
    D2 = zeros(L, L/subsamplingFactor.slow);

    row = 1;
    for col = 1: subsamplingFactor.fast: N
        D1(row,col) = 1;
        row = row + 1;
    end

    col = 1;
    for row = 1: subsamplingFactor.slow: L
        D2(row, col) = 1;
        col = col + 1;
    end
    figure;
    imshow(D1)
    title('D1')
    figure;
    imshow(D2)
    title('D2')
    D2
    
    

    subSampledData = D1*ADCdata*D2;
end