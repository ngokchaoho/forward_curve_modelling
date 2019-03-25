option = read.csv("Options_2.csv",header = TRUE)
gamma = read.csv("gamma.csv",header = TRUE)
lambda = read.csv("lambda.csv",header = TRUE)
option = option[1:7]
p1_sample = option[option$T-option$te==30,]
p1_sample = p1_sample[nrow(p1_sample),]
sigma1_bar = p1_sample$Volatility
gamma_index = 1
sigma_t1 = sigma1_bar/sqrt(gamma[gamma_index,2]^2*lambda[1,2]+gamma[gamma_index,3]^2*lambda[2,2])

p2_sample = option[option$T-option$te==60,]
p2_sample = p2_sample[nrow(p2_sample),]
sigma2_bar = p2_sample$Volatility
gamma_index = 2
sigma_t2 = sqrt((sigma2_bar^2*60-sigma1_bar^2*30)/
                  (gamma[gamma_index,2]^2*lambda[1,2]+gamma[gamma_index,3]^2*lambda[2,2])*(60-30)
)
