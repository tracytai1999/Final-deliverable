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
#Chart 2 color input and state input
unique_state <- unique(covid_chart$state)

chart2_state_input <- selectInput(
  inputId = "chart2state",
  label = "Select a state",
  choices = unique_state,
  selected = "Alaska"
)

chart2_color_input <- selectInput(
  inputId = "chart2color",
  label = "Select a color",
  choices = c("Red", "Green", "Yellow", "Purple", "Orange", "Blue", "Black", "Pink")
)

#Chart 2 analysis

chart2_tab <- tabPanel("State deaths chart",
                       titlePanel("States with GPD proportion"),
                       p("You can interact by choosing state and color."),
                       sidebarLayout(
                         sidebarPanel(
                           chart2_state_input,
                           chart2_color_input,
                         ),
                         mainPanel(
                           plotlyOutput(outputId = "deathchart")
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