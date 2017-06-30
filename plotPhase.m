% test basic beamforming response

sideNum = 10;
frequency = 150;
interval_distance = 0.1;

target_angle = -20;
targetVector = phaseVector( target_angle, sideNum, interval_distance, frequency );
weight_angle_low = -90;
weight_angle_high = 90;
weight_angle_interval = 1;

testData = zeros( round((weight_angle_high - weight_angle_low) / weight_angle_interval) +1, 2 );

index = 1;
for weight_angle = weight_angle_low : weight_angle_interval : weight_angle_high
    currentVector = phaseVector( weight_angle, sideNum, interval_distance, frequency );
    testData(index,1) = abs(sum( currentVector .* targetVector ));
    testData(index,2) = weight_angle;
    index = index +1;
end

plot(testData(:,1));
hold;
%plot(testData(:,2));