data1=csvread('gamma.csv',1,1);
data2=csvread('lambda.csv',1,1);
gamma11=double(data1(1,1));
gamma12=double(data1(1,2));
lambda1=double(data2(1,1));
lambda2=double(data2(2,1));
global sigma = zeros(1,2);
global sigma(1)=gamma11*sqrt(lambda1);
global sigma(2)=gamma12*sqrt(lambda2);
sigma_t = 8;
w=[1,-1];
F_zero=[120,100];
rho=0.8;
T = [60,60];
t = 30;
%Calculate M1
M1=0;
for i=1:2  
    M1 = M1 + w(i)*F_zero(i);
end

%Calculate M2
function result = psi(x1,x2)
    global sigma;
    term_1 = 1;
    %as T1 or T2 -t always equals to 30, we always use the first row of PC.
    for i=1:2
        term_1 = term_1 * sigma(i);
    end
    term_2 = 1;
    for i=1:2
        term_2 = term_2 * sigma(i);
    end
    term_3=0;
    for i=1:2
        for j=1:2
            term_3 = term_3 + sigma(i)*sigma(j);
        end
    end
    result = term_1+term_2+term_3;
end

M2=0;
for a=1:2
    for b=1:2
        M2 = M2 + w(a) * w(b) * F_zero(a) * F_zero(b) * exp(sigma_t^2 * rho * t * psi(a,b));
    end
end

%Çalculating M3
M3=0;
for a=1:2
    for b=1:2
        for c=1:2
            %again as T1-t and T2-t are the same
            M3=w(a)*w(b)*w(c)*F_zero(a)*F_zero(b)*F_zero(c) ...
                *exp(sigma_t*rho*t*3*psi(a,b))
        end
    end
end

skew=(M3-3*M2*M1+2*M1^3)/((M2-M1^2)^1.5);

%skew>0,price>0->lognormal distribution
%½â·½³ÌµÃ³ösigma,mºÍtau
sigma_bs=fsolve(@(sigma_bs)(exp(sigma_bs^2)+2)*(exp(sigma_bs^2)-1)^0.5-skew,1);
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
    % days: numbers of days remaining bin the option contract, this will be converted into unit of years.
    % Black-Scholes formulae C = S N(d1) - Xe-rt N(d2)
    
    K=60
    days=30
    r=0.03
    
    T=days/252;
    d1 = (log(B1/K) + 0.5*sigma_bs^2)/sigma_bs;
    d2 = d1 - sigma_bs;
    N1 = normcdf(d1);
    N2 = normcdf(d2);

    C = exp(-r*T)*(B1*N1-K*N2)
