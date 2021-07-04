# Falência Intestinal (FI)
## Análise de dados do Sistema de Informações de Saúde do Ministério da Saúde.

- Foram coletados dados do Sistema de Informações Hospitalares em duas bases separadas, a de Autorizações de Internações Hospitalares Reduzidas (AIH-RD) e a de Serviços Profissionais (SP). As bases foram cruzadas através do número de registro da AIH.
Com base em materiais disponíveis, foi estabelecido o critério de 6 semanas em nutrição parenteral para a definição do grupo de Falência Instestinal. A partir dessa definição, outros critérios para auxiliar na identificação de pacientes com FI foram estabelecidos, como a classificação com alguns códigos de CID (classificação internacional de doenças), idade, sexo etc.
- Utilizou-se um modelo de classificação para permitir a identificação de novos casos nos registros hospitalares e, assim, identificar quantos casos ocorrem em determinados estados do país. A base para a criação do modelo foram casos dos estados de São Paulo, Minas Gerais, Rio Grande do Sul, Santa Catarina e Bahia.
- Os dados brutos encontram-se disponíveis para download no DataSUS, Sistemas de Informações Hospitalares do SUS (SIHSUS) (http://www2.datasus.gov.br/DATASUS/index.php?area=0901)
- Em construção...

## Procedimentos (em Nutrição parenteral)

- 030901007-1 Nutrição parenteral em adulto 
- 030901009-8 Nutrição parenteral em pediatria 
- 030901008-0 Nutrição parenteral em neonatologia 
- Quando for utilizado o acesso de veia central para a instalação de nutrição parenteral, deve ser utilizado o código 04.15.04.001-9- Cateterismo de Veia Central por Punção


### GRUPO CID: K59 - Outros transtornos funcionais do intestino

- **CID 10 - K59**   Outros transtornos funcionais do intestino
- **CID 10 - K59.**  Constipação
- **CID 10 - K59.1** Diarréia funcional
- **CID 10 - K59.2** Cólon neurogênico não classificado em outra parte
- **CID 10 - K59.3** Megacólon não classificado em outra parte
- **CID 10 - K59.4** Espasmo anal
- **CID 10 - K59.8** Outros transtornos funcionais especificados do intestino
- **CID 10 - K59.9** Transtorno intestinal funcional, não especificado


- **0309010071** Nutricao parenteral em adultos
- **0309010080** Nutricao parenteral em neonatologia 
**0309010098** Nutricao parenteral em pediatria
