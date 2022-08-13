## R
install.packages(c("mlbench", "dplyr", "nnet", "NeuralNetTools", "caret"))
library(mlbench)
library(dplyr)
library(nnet)
library(NeuralNetTools)
library(caret)
data("BreastCancer")

## 1. Build Linear Regression
## predict medv (BostonHousing)
data("BostonHousing")
boston <- BostonHousing
glimpse(boston)
hist(boston$medv)

# Train test Split
train_test_split <- function(df, train_size=0.8) {
  set.seed(42)
  n <- nrow(df)
  id <- sample(1:n, size = n*train_size)
  train_df <- df[id, ]
  test_df <- df[-id, ]
  return( list(train = train_df, test = test_df))
}

split_data <- train_test_split(boston, 0.7)
train_df <- split_data$train
test_df <- split_data$test

# Train Model
lm_model <- lm(medv ~ crim + indus + rm + age,
               data = train_df)

summary(lm_model)

train_df$medv_pred <- predict(lm_model)
squared_error <- (train_df$medv - train_df$medv_pred) **2
rmse_train <- sqrt(mean(squared_error))
rmse_train

# Test Model
test_df$medv_pred <- predict(lm_model, newdata = test_df)
squared_error <- (test_df$medv - test_df$medv_pred) **2
rmse_test <- sqrt(mean(squared_error))
rmse_test

## Print Result
cat("RMSE Trian:", rmse_train, "\n")
cat("RMSE Test:", rmse_test)

## 2. Build Logistic Regression
## predict class (BreastCancer)
data("BreastCancer")
cancer <- BreastCancer
glimpse(cancer)

## Convert am to factor
cancer$Class <- factor(cancer$Class,
                       levels = c("benign", "malignant"),
                       labels = c(0, 1))

# Train test Split
split_data <- train_test_split(cancer, 0.7)
train_cancer <- split_data$train
test_cancer <- split_data$test

# Train Model
logReg_model <- glm(Class ~ Cell.shape, data = train_cancer, family = "binomial")
summary(logReg_model)

train_pred <- predict(logReg_model, type = "response")
train_cancer$Class_pred <- if_else(train_pred >= 0.5, 1, 0)
acc_train <- mean(train_cancer$Class == train_cancer$Class_pred)

# Test Model
test_pred <- predict(logReg_model, newdata = test_cancer, type = "response")
test_cancer$Class_pred <- if_else(test_pred >= 0.5, 1, 0)
acc_test <- mean(test_cancer$Class == test_cancer$Class_pred)

# Print Result
cat("Accuracy Trian:", acc_train, "\n")
cat("Accuracy Test:", acc_test)

## Confusion Matrix
confusion_M <- table(test_cancer$Class_pred, test_cancer$Class,
                     dnn = c("Predicted", "Actual"))

# Model Evaluation
accuracy = (confusion_M[1,1] + confusion_M[2,2]) / sum(confusion_M)
precision = confusion_M[2,2]/(confusion_M[2,2] + confusion_M[2,1])
recall = confusion_M[2,2]/(confusion_M[2,2] + confusion_M[1,2])
F1 = 2*precision*recall / (precision + recall)

# Result
cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, '\n')
cat("F-1 Score:", F1)

## Accuracy = (actual&predict_true + actual&predict_false) / sum(confusion_M)
## Recall = actual&prediction_true / (actual&predict_true + actual_true_predict_false)
## Precision = actual&predict_true / (actual&predict_true + actual_false_predict_true)
## F-1 Score = 2*Recall*Precision / (Recall + Precision)

## 3. Build Neural Network
## predict class (BreastCancer)
glimpse(cancer)

# Train test Split
split_data <- train_test_split(cancer, 0.8)
train_cancer <- split_data$train
test_cancer <- split_data$test

# Train Model
nnet_model <- nnet(Class ~ Cell.shape,
     data = train_cancer,
     size = 4,
     rang = 0.1)

summary(nnet_model)
train_pred <- predict(nnet_model, type = "class")
acc_train_nnet <- mean(train_pred == train_cancer$Class)
# Test Model
test_pred_nnet <- predict(nnet_model, newdata = test_cancer, type = "class")
acc_test_nnet <- mean(test_pred_nnet == test_cancer$Class)

# Print Result
cat("Accuracy Train:", acc_train_nnet, "\n")
cat("Accuracy Test:", acc_test_nnet)

# Plot network
plotnet(nnet_model)
