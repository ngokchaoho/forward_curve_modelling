gamma = read.csv("gamma_wti.csv",header = TRUE)
lambda = read.csv("lambda_wti.csv",header = TRUE)
# t = 16/05/2018
#also used for kirks'
sigma1_bar = 0.2386
j = 1
#delta t = 1
sigma_t = sigma1_bar/sqrt(gamma[j,2]^2*lambda[1,2]+gamma[j,3]^2*lambda[2,2])
#sigma_t = 20.2294

#implied volatility for brent in krik's
gamma = read.csv("gamma_brent.csv",header = TRUE)
lambda = read.csv("lambda_brent.csv",header = TRUE)
vol= sqrt(sigma_t^2*(gamma[j,2]^2*lambda[1,2]+gamma[j,3]^2*lambda[2,2]))
#answer vol used for kirks'
#[1] 0.226402