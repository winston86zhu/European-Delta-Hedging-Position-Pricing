format long g
[y1,y2,y3,y4] = binomialDeltaStraddle(90,0.03, 0.25, 1, 250,90); %Obtiain the binomial table
M = 10000; %Simulation time
r = 0.03;
mu = 0.18;
T = 1;
N =250;
S0 = 90;
K = 90;
sigma = 0.25;
last_price = y2(:,end);
last_price(end) = [];
last_op = y4(:,end);
last_op(end) = [];
S0 = ones(M,1) * S0;
V0 = ones(M,1) * y1;
d0 = ones(M,1) * y3(1,1);
B0 = V0 - d0.*S0;
%When there is no hedging
S = S0;
Delta_t = T / N;
for i = 1:N
    factor = exp((mu-0.5*sigma^2) * Delta_t + ...
        sigma * randn(M,1) * sqrt(Delta_t));
    S = S .* factor;
end
Payoff0 = (max(K - S, 0) + max(S - K, 0));
%When hedging is performed once
B0 = V0 - d0.*S0;
factor = exp((mu-0.5*sigma^2) * T + ...
        sigma * randn(M,1) * sqrt(T));
ST1 = S0 .* factor;
Payoff1 = (max(K - ST1, 0) + max(ST1 - K, 0));
Bn1 = B0 .* exp(r*T);
Pi1 = -Payoff1 + ST1 .* d0 + Bn1;


%When hedging is performed daily
B0 = V0 - d0.*S0;
ST2 = S0;
DT2 = d0;
B2 = B0;
for i = 2:N
    factor = exp((mu-0.5*sigma^2) * Delta_t + ...
        sigma * randn(M,1) * sqrt(Delta_t));
    ST2 = ST2 .* factor;
    Dbt2 = rmmissing(y3(:,i)); % shrink the vector 
    Sbt2 = rmmissing(y2(:,i));
   
    DT2_new = interpDelta(Dbt2, Sbt2, ST2);
    B2 = B2 * exp(r*Delta_t) + (DT2 - DT2_new).*ST2;
    DT2 = DT2_new;
end
Payoff2 = (max(K - ST2, 0) + max(ST2 - K, 0));
Pi2 = -Payoff2 + DT2.*ST2 + B2 * exp(-r*Delta_t);
%When hedging is performed weekly
ST3 = S0;
DT3 = d0;
B3 = B0;
hedgingT = 5:5:245;
for i = 2:N
    if ismember(i-1,hedgingT)
        factor = exp((mu-0.5*sigma^2) * Delta_t + ...
            sigma * randn(M,1) * sqrt(Delta_t));
        ST3 = ST3 .* factor;
        Dbt3 = rmmissing(y3(:,i));
        Sbt3 = rmmissing(y2(:,i));

        DT3_new = interpDelta(Dbt3, Sbt3, ST3);
        B3 = B3 * exp(5*r*Delta_t) + (DT3 - DT3_new).*ST3;
        DT3 = DT3_new;
    else
        factor = exp((mu-0.5*sigma^2) * Delta_t + ...
            sigma * randn(M,1) * sqrt(Delta_t));
        ST3 = ST3 .* factor;
    end
end
Payoff3 = (max(K - ST3, 0) + max(ST3 - K, 0));
Pi3 = -Payoff3 + DT3.*ST3 + B3 * exp(-r*Delta_t*5);
%When hedging is performed monthly
ST4 = S0;
DT4 = d0;
B4 = B0;
hedgingT = 20:20:240;
for i = 2:N
    if ismember(i-2,hedgingT)
        factor = exp((mu-0.5*sigma^2) * Delta_t + ...
            sigma * randn(M,1) * sqrt(Delta_t));
        ST4 = ST4 .* factor;
        Dbt3 = rmmissing(y3(:,i));
        Sbt3 = rmmissing(y2(:,i));
        DT4_new = interpDelta(Dbt3, Sbt3, ST4);
        B4 = B4 * exp(r*20*Delta_t) + (DT4 - DT4_new).*ST4;
        DT4 = DT4_new;
    else
        factor = exp((mu-0.5*sigma^2) * Delta_t + ...
            sigma * randn(M,1) * sqrt(Delta_t));
        ST4 = ST4 .* factor;
    end
end
Payoff4 = (max(K - ST4, 0) + max(ST4 - K, 0));
Pi4 = -Payoff4 + DT4.*ST4 + B4 * exp(-r*Delta_t*10);


%No Hedging
Payoff0 = - Payoff0 + y1 * exp(r * T);
relativePL0 = (Payoff0*exp(-r*T))/y1;
histogram(relativePL0,50);
%Hedge only once
relativePL1 = (Pi1*exp(-r*T))/y1;
histogram(relativePL1,50);
%Daily Hedge Plot
relativePL2 = (Pi2*exp(-r*T))/y1;
histogram(relativePL2,50);
%Weekly Hedge Plot
relativePL3 = (Pi3*exp(-r*T))/y1;
histogram(relativePL3,50);
%Monthly Hedge Plot
relativePL4 = (Pi4*exp(-r*T))/y1;
histogram(relativePL4,50);

%The rest code is for part(d)
%row_no = zeros(1,4);
row_no = q4row(relativePL0);
row_daily = q4row(relativePL2);
row_weekly = q4row(relativePL3);
row_monthly = q4row(relativePL4);
Item = ["mean","std", "VaR", "CVaR"]';
MyT = table(Item,row_no,row_monthly,row_weekly,row_daily);




