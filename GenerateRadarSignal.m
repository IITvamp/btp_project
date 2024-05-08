function ADCdata2d = GenerateRadarSignal(chirpParams, radarParams, targetRange, targetVelocity)

    timeStamps = zeros(1, radarParams.numChirps * radarParams.samplesPerChirp); % total size=chirps*no of samples
    t = 0 : radarParams.samplingTime : (radarParams.samplesPerChirp - 1) * radarParams.samplingTime;
    NLsamples = zeros(radarParams.numChirps * radarParams.samplesPerChirp, 1);
    lightSpeed = 3e8;
    
    for chirpIdx = 0 : (radarParams.numChirps - 1)    
        startIdx = 1 + chirpIdx * radarParams.samplesPerChirp;
        endIdx = startIdx + radarParams.samplesPerChirp - 1;
        timeStamps(startIdx : endIdx) = t;
        t = t + chirpParams.chirpRepeatTime;
    end

    t = 0 : radarParams.samplingTime : (radarParams.samplesPerChirp - 1) * radarParams.samplingTime;
    
    for chirpIdx = 0 : (radarParams.numChirps - 1)    
        startIdx = 1 + chirpIdx * radarParams.samplesPerChirp;
        endIdx = startIdx + radarParams.samplesPerChirp - 1;
        phaseTx = 2 * pi * (chirpParams.startFrequency * t + 0.5 * chirpParams.frequencySlope * t .* t);
        tau = 2 * (targetRange + targetVelocity * timeStamps(startIdx : endIdx)) / lightSpeed;
        phaseRx = 2 * pi * (chirpParams.startFrequency * (t - tau) + 0.5 * chirpParams.frequencySlope * (t - tau) .* (t - tau));
        dphase = phaseTx - phaseRx;
        
        NLSamples(startIdx : endIdx) = complex(cos(dphase), sin(dphase));

    end
    
    ADCdata2d = reshape(NLSamples, radarParams.samplesPerChirp, radarParams.numChirps);
end