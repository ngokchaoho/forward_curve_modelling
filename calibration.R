gamma = read.csv("gamma_wti.csv",header = TRUE)
lambda = read.csv("lambda_wti.csv",header = TRUE)
# t = 17/04/2018
#also used for kirks'
sigma1_bar = 0.2517
gamma_index = 1
#delta t = 30
sigma_t1 = sigma1_bar/sqrt(gamma[gamma_index,2]^2*lambda[1,2]+gamma[gamma_index,3]^2*lambda[2,2])
#> sigma_t1
#[1] 44.41368
sigma2_bar = 0.2503
gamma_index = 1
#delta t = 59
sigma_t2 = sqrt((sigma2_bar^2*59-sigma1_bar^2*30)/
                  (gamma[gamma_index,2]^2*lambda[1,2]+gamma[gamma_index,3]^2*lambda[2,2])*(59-30)
)

#implied volatility for brent in krik's
gamma = read.csv("gamma_brent.csv",header = TRUE)
lambda = read.csv("lambda_brent.csv",header = TRUE)
vol= sqrt(sigma_t1^2*(gamma[gamma_index,2]^2*lambda[1,2]+gamma[gamma_index,3]^2*lambda[2,2]))
#answer vol used for kirks'
#[1] 0.2619801