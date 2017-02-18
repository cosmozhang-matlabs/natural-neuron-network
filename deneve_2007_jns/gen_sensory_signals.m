function [ spikes, firing_rates ] = gen_sensory_signals( p, sti, steps )
%   p: number of neurons or preferred stimulis of neurons
%   sti: the stimuli value

%% handle the parameters

% prefs: a row vector
if numel(p) == 1
    prefs = gen_preferences(p);
elseif size(p, 1) == 1
    prefs = p;
else
    prefs = p';
end

numn = size(prefs, 2);

if nargin < 3
    steps = 1;
end

%% generate

func_fr = @(x,xi) 3 * exp( 2 * cos(x - xi) - 1 ) + 0.03;
firing_rates = func_fr(sti, prefs);

spikes = zeros(steps, numn);

for i = 1:numn
    spikes(:,i) = poissrnd(firing_rates(i), steps, 1);
end

end

