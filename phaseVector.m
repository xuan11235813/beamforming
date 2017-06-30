function vector = phaseVector( angle, num, interval_distance, frequency )

% angle : the incidence angle, orthogonal wave transition direction and receiver
% vector direction.
% num: the half receiver number besides the center one
% interval_distance: the distances between each sensor in receiver
% frequency: narrow band wave frequency

%This is for beamforming test. Because the multiplication between weight
%vector and incoming siganl is independent of global time delay. So we can
%just define the center phase is always 0.

% speed = sound speed
speed = 340;

angle  = angle/180 *pi;
disPhase = interval_distance * sin(angle)/speed * frequency * 2 * pi;

vector = zeros(2 *num +1,1);

for j = -num : num
    vector(j + num + 1) = cos(j * disPhase) + 1i * sin(j * disPhase);
end