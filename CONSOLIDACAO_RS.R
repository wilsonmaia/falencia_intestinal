#Consolidacao dos bancos de dados

RDRS_FINAL <- read.csv('RDRS_FINAL.csv')
SPRS_CONSOLIDADO <- read.csv('SPRS_CONSOLIDADO.csv') %>% select(c('SP_UF','SP_AA','SP_MM','SP_CNES','SP_NAIH','SP_PROCREA',
                                                                  'SP_DTINTER','SP_DTSAIDA','SP_ATOPROF','SP_M_PAC',
                                                                  'SP_CIDPRI','SP_CIDSEC','SP_QT_PROC'))

SPRS_CONSOLIDADO <- rename(SPRS_CONSOLIDADO, NOME_AIH = SP_NAIH)
RDRS_FINAL <- rename(RDRS_FINAL, NOME_AIH = N_AIH)
SPRS_CONSOLIDADO$NOME_AIH <- as.factor(SPRS_CONSOLIDADO$NOME_AIH)
RDRS_FINAL$NOME_AIH <- as.factor(RDRS_FINAL$NOME_AIH)
dados_brutos <- left_join(SPRS_CONSOLIDADO, RDRS_FINAL, by = 'NOME_AIH')

# verificacao de registros duplicados

duplicados <- duplicated(dados_brutos,fromLast = TRUE)

dados <- dados_brutos[!duplicados,]

# Variavel tempo de internacao

dados$DT_INTER <- ymd(dados$DT_INTER) 
dados$DT_SAIDA <- ymd(dados$DT_SAIDA)
dados <- mutate(dados, TEMP_INT = dados$DT_SAIDA-dados$DT_INTER)

write.csv(dados, 'RS_final.csv')
