function [ spikes, firing_rates ] = gen_sensory_signals( preferences, sti, dimd )
%   p: number of neurons or preferred stimulis of neurons
%   sti: the stimuli value

%% handle the parameters

% prefs: a row vector
if numel(preferences) == 1
    prefs = gen_preferences(preferences);
elseif size(preferences, 1) == 1
    prefs = preferences;
else
    prefs = preferences';
end

numn = size(prefs, 2);

%% generate

firing_rates = zeros(dimd, numn);
% spikes = zeros(dimd, numn);

func_fr = @(x,xi) 3 * exp( 2 * cos(x - xi) - 1 ) + 0.001;
for d = 1:dimd
    firing_rates(d,:) = func_fr(sti(d), prefs);
end

% for i = 1:numn
%     spikes(:,i) = poissrnd(firing_rates(i), 1, 1);
% end
spikes = poissrnd(firing_rates);

end

