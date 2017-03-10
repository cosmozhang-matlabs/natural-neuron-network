function [ est_vars ] = gen_est_vars ()

M = 1;
R = 0.001;

syms x;
fx = 3 * ( exp( 2*(cos(x)-1) ) + 0.01 );
dfx = diff(fx);


init_vars = R;

vars = zeros(1,100);
vars(:,1) = init_vars;
for i = 1:99
    Kt = vars(:,i) * ( vars(:,i) +  )
    vars()
end

end