data1=csvread('gamma_wti.csv',1,1);
data2=csvread('lambda_wti.csv',1,1);
data3=csvread('gamma_brent.csv',1,1);
data4=csvread('lambda_brent.csv',1,1);
gamma11=double(data1(1,1));
gamma12=double(data1(1,2));
lambda1=double(data2(1,1));
lambda2=double(data2(2,1));
gamma11_b=double(data3(1,1));
gamma12_b=double(data3(1,2));
lambda1_b=double(data4(1,1));
lambda2_b=double(data4(2,1));
global sigma;
sigma=zeros(1,2);
sigma(1)=gamma11*sqrt(lambda1);
sigma(2)=gamma12*sqrt(lambda2);
global sigma_b;
sigma=zeros(1,2);
sigma_b(1)= gamma11_b*sqrt(lambda1_b);
sigma_b(2)= gamma12_b*sqrt(lambda2_b);
sigma_t = 20.2294;
w=[1,-1];
F_zero=[71.49,79.28];
rho=0.8;
T = [6,15];
t = 1;
%Calculate M1
M1=0;
for i=1:2  
    M1 = M1 + w(i)*F_zero(i);
end

%Calculate M2
M2=0;
for a=1:2
    for b=1:2
        M2 = M2 + w(a) * w(b) * F_zero(a) * F_zero(b) * exp(sigma_t^2 * rho * t * mypsi(a,b));
    end
end

%Calculating M3
M3=0;
for a=1:2
    for b=1:2
        for c=1:2
            M3=w(a)*w(b)*w(c)*F_zero(a)*F_zero(b)*F_zero(c) * exp(sigma_t*rho*t*(psi(a,b)+psi(a,c)+psi(b,c)));
        end
    end
end

skew=(M3-3*M2*M1+2*M1^3)/((M2-M1^2)^1.5);
i=1;
if skew<0
  i=-1;
end
%skew>0,price>0->lognormal distribution
sigma_bs=fsolve(@(sigma_bs)(i)*(exp(sigma_bs^2)+2)*(exp(sigma_bs^2)-1)^0.5-skew,1);
m=fsolve(@(m)(M2-M1^2-exp(2*m)*exp(sigma_bs^2)*(exp(sigma_bs^2)-1)),1);
tau=fsolve(@(tau)(tau+exp(m+0.5*sigma_bs^2)-M1),1);

%BSM
B0=exp(m+0.5*sigma_bs^2)+tau;
B1=B0-tau 
    %B1 is a GBM.
    % C: call price
    % B1: modified stock price, 
    % K:  strike price
    % r: risk-free interest rate
    % sigma1: volatility of the stock price measured as annual standard deviation
    % days: numbers of days remaining in the option contract, this will be converted into unit of years.
    % Black-Scholes formulae C = S N(d1) - Xe-rt N(d2)
    C = zeros(10,1);
    for i = 1:10
        K=i-tau;
        days=2;
        r=0 ;
        T=days/252;
        d1 = (log(B1/K) + 0.5*sigma_bs^2)/sigma_bs;
        d2 = d1 - sigma_bs;
        N1 = normcdf(d1);
        N2 = normcdf(d2);
        C(i) = exp(-r*T)*(B1*N1-K*N2);
    end
