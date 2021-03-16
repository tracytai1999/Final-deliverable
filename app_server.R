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

#create variables
filtered_covid <- covid_chart %>%
  filter(date == max(date)) %>%
  group_by(date, state) %>%
  summarise(cases = sum(cases, na.rm = T))

#Create a server for 3 charts
server <- function(input, output) {

#graph
  output$table <- renderTable({
    
    top_ten_covid <- filtered_covid[order(filtered_covid$cases), ] %>%
      top_n(10) %>%
      arrange(cases) %>%
      mutate(state = factor(state, state))
    
  })
  
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
  output$deathchart <- renderPlotly({
     chart2_state <- input$chart2state
     
     death_data <- covid_chart %>%
       filter(state == chart2_state)
     
     death_chart <- ggplot(data = death_data) + 
         geom_col(mapping = aes(x = date, y = deaths),
                   fill = input$chart2color) + 
         labs(x = "Date", y = "Covid-19 Deaths", 
              title = paste0(chart2_state, "Covid-19 Deaths Graph")) +
     scale_y_continuous(labels = comma)
     
     return(death_chart)
  })

#Chart 3
  shapefile <- map_data('state')
  shapefile <- rename(shapefile, State = region)
  #load data for chart 3
  COVID19_state <- read_csv("https://raw.githubusercontent.com/tracytai1999/Final-deliverable/main/COVID19_state.csv")
  COVID19_state <- select(COVID19_state, State, Tested, Infected, Deaths)
  COVID19_state$State <- tolower(COVID19_state$State)
  covid_shapefile <- right_join(shapefile, COVID19_state, by = 'State')
  6:38
  #Chart 3
  output$chart3 <- renderPlotly({
    chosenstate <- input$selectstate
    mapdata <- covid_shapefile %>%
      filter(State == chosenstate)
    covidmap <- ggplot(data = mapdata) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = Deaths)) +
      labs(title = paste0("Number of COVID-19 Deaths in ", input$selectstate),
           x = "", y = "") +
      scale_fill_gradient(low=input$lowColor, high = input$colorb) +
      guides(fill=FALSE) +
      theme_void() +
      theme_void()
  })
}