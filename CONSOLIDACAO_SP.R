#Consolidacao dos bancos de dados

RDSP_FINAL <- read.csv('RDSP_FINAL.csv')
SPSP_CONSOLIDADO <- read.csv('SPSP_CONSOLIDADO.csv') %>% select(c('SP_UF','SP_AA','SP_MM','SP_CNES','SP_NAIH','SP_PROCREA',
                                                                  'SP_DTINTER','SP_DTSAIDA','SP_ATOPROF','SP_M_PAC',
                                                                  'SP_CIDPRI','SP_CIDSEC','SP_QT_PROC'))

SPSP_CONSOLIDADO <- rename(SPSP_CONSOLIDADO, NOME_AIH = SP_NAIH)
RDSP_FINAL <- rename(RDSP_FINAL, NOME_AIH = N_AIH)
SPSP_CONSOLIDADO$NOME_AIH <- as.factor(SPSP_CONSOLIDADO$NOME_AIH)
RDSP_FINAL$NOME_AIH <- as.factor(RDSP_FINAL$NOME_AIH)
dados_brutos <- left_join(SPSP_CONSOLIDADO, RDSP_FINAL, by = 'NOME_AIH')

# verificacao de registros duplicados

duplicados <- duplicated(dados_brutos,fromLast = TRUE)

dados <- dados_brutos[!duplicados,]

# Variavel tempo de internacao

dados$DT_INTER <- ymd(dados$DT_INTER) 
dados$DT_SAIDA <- ymd(dados$DT_SAIDA)
dados <- mutate(dados, TEMP_INT = dados$DT_SAIDA-dados$DT_INTER)

write.csv(dados, 'SP_final.csv')
