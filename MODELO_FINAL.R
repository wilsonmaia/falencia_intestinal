#################################
#                               #
#          MODELO FINAL         #
#                               #
#################################
#                               #
#     Support Vector Machine    #
#                               #
#################################
library(dplyr)
library(stringr)
library(tidymodels)
library(e1071)
library(caret)



ba <- read.csv('BA_final.csv')# observar variaveis X, X.1, X.2
mg <- read.csv('MG_final.csv')#DIAS_INT
rs <- read.csv('RS_final.csv')
sc <- read.csv('SC_final.csv')
sp <- read.csv('SP_final.csv')
#################################################################

ba$X = NULL
ba$X.1 = NULL
mg$X = NULL
mg$X.1 = NULL
mg$X.2 = NULL
rs$X = NULL
rs$X.1 = NULL
sc$X = NULL
sc$X.1 = NULL
sc$X.2 = NULL
sp$X = NULL
sp$X.1 = NULL
sp$X.2 = NULL
sp$DIAS_INT = NULL

#################################################################
ba <- select(ba,UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
             SP_UF , SP_AA , SP_MM , SP_CNES    ,
             NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
             SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
             UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
             CEP , MUNIC_RES , NASC ,         
             PROC_SOLIC , PROC_REA , VAL_TOT ,   
             DT_INTER , DT_SAIDA , MUNIC_MOV ,      
             DIAS_PERM , CID_NOTIF , GESTOR_TP , 
             CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
             DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
             DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9)
mg <- select(mg,UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
             SP_UF , SP_AA , SP_MM , SP_CNES    ,
             NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
             SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
             UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
             CEP , MUNIC_RES , NASC ,         
             PROC_SOLIC , PROC_REA , VAL_TOT ,   
             DT_INTER , DT_SAIDA , MUNIC_MOV ,      
             DIAS_PERM , CID_NOTIF , GESTOR_TP , 
             CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
             DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
             DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9)
sp <- select(sp,UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
             SP_UF , SP_AA , SP_MM , SP_CNES    ,
             NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
             SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
             UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
             CEP , MUNIC_RES , NASC ,         
             PROC_SOLIC , PROC_REA , VAL_TOT ,   
             DT_INTER , DT_SAIDA , MUNIC_MOV ,      
             DIAS_PERM , CID_NOTIF , GESTOR_TP , 
             CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
             DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
             DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9)
rs <- select(rs,UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
             SP_UF , SP_AA , SP_MM , SP_CNES    ,
             NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
             SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
             UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
             CEP , MUNIC_RES , NASC ,         
             PROC_SOLIC , PROC_REA , VAL_TOT ,   
             DT_INTER , DT_SAIDA , MUNIC_MOV ,      
             DIAS_PERM , CID_NOTIF , GESTOR_TP , 
             CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
             DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
             DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9)
sc <- select(sc,UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
             SP_UF , SP_AA , SP_MM , SP_CNES    ,
             NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
             SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
             UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
             CEP , MUNIC_RES , NASC ,         
             PROC_SOLIC , PROC_REA , VAL_TOT ,   
             DT_INTER , DT_SAIDA , MUNIC_MOV ,      
             DIAS_PERM , CID_NOTIF , GESTOR_TP , 
             CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
             DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
             DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9)

ba <- mutate(ba, ESTADO = 'BA')
mg <- mutate(mg, ESTADO = 'MG')
sp <- mutate(sp, ESTADO = 'SP')
sc <- mutate(sc, ESTADO = 'SC')
rs <- mutate(rs, ESTADO = 'RS')



dados <- rbind(mg,rs,ba,sc,sp)
#______________________________________________________________________________
#______________________________________________________________________________

dados <- mutate(dados, FALENCIA_INT = ifelse(TEMP_INT >= 42, 1,0))

# Codigos relacionados à Falencia Intestinal

