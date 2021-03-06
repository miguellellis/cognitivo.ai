library(ggplot2)
library(corrplot)
library(dplyr)
library(tidyr)
library(visreg)
library(DT)
library(knitr)


### Teste cognitivo - Miguel Lellis

###Recebendo os dados
data_rio <- read.csv(file = url("http://data.insideairbnb.com/brazil/rj/rio-de-janeiro/2021-02-22/visualisations/listings.csv"))


###Identificando percentual nulo no data set
percentual_nulo <- round(colSums(is.na(data_rio))*100/(nrow(data_rio)), 5)
data.frame(percentual_nulo)


###Explorando os dados


#Histogramas (Pre�o, Mpinimo de Noites, Npumero de Revs�es e Disponibilidade no ano)
par(mfrow=c(2,2))
hist(data_rio$price)
hist(data_rio$minimum_nights)
hist(data_rio$number_of_reviews)
hist(data_rio$availability_365)


#Analisando Outliers
split.screen(figs=c(1,2))
screen(1)
boxplot(data_rio[10], main="Box Plot of Price", ylab="Price", col = "grey")
screen(2)
hist(x = data_rio$price)
close.screen(all=TRUE)


#Analisando concentra��o de valores abaixo de R$2000,00
df_aux <- data_rio
lista_remov <- c()
for (i in 1:length(data_rio[[1]])) {
  if(df_aux[i,10] > 2000){
    valor <- -i
    lista_remov <- append(lista_remov, valor)
  }
}
lista_remov
df_aux <- df_aux[(lista_remov),]
df_aux


#Nova amostra
split.screen(figs=c(1,2))
screen(1)
boxplot(df_aux[10], main="Box Plot of Price", ylab="Price", col = "grey")
screen(2)
hist(x = df_aux$price)
close.screen(all=TRUE)


#m�dia das di�rias
media <- sum(df_aux[10])/length(df_aux[[10]])
media 


#Tipos de im�veis mais alugados
df_imov <- data.frame(table(df_aux$room_type))
df_perc <- df_imov[2]/sum(df_imov[2])
df_imov <- data.frame(df_imov[1],df_perc)
df_imov


#Bairros com maior presen�a
df_bairro <- data.frame(table(df_aux$neighbourhood))
df_bairro <- df_bairro[order(df_bairro[2], decreasing = TRUE),]
head(df_bairro, 20)




####################################################################
####################### Modelos de Previs�o ########################
####################################################################

#Excluindo vari�veis
df_pred <- df_aux[, -c(1:5, 7, 8, 13, 15)]
df_pred <- replace(x = df_pred, list = is.na(df_pred), values = 0)
df_pred


# Correla��o de Pearson com vari�veis espec�ficas
df_cor <- df_pred[,c(-1,-2)]
corrplot(cor(df_cor), method = "color", addCoef.col = "black")




#modelo 2 considerando o df completo
mod_1 <- lm(price ~ neighbourhood + room_type + minimum_nights + availability_365, data = df_pred)
summary(mod_1)





#M�dia Copacabana e Entire apt
lista_remov <- c()
for (i in 1:length(df_pred[[1]])) {
  if(df_pred[i,1] == "Copacabana" && df_pred[i,2] == "Entire home/apt" ){
    valor <- i
    lista_remov <- append(lista_remov, valor)
  }
}
lista_remov
df_cop_1 <- df_pred[(lista_remov),]
df_cop_1
sum(df_cop_1[3])/length(df_cop_1[[1]])


data_teste <- data.frame(neighbourhood = "Copacabana", room_type= "Entire home/apt", minimum_nights = 5, availability_365 = 365)
cat("Pre�o previsto: ", predict.lm(mod_1, data_teste), "\n")



#M�dia Copacabana e Private room
lista_remov <- c()
for (i in 1:length(df_pred[[1]])) {
  if(df_pred[i,1] == "Copacabana" && df_pred[i,2] == "Private room" ){
    valor <- i
    lista_remov <- append(lista_remov, valor)
  }
}
lista_remov
df_cop_2 <- df_pred[(lista_remov),]
df_cop_2
sum(df_cop_2[3])/length(df_cop_2[[1]])


data_teste <- data.frame(neighbourhood = "Copacabana", room_type= "Private room", minimum_nights = 5, availability_365 = 365)
cat("Pre�o previsto: ", predict.lm(mod_1, data_teste), "\n")


#M�dia Barra da Tijuca e Entire apt
lista_remov <- c()
for (i in 1:length(df_pred[[1]])) {
  if(df_pred[i,1] == "Barra da Tijuca" && df_pred[i,2] == "Entire home/apt" ){
    valor <- i
    lista_remov <- append(lista_remov, valor)
  }
}
lista_remov
df_bt_1 <- df_pred[(lista_remov),]
df_bt_1
sum(df_bt_1[3])/length(df_bt_1[[1]])


data_teste <- data.frame(neighbourhood = "Barra da Tijuca", room_type= "Entire home/apt", minimum_nights = 3, availability_365 = 365)
cat("Pre�o previsto: ", predict.lm(mod_1, data_teste), "\n")




#M�dia Ipanema e Entire apt
lista_remov <- c()
for (i in 1:length(df_pred[[1]])) {
  if(df_pred[i,1] == "Ipanema" && df_pred[i,2] == "Entire home/apt" ){
    valor <- i
    lista_remov <- append(lista_remov, valor)
  }
}
lista_remov
df_ip <- df_pred[(lista_remov),]
df_ip
sum(df_ip[3])/length(df_ip[[1]])


data_teste <- data.frame(neighbourhood = "Ipanema", room_type= "Entire home/apt", minimum_nights = 3, availability_365 = 365)
cat("Pre�o previsto: ", predict.lm(mod_1, data_teste), "\n")


