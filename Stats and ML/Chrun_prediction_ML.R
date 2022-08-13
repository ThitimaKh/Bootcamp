## install packages
library(tidyverse)
library(caret)
library(mlbench)

## load dataset Churn.csv
df <-read_csv("churn.csv")

## missing value
mean(complete.cases(df))

## preview data
glimpse(df)

df$churn <- factor(df$churn)
df$internationalplan <- factor(df$internationalplan)
df$voicemailplan <- factor(df$voicemailplan)

## 1. Split Data
set.seed(42)
id <- createDataPartition(y = df$churn,
                          p = 0.8,
                          list = FALSE)

train_df <- df[id, ]
test_df <- df[-id, ]

## 2. Train Model
## random forest
ctrl <- trainControl(method = "cv",
                     number = 5,
                     classProbs = TRUE,
                     summaryFunction = prSummary,
                     verboseIter = TRUE)

myGrid <- data.frame(mtry = 2:7)

logistic_model <- train(churn ~ . ,
                        data = train_df,
                        mothod = "glm",
                        metric = "AUC",
                        preProcess = c("center", "scale"),
                        tuneGrid = myGrid,
                        trControl = ctrl
)  # mtry = 2, AUC = 0.974

rf_model <- train(churn ~ . ,
                  data = train_df,
                  mothod = "rf",
                  metric = "AUC",
                  preProcess = c("center", "scale"),
                  tuneGrid = myGrid,
                  trControl = ctrl
)  # mtry = 2, AUC = 0.9728

varImp(rf_model)

## Compare three models
result <- resamples(
  list(
    logisticReg = logistic_model,
    randomForest = rf_model
  ))
summary(result)

## 3. Test Model
p <- predict(rf_model, newdata = test_df)

mean(p == test_df$churn)

## Confusion Matrix
confusionMatrix(p, test_df$churn,
                dnn = c("prediction", "Actual"),
                positive = "Yes",
                mode = "prec_recall")

# Precision : 0.9703          
# Recall : 0.6950
