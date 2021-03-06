# CONSTANTS 

.CAMARA = "camara"
.SENADO = "senado"

.RCONGRESSO <- "rcongresso"
.LEGGO <- "agora-digital"
  
.RCONGRESSO_URL <- paste0("analytics-ufcg/", .RCONGRESSO)
.LEGGO_URL <- paste0("analytics-ufcg/", .LEGGO)

.README_MESSAGE <- "Read the README file"
.HELP_MESSAGE <- "Use --help for more information\n"
.INPUT_FILEPATH <- "./data/proposicoes.csv"
.OLD_EMENDAS_FILEPATH <- "../leggo-backend/data/emendas_raw_old.csv"
.EMENDAS_FILEPATH <- "../leggo-backend/data/emendas_raw.csv"
.NEW_EMENDAS_FILEPATH <- "../leggo-backend/data/novas_emendas.csv"
.AVULSOS_FILEPATH <- "../leggo-backend/data/avulsos_iniciais.csv"
.TEXTOS_FILEPATH <- "../leggo-backend/data/textos.csv"
.FLAG <- 1
.HELP_INPUT_ARG <- paste0("Caminho para o arquivo csv contendo os dados das proposições [default=", .INPUT_FILEPATH, "]")
.HELP_OUTPUT_ARG <- paste0("Caminho para o arquivo csv de saída [default=", .NEW_EMENDAS_FILEPATH, "]")