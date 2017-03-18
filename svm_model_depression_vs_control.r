# Including required libraries
library(e1071)
library(rpart)
library(mlbench)
library(caret)
library(MASS)
# Importing depressin versus normal data
depression_vs_control <- read.csv("depression_vs_control.csv")

# Creating modeling variables
Predictor <- subset(depression_vs_control, select=-Type)
Target <-  noquote(depression_vs_control$Type)

# Generating SVM model
dvc_svm <- svm(noquote(Target) ~ ., data=depression_vs_control)
summary(dvc_svm)

dvc_svm1 <- svm(Predictor,Target)
summary(dvc_svm1)

Predicted <- predict(dvc_svm1,Predictor)
system.time(Predicted <- predict(dvc_svm1,Predictor))

# Results of SVM training model
train_result <- t(table(Predicted,Target))
train_sens <- sensitivity(train_result, "Normal") * 100
train_spec <- sensitivity(train_result, "Normal") * 100
train_accuracy <- mean(train_sens,train_spec)

# Tuning SVM model
svm_tune <- tune(svm, train.x=Predictor, train.y=Target, 
  kernel="radial", ranges=list(cost=10^(-1:2), gamma=c(.5,1,2)))
print(svm_tune)

tuned_dvc_svm <- svm(Type ~ ., data=depression_vs_control, kernel="radial", cost=1, gamma=0.5)
summary(tuned_dvc_svm)

Predicted <- predict(tuned_dvc_svm,Predictor)
system.time(predict(tuned_dvc_svm,Predictor))
# Confusion matrix after Tuning
mytunedsvm <- tune.svm(Type ~ ., data = depression_vs_control, gamma = 2^(-1:1), cost = 2^(2:4)) 
plot(mytunedsvm, transform.x=log10, xlab=expression(log[10](gamma)), ylab="C")

## Split data into a training (2/3) and test set (1/3)
index <- 1:nrow(depression_vs_control)
testindex <- sample(index, trunc(length(index)/3))
testset <- depression_vs_control[testindex,]
trainset <- depression_vs_control[-testindex,]

mytunedsvm <- tune.svm(Type ~ ., data = trainset, gamma = 2^(-1:1), cost = 2^(2:4)) 
summary(mytunedsvm)
plot (mytunedsvm, transform.x=log10, xlab=expression(log[10](gamma)), ylab="C")

# fit the model
svm.model <- svm(Type ~ ., data = trainset, cost = 100, gamma = 1)

# make the prediction (the dependent variable, Type, has column number 10)
# Removing the target variable
svm.pred <- predict(svm.model, testset[,-4])
# Predicting the Target variable
# Results of SVM training model
test_result <- t(table(pred = svm.pred, true = testset[,4]))
test_sens <- sensitivity(test_result, "Normal") * 100
test_spec <- sensitivity(test_result, "Normal") * 100
test_accuracy <- mean(test_sens,test_spec)


# ----------------------- LINEAR DISCRIMINANT ANALYSIS ---------------

# Performing Linear Discriminant Analysis
fitting <- lda(Type ~ ., data = depression_vs_control)
dvc_disc_model <- predict(fitting)$class
dvc_res <- table(dvc_disc_model, depression_vs_control$Type)

# Results of discriminant analysis
sensitivity(dvc_res, "Normal") * 100
specificity(dvc_res, "Depression") * 100
negPredValue(dvc_res, "Normal") * 100
posPredValue(dvc_res, "Normal") * 100

