function [ predictions ] = act_predict( numn, dimd, dimc, acts, prefs, eyeWeights )
% act_predict( acts ): predict the true values according to acts
%   dimc,dimd: dimensions of controlling and sensory variables (D,C)
%   acts: 1 x P^(D+C)
%   prefs: (D+C) x P^(D+C)
%   predictions: (D+C) vector

RCRT_STEPS = 10;

%% method 1
% sum_acts = sum(acts);
% predictions = prefs * acts' ./ sum_acts;


%% method 2
% [~,max_pos] = max(acts);
% predictions = prefs(:, max_pos);


%% method 3
acts = acts';
for i = 1:RCRT_STEPS
    acts = activity_iterate(dimd, dimc, acts, zeros(1, numn^dimd), eyeWeights, 1, 0);
end
sum_acts = sum(acts);
predictions = prefs * acts ./ sum_acts;

end

