% Development by Gan Zixuan

angle = [60,30];
% from 35 seconds to 55 seconds;
% test1 is from angle 60;
% test2 is from angle 0;
generateVoiceToTrack( 35, 55, angle(1), angle(2) );

% major process procedure:
% add window
% fft
% cbfweights
% ifft
% add window and synthesis

% get the constant parameter
para = sysParameter;
microNum = para.getMicroNum();
frequency = para.getFrequency();
distance = para.getInterval();
velocity = para.getSoundVelocity();
chipNum = para.getChipNum();
elementPos = (0:microNum-1)*distance;
% check the test files and initialize chip number
[y,~] = audioread('testAudio\1.wav'); 
sample = numel(y(:,1));

% chip number
N = floor(numel(y)/chipNum);

% allocate the target array
targetTrack1 = zeros(sample,1);
targetTrack2 = zeros(sample,1);

% allocate the memory to all the sound track
trackMemory = zeros(sample, microNum);
implementMemory = zeros(chipNum, microNum);
% read the test files
for i = 1:microNum
    fileName = strcat(num2str(i),'.wav');
    fileName = strcat('testAudio\',fileName);
    [y,~] = audioread(fileName); 
    trackMemory(:,i) = y(1:sample,1);
end

% get window
window = generateWindow( chipNum );

% calculate the weights
weight1 = zeros(chipNum, microNum);
weight2 = zeros(chipNum, microNum);

for j = 1:chipNum
    % calculate the frequency of current point
    fc = (j - 1)*frequency/chipNum;
    lambda = velocity/fc;
    
    % use phased array tool box to get beamforming weight
    wt = calculateBeamformingWeight(elementPos/lambda, angle);
    weight1(j,:) = wt(:,1)';
    weight2(j,:) = wt(:,2)';
end

% the chip is half overlapped 
for i = 1:2*N -1
    startIndex = (i - 1) * chipNum/2 + 1;
    endIndex = (i + 1) * chipNum/2;
    for j = 1:microNum
        
        %copy data to implement buffer
        implementMemory(:,j) = trackMemory(startIndex : endIndex,j);
        
        % multiply the window
        implementMemory(:,j) = implementMemory(:,j).*window;
        
        % fft
        implementMemory(:,j) = fft(implementMemory(:,j));
    end
    
    % times weight
    % ifft
    % real (hilbert)
    % times window
    halfTarget1 = ifft(sum(implementMemory.*weight1,2),'symmetric').*window;
    halfTarget2 = ifft(sum(implementMemory.*weight2,2),'symmetric').*window;
    
    % add to target buffer
    targetTrack1(startIndex:endIndex,1) = targetTrack1(startIndex:endIndex,1) + halfTarget1;
    targetTrack2(startIndex:endIndex,1) = targetTrack2(startIndex:endIndex,1) + halfTarget2;
end

audiowrite('target1.wav', targetTrack1, frequency);
audiowrite('target2.wav', targetTrack2, frequency);

clear;
clc;
