source(here::here("utils/constants.R"))

library(dplyr)

#' @title Fetch data for each proposition
#' @description Fetch data for each proposition in Senado and Camara
#' @param camara_id Proposition's ID from Camara
#' @param senado_id Proposition's ID from Senado
#' @examples 
#' fetch_propositions_versions(46249, 41703)
fetch_propositions_versions <- function(id, casa) {
  
  print(paste0("Processando dados da proposição com id ", id))
  
  if (casa == .CAMARA) {
    df <- agoradigital::extract_links_proposicao(id = id, casa = .CAMARA)
    
  } else {
    df <- agoradigital::extract_links_proposicao(id = id, casa = .SENADO)
  }
  
  return(df %>%
           dplyr::arrange(data) %>% 
           dplyr::filter(!is.na(tipo_texto)) %>%
           dplyr::mutate_all(~ as.character(.)))
}

safe_fetch_propositions_versions <- purrr::safely(
  fetch_propositions_versions,
  otherwise = tibble::tribble(~ id_proposicao, ~ casa, ~ codigo_texto, ~ data, ~ tipo_texto, ~ descricao,  ~ link_inteiro_teor, ~ pagina_inicial),
  quiet = FALSE)

#' @title Fetch data for all propositions
#' @description Fetch data for all propositions in Senado and Camara
#' @param props_df Dataframe with propositions whose texts will be fetched
#' @examples
#' fetch_textos_proposicao("data/tabela_geral_ids_casa.csv")
fetch_textos_proposicao <- function(props_df) {
  df <- 
    purrr::map2_df(.x = props_df$id_ext,
                   .y = props_df$casa,
                   ~ safe_fetch_propositions_versions(.x, .y)$result)
}

#' @title Save dataframe
#' @description Write dataframe in output_filepath
#' @param emendas_df Tabela com as emendas e os links 
#' @param emendas_raw Tabela com todas as emendas sem as distâncias
#' @param output_filepath Output filepath
save_new_emendas <- function(emendas_df, emendas_raw, output_filepath) {
  emendas_raw <-
    emendas_raw %>% 
    dplyr::mutate(id_emenda = as.character(codigo_emenda))
  
  novas_emendas <-
    dplyr::anti_join(emendas_df, emendas_raw, by=c("codigo_texto" = "id_emenda")) %>% 
    readr::write_csv(output_filepath)
}

