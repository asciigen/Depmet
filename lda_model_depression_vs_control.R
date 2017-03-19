# R script to perform linear discriminant analysis
# Author: Deepak Sharma
# Date: 16 September 2016

# Import libraries --------------------------------------------------------

library(MASS)

# Linear Discrimininant Analysis ------------------------------------------

fitting <- lda(Type ~ ., data = depression_vs_control)
dvc_disc_model <- predict(fitting)$class
dvc_res <- table(dvc_disc_model, depression_vs_control$Type)

# Results of discriminant analysis ----------------------------------------

sensitivity(dvc_res, "Normal") * 100
specificity(dvc_res, "Depression") * 100
negPredValue(dvc_res, "Normal") * 100
posPredValue(dvc_res, "Normal") * 100