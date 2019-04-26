function [y1,S_mat, Delta_mat, V_mat] = binomialDeltaStraddle(S0, rate, volatility, time, counter, strike)
y1 = zeros(1,1);
S_mat = NaN(counter+1,counter+1);
Delta_mat = NaN(counter,counter);
V_mat = NaN(counter+1,counter+1);
% initialize variables
K = strike;
T = time;
t_cap = T;
r = rate;
sigma = volatility;
delta_t = T/counter;
u = exp(sigma * sqrt(delta_t));
d = exp(-sigma * sqrt(delta_t));
q_star = (exp(r*delta_t) - d)/(u - d);
t = 0;
bstart = S0;

straddlevec = [];
for i = counter:-1:0
    final_val = u^(i) * d^(counter-i) * bstart;
    straddlevec = [straddlevec; (max(K - final_val, 0) + max(final_val - K, 0))];
end

prob = [];
for i = counter:-1:0
    prob = [prob; binopdf(i, counter, q_star)];
end
y1 = exp(-r * T)*prob.'* straddlevec;

V_mat(:,end) = straddlevec;
for i = counter+1:-1: 2
    for j = 1:i-1
        V_mat(j,i - 1) = exp(-1 * r * delta_t) *...
            (V_mat(j,i)*q_star + (1-q_star)*V_mat(j+1,i));
    end
end

for i = 1: counter+1
    S_mat(1,i) = bstart * u^(i - 1);
    for j = 1:i
        S_mat(j,i) = S_mat(1,i) * (d/u)^(j-1);
    end
end

for i = 1:counter
    for j = 1:i
        Delta_mat(j,i) =  (V_mat(j,i+1) - V_mat(j+1,i+1))/...
            ((u-d)*S_mat(j,i));
    end
end



end