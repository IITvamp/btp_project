clear all;
close all;
clc;

[radarParams, chirpParams] = params();
SNR = -20; % in dB

threshold_SNR = 10; % in dB

Fr = (1/sqrt(radarParams.samplesPerChirp))*dftmtx(radarParams.samplesPerChirp);
Fd = (1/sqrt(radarParams.numChirps))*dftmtx(radarParams.numChirps);


K = 1;

[groundTruth] = GenerateTarget(radarParams, chirpParams, K);
ADCdata2d = GenerateRadarSignalForMultiTarget(chirpParams, radarParams, groundTruth, K, SNR);

RangeDopplerDFTmtx = RangeDopplerDFT(ADCdata2d, Fr, Fd);
%ZdB = RangeDopplerDFTvisualization(RangeDopplerDFTmtx, radarParams, chirpParams);

signal_cells = 1;
noise_cells = 3;

%peaks = Cfar(RangeDopplerDFTmtx, chirpParams, radarParams, threshold_SNR, signal_cells, noise_cells);

 %disp('omp solution')
 %x_est = OMP2d(ADCdata2d, Fr, Fd);
 %ZdB = RangeDopplerDFTvisualization(x_est, radarParams, chirpParams);





% subsampling
subsamplingFactor.fast = 4;
subsamplingFactor.slow = 1;


[D1, D2, subSampledData] = subSampingADCdata(subsamplingFactor, ADCdata2d, radarParams);
[Z] = OMPforSubSampledData(subSampledData, D1*Fr', D2'*Fd');
ZdB = OMPestimationVisualisation(Z, radarParams, chirpParams, groundTruth);

%MeansquareErrorVsSNR(radarParams, chirpParams, Fr, Fd)




