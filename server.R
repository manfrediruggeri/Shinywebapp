#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(MASS)


shinyServer(function(input, output, session) {
    
    data(Boston)
    model1 <- lm(medv~ lstat , data=Boston)
    minlstat <- min(Boston$lstat)
    maxlstat <- max(Boston$lstat)
    
    model2 <- lm(medv~ rm , data=Boston)
    minrm <- min(Boston$rm)
    maxrm <- max(Boston$rm)
    
    model3 <- lm(medv~ ptratio , data=Boston)
    minptratio <- min(Boston$ptratio)
    maxptratio <- max(Boston$ptratio)
    
    model4 <- lm(medv~ crim , data=Boston)
    mincrim <- min(Boston$crim)
    maxcrim <- max(Boston$crim)
    
    model5 <- lm(medv~ rad , data=Boston)
    minrad <- min(Boston$rad)
    maxrad <- max(Boston$rad)
    
    model6 <- lm(medv ~ . -indus -age -zn , data=Boston)
    
    state <- reactiveValues()
    observe({
        state$inputSelect <- input$select
        if (state$inputSelect < 6) state$featureslider <- input$featureSlider
        if (state$inputSelect == 1) {
            state$fit <- model1
            state$min <- minlstat
            state$max <- maxlstat
            state$x <- Boston$lstat
            state$dat <- data.frame(lstat = state$featureslider)
            state$predict <- predict(state$fit, newdata=state$dat)
            state$xlab="lstat"
           
        }
        if (state$inputSelect == 2) {
            state$fit <- model2
            state$min <- minrm
            state$max <- maxrm
            state$x <- Boston$rm
            state$dat <- data.frame(rm = state$featureslider)
            state$predict <- predict(state$fit, newdata=state$dat)
            state$xlab="rm"
        }
        if (state$inputSelect == 3) {
            state$fit <- model3
            state$min <- minptratio
            state$max <- maxptratio
            state$x <- Boston$ptratio
            state$dat <- data.frame(ptratio = state$featureslider)
            state$predict <- predict(state$fit, newdata=state$dat)
            state$xlab="ptratio"
        }
        if (state$inputSelect == 4) {
            state$fit <- model4
            state$min <- mincrim
            state$max <- maxcrim
            state$x <- Boston$crim
            state$dat <- data.frame(crim = state$featureslider)
            state$predict <- predict(state$fit, newdata=state$dat)
            state$xlab="crim"
        }
        if (state$inputSelect == 5) {
            state$fit <- model5
            state$min <- minrad
            state$max <- maxrad
            state$x <- Boston$rad
            state$dat <- data.frame(rad = state$featureslider)
            state$predict <- predict(state$fit, newdata=state$dat)
            state$xlab="rad"
        }
        if (state$inputSelect == 6) {
            state$fit <- model6 
          
            state$dat <- data.frame(Boston)
            state$predict <- predict(state$fit, newdata=state$dat)
          
        }
        updateSliderInput(session, "featureSlider", min= state$min, max=state$max)
        if (state$inputSelect < 6) {
            output$plot5 <- renderPlot({plot(state$x, Boston$medv, ylab="medv", xlab= state$xlab, abline(state$fit, col="red" ))
                                    points(state$featureslider, state$predict, col="red", pch=16, cex=2)})
            output$prediction <- renderText(state$predict)}
        else {
            output$plot5 <- renderPlot({plot( Boston$medv, state$predict, xlab="medv", ylab="Predicted medv", abline(lm(Boston$medv ~ state$predict), col="red"))
                grid()})
            output$prediction <- renderText("Slider is disabled in this case")
        }
    
})
    
    observeEvent(state$inputSelect, {
        state$value <- (state$min + state$max)/2
        if(state$inputSelect == 6) {
            updateSliderInput(session, "featureSlider", label="", value = "")
            shinyjs::disable("featureSlider")}
        else {
            shinyjs::enable("featureSlider")
            updateSliderInput(session, "featureSlider", label="Select a value and predict", value = state$value)}
             
    })
    
    
    output$structure <- renderPrint(str(Boston))
    output$text1 <- renderPrint(summary(state$fit)) 
    output$plot1 <- renderPlot(plot(state$fit, which=1))
    output$plot2 <- renderPlot(plot(state$fit, which=2))
    output$plot3 <- renderPlot(plot(state$fit, which=3))
    output$plot4 <- renderPlot(plot(state$fit, which=4))
      
})
   

