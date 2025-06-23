function Y = DetermineYlim(x)
Y = ceil(10^(mod(log10(x),1)))*10^(floor(log10(x)));