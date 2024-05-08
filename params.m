function[radarParams, chirpParams] = params()
speedOfLight = 3e8;

% radar Parameters
radarParams.numChirps = 64;                 % chirps
radarParams.samplingFrequency = 20e6;       % Sampling frequency (MHz)
radarParams.samplingTime = 1 / radarParams.samplingFrequency; % Sampling time
radarParams.samplesPerChirp = 512;           % Samples

% Chirp Parameters
chirpParams.startFrequency = 77e9;          
chirpParams.frequencySlope = 30e6 / (1e-6); % MHz/us
chirpParams.chirpDuration = 15e-6; 
chirpParams.rampUpTime = 20e-6; % us
chirpParams.bandwidth = chirpParams.chirpDuration * chirpParams.frequencySlope;
chirpParams.chirpRepeatTime = chirpParams.rampUpTime + 2e-6;
chirpParams.rangeRes = speedOfLight * chirpParams.chirpDuration / (2 * chirpParams.bandwidth * radarParams.samplesPerChirp * radarParams.samplingTime); % in meter
chirpParams.velocityRes = speedOfLight / (2 * chirpParams.startFrequency * chirpParams.chirpRepeatTime * radarParams.numChirps); % in meter/sec

end