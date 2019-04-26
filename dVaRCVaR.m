function [var,cvar]=dVaRCVaR(PandL, beta)
%M independent samples
sortedPL = sort(PandL);
ibeta = floor((1-beta) * length(PandL));
var = sortedPL(ibeta);
cvar = mean(sortedPL(1:ibeta));