dados <- mutate(dados, CID_CONEXAO = ifelse(str_detect(CID_NOTIF, 'K59')| str_detect(CID_NOTIF, 'K500')|
                                              str_detect(CID_NOTIF, 'S364')|str_detect(CID_NOTIF, 'P77')|
                                              str_detect(CID_NOTIF, 'K550')|str_detect(CID_NOTIF, 'K551')|
                                              str_detect(CID_NOTIF, 'K559')|str_detect(CID_NOTIF, 'S352')|
                                              str_detect(CID_NOTIF, 'K562')|str_detect(CID_NOTIF, 'Q793')|
                                              str_detect(CID_NOTIF, 'Q41') |str_detect(CID_NOTIF, 'R100')|
                                              str_detect(CID_NOTIF, 'I748')|str_detect(CID_NOTIF, 'Q431')|
                                              str_detect(CID_NOTIF, 'Q438')|str_detect(CID_NOTIF, 'K561')|
                                              str_detect(CID_NOTIF, 'K565')|str_detect(CID_NOTIF, 'K638')|
                                              str_detect(CID_NOTIF, 'K912')|str_detect(CID_NOTIF, 'Q438')|
                                              str_detect(DIAGSEC1, 'K500') |str_detect(DIAGSEC1, 'S364')| 
                                              str_detect(DIAGSEC1, 'P77')  |str_detect(DIAGSEC1, 'K550')|
                                              str_detect(DIAGSEC1, 'K551') |str_detect(DIAGSEC1, 'K559')|
                                              str_detect(DIAGSEC1, 'S352') |str_detect(DIAGSEC1, 'K562')|
                                              str_detect(DIAGSEC1, 'Q793') |str_detect(DIAGSEC1, 'Q41')|
                                              str_detect(DIAGSEC1, 'R100') |str_detect(DIAGSEC1, 'I748')|
                                              str_detect(DIAGSEC1, 'Q431') |str_detect(DIAGSEC1, 'Q438')|
                                              str_detect(DIAGSEC1, 'K561') |str_detect(DIAGSEC1, 'K565')|
                                              str_detect(DIAGSEC1, 'K638') |str_detect(DIAGSEC1, 'K912')|
                                              str_detect(DIAGSEC1, 'Q438') |str_detect(DIAGSEC1, 'K59')|
                                              str_detect(DIAGSEC2, 'K500') |str_detect(DIAGSEC2, 'S364')| 
                                              str_detect(DIAGSEC2, 'P77')  |str_detect(DIAGSEC2, 'K550')|
                                              str_detect(DIAGSEC2, 'K551') |str_detect(DIAGSEC2, 'K559')|
                                              str_detect(DIAGSEC2, 'S352') |str_detect(DIAGSEC2, 'K562')|
                                              str_detect(DIAGSEC2, 'Q793') |str_detect(DIAGSEC2, 'Q41')|
                                              str_detect(DIAGSEC2, 'R100') |str_detect(DIAGSEC2, 'I748')|
                                              str_detect(DIAGSEC2, 'Q431') |str_detect(DIAGSEC2, 'Q438')|
                                              str_detect(DIAGSEC2, 'K561') |str_detect(DIAGSEC2, 'K565')|
                                              str_detect(DIAGSEC2, 'K638') |str_detect(DIAGSEC2, 'K912')|
                                              str_detect(DIAGSEC2, 'Q438') |str_detect(DIAGSEC2, 'K59')|
                                              str_detect(DIAGSEC3, 'K500') |str_detect(DIAGSEC3, 'S364')| 
                                              str_detect(DIAGSEC3, 'P77')  |str_detect(DIAGSEC3, 'K550')|
                                              str_detect(DIAGSEC3, 'K551') |str_detect(DIAGSEC3, 'K559')|
                                              str_detect(DIAGSEC3, 'S352') |str_detect(DIAGSEC3, 'K562')|
                                              str_detect(DIAGSEC3, 'Q793') |str_detect(DIAGSEC3, 'Q41')|
                                              str_detect(DIAGSEC3, 'R100') |str_detect(DIAGSEC3, 'I748')|
                                              str_detect(DIAGSEC3, 'Q431') |str_detect(DIAGSEC3, 'Q438')|
                                              str_detect(DIAGSEC3, 'K561') |str_detect(DIAGSEC3, 'K565')|
                                              str_detect(DIAGSEC3, 'K638') |str_detect(DIAGSEC3, 'K912')|
                                              str_detect(DIAGSEC3, 'Q438') |str_detect(DIAGSEC3, 'K59')|
                                              str_detect(DIAGSEC4, 'K500') |str_detect(DIAGSEC4, 'S364')| 
                                              str_detect(DIAGSEC4, 'P77')  |str_detect(DIAGSEC4, 'K550')|
                                              str_detect(DIAGSEC4, 'K551') |str_detect(DIAGSEC4, 'K559')|
                                              str_detect(DIAGSEC4, 'S352') |str_detect(DIAGSEC4, 'K562')|
                                              str_detect(DIAGSEC4, 'Q793') |str_detect(DIAGSEC4, 'Q41')|
                                              str_detect(DIAGSEC4, 'R100') |str_detect(DIAGSEC4, 'I748')|
                                              str_detect(DIAGSEC4, 'Q431') |str_detect(DIAGSEC4, 'Q438')|
                                              str_detect(DIAGSEC4, 'K561') |str_detect(DIAGSEC4, 'K565')|
                                              str_detect(DIAGSEC4, 'K638') |str_detect(DIAGSEC4, 'K912')|
                                              str_detect(DIAGSEC4, 'Q438') |str_detect(DIAGSEC4, 'K59')|
                                              str_detect(DIAGSEC5, 'K500') |str_detect(DIAGSEC5, 'S364')| 
                                              str_detect(DIAGSEC5, 'P77')  |str_detect(DIAGSEC5, 'K550')|
                                              str_detect(DIAGSEC5, 'K551') |str_detect(DIAGSEC5, 'K559')|
                                              str_detect(DIAGSEC5, 'S352') |str_detect(DIAGSEC5, 'K562')|
                                              str_detect(DIAGSEC5, 'Q793') |str_detect(DIAGSEC5, 'Q41')|
                                              str_detect(DIAGSEC5, 'R100') |str_detect(DIAGSEC5, 'I748')|
                                              str_detect(DIAGSEC5, 'Q431') |str_detect(DIAGSEC5, 'Q438')|
                                              str_detect(DIAGSEC5, 'K561') |str_detect(DIAGSEC5, 'K565')|
                                              str_detect(DIAGSEC5, 'K638') |str_detect(DIAGSEC5, 'K912')|
                                              str_detect(DIAGSEC5, 'Q438') |str_detect(DIAGSEC5, 'K59')|
                                              str_detect(DIAGSEC6, 'K500') |str_detect(DIAGSEC6, 'S364')| 
                                              str_detect(DIAGSEC6, 'P77')  |str_detect(DIAGSEC6, 'K550')|
                                              str_detect(DIAGSEC6, 'K551') |str_detect(DIAGSEC6, 'K559')|
                                              str_detect(DIAGSEC6, 'S352') |str_detect(DIAGSEC6, 'K562')|
                                              str_detect(DIAGSEC6, 'Q793') |str_detect(DIAGSEC6, 'Q41')|
                                              str_detect(DIAGSEC6, 'R100') |str_detect(DIAGSEC6, 'I748')|
                                              str_detect(DIAGSEC6, 'Q431') |str_detect(DIAGSEC6, 'Q438')|
                                              str_detect(DIAGSEC6, 'K561') |str_detect(DIAGSEC6, 'K565')|
                                              str_detect(DIAGSEC6, 'K638') |str_detect(DIAGSEC6, 'K912')|
                                              str_detect(DIAGSEC6, 'Q438') |str_detect(DIAGSEC6, 'K59')|
                                              str_detect(DIAGSEC7, 'K500') |str_detect(DIAGSEC7, 'S364')| 
                                              str_detect(DIAGSEC7, 'P77')  |str_detect(DIAGSEC7, 'K550')|
                                              str_detect(DIAGSEC7, 'K551') |str_detect(DIAGSEC7, 'K559')|
                                              str_detect(DIAGSEC7, 'S352') |str_detect(DIAGSEC7, 'K562')|
                                              str_detect(DIAGSEC7, 'Q793') |str_detect(DIAGSEC7, 'Q41')|
                                              str_detect(DIAGSEC7, 'R100') |str_detect(DIAGSEC7, 'I748')|
                                              str_detect(DIAGSEC7, 'Q431') |str_detect(DIAGSEC7, 'Q438')|
                                              str_detect(DIAGSEC7, 'K561') |str_detect(DIAGSEC7, 'K565')|
                                              str_detect(DIAGSEC7, 'K638') |str_detect(DIAGSEC7, 'K912')|
                                              str_detect(DIAGSEC7, 'Q438') |str_detect(DIAGSEC7, 'K59')|
                                              str_detect(DIAGSEC8, 'K500') |str_detect(DIAGSEC8, 'S364')| 
                                              str_detect(DIAGSEC8, 'P77')  |str_detect(DIAGSEC8, 'K550')|
                                              str_detect(DIAGSEC8, 'K551') |str_detect(DIAGSEC8, 'K559')|
                                              str_detect(DIAGSEC8, 'S352') |str_detect(DIAGSEC8, 'K562')|
                                              str_detect(DIAGSEC8, 'Q793') |str_detect(DIAGSEC8, 'Q41')|
                                              str_detect(DIAGSEC8, 'R100') |str_detect(DIAGSEC8, 'I748')|
                                              str_detect(DIAGSEC8, 'Q431') |str_detect(DIAGSEC8, 'Q438')|
                                              str_detect(DIAGSEC8, 'K561') |str_detect(DIAGSEC8, 'K565')|
                                              str_detect(DIAGSEC8, 'K638') |str_detect(DIAGSEC8, 'K912')|
                                              str_detect(DIAGSEC8, 'Q438') |str_detect(DIAGSEC8, 'K59')|
                                              str_detect(DIAGSEC9, 'K500') |str_detect(DIAGSEC9, 'S364')| 
                                              str_detect(DIAGSEC9, 'P77')  |str_detect(DIAGSEC9, 'K550')|
                                              str_detect(DIAGSEC9, 'K551') |str_detect(DIAGSEC9, 'K559')|
                                              str_detect(DIAGSEC9, 'S352') |str_detect(DIAGSEC9, 'K562')|
                                              str_detect(DIAGSEC9, 'Q793') |str_detect(DIAGSEC9, 'Q41')|
                                              str_detect(DIAGSEC9, 'R100') |str_detect(DIAGSEC9, 'I748')|
                                              str_detect(DIAGSEC9, 'Q431') |str_detect(DIAGSEC9, 'Q438')|
                                              str_detect(DIAGSEC9, 'K561') |str_detect(DIAGSEC9, 'K565')|
                                              str_detect(DIAGSEC9, 'K638') |str_detect(DIAGSEC9, 'K912')|
                                              str_detect(DIAGSEC9, 'Q438') |str_detect(DIAGSEC9, 'K59'),
                                            1, 0))

