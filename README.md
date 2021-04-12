# cognitivo.ai
Teste de Análise de Dados Airbnb_Miguel Lellis

# cognitivo.ai
Teste de Análise de Dados Airbnb_Miguel Lellis

Relatório de análise baseado em um conjunto de dados provenientes do Airbnb.

Em dado projeto busca-se apresentar um modelo de predição de custos mediante regressão linear, utilizando o software R como forma de apoio.

Primeiramente é realizado a importação e observação dos dados.


--------------------------
data_rio <- read.csv(file = url("http://data.insideairbnb.com/brazil/rj/rio-de-janeiro/2021-02-22/visualisations/listings.csv"))
percentual_nulo <- round(colSums(is.na(data_rio))*100/(nrow(data_rio)), 5)
data.frame(percentual_nulo)
--------------------------

Identificando as seguintes variáveis no dataset. Vale ressaltar que também foi possível identificar a falta de dados em algumas variávies, 
como por exemplo na variável XXXXXXXXXXX, indicando ausência total de dados e em XXXXXXXX indicando falta de 37,xxxx% dos dados.

