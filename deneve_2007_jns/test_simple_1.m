
P = 60;
D = 1;
C = 0;
% L = reshape([1 0 0 0.5 0.9 0 0 1 1], [3 3]);
L = [1, 0.003; 0, 1];

iter_times = 1000;

prefs = gen_func_preferences(D+C, P);

weights = recurrent_weight(P, D, C, L, prefs);

init_act = zeros(1, P^(D+C));
init_sensory = repmat( gen_sensory_signals(P,0,1), [1 D]);

preds = zeros(D+C, iter_times);
act = activity_iterate(D, C, init_act, init_sensory, weights, 0, 1);

figure(1);

subplot(2, 2, [1,2]);
title('Iterations');
for i = 1:iter_times
    if mod(i-1, 100) == 0
%         plot(act, 'Color', [1,1,1]*(i/iter_times)); hold on;
        plot(act); hold on;
    end
    preds(:,i) = act_predict(act', prefs);
    act = activity_iterate(D, C, act, zeros(1, P^D), weights, 1, 0);
end

subplot(2, 2, [3,4]);
plot(preds);
title('Predictions');