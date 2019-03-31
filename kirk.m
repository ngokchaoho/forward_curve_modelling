clear all;
clc;

%2 for WTI;1 for Brent
%Price of underlying asset
S2=71.49
S1=79.28


deltat=2/252
sigma_b=0.2386
sigma_a=0.4965824

%Quantity of asset
Q1=1
Q2=1

%Strike price
X=5

%Time to expiration of the option in years
T=2/252

%cost of carry
b1=0
b2=0

%Risk free interest rate
r=0

%Implied Volatility of asset
sigma_1=sigma_a
sigma_2=sigma_b

%correlation of asset price
rho=0.05

F=(Q2*S2*exp((b2-r)*T))/(Q2*S2*exp((b2-r)*T)+X*exp(-r*T))
sigma=sqrt(sigma_1^2+(sigma_2*F)^2-2*rho*sigma_1*sigma_2*F)
S=(Q1*S1*exp((b1-r)*T))/(Q2*S2*exp((b2-r)*T)+X*exp(-r*T))
d1=(log(S)+(sigma^2/2)*T)/(sigma*sqrt(T))
d2=d1-sigma*sqrt(T)


%Value of call spread option
c=(Q2*S2*exp((b2-r)*T)+X*exp(-r*T))*(S*cdf('Normal',d1)-cdf('Normal',d2))
