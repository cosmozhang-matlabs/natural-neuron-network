function [] = test_simple_1()

%% specify the parameters

P = 60; % Number of neurons for per dimension
D = 1; % Number of sensory dimensions
C = 0; % Number of controlling dimensions

% Recurrent weights:
% Concatenate the measurements,
% i.e. let x_ = [s_1, s_2, ..., s_D, c_1, c_2, ..., c_C, 1]
% So, rows/cols of L should be D+C+1
L = [1, 0.003; 0, 1];
% L = reshape([1 0 0 0.5 0.9 0 0 1 1], [3 3]);
Ma = L;

iter_times = 300; % steps of recurrent iterations
plot_steps = 100; % plot a response curve every `plot_steps`

%% do the simulation

prefs = gen_func_preferences(D+C, P);
pref_ticks = prefs(1,:);

weights = recurrent_weight(P, D, C, L, prefs);
eye_weights = recurrent_weight(P, D, C, eye(C+D+1), prefs);

actual_val = repmat([zeros(D,1);1], [1,iter_times]); % this is with a 1 tail
actual_noise_var = [zeros(D,1)+0.003;0]; % this is with a 0 tail
% sensory_spikes = zeros(D,P,iter_times);

last_actual_val = [zeros(D,1);1];
init_act = zeros(1, P^(D+C));
init_sensory = gen_sensory_signals(P, last_actual_val(1:end-1,1), D);

preds = zeros(D+C, iter_times);
act = activity_iterate(D, C, init_act, init_sensory, weights, 0, 1);

figure(1);

subplot(3, 1, 1);
for i = 1:iter_times
    if mod(i-1, plot_steps) == 0
%         plot(act, 'Color', [1,1,1]*(i/iter_times)); hold on;
        plot(pref_ticks, act);
        xlim([pref_ticks(1), pref_ticks(end)]);
        hold on;
    end
    preds(:,i) = act_predict(P,D,C, act', prefs, eye_weights);
    
    actual_val(:,i) = Ma * last_actual_val + normrnd(zeros(D+1,1), actual_noise_var);
    new_sensory = gen_sensory_signals(P, actual_val(1:end-1,i), D);
    act = activity_iterate(D, C, act, new_sensory, weights, 1, 0);
    
    last_actual_val = actual_val(:,i);
end
title('Iterations');

subplot(3, 1, 2);
plot(preds);
hold on;
plot(actual_val(1,:));
title('Predictions');

subplot(3, 1, 3);
plot(preds - actual_val(1,:));
title('Error');

end