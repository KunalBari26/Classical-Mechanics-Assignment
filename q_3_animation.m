clc;
clear;


m = 1;              
k = 1;             
c1 = 0.3;           
c2 = 0.2;           
c3 = 0.15;          


omega1 = 0;                  
omega2 = sqrt(3 * k / m);    
omega3 = -sqrt(3 * k / m);   


numFrames = 200;             
t = linspace(0, 2 * pi, numFrames);  


x0 = [0, -1, 1];    
y0 = [sqrt(3)/2, -sqrt(3)/2, -sqrt(3)/2];  


videoFilename = 'Question 3 Final Video.mp4';
video = VideoWriter(videoFilename, 'MPEG-4'); 
video.FrameRate = 20; 
open(video); 

figure;
axis equal;
axis([-2 2 -2 2]);
hold on;
grid on;
title('Triangular Mass-Spring Oscillation Animation');
xlabel('X Position');
ylabel('Y Position');


colors = ['r', 'g', 'b'];
labels = {'m', 'm', 'm'};

for i = 1:numFrames
    
    clf;
    axis equal;
    axis([-2 2 -2 2]);
    hold on;
    title('Equilateral Triangle Mass System');
    xlabel('X Position');
    ylabel('Y Position');
    grid on;
    
    
    x1 = x0(1) + c1 * cos(omega1 * t(i)) + c2 * cos(omega2 * t(i))+ c3 * cos(omega3 * t(i));
    x2 = x0(2) + c1 * cos(omega1 * t(i)) - c2 * cos(omega2 * t(i)) ;
    x3 = x0(3) + c1 * cos(omega1 * t(i)) - c3 * cos(omega3 * t(i));
    
    y1 = y0(1) + c1 * cos(omega1 * t(i)) + c2 * cos(omega2 * t(i))+ c3 * cos(omega3 * t(i));
    y2 = y0(2) + c1 * cos(omega1 * t(i)) - c2 * cos(omega2 * t(i)) ;
    y3 = y0(3) + c1 * cos(omega1 * t(i)) - c3 * cos(omega3 * t(i));
    
    
    X = [x1, x2, x3];
    Y = [y1, y2, y3];

    
    for j = 1:3
        plot(X(j), Y(j), 'o', 'MarkerSize', 20, 'MarkerFaceColor', colors(j));
        text(X(j), Y(j) + 0.1, labels{j}, 'HorizontalAlignment', 'center', 'Color', colors(j));
    end

    
    plot([X(1), X(2)], [Y(1), Y(2)], 'k-', 'LineWidth', 2); 
    plot([X(2), X(3)], [Y(2), Y(3)], 'k-', 'LineWidth', 2); 
    plot([X(3), X(1)], [Y(3), Y(1)], 'k-', 'LineWidth', 2); 

   
        frame = getframe(gcf);
        writeVideo(video, frame);
        pause(0.05);
end

close(video);
disp(['Video saved as ', videoFilename]);
