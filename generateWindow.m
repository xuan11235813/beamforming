% Development by Gan Zixuan

function window = generateWindow(N)

window = 1:N;

window = sin((window' - 1)/(N-1) * pi);
