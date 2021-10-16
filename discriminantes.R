### Planta anidrido

library(readxl)
dados <- read_excel("R/dados.xlsx")
View(dados)

dados <- dados[,-c(1)]

## distância estatístia

x <- dados
y <- as.data.frame(mahalanobis(x, colMeans(x), cov(x)))
names(y)[1] = "Distancias"
y$Index = c(1:nrow(y))


alpha = 0.05
df <- ncol(x[,])
limite <- qchisq(1-alpha,df = df)
is_mv_outlier <- ifelse(y$Distancias > limite, "SIM", "NÃO")
x$Outliers <- is_mv_outlier
x = x[x$Outliers == "NÃO",]

x
summary(x)

x[29] = NULL

dados <- x

## padronização dos dados

dados_padronizados <- scale(dados)

set.seed(222)
kc <- kmeans(dados_padronizados,3)
groups.k <- kc$cluster
dadosC.k <- cbind(dados,groups.k)

dadosC.k
#View(dadosC.k)

groups.k <- as.factor(groups.k)

str(dadosC.k)

set.seed(777)
ind <- sample(2,nrow(dadosC.k),replace=TRUE,prob=c(0.6,0.4))
training <- dadosC.k[ind==1,]
testing <- dadosC.k[ind==2,]

plot(training$PI0102,training$FC0104,xlab="PI0102",ylab="FC0104")
lines(testing$PI0102,testing$FC0104,type="p",col=2)
legend("bottomright",legend=c("training","testing"),col=c(1,2),pch=1)

#View(dadosC.k)
dadosC.k[,-c(29)] <- scale(dadosC.k[,-c(29)])
#View(dadosC.k)

library(MASS)

## Discriminante linear

#View(dados)
#View(dadosC.k)

lda.train <- lda(formula=groups.k~.,data = training,
                 na.action="na.omit")
lda.train

plot(lda.train,col=as.integer(training$groups.k))
legend("bottomright",legend=c("Grupo 1","Grupo 2","Grupo 3"),col=c(1,2,3),pch=1)

lda.train.p <- predict(lda.train,training)

ldahist(data=lda.train.p$x[,1],g=training$groups.k)
ldahist(data=lda.train.p$x[,2],g=training$groups.k)



lda.teste <- lda(formula=groups.k~.,data = testing,
                 na.action="na.omit")
lda.teste

plot(lda.teste,col=as.integer(testing$groups.k))
legend("bottomright",legend=c("Grupo 1","Grupo 2","Grupo 3"),col=c(1,2,3),pch=1)

# Biplot

#install.packages("devtools")
library(devtools)
install_github("fawda123/ggord")
library(ggord)
ggord(lda.train,training$groups.k)

lda.teste.p <- predict(lda.teste,testing)

ldahist(data=lda.teste.p$x[,1],g=testing$groups.k)
ldahist(data=lda.teste.p$x[,2],g=testing$groups.k)




#install.packages("klaR")
library(klaR)

partimat(groups.k~.,data = dadosC.k, method = "lda")

#predição do modelo para testing data
lda.test <- predict(lda.train,newdata=testing)
lda.test$class

#confusion matrix
tab.test <- table(Predição=lda.test$class,Atual=testing$groups.k)
tab.test

#erro de predição do modelo
erro.test <- 1 - sum(diag(tab.test))/sum(tab.test)
erro.test

p1 <- predict(lda.train, training)$class
tab <- table(Predicted = p1, Actual = training$groups.k)
tab

install.packages("psych")
library(psych)
pairs.panels(dadosC.k[1:8],
             gap = 0,
             bg = c("red","green","blue")[dadosC.k$groups.k],
             pch = 21)
pairs.panels(dadosC.k[8:15],
             gap = 0,
             bg = c("red","green","blue")[dadosC.k$groups.k],
             pch = 21)
pairs.panels(dadosC.k[15:22],
             gap = 0,
             bg = c("red","green","blue")[dadosC.k$groups.k],
             pch = 21)
pairs.panels(dadosC.k[22:8],
             gap = 0,
             bg = c("red","green","blue")[dadosC.k$groups.k],
             pch = 21)








#### Discriminante quadrático

library(readxl)
dad <- read_excel("R/dados.xlsx")
View(dados)

dados <- dad[,-c(1)]

## distância estatístia

x <- dados
y <- as.data.frame(mahalanobis(x, colMeans(x), cov(x)))
names(y)[1] = "Distancias"
y$Index = c(1:nrow(y))


alpha = 0.05
df <- ncol(x[,])
limite <- qchisq(1-alpha,df = df)
is_mv_outlier <- ifelse(y$Distancias > limite, "SIM", "NÃO")
x$Outliers <- is_mv_outlier
x = x[x$Outliers == "NÃO",]

x
summary(x)

x[29] = NULL

dados <- x

## padronização dos dados

dados_padronizados <- scale(dados)

set.seed(222)
kc <- kmeans(dados_padronizados,3)
groups.k <- kc$cluster
dadosC.k <- cbind(dados,groups.k)

dadosC.k
#View(dadosC.k)

groups.k <- as.factor(groups.k)

str(dadosC.k)

set.seed(111)
ind <- sample(2,nrow(dadosC.k),replace=TRUE,prob=c(0.5,0.5))
training <- dadosC.k[ind==1,]
testing <- dadosC.k[ind==2,]

plot(training$PI0102,training$FC0104,xlab="PI0102",ylab="FC0104")
lines(testing$PI0102,testing$FC0104,type="p",col=2)
legend("bottomright",legend=c("training","testing"),col=c(1,2),pch=1)

#View(dadosC.k)
dadosC.k[,-c(29)] <- scale(dadosC.k[,-c(29)])
#View(dadosC.k)

library(MASS)




#View(dados)
#View(dadosC.k)

qda.train <- qda(formula=groups.k~.,data = training,
                 na.action="na.omit")
qda.train

plot(qda.train,col=as.integer(training$groups.k))


qda.train.p <- predict(qda.train,training)

qdahist(data=qda.train.p$x[,1],g=training$groups.k)
qdahist(data=qda.train.p$x[,2],g=training$groups.k)












qda.teste <- qda(formula=groups.k~.,data = testing,
                 na.action="na.omit")
qda.teste

plot(qda.teste,col=as.integer(testing$groups.k))
legend("topleft",legend=c("Grupo 1","Grupo 2","Grupo 3"),col=c(1,2,3),pch=1)

qda.teste.p <- predict(qda.teste,testing)

qdahist(data=qda.teste.p$x[,1],g=testing$groups.k)
qdahist(data=qda.teste.p$x[,2],g=testing$groups.k)


#install.packages("klaR")
library(klaR)

partimat(groups.k~.,data = dados,method="lda")

#predição do modelo para testing data
qda.test <- predict(qda.train,newdata=testing)
qda.test$class

#confusion matrix
tab.test <- table(Predição=qda.test$class,Atual=testing$groups.k)
tab.test

#erro de predição do modelo
erro.test <- 1 - sum(diag(tab.test))/sum(tab.test)
erro.test


p1 <- predict(qda.train, training)$class
tab <- table(Predicted = p1, Actual = training$groups.k)
tab
sum(diag(tab))/sum(tab)
erro.test <- 1 - sum(diag(tab))/sum(tab)
erro.test
# só consegue calcular a previsão para os dados de treinamento






fit = qda(groups.k~.,data = training)

pred = predict(fit,testing)

pred_class = pred$class

table(pred_class,testing$groups.k)

tab <- table(pred_class,testing$groups.k)

erro.test <- 1 - sum(diag(tab))/sum(tab)
erro.test


