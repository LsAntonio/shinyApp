
library(shiny)

library(ggplot2)
library(mgcv) # to gam
library(MASS) # to rlm
data("mtcars")
linearOption <- "lm"
colorOption <- "red"
titleOption <- "none"

shinyServer(function(input, output) {
   
  
  output$modelPlot <- renderPlot({
    linearOption <- switch(input$options,
                           lmOp = "lm",
                           glmOp = "glm",
                           gamOp = "gam",
                           loessOp = "loess",
                           rlmOp = "rlm")
    
    colorOption <- switch(input$options,
                          lmOp = "red",
                          glmOp = "blue",
                          gamOp = 'magenta',
                          loessOp = "green",
                          rlmOp = "purple")
    
    titleOption <- switch(input$options,
                          lmOp = "Fitting Linear Model (lm)",
                          glmOp = "Fitting Generalized Linear Model (glm)",
                          gamOp = "Generalized additive models with integrated smoothness estimation (gam)",
                          loessOp = "Local Polynomial Regression Fitting (loess)",
                          rlmOp = "Robust Fitting of Linear Models (rlm)")
    
    ggplot(mtcars, aes(x=wt, y=mpg, color=cyl)) + geom_point(size = 5) + geom_smooth(method=linearOption, color = colorOption, formula = y ~ x) + ggtitle(titleOption) + xlab("Weight (1000 lbs)") + ylab("Miles per gallon") + theme(axis.title.x = element_text(size = 18), axis.title.y = element_text(size = 18), plot.title = element_text(size = 20, face = "bold"))
    })
  
  output$summary <- renderPrint({
    
    linearOpt <- switch(input$options,
                           lmOp = "lm",
                           glmOp = "glm",
                           gamOp = "gam",
                           loessOp = "loess",
                           rlmOp = "rlm")
    
    
    if(linearOpt == "lm"){
      model <- with(mtcars, lm(wt~mpg))
    }
    if(linearOpt == "glm"){
      model <- with(mtcars, glm(wt~mpg))
    }
    if(linearOpt == "gam"){
      model <- with(mtcars, gam(wt~mpg))
    }
    if(linearOpt == "loess"){
      model <- with(mtcars, loess(wt~mpg))
    }
    if(linearOpt == "rlm"){
      model <- with(mtcars, rlm(wt~mpg))
    }
    
    summary(model)
  })
  
  output$table <- renderDataTable({
    mtcars
  })
  
})
