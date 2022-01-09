# Data-Mining-Estimasi
Pada pengerjaannya dilakukan menggunakan pemrograman Rstudio.
Terdapat 3 project di dalamnya, diantaranya:
1. Biostatistik: 
 
 Data ini merupakan data untuk UTS pada matakuliah Biostatistik, terdapat 20 data yang berisikan kolom:
 "Pasien", "Jenis Kelamin", "Berat Badan", "Media Kontras A & B".
 Dalam pembagiannya untuk Variabel Y adalah "Berat Badan" adapun untuk Variabel X adalah "Media Kontras A" & "Media Kontras B".
 Metode yang digunakan adalah Regresi Linear Berganda, sebelum mendapatkan hasil darii perhitungan linear model peneliti mengidentifikasi terlebih dahulu 
 dengan melihat grafik untuk mengestimasi korelasi antara var X & Y. Selanjutnya penggunaan fungsi lm untuk mencari linear model
 dengan p-value: 0.4316. Melihat nilai residual dan didapati bahwa hasil yang diperoleh 11 nilai minus dan lainnya positif dari 20 nilai, 
 lalu menggunakan Kolmogorov-Smirnov test denagn hasil p-value = 0.7939, Berikutnya menggunakan Homoscedasticity Test yaitu Breusch-Pagan test dengan p-value = 0.9325 dan
 Durbin-Watson test dengan hasil p-value = 0.6769, dan yang terakhir Assumption Non-Multicollinearity Test antara "Media Kontras A" & "Media Kontras B" dengan
 masing - masing memperoleh nilai 1.001331 dan 1.001331.
 
 
2. Home, Heating Oil Insulation:
 
 Dalam database tersebut berisi mengenai "Pengaruh Heating Oil terhadap Insulation pada Rumah".
 Variable X dalam penelitian ini adalah "Insulation", "Temperature", "Num_Occupants", "Avg_Age", dan "Home_Size", 
 adapun variable Y dalam penelitian ini adalah "Heating_Oil".
 Terdapat "1218" data yang masing kolom berjenis "Numeric". Dalam penelitiannya untuk nilai dalam Linear Model semuanya bernilai Positif kecuali 
 pada kolom "Num_Occupants" yang memiliki nilai min, dengan nilai (F-statistic: 749.7 on 5 and 840 DF,  p-value: < 2.2e-16) yang berarti bahwa 
 terdapat hubungan antara variabel X dan Y walaupun ada 1 variabel X yang tidak berhubungan.
 
3. Data Skripsi:
 
