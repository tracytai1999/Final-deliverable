# load necessary packages
library(shiny)
library(lintr)

# load sources
source("app_ui.R")
source("app_server.R")

# create a ShinyApp
shinyApp(ui = ui, server = server)
