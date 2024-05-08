function ZdB = OMPestimationVisualisation(Z, radarParams, chirpParams, groundTruth)

    N = radarParams.samplesPerChirp;
    L = radarParams.numChirps;

    figure;
    Zlinear = (abs(Z));
  
    Zfinal = [Zlinear(:,L/2 + 1:L), Zlinear(:,1:L/2)];
  
    
    ZdB = 10*log10(Zfinal);
    rangeAxis = 0 : chirpParams.rangeRes : (N - 1) * chirpParams.rangeRes;
    velocityAxis = -chirpParams.velocityRes *(L/2) : chirpParams.velocityRes : chirpParams.velocityRes *(L/2 - 1);

    [V_axis, R_axis] = meshgrid(velocityAxis, rangeAxis);
    surf(V_axis, R_axis, Zfinal, 'edgecolor', 'none', 'FaceAlpha',1);
    xlabel('Doppler Axis (m/s)');
    ylabel('Range Axis (m)');
    zlabel('Magnitude of Z (in dB)');
    title('OMP based estimation on subsampled data');
    hold on;
     

     for i = 1:length(groundTruth.velocity)
        plot3([groundTruth.velocity(i), groundTruth.velocity(i)], [groundTruth.range(i), groundTruth.range(i)], [0, 100], 'Color', 'r', 'LineWidth', 2, 'Marker', 'o'); 
     end
   
     legend('estimated value', 'ground Truth');

end