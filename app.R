# load necessary packages
library(shiny)

# load sources
source("app_ui.R")
source("app_server.R")

# create a ShinyApp
shinyApp(ui = ui, server = server)
