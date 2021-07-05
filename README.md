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

