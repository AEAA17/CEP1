Este código em R implementa um projeto de controle estatístico de processo (CEP) para monitorar a variável de pressão no processo de craqueamento catalítico em leito fluido (FCC). A análise é realizada utilizando dados gerados aleatoriamente no Excel, dentro da faixa de operação encontrada na literatura.

1. Instalação e Carregamento das Bibliotecas
Primeiro, as bibliotecas necessárias para a análise foram instaladas e carregadas:

readxl: Permite a leitura de arquivos Excel, que contém os dados de pressão gerados.
qcc: Uma biblioteca voltada para a criação de gráficos de controle de qualidade, permitindo a análise de processos industriais.

2. Carregamento e Preparação dos Dados
Os dados de pressão foram importados a partir de um arquivo Excel, especificado no caminho caminho_para_arquivo. Em seguida, as colunas do dataframe foram renomeadas para facilitar o manuseio:

Subgrupo: Identifica o grupo de observações.
Obs1 a Obs5: Representam as cinco observações de pressão coletadas para cada subgrupo.

3. Criação do Objeto de Tabela
Um dataframe denominado Pressão foi criado, contendo apenas as colunas de observações (Obs1 a Obs5). Esse formato é necessário para a criação de gráficos de controle com o pacote qcc.

4. Ajuste de Margens para Plotagem
As margens do gráfico foram ajustadas com a função par para melhorar a visualização dos gráficos de controle.

5. Gráfico X-bar
O gráfico X-bar é utilizado para monitorar a média das observações de cada subgrupo:
limits_xbar: Define os limites de controle baseados na faixa de operação da pressão (1.71 a 2.41).
qcc: A função qcc gera o gráfico X-bar, que é plotado para verificar se a média das observações de pressão está dentro dos limites de controle estabelecidos.
6. Gráficos R e S
Além do gráfico X-bar, foram gerados gráficos R e S para monitorar a variabilidade do processo:

Gráfico R: Monitora a amplitude (range) das observações em cada subgrupo.
Gráfico S: Monitora o desvio padrão das observações em cada subgrupo.

7. Análise de Capacidade do Processo
Por fim, foi realizada uma análise de capacidade do processo utilizando a função process.capability. Essa análise avalia se o processo de pressão está operando de forma eficaz dentro dos limites especificados (1.71 a 2.41). O gráfico de capacidade do processo é gerado para visualizar o desempenho do processo em relação aos limites especificados.

Código:

# Instalar e carregar as bibliotecas necessárias
install.packages("readxl")
library(readxl)
install.packages("qcc")
library(qcc)

caminho_para_arquivo <- "/P.xlsx"
dados <- read_excel(caminho_para_arquivo)

# Renomear colunas
colnames(dados) <- c("Subgrupo", "Obs1", "Obs2", "Obs3", "Obs4", "Obs5")

# Criar objeto de tabela no formato aceitável pelo pacote qcc
Pressão <- data.frame(dados$Obs1, dados$Obs2, dados$Obs3, dados$Obs4, dados$Obs5)

# Ajustar margens
par(mfrow = c(1, 1), mar = c(3, 3, 2, 2) + 0.1)

# Definir limites para o gráfico X-bar
limits_xbar <- matrix(c(1.71, 2.41), ncol = 2, byrow = TRUE)

# Criar e plotar o gráfico X-bar
XB <- qcc(Pressão, type = "xbar", plot = TRUE, limits = limits_xbar)

# Criar e plotar os gráficos R e S 
R <- qcc(Pressão, type = "R", plot = TRUE)
S <- qcc(Pressão, type = "S", plot = TRUE)

# Criar e plotar os gráficos de capacidade
process.capability(XB,spec.limits=c(1.71,2.41))