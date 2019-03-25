library(rlist)
library(reshape2)
library(openxlsx)
data = NULL
brent = read.csv("combined.csv",header=TRUE)
brent$period = brent$Expiry - brent$t
unique_period = unique(brent$period)
#exclude 0
unique_period = unique_period[unique_period!=0]
unique_period = sort(unique_period)
groupped = vector("list",length(unique_period))
for (i in 1:length(unique_period)){
  groupped[[i]]=brent[brent$period==unique_period[i],]
  ln_diff = seq(1,nrow(groupped[[i]]))
  groupped[[i]]=cbind(brent[brent$period==unique_period[i],],ln_diff)
  len = nrow(groupped[[i]]) 
  for (j in 1:len){
    next_step = brent[brent$t==groupped[[i]][j,]$t+1 & brent$Expiry==groupped[[i]][j,]$Expiry,][1,]
    if (is.na(sum(next_step)))
      groupped[[i]][j,]$ln_diff = NA
    else
      groupped[[i]][j,]$ln_diff = log(next_step$Value) - log(groupped[[i]][j,]$Value)
  }
}

filtered_groupped = vector("list",length(unique_period))
for (i in 1:length(unique_period)) {
  filtered_groupped[[i]] = groupped[[i]][!is.na(groupped[[i]]$ln_diff),]
}
delta = NULL

for (i in 1:length(unique_period)) 
  amount[i] = nrow(filtered_groupped[[i]])
tau = 35:45
#assumed delta t = 1
for (i in 1:length(tau)){
  delta=cbind(delta,filtered_groupped[[tau[i]]]$ln_diff[1:11]/1)
}
c = cov(delta)
result=eigen(c)
gamma = result$vectors
lambda = result$values
cumsum(result$values/sum(result$values))
write.csv(file="gamma.csv",gamma)
write.csv(file="lambda.csv",lambda)