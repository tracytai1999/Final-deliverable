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
  p("This is an introduction of our project"),
  p(" As one of the biggest pandemics entered the world named Covid-19, everyone 
    has been affected by this in someway. Whether it be their health, their 
    families or their jobs. This pandemic has caused people to work from their
    home to stay safe and healthy becuase Covid-19 is very quick and contagious.
    resturants, malls, and movies have been closed for this cause, and a lot
    of businesses have been affected. In this project, we want to use data
    visualiaztion to show how covid 10 has effected the economy in each state,
    and compare data from each state to see what actions and policies are useful
    to solve the problem."),
  h2("Research Quesions"),
  p(" What is the increasing trend for covid cases in each state?"),
  p(" Do any of the states have increasing or decreasing cases due to Covid?"),
  p(" How has Covid affected the people that are not diagnosed with Covid")
  
                             
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
  p(" In conclusion,from the graphs we designed we were able to distinguish
    the differences and simlarities between states. Whether the rates are high
    or low. We made charts for the states that impacted covid, and showed 
    how high it rose. For example in the chart for Alaska, between January 2020
    to Jancuary 2021, the rates rose pretty quickly and it stays consistently
    growing. We used data visualization to compare the states and show whether 
    the cases increased or decreased and how it impacted people. ")

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