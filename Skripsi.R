library(car)
library(ggplot2)
library(lmtest)
library(tidyverse)
library(readr)
Kuesioner_Skripsi <- read_csv("DATA SCIENCE APP/Project Dwnld/DATA ANALYST/R/Project/Oji/Kuesioner_Mujiono.csv", 
                              col_types = cols(Nama_Lengkap = col_character(), 
                                               Jenis_Kelamin = col_factor(levels = c()), 
                                               Kualitas_Pelayanan_Setelah_Merger = col_factor(levels = c()), 
                                               Prinsip_Syariah_Sebelum_Merger = col_factor(levels = c()), 
                                               Produk_Setelah_merger = col_factor(levels = c()), 
                                               Kredibilitas_BSI = col_factor(levels = c()), 
                                               Kemudahan_layanan = col_factor(levels = c()), 
                                               Migrasi_bank = col_factor(levels = c()), 
                                               Kemudahan_migrasi_rekening_bank = col_factor(levels = c()), 
                                               Pengguna_bank_BSI = col_factor(levels = c()), 
                                               Lokasi_BSI = col_factor(levels = c()), 
                                               Keyakinan_nasabah_agar_dana_dikelolaBSI = col_factor(levels = c()), 
                                               Ketertarikan_nasabah_menabung = col_factor(levels = c()), 
                                               Ketertarikan_menabung_karena_Kemudahan_Akses = col_factor(levels = c()), 
                                               Ketertarikan_menabung_karena_kepuasan_pelayanan = col_factor(levels = c()), 
                                               Ketertarikan_karena_prinsipSyariah_dalam_praktik_transaksi = col_factor(levels = c()), 
                                               Ketertarikan_bertransaksi_Karena_kebutuhan_dan_tujuan = col_factor(levels = c()), 
                                               Ketertarikan_menggunakan_karena_pelayanan = col_factor(levels = c()), 
                                               Ketertarikan_karena_mudah_dalam_transaksi = col_factor(levels = c())))
View(Kuesioner_Skripsi)

#--- Describe Data ---#

str(Kuesioner_Skripsi)

Data_baru <- Kuesioner_Skripsi %>% 
  mutate(across(where(is.factor), as.numeric))

summary(Data_baru)
str(Data_baru)

#--- Visualization to estimate correlation between X & Y var. --#
P1 <- ggplot(Data_baru, aes(x = Produk_Setelah_merger, y = Jenis_Kelamin)) +
  geom_point() +
  stat_smooth()
P2 <- ggplot(Data_baru, aes(x = Ketertarikan_karena_prinsipSyariah_dalam_praktik_transaksi, 
                            y = Jenis_Kelamin)) +
  geom_point() +
  stat_smooth()
gridExtra::grid.arrange(P1, P2, ncol = 2) 

#--- Multiple Linear Regression ---#
Model <- lm(Jenis_Kelamin~Produk_Setelah_merger +
              Ketertarikan_karena_prinsipSyariah_dalam_praktik_transaksi,
            data = Data_baru)
summary(Model)

Model2 <- lm(Jenis_Kelamin~-1+Produk_Setelah_merger +
               Ketertarikan_karena_prinsipSyariah_dalam_praktik_transaksi,
             data = Data_baru) #Remove the Intercept
summary(Model2)

#--- Assumption Norm-Test --#

Residu_Data <- residuals(Model) #Pre-Test Assumption Norm

qqnorm(Residu_Data)
ks.test(Residu_Data, 'pnorm', 0, sd(Residu_Data))

#--- Homoscedasticity Test ---#

bptest(Model) #Breusch Pagan Test

dwtest(Model) #Durbin Watson test

#--- Assumption Non-Multicollinearity Test ---#
vif(Model)
