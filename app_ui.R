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
chart2_tab <- tabPanel("Chart 2")

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