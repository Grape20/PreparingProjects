# Random Forest
# Based on package randomForest

rm(list=ls())

library(randomForest)
set.seed(1)

library(speff2trial)
data("ACTG175")
#clean data
actg=data.frame(
  ACTG175$cd496,
  ACTG175$wtkg,
  as.factor(ACTG175$karnof),
  as.factor(ACTG175$strat),
  as.factor(ACTG175$treat),
  ACTG175$cd40/ACTG175$cd80
)
colnames(actg)<-c('CD496','Weight','Karnof','strat','treat','Ratio48')
actg=actg[-which(is.na(actg$CD496)),]

train=sample(1:nrow(actg),nrow(actg)/10*9)
actg.test=actg[-train,'CD496']
#1
RF1.actg=randomForest(CD496~.,data = actg,subset = train, ntree=100, 
                      mtry = 1, importance = TRUE,
                      nodesize = 6)
print(RF1.actg)
yhat.RF1=predict(RF1.actg,newdata = actg[-train,])
print(list(MSE.Test.RF1=mean((yhat.RF1-actg.test)^2)))

#Bagging
bag.actg=randomForest(CD496~.,data = actg,subset = train, ntree=100, 
                      mtry = ncol(actg)-1, importance = TRUE,
                      nodesize = 6)
print(bag.actg)
yhat.bag=predict(bag.actg,newdata = actg[-train,])
print(list(MSE.Test.Bagging=mean((yhat.bag-actg.test)^2)))

# plot(yhat.RF1,actg.test)
# abline(0,1)

varImpPlot(RF1.actg,main = 'RandomForest1.ACTG')

# Test for other random forest for different values of mtry
# #2
# RF2.actg=randomForest(CD496~.,data = actg,subset = train, ntree=100, 
#                       mtry = 2, importance = TRUE,
#                       nodesize = 6)
# print(RF2.actg)
# yhat.RF2=predict(RF2.actg,newdata = actg[-train,])
# mean((yhat.RF2-actg.test)^2)
# #3
# RF3.actg=randomForest(CD496~.,data = actg,subset = train, ntree=200, 
#                       mtry = 3, importance = TRUE,
#                       nodesize = 6)
# print(RF3.actg)
# yhat.RF3=predict(RF3.actg,newdata = actg[-train,])
# mean((yhat.RF3-actg.test)^2)
# #4
# RF4.actg=randomForest(CD496~.,data = actg,subset = train, ntree=100, 
#                       mtry = 4, importance = TRUE,
#                       nodesize = 6)
# print(RF4.actg)
# yhat.RF4=predict(RF4.actg,newdata = actg[-train,])
# mean((yhat.RF4-actg.test)^2)

