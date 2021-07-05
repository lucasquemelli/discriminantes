# discriminantes
Este é um projeto que utiliza análise de discriminantes para avaliar as variáveis de um processo químico industrial.

A análise de discriminantes tem como finalidade estabelecer combinações lineares ou quadráticas que promovam a melhor separação entre dois ou mais grupos. O propósito fundamental é estimar uma relação entre uma variável dependente isolada e um conjunto quantitativo de variáveis independentes.

Pode ser visto na figura abaixo, o código no RStudio para a implementação do DataFrame e a limpeza dos outliers Mahalanobis.

![image](https://user-images.githubusercontent.com/81119854/124519803-d2801200-ddc0-11eb-8deb-1fadb4c4cf48.png)

Na figura abaixo, pode ser observado o comando para retirar a coluna 1. Essa coluna não está inclusa no cálculo porque é a coluna de horas. Em seguida, foi realizada a padronização dos dados para ser feito o agrupamento deles em 3 grupos. Na sequência, um vetor de uma coluna com 281 linhas, referentes ao número de observações, foi adicionado ao conjunto de dados com a indicação (em 1, 2 e 3) para agrupar as observações em um dos três grupos, conforme a figura abaixo.

![image](https://user-images.githubusercontent.com/81119854/124520051-9dc08a80-ddc1-11eb-9a31-a79b7d373019.png)

A determinação dos grupos ocorreu com a utilização da função kmeans. Após sua implementação, os grupos foram salvos em um vetor coluna e adicionados a um novo DataFrame (dadosC.k). Os dados numéricos dos grupos foram transformados em fatores para definir sua utilização como identificadores de cada grupo. 

Em seguida, os dados foram exibidos, com a utilização do comando str. O resultado desse último passo pode ser visto na figura abaixo:

![image](https://user-images.githubusercontent.com/81119854/124520182-090a5c80-ddc2-11eb-8fec-08c9a6de6896.png)

Pode ser visto na figura acima que, após a limpeza dos outliers Mahalanobis, o número de observações resultante foi de 239. No vetor grupo formado, apesar de o tipo de variável ter sido identificado como inteiro, ele foi transformado em fator (de 3 níveis), conforme figura abaixo:

![image](https://user-images.githubusercontent.com/81119854/124520267-4373f980-ddc2-11eb-89c4-6502694da396.png)

Definidos os grupos e inseridos em um DataFrame, foi feita a partição dos dados. É necessário calibrar o modelo para classificar as informações e as novas informações (se surgirem) em um determinado grupo. Para tanto, os dados foram particionados em dois conjuntos: treinamento e teste. 

O conjunto de treinamento é utilizado para realizar a análise de discriminantes e calibração do modelo matemático. O conjunto de teste contém os dados que não foram utilizados para calibrar o modelo – uma tentativa de verificar, a partir dos dados de teste, se o treinamento (calibração) foi eficiente. 

A porcentagem de dados a ser definida como treinamento e teste é melhor determinada por tentativa e erro. Entretanto, quando os dados de cada grupo estão muito bem divididos (grande distância entre os clusters), a porcentagem tem menor influência, já que cada grupo terá características muito particulares e bem definidas, resultando em ótimo ajuste do modelo de predição. O script com esse código pode ser visto na figura abaixo.

![image](https://user-images.githubusercontent.com/81119854/124520377-b2e9e900-ddc2-11eb-9fa6-7067bb97a75c.png)

No código da figura acima, o percentual de dados escolhidos para o treinamento foi de 60 % (logo, para teste foi de 40%). Foram testados os percentuais de treinamento de 60, 70, 80 e 90% e todos obtiveram a mesma eficiência em predizer os dados. 

Idealmente, é necessário que o conjunto de treinamento tenha mais de 50 % de todos os dados para que seja feita uma boa calibração. O último comando da figura acima é a padronização dos dados, com exclusão da última coluna, que é a coluna de fatores. 

O gráfico gerado a partir da função plot para exemplificar o procedimento aleatório da escolha de dados de treinamento e teste pode ser visto na figura abaixo, que relaciona as variáveis PI0102 com FC0104.

![image](https://user-images.githubusercontent.com/81119854/124520991-7cad6900-ddc4-11eb-914c-b57b3f173b98.png)

Pode ser notado na figura acima que a seleção de dados para os conjuntos treinamento e teste foi aleatória (não apresentou tendências na sua distribuição). Após o treinamento do modelo, utiliza-se os discriminantes linear e quadrático.

# Discriminante linear

A implementação do código do R para o discriminante linear, para a exibição dos seus valores e para o gráfico identificando a separação dos grupos (no conjunto de treinamento) pode ser vista na figura abaixo. Os valores dos coeficientes dos discriminantes LD1 e LD2 gerados podem ser vistos na figura subsequente.

![image](https://user-images.githubusercontent.com/81119854/124521377-a6b35b00-ddc5-11eb-8d2a-29fa5a50d6a3.png)

![image](https://user-images.githubusercontent.com/81119854/124521412-c480c000-ddc5-11eb-863e-31bfd40cb7f1.png)

A porcentagem de separação da função LD1 é de 87,98 %, enquanto a porcentagem de separação da função LD2 é de 12,02 %. Para identificar as observações e como elas estão separadas, foi construído o gráfico da figura abaixo, em função dos dois discriminantes lineares.

![image](https://user-images.githubusercontent.com/81119854/124521529-348f4600-ddc6-11eb-8391-4097586ad400.png)

Pela figura acima, pode ser concluído que houve uma ótima separação dos grupos. LD1 é a função responsável pela maior separação entre os grupos, enquanto LD2 pela segunda maior separação. Ambas permitem a visualização de quais grupos estão direcionando os dois eixos. 

Essa situação facilita no treinamento do modelo de previsão, fazendo com que a porcentagem de treinamento seja mais flexível, além de diminuir o erro de previsão do modelo. Outra forma de visualizar a separação é visualizando a separação provocada por cada função. 

O código para os gráficos de histogramas dessa separação está na figura abaixo e os histogramas da separação dos dados em três grupos pelas duas funções estão na figura subsequente.
