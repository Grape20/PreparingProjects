# Bootstrap

# warning off

rm(list = ls())

library(boot)
library(speff2trial)
library(splines)
data("ACTG175")

# Clean data
actg=ACTG175
actg=actg[-which(is.na(actg$cd496)),]
Ratio48=actg$cd40/actg$cd80
Weight=actg$wtkg
CD496=actg$cd496
actg=data.frame(CD496,Weight,Ratio48)

LambdaWt<-function(dat,indices){
  # Against Weight
  # Smoothing spline fit, using LOOCV to determine lambda
  SplineCV=smooth.spline(dat$Weight[indices],dat$CD496[indices],cv=TRUE)
  SplineLambda=SplineCV$lambda
  EffectDf=SplineCV$df
  c(SplineLambda,EffectDf)
}

LambdaRat<-function(dat,indices){
  # Against Ratio48
  # Smoothing spline fit, using LOOCV to determine lambda
  SplineCV2=smooth.spline(dat$Ratio48[indices],dat$CD496[indices],cv=TRUE)
  SplineLambda2=SplineCV2$lambda
  EffectDf2=SplineCV2$df
  c(SplineLambda2,EffectDf2)
}

set.seed(1)
BootWt=boot(actg,LambdaWt,R=50)
BootRat=boot(actg,LambdaRat,R=50)

print(BootWt)
print(BootRat)

