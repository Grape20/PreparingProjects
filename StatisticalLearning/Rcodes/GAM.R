rm(list = ls())

library(speff2trial)
data("ACTG175")
library(gam)
#clean data
actg=ACTG175
Ratio48=actg$cd40/actg$cd80
actg=data.frame(actg,Ratio48)
actg=actg[-which(is.na(actg$cd496)),]
actg=actg[-which(actg$Ratio48>1.5),]
actg=actg[-which(actg$karnof==70),] #remove the very few observation

actg$karnof=as.factor(actg$karnof)
actg$strat=as.factor(actg$strat)
actg$treat=as.factor(actg$treat)

train=sample(1:nrow(actg),nrow(actg)/10*9)

# GAM
gam.m1=gam(cd496~s(wtkg,2.45)+s(Ratio48,3.84)+karnof+strat+treat,
           data = actg, subset = train)
par(mfrow=c(1,5))
plot(gam.m1, se=TRUE,col="blue")

test=actg$cd496[-train]
preds=predict(gam.m1,newdata=actg[-train,])
print(list(MSE.GAM.Test=mean((preds-test)^2)))
