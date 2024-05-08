function ADCdata2d = GenerateRadarSignalForMultiTarget(chirpParams, radarParams, groundTruth, K, SNR)
      N = radarParams.samplesPerChirp;
      L = radarParams.numChirps;
      noisePower = 10^((-1 * SNR)/10);
      sigma = sqrt(noisePower/2);
      ADCdata2d = zeros(N, L);
      targetRange = groundTruth.range;
      targetVelocity = groundTruth.velocity;

      for i = 1 : K
          ADCdataOfKthReflection = GenerateRadarSignal(chirpParams, radarParams, targetRange(i), targetVelocity(i));
          noise = 1/sqrt(2) * sigma * (randn(N, L) + 1i * randn(N, L));
          Zamplitude = 0.5 + 0.5 * rand();
          Zphase = 2 * pi * rand();
          Z = Zamplitude * exp(1i * Zphase);
          ADCdata2d = ADCdata2d + Z * ADCdataOfKthReflection + noise;
          
      end
end