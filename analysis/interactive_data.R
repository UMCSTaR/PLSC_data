library(shiny)
library(DT)

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel(title=h1("Upload file and select columns", align="center")),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      
      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),
      
      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Semicolon = ";",
                               Comma = ",",
                               Tab = "\t"),
                   selected = ";"),
      
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(All = "all",
                               Head = "head"),
                   selected = "all"),
      
      
      column(7, 
             checkboxGroupInput("checkGroup", 
                                h3("Markers"), 
                                choices = list("E14"=1,
                                               "E16"=2,
                                               "E18_1"=3,
                                               "E18"=4,"FAEE" = 5, 
                                               "EtG" = 6
                                ), 
                                
                                
                                selected = 1)),
      # Horizontal line ----
      tags$hr(),
      fluidRow(
        
        column(7,
               h3("Model"),
               actionButton("action", "LR"))),
      # Horizontal line ----
      tags$hr()
      
      
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tabsetPanel(
        id = 'dataset',
        tabPanel("FILE", DT::dataTableOutput("file1"))
        
        
      ))
    
  )
)
######################################################################################

# Define server logic to read selected file ----
server <- function(input, output, session) {
  
  
  
  output$file1 <- DT::renderDataTable({
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep)
    
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
    
  }) 
  
}