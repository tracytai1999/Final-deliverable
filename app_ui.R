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
introduction_tab <- tabPanel(
  "Introduction",
  p("This is an introduction of our project")
                             
)

#define variables
states <- unique(covid_chart$state)

#Chart 1
covid_layout <- sidebarLayout(
  sidebarPanel(
    select_country <- selectInput(
      inputId = "state_covid",
      label = "Select a state",
      choices = states,
      selected = "Alaska"),
    select_color <- selectInput(
      inputId = "color",
      choices = c("coral", "grey", "skyblue", "lightpink", "orange",
                  "firebrick"),
      label = "Select a color")
  ),mainPanel(
    plotlyOutput(outputId = "chart1")
  ))

chart1_tab <- tabPanel(
  "State Covid-19 Cases Graph",
  titlePanel("Covid-19 Cases for Each State in the U.S."),
  covid_layout
)



#Chart 2
#Chart 2 color input
chart2_color_input <- selectInput(
  inputId = "chart2color",
  label = "Select a color",
  choices = c("Red", "Green", "Yellow", "Purple", "Orange", "Blue", "Black", "Pink")
)

#Chart 2 analysis
by_gdp_count <- gdp_chart %>%
  select(State, stateGDP)

top_five_states <- by_gdp_count %>%
  top_n(5) %>%
  arrange(stateGDP) %>%
  mutate(Proportion = stateGDP / sum(stateGDP))

chart2_tab <- tabPanel("State GDP Chart",
                       titlePanel("Top 5 states with highest GPD proportion"),
                       br(),
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
                           plotlyOutput(outputId = "top5chart")
                         )
                       )
                       
)

#Chart 3
chart3_tab <- tabPanel("Chart 3")

#Conclusion
conclusion_tab <- tabPanel(
  "Data Analysis",
  p("This is an summary takeout for our project.")

  )

#Create a UI 
ui <- navbarPage(
  "Covid_19 Analysis",
  introduction_tab,
  chart1_tab,
  chart2_tab,
  chart3_tab,
  conclusion_tab
  
)