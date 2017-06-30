function testAngleAmplitudeArray(frequency,distance)
startAngle = -90;
endAngle = 90;
lambda = 340/frequency;
N = 9;

pos = [
    0;
    2;
    3;
    4;
    5;
    6;
    7;
    8;
    10];


% This function is to test the synthesis amplitude
% distance: the interval distance between each adjacent microphone
% lambda: wave length
% microphone number

% define the angle interval
interval = 0.2;

% to save the amplitude data
y1 = zeros(numel(startAngle:interval:endAngle),1);
y2 = zeros(numel(startAngle:interval:endAngle),1);
y3 = zeros(numel(startAngle:interval:endAngle),1);
y4 = zeros(numel(startAngle:interval:endAngle),1);
index = 0;
for theta = startAngle:interval:endAngle
    index = index + 1;
    phi = distance * sin( theta/180 * pi )/lambda * 2 * pi;
    result = 0;
    for i = 1:N
        result = result + exp(1j * (i-1)* phi);
    end
    y1(index) = log(abs(result)) * 20;
    y2(index) = abs(result);
    
    result = sum(exp(1j * pos* distance * sin( theta/180 * pi )/lambda * 2 * pi));
    y3(index) = log(abs(result)) * 20;
    y4(index) = abs(result);
end
y2 = y2.* (max(y1)/max(y2));
y4 = y4.* (max(y3)/max(y4));
figure;
hold;
plot(startAngle:interval:endAngle , y1, 'yellow');
plot(startAngle:interval:endAngle , y2, 'red');
plot(startAngle:interval:endAngle , y3, 'green');
plot(startAngle:interval:endAngle , y4, 'blue');
