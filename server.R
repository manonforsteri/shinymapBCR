#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# install.packages("anyLib")
# anyLib::anyLib(c("shiny", "shinydashboard", "shinyWidgets", "DT", "plotly", "ggplot2", "googleVis", "colourpicker"))
library(shinydashboard)
library(shinyWidgets)

# Define server logic required to draw a histogram
server <- function(input, output, session) { 
  
  data <- reactiveValues()
  
  
  #PrÃ©visualisation
  output$preview <-  renderDataTable({
    
    req(input$dataFile)
   
    #A FAIRE : LUI DIRE DE MONTRER UNIQUEMENT LES COLONNES QUI NOUS INTERESSENT
    #(La c'est encore un peu brouillon^^)
    df <- read.csv(input$dataFile$datapath,
                   header = TRUE,
                   sep = ";",
                   dec=".",
                   nrows=10
    )
  },  options = list(scrollX = TRUE , dom = 't'))
  
  
  
  #Lecture des donnÃ©es
  
  observeEvent(input$actBtnVisualisation, {
    
    if(!is.null(input$dataFile$datapath)){
      data$table = read.csv(input$dataFile$datapath,
                            header = TRUE,
                            sep = ";",
                            dec=".")
      sendSweetAlert(
        session = session,
        title = "Done !",
        text = "Le fichier a bien été lu !",
        type = "success"
      )
      
      updateTabItems(session, "tabs", selected = "visualization")
    }
    
  })
  
  }