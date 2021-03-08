# ui page
#Load library
library(tidyverse)
library(shiny)
library(countrycode)
library(ggplot2)
library(plotly)

#Connect the server to UI
source("app_server.R")

#Introduction
introduction_tab <- tabPanel("Introduction")

#Chart 1
chart1_tab <- tabPanel("Chart 1")

#Chart 2
#Chart 2 color input
chart2_color_input <- selectInput(
  inputId = "chart2color",
  label = "Choose a color",
  choices = c("Red", "Green", "Yellow", "Purple", "Orange", "Blue", "Black", "Pink")
)

#Chart 2 analysis
by_gdp_count <- gdp_chart %>%
  select(State, stateGDP)

top_five_states <- by_gdp_count %>%
  top_n(5) %>%
  arrange(stateGDP) %>%
  mutate(Proportion = stateGDP / sum(stateGDP))

chart2_tab <- tabPanel("Chart 2",
                       titlePanel("Chart of top 5 countries has the highest GPD proportion"),
                       br(),
                       p("Below is a pie chart showing 5 countries has the highest GDP proportion in the US."),
                       p("1. ", strong("Illinois")),
                       p("2. ", strong("Florida")),
                       p("3. ", strong("New York")),
                       p("4. ", strong("Texas")),
                       p("5. ", strong("California")),
                       sidebarLayout(
                         sidebarPanel(
                           chart2_color_input,
                         ),
                         mainPanel(
                           h2("Pie chart of top 5 highest GDP proportion"),
                           plotlyOutput(outputId = "top5chart")
                         )
                       )
                       
)

#Chart 3
chart3_tab <- tabPanel("Chart 3")

#Conclusion
conclution_tab <- tabPanel("Conclution")

#Create a UI 
ui <- navbarPage(
  "Final Deliverible",
  introduction_tab,
  chart1_tab,
  chart2_tab,
  chart3_tab,
  conclution_tab
  
)