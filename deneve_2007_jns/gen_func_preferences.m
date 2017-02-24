function [ prefs ] = gen_func_preferences( dims, numn )
%   dims: D+C
%   numn: number of neurons per dimension (P)
%   prefs: (D+C) x P^(D+C)

prefs = zeros(dims, numn^dims);

single_prefs = gen_preferences(numn);

for dp = 1:dims
    pref_row = repmat(single_prefs, [numn^(dp-1), 1]);
    pref_row = reshape(pref_row, [1, numn^dp]);
    pref_row = repmat(pref_row, [1, numn^(dims-dp)]);
    prefs(dp, :) = pref_row;
end

end

