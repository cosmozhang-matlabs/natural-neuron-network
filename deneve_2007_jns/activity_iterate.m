function [ next_act, next_kgain ] = activity_iterate( dimd, dimc, act, sensory, imat, prefs, kgain )
%   dimc,dimd: dimensions of controlling and sensory variables
%   act: current activity: 1 x P^(D+C)
%   sensory: current sensory input (spikes): 1 x P^D
%   imat: iterating matrix (combination of M and B)
%   kgain: Kalman gain

%% handle parameters

% preset parameters
% for 1D obj tracking
mu = 0.001;
eta = 0.01;
kw = 1;

end