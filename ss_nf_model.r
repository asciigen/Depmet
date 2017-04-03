# Classification using Fuzzy rules
# Author: Deepak Sharma
# Date: 3 April 2017


# Import libraries --------------------------------------------------------

require(frbs)

depression_vs_control <- read.csv("depression_vs_control_fuzzy.csv")
dvc <- depression_vs_control
attach(dvc)

# 3 Input and 1 Output variable

## Split the data to be training and testing datasets
data.train <- dvc[sample(nrow(dvc), 90),] 
data.tst <- dvc[-sample(nrow(dvc), 90),]
real.val <- as.numeric(as.factor(matrix(dvc[45:52,4])))

## Define interval of data
range.data <-apply(data.train, 1,range)

method.type <- "WM"
control <- list(num.labels = 10, type.mf = "GAUSSIAN", type.defuz = "WAM",
                type.tnorm = "MIN", type.snorm = "MAX", type.implication.func = "ZADEH",
                name = "sim-0")

## Learning step: Generate an FRBS model
object.reg <- frbs.learn(data.train,range.data=NULL,method.type,control)

## Predicting step: Predict for newdata
res.test <- predict(object.reg, data.tst)

## Display the FRBS model
summary(object.reg)

## Plot the membership functions
par(mar = rep(2, 4))
plotMF(object.reg)

