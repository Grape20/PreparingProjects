# warning off
library(speff2trial)
data("ACTG175")
actg=ACTG175
# Test Association between cd496 and Age
Age=actg$age;cd496=actg$cd496
TestAge=cor.test(Age,cd496,alternative = 'two.sided',
                 method = 'spearman',conf.level = 0.95)
print(TestAge)

Age2=(Age-mean(Age))^2
TestAge2=cor.test(Age2,cd496,alternative = 'two.sided',
                 method = 'spearman',conf.level = 0.95)
print(TestAge2)

# Error: bell shape can not use spearman rho
# Test Association between cd496 and Weight
# Weight=actg$wtkg
# TestWt=cor.test(Weight,cd496,alternative = 'two.sided',
#                 method = 'spearman',conf.level = 0.95)
# print(TestWt)

# Test Association between cd496 and Ratio48
Ratio48=actg$cd40/actg$cd80
TestRat=cor.test(Ratio48,cd496,alternative = 'two.sided',
                 method = 'spearman',conf.level = 0.95)
print(TestRat)



