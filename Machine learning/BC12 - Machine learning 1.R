#call library
library(mlbench) #collection of ml dataset
library(caret) #classification & regression
library(tidyverse)

##House price prediction
data("BostonHousing")
 df<-BostonHousing
 View(df)
 
#missing value
 # if mean = 1 -> data is complete didn't missing
mean(complete.cases(df))

#ml workflow
#1. split data
#2. train model 
#3. score model (predict)
#4. evaluate

  ## Split data
set.seed(42)
n<-nrow(df)
#80-20 split 
train_id <-sample(1:n,size=0.8*n)
#split data 
train_df <-df[train_id,]
test_df <- df[-train_id,]

  ## Train model
## medv = f(crim,rm,age)
set.seed(42)
#train control
#defult boot : alt LOOCV,cv
train_ctrl <- trainControl(
  #golden standard : K-fold cross varidation
  #k=5
  method = "cv",
  number=5
)

#super golden :repetive k fold for 5 time
#for fight overfitting 
set.seed(42)
train_ctrl <- trainControl(
  #golden standard : K-fold cross varidation
  #k=5
  method = "repeatedcv",
  #model train number*repeated
  number=5,
  repeats = 5
)

#boost trap sampling n=25
set.seed(42)
model <- train(#parameter
          medv ~ crim +rm + age,
               data=train_df,
               method="lm",
          trControl=train_ctrl)

    ##check overfiting
  
  #3. score model
#model predict test_df
p_medv <- predict(model,newdata = test_df)

  #4. evaluate model
#compare rmse train vs test
sq_err <- (test_df$medv-p_medv)**2
mae <- mean((test_df$medv-p_medv)**2)
test_rmse <- sqrt( mean((test_df$medv-p_medv)**2)
)
## good fit : train err close to test err

    ##ways to improve the model
#1. more data = almost always better
 #1.1 More data point
 #1.2 more features (relevant features)

#2. change model to a high performance model
#random forest
#used all feature 
set.seed(42)
rf_model <- train(#parameter
  medv ~ .,
  data=train_df,
  method="rf",
  trControl=train_ctrl)
#evaluate
p_medv_rf <- predict(rf_model,newdata = test_df)
test_rmse_rf <- sqrt( mean((test_df$medv-p_medv_rf)**2)
)
