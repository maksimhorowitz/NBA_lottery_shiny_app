################################################################################
### This script is the server portion of a shiny app which calculates and    ###
### visualizes probabilitie of the NBA lottery.                              ###
### Author: Maksim Horowitz                                                  ###
### Date Created: 3/17/2018                                                  ###
################################################################################

# Packages ---------------------

library(shiny)
library(tidyverse)
library(stringr)

# Data Processing --------------

# Create Dataframe 



# Building Server logic --------

shinyServer(function(input, output) {

  output$num_input <- renderUI({
    
      total_seeds <- as.integer(input$lot_seeds_count)

      lapply(1:total_seeds, function(i) {
        numericInput(inputId = paste0("seed", i), label = paste("Odds for Seed #", i),
                    min = 0, max = 1, value = 1/total_seeds, step = .001)
      })
    })
  
  values <- reactiveValues(df_odds = NULL)
  
  odds_first <- reactive({

  odds_vector_create <- names(input)[str_which(names(input), "seed[0-9]{1,2}")]
  #odd_values_seed <- sapply(odds_vector_create, get)

  odd_values_seed <- lapply(odds_vector_create, FUN = function(x) input[[x]]) %>% unlist

  names(odd_values_seed) <- odds_vector_create
  
  # Output vector for now.
  list(odds = odd_values_seed, names = odds_vector_create)

  })

  output$raw_odds <- renderTable( {
    data.frame(Seed = names(odds_first()$odds),
       Prob_1 = odds_first()$odds ) %>%
      mutate(Seed_Num = str_extract(Seed, "[0-9]{1,2}") %>% as.numeric()) %>%
      arrange(Seed_Num) %>%
      select(Seed_Num, Prob_1) %>%
      rename("Seed" = "Seed_Num") %>%
      mutate(Num_Combs = 1000*Prob_1)
    
    })
  
  output$names <- reactive({odds_first()$names})
  
})
