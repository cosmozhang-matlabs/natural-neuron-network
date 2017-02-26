function [ weight ] = recurrent_weight( numn, dimd, dimc, imat, prefs )
%   numn: number of neurons per dimension (P)
%   dimc,dimd: dimensions of controlling and sensory variables (D,C)
%   prefs: preferences: (D+C) x P^(D+C)

if nargin < 4
    imat = eye(dimd+dimc);
end
if nargin < 5
    prefs = gen_func_preferences(dimd+dimc, numn);
end

tprefs = imat * prefs; % transformed preferences

weight = zeros(numn^(dimd+dimc));
for i = 1:(numn^(dimd+dimc))
    weight(i,:) = exp( sum( cos( repmat(tprefs(1:dimd,i), [1,(numn^(dimd+dimc))]) - prefs(1:dimd,:) ) , 1 ) - dimd );
end

% prefm = reshape(transpose(prefs), zeros(1,dimd+dimc)+numn, dimd+dimc);
% tprefm = reshape(transpose(tprefs), zeros(1,dimd+dimc)+numn, dimd+dimc);

% wkernel = zeros(zeros(1,dimd+dimc)+numn);
% wkernel(i,j,k...) = tprefm(,:,:,:,1)

end

