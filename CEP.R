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
