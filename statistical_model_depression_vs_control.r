# R script to perform statistical analysis of depression versus control data
# Author: Deepak Sharma
# Date: 13 September 2016

# Import libraries --------------------------------------------------------

# Import data -------------------------------------------------------------

depression_vs_control <- read.csv("depression_vs_control.csv")
dvc <- depression_vs_control
attach(dvc)

# Student's t-test --------------------------------------------------------

# 1:48 is Control data
# 49:96 is Depression data
t.test(Negatives[1:48],Negatives[49:96])
t.test(Fluctuations[1:48],Fluctuations[49:96])
t.test(Positives[1:48],Positives[49:96])

# One way ANOVA -----------------------------------------------------------

d_v_c = depression_vs_control

summary(aov(Negatives[1:48] ~ Negatives[49:96]))
summary(aov(Positives[1:48] ~ Positives[49:96]))
summary(aov(Fluctuations[1:48] ~ Fluctuations[49:96]))

boxplot(Positives[1:48], Positives[49:96], ylab="No. of positives",names=c("Control","Depressed"), main="Positives difference between control and depression")
boxplot(Negatives[1:48], Negatives[49:96], ylab="No. of negatives",names=c("Control","Depressed"), main="Negatives difference between control and depression")
boxplot(Fluctuations[1:48], Fluctuations[49:96], ylab="No. of fluctuations",names=c("Control","Depressed"), main="Fluctuation difference between control and depression")

