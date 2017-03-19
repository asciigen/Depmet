# R script to classify data using k-means clustering
# Author: Deepak Sharma
# Date: 4 October 2016


# Import libraries --------------------------------------------------------

library(datasets)
library(psych)
library(ggplot2)

# Import data -------------------------------------------------------------

depression_vs_control <- read.csv("depression_vs_control.csv")
dvc <- depression_vs_control
attach(dvc)
headTail(dvc)

# K means clustering ------------------------------------------------------

set.seed(10)
dvc_cluster <- kmeans(dvc[, 1:3], 2, nstart = 10)
dvc_cluster
table(dvc_cluster$cluster, Type)
dvc_cluster$cluster <- as.factor(dvc_cluster$cluster)

# Visualization -----------------------------------------------------------

# Original data plot
ggplot(dvc, aes(Negatives, Positives, Fluctuations, color = Type)) + geom_point()
# Cluster plot
ggplot(dvc, aes(Negatives, Positives, Fluctuations, color = dvc_cluster$cluster)) + geom_point()

