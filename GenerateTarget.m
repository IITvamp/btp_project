function [groundTruth] = GenerateTarget(radarParams, chirpParams, K)

maxRange = chirpParams.rangeRes * (radarParams.samplesPerChirp/2 - 1) ;
maxVelocity = chirpParams.velocityRes * (radarParams.numChirps/2 - 1);
groundTruth.range = zeros(K, 1);
groundTruth.velocity = zeros(K, 1);
for i = 1:K
    groundTruth.range(i) = max(0.5,  rand*(0.9* maxRange));
    groundTruth.velocity(i) = -0.9 * maxVelocity +  rand*(2* 0.9 * maxVelocity);
    %hack ankit
    %groundTruth.velocity(i)  = abs(groundTruth.velocity(i));
end


disp('Target Range, Velecoity')
disp([groundTruth.range, groundTruth.velocity])
end