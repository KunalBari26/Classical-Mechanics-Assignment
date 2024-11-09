clc;
clear;


M = 1;          
m = 0.5;         
k = 1;           

omega1 = 0;                              
omega2 = sqrt(k / M);                    
omega3 = sqrt(k * (1 + 2 * M / m) / M);  


c1 = 0.0; 
c2 = 0.05;  
c3 = 0.03; 

numFrames = 200;                               
t = linspace(0, 2 * pi / min(omega2, omega3), numFrames);  


figure;
axis equal;
axis([-0.3 0.3 -0.2 0.2]); 
hold on;
grid on;
title('CO2 Molecule Oscillations');
xlabel('Position');
ylabel('Relative Displacement');

colors = ['r', 'g', 'b']; 
labels = {'O', 'C', 'O'};


videoFilename = 'Question 1 Final Video.mp4';
video = VideoWriter(videoFilename, 'MPEG-4');
video.FrameRate = 20;
open(video);


minDistance = 0.1;  


for i = 1:numFrames
    clf;  
    axis equal;
    axis([-0.3 0.3 -0.2 0.2]);
    hold on;
    title('CO2 Molecule Oscillations');
    xlabel('Position');
    ylabel('Relative Displacement');
    grid on;
    
    
    x1 = c1 * cos(omega1 * t(i)) + c2 * cos(omega2 * t(i)) + c3 * cos(omega3 * t(i)); 
    x2 = c1 * cos(omega1 * t(i)) - (2 * M / m) * c2 * cos(omega2 * t(i)) + c3 * cos(omega3 * t(i));            
    x3 = -c1 * cos(omega1 * t(i))  + c3 * cos(omega3 * t(i)); 

    
    if x1 > x2
        temp = x1; 
        x1 = x2;
        x2 = temp;
    end
    if x2 > x3
        temp = x2; 
        x2 = x3;
        x3 = temp;
    end
    if x1 > x2
        temp = x1;
        x1 = x2;
        x2 = temp;
    end

   
    if (x2 - x1) < minDistance
        overlapAdjustment = (minDistance - (x2 - x1)) / 2;
        x1 = x1 - overlapAdjustment;
        x2 = x2 + overlapAdjustment;
    end
    
    if (x3 - x2) < minDistance
        overlapAdjustment = (minDistance - (x3 - x2)) / 2;
        x2 = x2 - overlapAdjustment;
        x3 = x3 + overlapAdjustment;
    end
    
    
    plot(x1, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(1));
    plot(x2, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(2));
    plot(x3, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(1));
    
    text(x1, 0.05, labels{1}, 'HorizontalAlignment', 'center', 'Color', colors(1));
    text(x2, 0.05, labels{2}, 'HorizontalAlignment', 'center', 'Color', colors(2));
    text(x3, 0.05, labels{3}, 'HorizontalAlignment', 'center', 'Color', colors(1));

    
    plot([x1, x2], [0, 0], 'k-', 'LineWidth', 2); 
    plot([x2, x3], [0, 0], 'k-', 'LineWidth', 2); 

    
    frame = getframe(gcf);
    writeVideo(video, frame);

    
    pause(0.05);
end


close(video);
disp(['Video saved as ', videoFilename]);
