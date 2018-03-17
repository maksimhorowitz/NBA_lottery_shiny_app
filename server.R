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
  
  output$odds_vector <- reactive({
    
  odds_vector_create <- names(input)[str_which(names(input), "seed[0-9]{1,2}")]
  #odd_values_seed <- sapply(odds_vector_create, get)
  
  odd_values_seed <- sapply(odds_vector_create, FUN = function(x) input$x)
  
  # Output vector for now.
  data.frame(Prob_1 = odd_values_seed)
  
  })
  
})
