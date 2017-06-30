
% specify the frequency and angle
frequency = 300;
angle = 30;
distance = 0.6;
N = 12;
elementPos = (0: N-1) * distance;
lambda = 340/frequency;
weight1 = cbfweights(elementPos/lambda, angle);
weight2 = calculateBeamformingWeight( elementPos/lambda , angle );

figure;
hold;

testWeightFunction( weight1, frequency, distance );
testWeightFunction( weight2, frequency, distance );