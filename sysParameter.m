% Development by Gan Zixuan

classdef sysParameter
    properties
       distance = 1;
       soundVelocity = 340;
       frequency = 44100;
       microphoneNumber = 11;
       chipNum = 8192;
    end
    
    % The only thing need to be remembered is method getShift. The input
    % parameter theta is the angle between incident ray and vertical
    % orientation of microphone line, from -90 to 90. Output is the shift 
    % size of current sample frequency.
    
    methods
        function velocity = getSoundVelocity(obj)
            velocity = obj.soundVelocity;
        end
        function interval = getInterval(obj)
            interval = obj.distance;
        end
        function freq = getFrequency(obj)
            freq = obj.frequency;
        end
        function num = getMicroNum(obj)
            num = obj.microphoneNumber;
        end
        function waveLength = getWaveLength(obj)
            waveLength = obj.soundVelocity/obj.frequency;
        end            
        function intervalShift = getShift( obj, theta )
            intervalShift = fix(obj.distance * sin(theta / 180 * pi)/obj.soundVelocity * obj.frequency);
        end
        function num = getChipNum(obj)
            num = obj.chipNum;
        end
    end
    
end

