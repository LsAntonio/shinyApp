

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Regression Models Display and Calculation"),
  
  sidebarLayout(
    sidebarPanel(
      h3("How to Use"),
      p("Choose a regresion model from the list below, once you selected one, a plot will be displayed into the", 
        strong("Plot Tab"), "showing the model across the variables", 
        strong("Weight"), "and", strong("Miles per galon"), "from the", strong("mtcars dataset"),". The",
               strong("Model Tab"), "will show you the model details, like parameters, errors, etc. Finally the",
               strong("Data Tab"), "contain an interactive view of the", strong("mtcars dataset"), "."),
      
      radioButtons("options", "Choose the Regression Model to plot:",
                   c("Fitting Linear Model (lm)" = "lmOp",
                     "Fitting Generalized Linear Model (glm)" = "glmOp",
                     "Generalized additive models with integrated smoothness estimation (gam)" = "gamOp",
                     "Local Polynomial Regression Fitting (loess)" = "loessOp",
                     "Robust Fitting of Linear Models (rlm)" = "rlmOp"))

    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("modelPlot")),
        tabPanel("Model", verbatimTextOutput("summary")),
        tabPanel("Data", dataTableOutput("table"))
      )
    )
  )
))
