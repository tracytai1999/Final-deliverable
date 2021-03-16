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
  img(src = 'covidimage.png', height = '350px', width = '1300px', align =
        "center"),
  h2("Introduction for Covid-19 Analysis"),
  p(" As one of the biggest pandemics entered the world named Covid-19, everyone 
    has been affected by this in someway. Whether it be their health, their 
    families or their jobs. This pandemic has caused people to work from their
    home to stay safe and healthy becuase Covid-19 is very quick and contagious.
    resturants, malls, and movies have been closed for this cause, and a lot
    of businesses have been affected. In this project, we want to use data
    visualiaztion to show how covid 10 has effected the economy in each state,
    and compare data from each state to see what actions and policies are useful
    to solve the problem."),
  h4("Research Quesions: "),
  p("1. What is the increasing trend for covid cases in each state?
     2. Do any of the states have increasing or decreasing cases due to Covid?
     3. Do any of the states have deaths case trend that is stable?"),
  p(" We will use our data set to explore different trends existing for each
    state, and provide a information source for people who want to explore
    more on effects created by Covid-19. ")
          
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
  p("You can interact by choosing state and color."),
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

chart2_tab <- tabPanel("State Covid-19 Deaths Graph",
                       titlePanel("Covid-19 Deaths for Each State in the U.S."),
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
state19 <- unique(covid_shapefile$State)
state_input <- selectInput(
  inputId = "selectstate",
  label = "Choose a state",
  choices = state19,
  selected = ""
)
ourColors <- c("red", "blue", "green", "cyan", "yellow", "orange", "black", "gray", "purple" )
colorblindfriendly <- c("#000000","#004949","#009292","#FF6DB6","#FFB6DB",
                        "#490092","#006DDB","#B66DFF","#6DB6FF","#B6DBFF",
                        "#920000","#924900","#DB6D00","#24FF24","#FFFF6D")
chart3_tab <- tabPanel("US COVID-19 Map",
                       p("Hover your cursor over the state to see the death toll"),
                       sidebarLayout(
                         sidebarPanel(
                           state_input,
                           selectInput("lowColor", "Regular Colors", ourColors, selected = "blue"),
                           selectInput("colorb", "Colorblind Friendly Colors", colorblindfriendly, selected = "000000"),
                         ),
                         mainPanel(
                           plotlyOutput(outputId = "chart3")
                         )
                       )
)

#Conclusion
conclusion_tab <- tabPanel(
  "Data Analysis",
  h2("Conclusion for Covid-19 Analysis"),
  p(" In conclusion, from the graphs we designed we were able to distinguish
    the differences and simlarities between states. Whether the rates are high
    or low. We made charts for the states that impacted covid, and showed 
    how high it rose. For example in the chart for Alaska, between January 2020
    to Jancuary 2021, the rates rose pretty quickly and it stays consistently
    growing. Any states that viewers are interested in can be found in the
    graphs we created. We used data visualization to compare the states and 
    show whether the cases and deaths increased or stayed the same, and how it
    impacted people. The increasing trend for most states have been increasing
    sharply during December 2020 and January 2021, and then going back to
    normal. From this observation, we could generate more questions regarding
    the causes of the rapid increase. For the number of covid-cases in
    Massachusetts between September 1st, 2020 and September 2st, there is a
    decrease of more than 7000 cases, leads to confusions of whether it result
    from a mistake or something else. These graphs are very useful in observing
    data for individual state, and trigger further explorations. "),
  h4("Top Ten States with Highest Number of Covid-19 Cases Most Recently"),
  tableOutput("table"),
  p("In this table, we concluded the ten states with highest Covid-19 cases for
    people to look at. The increasing trend of these states can be found in
    the interactive graphs we made by choosing the states you are interested in.
    We have created a information website for people to interact and collect
    information. We hope this website can help people to collect information 
    when doing analysis or research on Covid-19. ")
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