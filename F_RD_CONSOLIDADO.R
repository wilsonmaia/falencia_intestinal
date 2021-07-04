##################################################
#                                                #
#      BANCOS DE DADOS - AIH Reduzidas(RD)       #
#                                                #
##################################################

library(tidyverse)
library(read.dbc)

### Variaveis de interesse

selecao <- c('UF_ZI','ANO_CMPT','MES_CMPT','CEP','MUNIC_RES','NASC','SEXO',
             'UTI_MES_TO','PROC_SOLIC','PROC_REA','VAL_TOT','DT_INTER',
             'DT_SAIDA','MUNIC_MOV','IDADE','DIAS_PERM','MORTE','CID_NOTIF',
             'GESTOR_TP','CNES','CID_ASSO','CID_MORTE','DIAGSEC1','DIAGSEC2',
             'DIAGSEC3','DIAGSEC4','DIAGSEC5','DIAGSEC6','DIAGSEC7','DIAGSEC8',
             'DIAGSEC9','N_AIH')

###########################


RDSC_CONSOLIDADO = list.files(path = "ESTADOS/SC/RD_SC/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>% select(all_of(selecao)))

write.csv(RDSC_CONSOLIDADO, 'RDSC_CONSOLIDADO.csv')

###

RDRS_CONSOLIDADO = list.files(path = "ESTADOS/RS/RD_RS/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>% select(all_of(selecao)))

write.csv(RDRS_CONSOLIDADO, 'RDRS_CONSOLIDADO.csv')

###

RDSP_CONSOLIDADO = list.files(path = "ESTADOS/SP/RD_SP/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>% select(all_of(selecao)))

write.csv(RDSP_CONSOLIDADO, 'RDSP_CONSOLIDADO.csv')

###

RDMG_CONSOLIDADO = list.files(path = "ESTADOS/MG/RD_MG/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>% select(all_of(selecao)))

write.csv(RDMG_CONSOLIDADO, 'RDMG_CONSOLIDADO.csv')

###

RDBA_CONSOLIDADO = list.files(path = "ESTADOS/BA/RD_BA/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>% select(all_of(selecao)))

write.csv(RDBA_CONSOLIDADO, 'RDBA_CONSOLIDADO.csv')

###