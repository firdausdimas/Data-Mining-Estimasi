library(caTools)
library(dplyr)
library(ggthemes)
library(ggplot2)
library(stats)
library(readr)
Dataset_Temp <- read_csv("DATA SCIENCE APP/Project Dwnld/DATA ANALYST/R/Data Processing/Data Mining/Estimation/Single Linear Regression/Dataset_Temp.csv")
View(Dataset_Temp)

head(Dataset_Temp)
str(Dataset_Temp)
summary(Dataset_Temp)

chooseCRANmirror()

#-- Calculating the Correlation --#
cor_var <- cor(Dataset_Temp)

#-- Making random sample data --#
set.seed(123)
sample_Data <- sample.split(Dataset_Temp$Avg_Age, SplitRatio = 0.70)
sample_Data

#-- Data Training --#
Train.Data <- subset(Dataset_Temp, sample_Data == T) #Choosing the only TRUE data
View(Train.Data)

#-- Data Testing --#
Test.Data <- subset(Dataset_Temp, sample_Data == F) #Choosing the only FALSE data
View(Test.Data)

#-- Regression Model --#
Model_lm <- lm(Heating_Oil~.,
            data = Train.Data) #Choosing All X variable by Data Trained
summary(Model_lm)

#-- residual Data --#
Res <- residuals(Model_lm)
Res <- data.frame(Res) #making data frame from residuals data
head(Res)

#-- Make prediction from Model --#
Pred_HO <- predict(Model_lm, Test.Data)

#-- Combine prediction value with actual value (Test.Data) --#
result_data <- cbind(Pred_HO, Test.Data$Heating_Oil)
head(result_data)
colnames(result_data)=c('Prediction', 'Real_Numb') #labeling Column Name
result_data <- as.data.frame(result_data) #Changing format to data fram for extract the Con_val
 
Con.val <- function(x){ #confirmation predict value with 0 or + number
  if(x<0){
    return(0)
  }else{
    return(x)
  }
}
result_data$Prediction <- sapply(result_data$Prediction, Con.val)
head(result_data)

#-- Evaluating the Model by using Mean Square  Error $ RMSE  --#
MSE <- mean((result_data$Prediction - result_data$Real_Numb)^2)
print(MSE)

RMSE <- (MSE)^0.5
print(RMSE)

#-- Find out how influence the percentage value from correlation variable between X & Y --#
SSE <- sum((result_data$Prediction - result_data$Real_Numb)^2) #using Sum of Square for Error Method
print(SSE)

SST <- sum((mean(Dataset_Temp$Heating_Oil) - result_data$Real_Numb)^2) #Total Sum of Square
print(SST)

RSquare <- 1-SSE/SST
print(RSquare)


