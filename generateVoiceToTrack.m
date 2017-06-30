% Development by Gan Zixuan


% This function is to generate 10 tracks of music from two mp3 file, whose
% names are determined as test1.mp3 and test2.mp3. The inpur variables are
% startTime: the start time to generate, second
% endTime: finish time, second
% angle1: normal angle, -90~90, of test1.mp3
% angle2: normal angle, -90~90, of test2.mp3
% IMPORTANT: the startTime and endTime here are exactly the earilies 
% microphone. 

function generateVoiceToTrack( startTime, endTime, angle1, angle2 )


para = sysParameter;
frequency = para.getFrequency();
microNum = para.getMicroNum();
% read the audio
[y1, ~] = audioread('test1.mp3');
[y2, ~] = audioread('test2.mp3');

% prepare for the basic parameter
shift1 = para.getShift(angle1);
shift2 = para.getShift(angle2);
startIndex = fix(startTime * frequency);
endIndex = fix(endTime * frequency);
audiowrite('origin1.wav',y1(startIndex:endIndex, 1), frequency);
audiowrite('origin2.wav',y2(startIndex:endIndex, 1), frequency);

% change the directory
mkdir testAudio;
cd testAudio;

% regenerate the audio
for i = 1:microNum
    currentStart1 = startIndex + (i - 1) * shift1;
    currentEnd1 = endIndex + (i - 1) * shift1;
    currentStart2 = startIndex + (i - 1) * shift2;
    currentEnd2 = endIndex + (i - 1) * shift2;
    testAudio = y1(currentStart1:currentEnd1, 1);
    testAudio = testAudio + y2(currentStart2:currentEnd2,1);
    fileName = strcat(num2str(i),'.wav');
    audiowrite(fileName, testAudio, frequency);
end


cd ..
clear y1;
clear y2;