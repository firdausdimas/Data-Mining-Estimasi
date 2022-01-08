library(car)
library(ggplot2)
library(lmtest)
library(tidyverse)
library(readr)
BioData_ <- read_csv("DATA SCIENCE APP/Project Dwnld/DATA ANALYST/R/Project/UTS statistika/Biostatistik..csv", 
                          col_types = cols(Pasien = col_number(), 
                                           `Jenis Kelamin` = col_factor(levels = c()), 
                                           `Berat Badan` = col_number(), 
                                           `Media Kontras A` = col_number(), 
                                           `Media Kontras B` = col_number()))
View(BioData_)

summary(BioData_)
describe(BioData_)

head(BioData_)
tail(BioData_)

names(BioData_)
str(BioData_)

#bio <- BioData_

#-- Merubah Nama Kolom --#
colnames(BioData_) <- c("Pasien", "Jenis_Kelamin", "Berat_Badan", 
                   "Media_Kontras.A", "Media_Kontras.B")

#-- Mengisi Data Kurang Lengkap & NA pada Kolom --#

BioData_$Media_Kontras.A [BioData_$Media_Kontras.A == "6"] <- 691 #Kolom Sinyal(Media Kontras A)
BioData_$Media_Kontras.B [BioData_$Media_Kontras.B == "13"] <- 1391 #Kolom Sinyal(Media Kontras B)
BioData_$Media_Kontras.B [BioData_$Media_Kontras.B == "14"] <- 1491 #Kolom Sinyal(Media Kontras B)
BioData_$Media_Kontras.B [BioData_$Media_Kontras.B == "15"] <- 1591 #Kolom Sinyal(Media Kontras B)

any(is.na(BioData_))
which(is.na(BioData_))


BioData_[20, 2] <- "P"
BioData_[20, 3] <- 45
#-----------------------------------------#

#-- Merubah Data Kolom menjadi Numeric --#
length(BioData_$Jenis_Kelamin)
table(BioData_$Jenis_Kelamin)

DataFresh <- BioData_ %>% 
  mutate(across(where(is.factor), as.numeric))
summary(DataFresh)
str(DataFresh)

#-- grafik sementara --#

tab1(DataFresh$Jenis_Kelamin, sort.group = "decreasing", cum.percent = T, 
     col = c("red", "pink"), main = "Data Berdasarkan Jenis Kelamin")

BarChart(Berat_Badan, data = DataFresh, by= Jenis_Kelamin,
         main = "Data Berdasarkan Berat Badan")

#--- grafik untuk mengestimasi korelasi antara var X & Y. --#
G1 <- ggplot(DataFresh, aes(x = Media_Kontras.A, y = Berat_Badan)) +
  geom_point() +
  stat_smooth()
G2 <- ggplot(DataFresh, aes(x = Media_Kontras.B, 
                            y = Berat_Badan)) +
  geom_point() +
  stat_smooth()
gridExtra::grid.arrange(G1, G2, ncol = 2) 

#--- Multiple Linear Regression ---#
Model_ <- lm(Berat_Badan~Media_Kontras.A +
               Media_Kontras.B,
            data = DataFresh)
summary(Model_)

Models <- lm(Berat_Badan~-1+Media_Kontras.A +
               Media_Kontras.B,
             data = DataFresh) #Remove the Intercept
summary(Models)

#--- Assumption Norm-Test --#

ResiduData <- residuals(Model_) #Pre-Test Assumption Norm

qqnorm(ResiduData)
ks.test(ResiduData, 'pnorm', 0, sd(ResiduData)) #Kolmogorov-Smirnov test

#--- Homoscedasticity Test ---#

bptest(Model_) #Breusch Pagan Test

dwtest(Model_) #Durbin Watson test

#--- Assumption Non-Multicollinearity Test ---#
vif(Model_)
