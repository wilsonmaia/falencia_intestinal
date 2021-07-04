#Consolidacao dos bancos de dados

RDBA_FINAL <- read.csv('RDBA_FINAL.csv')
SPBA_CONSOLIDADO <- read.csv('SPBA_CONSOLIDADO.csv') %>% select(c('SP_UF','SP_AA','SP_MM','SP_CNES','SP_NAIH','SP_PROCREA',
                                                                  'SP_DTINTER','SP_DTSAIDA','SP_ATOPROF','SP_M_PAC',
                                                                  'SP_CIDPRI','SP_CIDSEC','SP_QT_PROC'))

SPBA_CONSOLIDADO <- rename(SPBA_CONSOLIDADO, NOME_AIH = SP_NAIH)
RDBA_FINAL <- rename(RDBA_FINAL, NOME_AIH = N_AIH)
SPBA_CONSOLIDADO$NOME_AIH <- as.factor(SPBA_CONSOLIDADO$NOME_AIH)
RDBA_FINAL$NOME_AIH <- as.factor(RDBA_FINAL$NOME_AIH)
dados_brutos <- left_join(SPBA_CONSOLIDADO, RDBA_FINAL, by = 'NOME_AIH')

# verificacao de registros duplicados

duplicados <- duplicated(dados_brutos,fromLast = TRUE)

dados <- dados_brutos[!duplicados,]

# Variavel tempo de internacao

dados$DT_INTER <- ymd(dados$DT_INTER) 
dados$DT_SAIDA <- ymd(dados$DT_SAIDA)
dados <- mutate(dados, TEMP_INT = dados$DT_SAIDA-dados$DT_INTER)

write.csv(dados, 'BA_final.csv')
