function [ next_act, next_ccon, next_kgain ] = activity_iterate( dimd, dimc, act, sensory, weights, ccon, kgain )
%   dimc,dimd: dimensions of controlling and sensory variables (D,C)
%   act: current activity: 1 x P^(D+C)
%   sensory: current sensory input (spikes): P^D x 1 (s^1_1, s^1_2, ...,
%           s^1_P, s^2_1, ..., s^D_1)
%   imat: iterating matrix (combination of M and B)
%   weights: connection weights (w_ij)
%   prefs: preferences: 1 x P^(D+C)
%   ccon: motor command (f^c_i): C x P
%   kgain: Kalman gain: D x 1

%% handle parameters

% transform vectors
if size(act, 1) == 1
    act = act';
end
if size(sensory, 1) == 1
    sensory = sensory';
end
if size(kgain, 1) == 1
    kgain = kgain';
end

% preset parameters
% for 1D obj tracking
mu = 0.001;
eta = 0.01;
numn = size(sensory, 1) / dimd;
dimp = numn;

% vectors to matrix
mat_sensory = reshape(sensory, dimp, dimd);
mat_sensory = mat_sensory';

%% do iteration

weighed_inputs = (weights * act).^2;

hA = weighed_inputs ./ (mu + eta * sum(weighed_inputs));

next_act = hA .* ccon + mat_sensory' * kgain;

end