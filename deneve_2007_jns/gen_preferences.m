function [ prefs ] = gen_preferences( num )

srr = 1/1; % sub-range ratio

% if mod(num, 2) == 1
%     pos_prefs = 0 : (2*pi/(num-1)) : pi;
%     prefs = [fliplr(pos_prefs(1:end)), pos_prefs];
% else
%     prefs = 1;
% end

% prefs = -pi : (2*pi/(num-1)) : pi;
prefs = -pi*srr : (2*pi*srr/num) : pi*srr;
prefs = prefs(1:end-1);

end

