clear all;
clc;

%import data
data1=importdata('/Users/ziruilian/Desktop/commodity_matlab/gamma_wti.csv')
data2=importdata('/Users/ziruilian/Desktop/commodity_matlab/lambda_wti.csv')
data3=importdata('/Users/ziruilian/Desktop/commodity_matlab/gamma_brent.csv')
data4=importdata('/Users/ziruilian/Desktop/commodity_matlab/lambda_brent.csv')
gamma1=double(data1.data(2,2))
gamma2=double(data1.data(2,3))
gamma3=double(data3.data(3,2))
gamma4=double(data3.data(3,3))
lambda1=double(data2.data(1,1))
lambda2=double(data2.data(2,1))
lambda3=double(data4.data(1,1))
lambda4=double(data4.data(2,1))
sigma_a1=gamma1*sqrt(lambda1)
sigma_a2=gamma2*sqrt(lambda2)
sigma_b1=gamma3*sqrt(lambda1)
sigma_b2=gamma4*sqrt(lambda2)
deltat=2
sigma_t=42.10212


deltat=1/252


mu=[0 0 0 0]
sigma=[0.8 0.8 0.8 0.8]%correlation of brownian motion
t=1
X=5%strike price
n=1000%times of simulation


Drift1 = -1/2* (sigma_t)^2*(sigma_a1^2+sigma_a2^2) * deltat; %Drift asset one
Drift2 = -1/2 *(sigma_t)^2*(sigma_b2^2+sigma_b2^2) * deltat; % Drift asset two

P=zeros(1,n)


for i = 1: n,
lnF1=log(71.49)
lnF2=log(79.28) 
R = mvnrnd(mu,sigma,t)



 for k= 1:t,
    
Delta_lnF1(k)=Drift1*deltat+sigma_t*(sigma_a1*R(k,1)*(1/6)+sigma_a2*R(k,2)*(1/6))
Delta_lnF2(k)=Drift2*deltat+sigma_t*(sigma_b1*R(k,3)*(1/15)+sigma_b2*R(k,4)*(1/15))
lnF1=lnF1+Delta_lnF1(k)
lnF2=lnF2+Delta_lnF2(k)
F1=exp(lnF1)
F2=exp(lnF2)


end
P(1,i)=max((F2-F1-X),0)

end

Price=mean(P)



    