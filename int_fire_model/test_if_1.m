% function [] = test_if_1 ()

% deltaf = @(t1, t2) (((t1 + eps) .* (t2 + eps)) < 0);
deltaf = @(t1, t2) (((t1 + eps) < 0) & ((t2 + eps) > 0));

tao = 5;
delta_t = 0.1;
s = 1;
n_neurons_per_pop = 10;
g_leak = 0.5;
V_leak = 0;
V_thre = 1;
V_reset = 0;
V_spike = 3;

interval_on = 2;
interval_off = 10;

tk = 0;
tk = [tk, tk(end) + (interval_off:interval_off:100)];
tk = [tk, tk(end) + (interval_off:interval_on:100)];
tk = [tk, tk(end) + (interval_off:interval_off:300)];

ti_sequence = 0:delta_t:400;
last_ti = 0;

var_seq_len = size(ti_sequence, 2) + 1;
I_sequence = zeros(1, var_seq_len);
I_sequence(1) = 0;
V_sequence = zeros(1, var_seq_len);
V_sequence(1) = V_leak;

iter_idx = 1;

for ti = ti_sequence
    I = I_sequence(iter_idx);
    V = V_sequence(iter_idx);
    dI_t = (1/tao) * ( - I + s * n_neurons_per_pop * sum(deltaf(last_ti - tk, ti - tk)) );
    dV_t = - g_leak * (V - V_leak) + I;
    iter_idx = iter_idx + 1;
    I_sequence(iter_idx) = I + dI_t * delta_t;
    if V == V_spike
        V_sequence(iter_idx) = V_reset;
    elseif V > V_thre
        V_sequence(iter_idx) = V_spike;
    else
        V_sequence(iter_idx) = V + dV_t * delta_t;
    end
    last_ti = ti;
end

close all;
% figure(1);
% plot(ti_sequence, I_sequence(2:end));
% title('Current');
figure(2);
plot(ti_sequence, V_sequence(2:end));
title('Voltage');

% end
