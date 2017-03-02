function [ predictions ] = act_predict( acts, prefs )
% act_predict( acts ): predict the true values according to acts
%   acts: 1 x P^(D+C)
%   prefs: (D+C) x P^(D+C)
%   predictions: (D+C) vector

% sum_acts = sum(acts);
% predictions = prefs * acts' ./ sum_acts;

[~,max_pos] = max(acts);
predictions = prefs(:, max_pos);

end

