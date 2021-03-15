#warning off
library(ggplot2)
library(speff2trial)
data("ACTG175")
# age
ggplot(ACTG175,aes(x=age,y=cd496))+geom_point(size=1)+labs(x='Age')
# weight
ggplot(ACTG175,aes(x=wtkg,y=cd496))+geom_point(size=1)+labs(x='Weight')
# cd4/cd8 at baseline
ratio48=ACTG175$cd40/ACTG175$cd80
cd496=ACTG175$cd496
datatemp=data.frame(ratio48,cd496)
ggplot(datatemp,aes(x=ratio48,y=cd496))+geom_point(size=1)+
  xlim(0,2)

# karnofsky score
ggplot(ACTG175,aes(x=karnof,y=cd496))+geom_point(size=1)+labs(x='Karnofsky Score')
ggplot(ACTG175,aes(x=as.factor(karnof),y=cd496))+geom_boxplot()
# stratification of antiretroviral history 
ggplot(ACTG175,aes(x=as.factor(strat),y=cd496))+geom_boxplot()
# treatment taken
ggplot(ACTG175,aes(x=as.factor(treat),y=cd496))+geom_boxplot()
