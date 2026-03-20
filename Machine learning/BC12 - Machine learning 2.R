library(tidyverse)
library(mlbench)
library(caret)

  #Predict diabetes
data("PimaIndiansDiabetes")
df<-  PimaIndiansDiabetes%>%
  drop_na()

  #KNN

#split data
set.seed(42)
n <- nrow(df)
id<- sample(1:n,size =0.8*n)
train_df <- df[id,]
test_df <- df[-id,]

#train model
set.seed(42)
ctrl <- trainControl(method="cv",
                     number=5,
                     verboseIter = TRUE,
                     summaryFunction = prSummary,
                     classProbs = TRUE)
#set of hyperparameter
k_grid <- data.frame(k=c(3,5,7,9))

knn_model <- train(diabetes ~ .,
           data=train_df,
           method = "knn",
           #grid search
           tuneGrid=k_grid,
           trControl=ctrl,
           #default metric -> accuracy .alt : Kappa
           metric='Recall',
           #pre process data
           preProcess=c("center","scale"))

#center and scale :standardization
#change scale to same range
##z = (x-x_bar)/sd

#normalization : data range 0-1
##norm_x = (x-min_x)/(max_x - min_x)

# test data
pred_diabetes <- predict(knn_model,newdata=test_df)

  #Random forest
rf_model <- train(diabetes ~ .,
                   data=train_df,
                   method = "rf",
                   trControl=ctrl,
                   #default metric -> accuracy .alt : Kappa
                   metric='Recall',
                   #pre process data
                   preProcess=c("center","scale"))

