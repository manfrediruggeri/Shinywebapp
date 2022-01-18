#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)


shinyUI(tagList(useShinyjs(),
        
    fluidPage(
      
        titlePanel("Linear Regression Models On Boston Housing Dataset"),
        
        sidebarLayout(
            
            sidebarPanel(
                
                selectInput("select", label = "Select Model", 
                            choices = c("medv ~ lstat" = 1, "medv ~ rm" = 2, "medv ~ ptratio" = 3, "medv ~ crim" = 4, "medv ~ rad" = 5, "medv ~ . -indus -age -zn" = 6), 
                            selected = 1),
                hr(),
                sliderInput("featureSlider", "Select a value and predict", 
                            min = 3, max = 9, value = 6, step =0.01)
            ),
            
            mainPanel(
               
                
               
                
                fluidRow(
                    tabsetPanel(id="inMain",
                        tabPanel("Summary", 
                                 br(), 
                                 verbatimTextOutput("text1"),
                        ),
                        tabPanel("Diagnostics",
                                 br(),
                                 plotOutput("plot1"),
                                 plotOutput("plot2"),
                                 plotOutput("plot3"),
                                 plotOutput("plot4")
                               
                        ),
                        tabPanel("Prediction",
                                br(),
                                plotOutput("plot5"),
                                br(),
                                h4("Predicted medv:"),
                                textOutput("prediction")
                        ),
                        tabPanel("Documentation",
                                br(),
                                p("This simple web page is a web app example that performs statistical analysis using
                                  R framework and his shiny package."),
                                h4("Dataset"),
                                p("Used dataset is Boston, found in MASS package"), 
                                p("Boston is a database derived from information collected by the U.S. Census Service concerning housing in the area of Boston Mass."),
                                p("We can see 506 cases and 14 variables"),
                                verbatimTextOutput("structure"),
                                p("medv, median value of owner-occupied homes in $1000's, is our target."),
                                h4("Using App: click on - Select model -"),
                                p("This app performs six different linear regression models, the user can choose the model clicking - Select model - on the left side"),
                                h4("Using app: click on tabs"),
                                p("The calculations are shown into three tabs:"),
                                p("Tab Summary: slope, intercept and every relevant information about choosen model."),
                                p("Tab Diagnostics: four grahs are shown to understand if data are consistent with a linear regression."),
                                p("Tab Prediction: shows linear regression graph"),
                                p("Tab Documentation: this text"),
                                h4("Using app: select a value in the slider"),
                                p("In the graph shown on tab Prediction we see a big red point moving on regression line and, under the graph, a textbox showing the predicted value for variable medv."),
                                p("Side note : the sixth model is a multilinear regression model depending on more than one value, that is why slider is correctly disabled in this case"),
                                p("Thanks for reading")
                                
                        )
                        
                    ),
                   
                    
                    
                    
                ),
                
            )
        )
    )
))
