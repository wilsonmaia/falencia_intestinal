#Consolidacao dos bancos de dados

RDMG_FINAL <- read.csv('RDMG_FINAL.csv')
SPMG_CONSOLIDADO <- read.csv('SPMG_CONSOLIDADO.csv') %>% select(c('SP_UF','SP_AA','SP_MM','SP_CNES','SP_NAIH','SP_PROCREA',
                                                                  'SP_DTINTER','SP_DTSAIDA','SP_ATOPROF','SP_M_PAC',
                                                                  'SP_CIDPRI','SP_CIDSEC','SP_QT_PROC'))
                                                                  
                                                                  

SPMG_CONSOLIDADO <- rename(SPMG_CONSOLIDADO, NOME_AIH = SP_NAIH)
RDMG_FINAL <- rename(RDMG_FINAL, NOME_AIH = N_AIH)
SPMG_CONSOLIDADO$NOME_AIH <- as.factor(SPMG_CONSOLIDADO$NOME_AIH)
RDMG_FINAL$NOME_AIH <- as.factor(RDMG_FINAL$NOME_AIH)
dados_brutos <- left_join(SPMG_CONSOLIDADO, RDMG_FINAL, by = 'NOME_AIH')

# verificacao de registros duplicados

duplicados <- duplicated(dados_brutos,fromLast = TRUE)

dados <- dados_brutos[!duplicados,]

# Variavel tempo de internacao

dados$DT_INTER <- ymd(dados$DT_INTER) 
dados$DT_SAIDA <- ymd(dados$DT_SAIDA)
dados <- mutate(dados, TEMP_INT = dados$DT_SAIDA-dados$DT_INTER)

write.csv(dados, 'MG_final.csv')
