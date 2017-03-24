# R script to model depression data using neural networks
# Author: Deepak Sharma
# Date: 26 March 2017

# Import libraries --------------------------------------------------------

library(RSNNS)

# Loading data
depression_vs_control <- read.csv("depression_vs_control.csv")
dvc <- depression_vs_control

# Creating modeling variables
Predictor <- subset(depression_vs_control, select=-Type)
Target <-  noquote(depression_vs_control$Type)


# MLP model ---------------------------------------------------------------

attach(dvc)
DecTarget <- decodeClassLabels(Target)
dvc <- splitForTrainingAndTest(Predictor, DecTarget, ratio = 0.15)
dvc <- normTrainingAndTestSet(dvc)
model <- mlp(dvc$inputsTrain, dvc$targetsTrain, size = 5,
  learnFuncParams = 0.1, maxit = 60, inputsTest = dvc$inputsTest,
  targetsTest = dvc$targetsTest)
predictions <- predict(model, dvc$inputsTest)

plotIterativeError(model)
plotRegressionError(predictions[, 2], dvc$targetsTest[, 2], pch = 3)
plotROC(fitted.values(model)[, 2], dvc$targetsTrain[, 2])
plotROC(predictions[, 2], dvc$targetsTest[, 2])

confusionMatrix(dvc$targetsTrain, fitted.values(model))
confusionMatrix(dvc$targetsTest, predictions)
confusionMatrix(dvc$targetsTrain, encodeClassLabels(fitted.values(model),
  method = "402040", l = 0.4, h = 0.6))
weightMatrix(model)

# SOM Network -------------------------------------------------------------

model <- som(Predictor, mapX = 16, mapY = 16, maxit = 500,
  targets = Target)
plotActMap(model$map, col = rev(heat.colors(12)))
plotActMap(log(model$map + 1), col = rev(heat.colors(12)))
persp(1:model$archParams$mapX, 1:model$archParams$mapY, log(model$map + 1),
  theta = 30, phi = 30, expand = 0.5, col = "lightblue")
plotActMap(model$labeledMap)
model$spanningTree
model$labeledMap
model$componentMaps
model$map
model$actMaps


for(i in 1:ncol(Predictor)) plotActMap(model$componentMaps[[i]],
  col = rev(topo.colors(12)))


# ART2 Network --------------------------------------------------------------------

patterns <- snnsData$art2_tetra_med.pat
model <- art2(patterns, f2Units = 5,
  learnFuncParams = c(0.99, 20, 20, 0.1, 0),
  updateFuncParams = c(0.99, 20, 20, 0.1, 0))

library("scatterplot3d")
scatterplot3d(patterns, pch = encodeClassLabels(model$fitted.values))