install.packages("lavaan")
install.packages("semPlot")

library(lavaan)
library(semPlot)

data(HolzingerSwineford1939)

lm_out_1 <- lm(x4 ~ ageyr, data=HolzingerSwineford1939)
sem_out_1 <- sem('x4 ~ ageyr', data=HolzingerSwineford1939)

summary(lm_out_1)
summary(sem_out_1)

cfa_mod_1 <- '
visual  =~ x1 + x2 + x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9
'
cfa_out_1 <- cfa(cfa_mod_1, data=HolzingerSwineford1939)

summary(cfa_out_1)

parameterEstimates(cfa_out_1)

semPaths(cfa_out_1, whatLabels = "est")

semPaths(cfa_out_1, whatLabels = "est", mar=c(5,2,8,2), edge.label.cex=.9)

wd_mod_1 <- '
X =~ x1 + x2
Y =~ x4 + x5
Y ~ X
'
wd_out_1 <- sem(wd_mod_1, data=HolzingerSwineford1939)

summary(wd_out_1)

semPaths(wd_out_1, whatLabels = "est")

wd_mod_2 <- '
X =~ 1*x1 + 1*x2
Y =~ 1*x4 + 1*x5
Y ~ X
'
wd_out_2 <- sem(wd_mod_2, data=HolzingerSwineford1939)

summary(wd_out_2)

wd_mod_3 <- '
X =~ x1 + b1*x2
Y =~ x4 + b1*x5
Y ~ X
'
wd_out_3 <- sem(wd_mod_3, data=HolzingerSwineford1939)

summary(wd_out_3)

cfa_mod_2 <- '
visual  =~ x1 + x2 + x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9

visual ~~ 0*textual
visual ~~ 0*speed
'
cfa_out_2 <- cfa(cfa_mod_2, data=HolzingerSwineford1939)

summary(cfa_out_2)

semPaths(cfa_out_2, whatLabels = "est")

complex_mod_1 <- '
visual  =~ x1 + x2 + x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9

visual  ~ textual + speed
textual ~ speed
'
complex_out_1 <- sem(complex_mod_1, data=HolzingerSwineford1939)

parameterEstimates(complex_out_1)

semPaths(complex_out_1, whatLabels = "est")

lower <- '
11.834
6.947   9.364
6.819   5.091  12.532
4.783   5.028   7.495   9.986
-3.839  -3.889  -3.841  -3.625  9.610
-21.899 -18.831 -21.748 -18.775 35.522 450.288 '

wheaton.cov <- 
  getCov(lower, names = c("anomia67", "powerless67", "anomia71", 
                          "powerless71", "education", "sei"))

fit <- sem(wheaton.model, sample.cov = wheaton.cov, sample.nobs = 932)