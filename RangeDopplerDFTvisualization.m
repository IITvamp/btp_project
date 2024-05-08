function ZdB = RangeDopplerDFTvisualization(DopplerDFTdata, radarParams, chirpParams)


    figure;
    Zlinear = (abs(DopplerDFTdata));
    [N,L] = size(Zlinear);
  
    Zpro = Zlinear(1:N/2,:);
    %Zpro = Zlinear;
    Zfinal = [Zpro(:,L/2 + 1:L), Zpro(:,1:L/2)];
  
    
    ZdB = 10*log10(Zfinal);
    rangeAxis = 0 : chirpParams.rangeRes : (radarParams.samplesPerChirp/2 - 1) * chirpParams.rangeRes;
    velocityAxis = -chirpParams.velocityRes *(radarParams.numChirps/2) : chirpParams.velocityRes : chirpParams.velocityRes *(radarParams.numChirps/2 - 1);

    [V_axis, R_axis] = meshgrid(velocityAxis, rangeAxis);
    surf(V_axis, R_axis, Zfinal, 'edgecolor', 'none', 'FaceAlpha',1);
    xlabel('Doppler Axis (m/s)');
    ylabel('Range Axis (m)');
    zlabel('Magnitude of 2D DFT (in dB)');
    title('RangeDoppler DFT');

end