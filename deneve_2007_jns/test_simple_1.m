
P = 60;
D = 1;
C = 0;
% L = reshape([1 0 0 0.5 0.9 0 0 1 1], [3 3]);
L = [1, 0.003; 0, 1];

iter_times = 100;
plot_steps = 10;

prefs = gen_func_preferences(D+C, P);
pref_ticks = prefs(1,:);

weights = recurrent_weight(P, D, C, L, prefs);
eye_weights = recurrent_weight(P, D, C, eye(C+D+1), prefs);

init_act = zeros(1, P^(D+C));
init_sensory = repmat( gen_sensory_signals(P,0,1), [1 D]);

preds = zeros(D+C, iter_times);
act = activity_iterate(D, C, init_act, init_sensory, weights, 0, 1);

figure(1);

subplot(2, 2, [1,2]);
title('Iterations');
for i = 1:iter_times
    if mod(i-1, plot_steps) == 0
%         plot(act, 'Color', [1,1,1]*(i/iter_times)); hold on;
        plot(pref_ticks, act);
        xlim([pref_ticks(1), pref_ticks(end)]);
        hold on;
    end
    preds(:,i) = act_predict(P,D,C, act', prefs, eye_weights);
    act = activity_iterate(D, C, act, zeros(1, P^D), weights, 1, 0);
end

subplot(2, 2, [3,4]);
plot(preds);
title('Predictions');