dados$CID_CONEXAO = ifelse(is.na(dados$CID_CONEXAO),0,1)
write.csv(dados, 'BANCOmodSVM.csv')
#______________________________________________________________________________
#______________________________________________________________________________

## Variaveis utilizadas
# UTI_MES_TO, SP_QT_PROC, CID_CONEXAO, IDADE, SEXO, MORTE, FALENCIA_INT

variaveis <- c('UTI_MES_TO','SP_QT_PROC',
               'CID_CONEXAO','IDADE','SEXO',
               'MORTE','FALENCIA_INT')
UTI_MES_TO+SP_QT_PROC+CID_CONEXAO+IDADE+SEXO+MORTE+FALENCIA_INT
###############################################################################

splits <- initial_split(dados, strata = FALENCIA_INT, prop = 8/10)

# Separacao com o Tidymodels
dados_trainning <- training(splits)
dados_testing <- testing(splits)
table(dados_testing$FALENCIA_INT)
table(dados_trainning$FALENCIA_INT)

###############################################################################
#UTI_MES_TO , SP_QT_PROC , IDADE , SEXO , MORTE ,
#SP_UF , SP_AA , SP_MM , SP_CNES    ,
#NOME_AIH , SP_PROCREA , SP_DTINTER , SP_DTSAIDA, 
#SP_ATOPROF , SP_M_PAC , SP_CIDPRI , SP_CIDSEC,  
#UF_ZI , ANO_CMPT , MES_CMPT , TEMP_INT ,
#CEP , MUNIC_RES , NASC ,         
#PROC_SOLIC , PROC_REA , VAL_TOT ,   
#DT_INTER , DT_SAIDA , MUNIC_MOV ,      
#DIAS_PERM , CID_NOTIF , GESTOR_TP , 
#
#CNES , CID_ASSO , CID_MORTE , DIAGSEC1,   
#DIAGSEC2 , DIAGSEC3 , DIAGSEC4 , DIAGSEC5,   
#DIAGSEC6 , DIAGSEC7 , DIAGSEC8 , DIAGSEC9




###############################################################################

# Modelo
library(e1071)
classificador <- svm(FALENCIA_INT ~ UTI_MES_TO + SP_QT_PROC +
                       CID_CONEXAO + IDADE + SEXO + MORTE,
                     dados_trainning,type= 'C-classification', 
                     kernel='radial')
previsoes <- predict(classificador, newdata = dados_testing[,-x])

# Matriz de confusao
matriz_conf <- table(dados_testing[,47],previsoes)
matriz_conf

#avaliacao
library(caret)
confusionMatrix(matriz_conf)


# SALVANDO O MODELO
saveRDS(classificador,'svmMODEL.rds')
previsor <- readRDS('svmMODEL.rds')
#
#
indice = as.data.frame(previsoes)

positivos <- filter(indice,previsoes==1)
positivos = rownames_to_column(positivos)

bancoFILT = dados_testing
bancoFILT = rownames_to_column(bancoFILT)



bancoFILT <- left_join(positivos,bancoFILT, by="rowname")
write.csv(bancoFILT, 'bancoFILT.csv')
table(bancoFILT$CID_MORTE)


