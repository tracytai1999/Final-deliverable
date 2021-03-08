#server page
#Load library
library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(maps)
library(plotly)

#Load dataset for chart 2
gdp_chart <- read.csv("https://raw.githubusercontent.com/tracytai1999/Exploratory-Analysis/main/Exploratory%20Analysis/GDP.csv")


#Create a server for 3 charts
server <- function(input, output) {
#Chart 1
  
  
#Chart 2
  output$top5chart <- renderPlotly({
     chart2_color_input <- input$chart2color
     
     top_5_chart <-
       ggplot(data = top_five_states) + 
         geom_point(mapping = aes(x = State, y = Proportion),
                    color = chart2_color_input, size = 10) + 
         labs(x = "States", y = "Proportion of GDP", title = "Top 5 states has highest Proportion of GDP")
     
     return(top_5_chart)
  })

#Chart 3
}