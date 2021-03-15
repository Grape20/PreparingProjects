# Regression Tree
# based on package rpart

rm(list=ls())

library(rpart)
library(rpart.plot)

library(speff2trial)
data("ACTG175")
#clean data
ACTG175c=ACTG175[-which(ACTG175$karnof==70),] #remove the very few observation
attach(ACTG175c)
karnof=as.factor(karnof)
strat=as.factor(strat)
treat=as.factor(treat)
Ratio48=cd40/cd80
actg2=data.frame(
  cd496,
  wtkg,
  karnof,
  strat,
  treat,
  Ratio48
)

actg2=actg2[-which(is.na(actg2$cd496)),]

# Use package rpart to construct a tree

# The rpart automatically set comlexity parameter as 0.01
actg2.rpart=rpart(cd496~.,data = actg2)
# Plot the tree
par(mfrow=c(1,1))
rpart.plot(actg2.rpart)

# Set control parameter of rpart, 
# lowest cp=0.004, 5 fold cross validation
contr=rpart.control(cp=0.006,xval=5)
# The rpart performs 5 fold cross validation and store results
set.seed(14)
actg2.rpart=rpart(cd496~.,data = actg2,control = contr)
# Plot the tree
rpart.plot(actg2.rpart)

# The cv result is stored as a form of 
# different complexity parameter alpha and SSE
plotcp(actg2.rpart)
# Find the best cp
min.cp=actg2.rpart$cptable[which.min(actg2.rpart$cptable[,'xerror']),'CP']
print(list(min.cp=min.cp))

# plot pruned tree
actg2.rpart.pruned=prune(actg2.rpart,cp=min.cp)
rpart.plot(actg2.rpart.pruned)

