#################################################
#                                               #
# BANCOS DE DADOS - SERVICOS PROFISSIONAIS (sp) #
#                                               #
#################################################

library(tidyverse)
library(read.dbc)

###############################################################################


SPBA_CONSOLIDADO = list.files(path = "ESTADOS/BA/SP_BA/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>%  
           filter(SP_ATOPROF == '0309010098'|SP_ATOPROF == '0309010080'|SP_ATOPROF == '0309010071'))

write.csv(SPBA_CONSOLIDADO,'SPBA_CONSOLIDADO.csv')
###


SPMG_CONSOLIDADO = list.files(path = "ESTADOS/MG/SP_MG/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>%  
           filter(SP_ATOPROF == '0309010098'|SP_ATOPROF == '0309010080'|SP_ATOPROF == '0309010071'))

write.csv(SPMG_CONSOLIDADO,'SPMG_CONSOLIDADO.csv')
###


SPSP_CONSOLIDADO = list.files(path = "ESTADOS/SP/SP_SP/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>%  
           filter(SP_ATOPROF == '0309010098'|SP_ATOPROF == '0309010080'|SP_ATOPROF == '0309010071'))

write.csv(SPSP_CONSOLIDADO,'SPSP_CONSOLIDADO.csv')

###

SPRS_CONSOLIDADO = list.files(path = "ESTADOS/RS/SP_RS/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>%  
           filter(SP_ATOPROF == '0309010098'|SP_ATOPROF == '0309010080'|SP_ATOPROF == '0309010071'))

write.csv(SPRS_CONSOLIDADO,'SPRS_CONSOLIDADO.csv')

###

SPSC_CONSOLIDADO = list.files(path = "ESTADOS/SC/SP_SC/", pattern = '.dbc',full.names = T) %>% 
  map_df(~read.dbc(.) %>%  
           filter(SP_ATOPROF == '0309010098'|SP_ATOPROF == '0309010080'|SP_ATOPROF == '0309010071'))

write.csv(SPSC_CONSOLIDADO,'SPSC_CONSOLIDADO.csv')


