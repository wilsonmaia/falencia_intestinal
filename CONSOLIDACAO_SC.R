#Consolidacao dos bancos de dados

RDSC_FINAL <- read.csv('RDSC_FINAL.csv')
SPSC_CONSOLIDADO <- read.csv('SPSC_CONSOLIDADO.csv') %>% select(c('SP_UF','SP_AA','SP_MM','SP_CNES','SP_NAIH','SP_PROCREA',
                                                                  'SP_DTINTER','SP_DTSAIDA','SP_ATOPROF','SP_M_PAC',
                                                                  'SP_CIDPRI','SP_CIDSEC','SP_QT_PROC'))

SPSC_CONSOLIDADO <- rename(SPSC_CONSOLIDADO, NOME_AIH = SP_NAIH)
RDSC_FINAL <- rename(RDSC_FINAL, NOME_AIH = N_AIH)
SPSC_CONSOLIDADO$NOME_AIH <- as.factor(SPSC_CONSOLIDADO$NOME_AIH)
RDSC_FINAL$NOME_AIH <- as.factor(RDSC_FINAL$NOME_AIH)
dados_brutos <- left_join(SPSC_CONSOLIDADO, RDSC_FINAL, by = 'NOME_AIH')

# verificacao de registros duplicados

duplicados <- duplicated(dados_brutos,fromLast = TRUE)

dados <- dados_brutos[!duplicados,]

# Variavel tempo de internacao

dados$DT_INTER <- ymd(dados$DT_INTER) 
dados$DT_SAIDA <- ymd(dados$DT_SAIDA)
dados <- mutate(dados, TEMP_INT = dados$DT_SAIDA-dados$DT_INTER)

write.csv(dados, 'SC_final.csv')
