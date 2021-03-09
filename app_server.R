#server page
#Load library
library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(maps)
library(plotly)
library(scales)

#Load dataset for chart 2
gdp_chart <- read.csv("https://raw.githubusercontent.com/tracytai1999/Exploratory-Analysis/main/Exploratory%20Analysis/GDP.csv")
covid_chart <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

#Create a server for 3 charts
server <- function(input, output) {

#Chart 1
    output$chart1 <- renderPlotly({
      
      selected_state <- input$state_covid
      
      covid_data <- covid_chart %>%
        filter(state == selected_state)
      
      covid_graph <- ggplot(data = covid_data) +
        geom_col(mapping = aes(x = date, y = cases), fill = input$color) +
        labs(title = paste0(selected_state, " Covid-19 Cases Graph"), x = "Date",
             y = "Covid-19 Cases") + 
        scale_y_continuous(labels = comma)
      
      ggplotly(covid_graph)
    })
  
  
#Chart 2
  output$top5chart <- renderPlotly({
     chart2_color_input <- input$chart2color
     
     top_5_chart <-
       ggplot(data = top_five_states) + 
         geom_point(mapping = aes(x = State, y = Proportion),
                    color = chart2_color_input, size = 10) + 
         labs(x = "States", y = "Proportion of GDP", title = "Top 5 states with highest Proportion of GDP")
     
     return(top_5_chart)
  })

#Chart 3
}