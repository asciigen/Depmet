# R script to perform statistical analysis of depression versus control data
# Author: Deepak Sharma
# Date: 14 September 2016

# Loding data
library(readr)
depression_vs_control <- read_csv("depression_vs_control.csv")

# Perform student's t-test
# 1:48 is Control data
# 49:96 is Depression data
t.test(depression_vs_control$Negatives[1:48],depression_vs_control$Negatives[49:96])
t.test(depression_vs_control$Fluctuations[1:48],depression_vs_control$Fluctuations[49:96])
t.test(depression_vs_control$Positives[1:48],depression_vs_control$Positives[49:96])

# Perform One way ANOVA
d_v_c = depression_vs_control

summary(aov(d_v_c$Negatives[1:48] ~ d_v_c$Negatives[49:96]))
summary(aov(d_v_c$Positives[1:48] ~ d_v_c$Positives[49:96]))
summary(aov(d_v_c$Fluctuations[1:48] ~ d_v_c$Fluctuations[49:96]))

boxplot(depression_vs_control$Positives[1:48], depression_vs_control$Positives[49:96], ylab="No. of positives",names=c("Control","Depressed"), main="Positives difference between control and depression")
boxplot(depression_vs_control$Negatives[1:48], depression_vs_control$Negatives[49:96], ylab="No. of negatives",names=c("Control","Depressed"), main="Negatives difference between control and depression")
boxplot(depression_vs_control$Fluctuations[1:48], depression_vs_control$Fluctuations[49:96], ylab="No. of fluctuations",names=c("Control","Depressed"), main="Fluctuation difference between control and depression")

