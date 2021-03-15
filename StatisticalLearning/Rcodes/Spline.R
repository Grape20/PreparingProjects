# warning off

rm(list = ls())

library(speff2trial)
library(splines)
data("ACTG175")

# Clean data
actg=ACTG175
actg=actg[-which(is.na(actg$cd496)),]

# Against Weight
# Smoothing spline fit, using LOOCV to determine lambda
SplineCV=smooth.spline(actg$wtkg,actg$cd496,cv=TRUE)
print(list(SplineLambda=SplineCV$lambda,EffectDf=SplineCV$df))

# Plot results
wtlims=range(actg$wtkg)
par(mfrow=c(1,1))
plot(cd496~wtkg,data = actg,xlim=wtlims, cex=.5,col='darkgrey',
     main = 'Smoothing Spline against Weight',xlab='Weight')
lines(SplineCV,col='blue',lwd=2)

# Against Ratio48
# Smoothing spline fit, using LOOCV to determine lambda
Ratio48=actg$cd40/actg$cd80
# Clean the ratio48 outlier 
cd496=actg[-which(Ratio48>1.5),'cd496']
Ratio48=Ratio48[-which(Ratio48>1.5)]

SplineCV2=smooth.spline(Ratio48,cd496,cv=TRUE)
print(list(SplineLambda2=SplineCV2$lambda,EffetDf2=SplineCV2$df))

# Plot results
Ratlims=range(Ratio48)
par(mfrow=c(1,1))
plot(Ratio48,cd496,xlim=Ratlims,cex=.5,col='darkgrey',
     main = 'Smoothing Spline against Ratio48')
lines(SplineCV2,col='blue',lwd=2)
