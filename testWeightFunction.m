function testWeightFunction( weight, frequency, distance )

% This function calculate the weight performance along the angle
% The three parameters here are obviously not independent. weight can be
% obtained by given frequency and distance.

N = numel(weight);
startAngle = -90;
endAngle = 90;
lambda = 340/frequency;


% define the angle interval
interval = 0.2;

% to save the amplitude data
y1 = zeros(numel(startAngle:interval:endAngle),1);
index = 0;
for theta = startAngle:interval:endAngle
    index = index + 1;
    phi = distance * sin( theta/180 * pi )/lambda * 2 * pi;
    result = 0;
    for i = 1:N
        result = result + exp(1j * (i-1)* phi)* weight(i);
    end
    y1(index) = log(abs(result)) * 20;
end

plot(startAngle:interval:endAngle , y1);