function weight = calculateBeamformingWeight( standardPhase , angle )

% This function is used for calculating beamforming weights. The essential
% idea for this function is trying to fix the phase difference of incoming
% signals of dertermined direction.

% standardPhase is a vector, which represents the distances of each pair of
% adjacent sensors and divided by wave length (total phase difference)

M = numel(standardPhase);
N = numel(angle);

% allocate the phase difference memory
weight = zeros(M,N);

for i = 1:N
    for k = 1:M
        weight(k,i) = standardPhase(k) * sin( angle(i)/180 * pi )* 2 * pi;
    end
end

weight = exp( 1j * weight)/M;