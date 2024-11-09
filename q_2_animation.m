clc;
clear;

c1 = 0.3;   
c2 = 0.2;   
c3 = 0.15;  

omega1 = sqrt(2);          
omega2 = 2 + sqrt(2);      
omega3 = 2 - sqrt(2);      

numFrames = 250;            
t = linspace(0, 2 * pi, numFrames);  

videoFilename = 'Question 2 Final Video.mp4';
video = VideoWriter(videoFilename, 'MPEG-4'); 
video.FrameRate = 20; 
open(video); 

figure;
axis equal;
axis([-2 2 -2 2]);
hold on;
grid on;
title('Mass-Spring Oscillation Animation');
xlabel('X Position');
ylabel('Y Position');

figure;
axis equal;
axis([-2 2 -0.5 0.5]);
hold on;
grid on;
title('3-Mass 4-Spring System ');
xlabel('Position');
ylabel('Amplitude');

colors = ['r', 'g', 'b'];
labels = {'m', 'm', 'm'};


minDistance = 0.5;  

for i = 1:numFrames
    
    clf;
    axis equal;
    axis([-2 2 -0.5 0.5]);
    hold on;
    title('3-Mass 4-Spring System ');
    xlabel('Position');
    ylabel('Amplitude');
    grid on;
    
    % Define the positions of the masses
    x1 = -c1 * cos(omega1 * t(i))  + c3 * cos(omega3 * t(i));
    x2 = c1 * cos(omega1 * t(i)) + sqrt(2) * c2 * cos(omega2 * t(i)) + c3 * cos(omega2 * t(i));
    x3 = c1 * cos(omega1 * t(i)) - sqrt(2) * c2 * cos(omega2 * t(i)) + c3 * cos(omega2 * t(i));
    
    % Ensure the masses do not cross or overlap
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

    % Enforce minimum distance between masses
    % If the distance between consecutive masses is less than the threshold, adjust the positions
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
    
    % Plot the masses
    plot(x1, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(1));
    text(x1, 0.1, labels{1}, 'HorizontalAlignment', 'center', 'Color', colors(1));
    plot(x2, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(2));
    text(x2, 0.1, labels{2}, 'HorizontalAlignment', 'center', 'Color', colors(2));
    plot(x3, 0, 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(3));
    text(x3, 0.1, labels{3}, 'HorizontalAlignment', 'center', 'Color', colors(3));

    % Plot the springs (lines between masses)
    plot([x1, x2], [0, 0], 'k-', 'LineWidth', 2); 
    plot([x2, x3], [0, 0], 'k-', 'LineWidth', 2); 
    plot([-2, x1], [0, 0], 'k-', 'LineWidth', 2); 
    plot([x3, 2], [0, 0], 'k-', 'LineWidth', 2);  

    
    frame = getframe(gcf);
    writeVideo(video, frame);
    
    pause(0.05);  
end

close(video);
disp(['Video saved as ', videoFilename]);
