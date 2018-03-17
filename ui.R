################################################################################
### This script is the UI portion of a shiny app which calculates and        ###
### visualizes probabilitie of the NBA lottery.                              ###
### Author: Maksim Horowitz                                                  ###
### Date Created: 3/17/2018                                                  ###
################################################################################

# Packages ---------------------

library(shiny)
library(tidyverse)
library(stringr)

# Begin UI programming ---------

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Lottery Odds by Seed"),
  
  sidebarPanel(
    
    numericInput("lot_seeds_count", "Number of Lottery Seeds:", 14, max = 30, min = 14),
    
    helpText("Note: When you update the number of seeds. You will then be prompted to input first pick lottery odds for each."),
    
   # actionButton("odd_next", "Next"),
    
  #  conditionalPanel(
   #   condition = "input.odd_next == 1",
      
      uiOutput("num_input")
  
  ),  
 # )),
  

  mainPanel( #verbatimTextOutput("names"),
             tableOutput("raw_odds")
             )
))
