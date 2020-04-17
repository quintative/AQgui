#' A GUI for exploring 2d data
#'
#' Explore data stored in data.tables!
#' @param data Use awesome data.table to get going...
#' @import data.table
#' @export

GUI_2d_explore <- function(data){
  library(data.table)
  library(plotly)
  library(dplyr)
  library(MASS)
  # Shiny app
  library(shiny)
  library(shinydashboard)
  # Density Based Clustering
  library(fpc)
  # knn regression
  library(caret)
  # Developer tools
  library(devtools)

  # Define UI
  ui <- fluidPage(
    tabsetPanel(
      # ============================================================
      tabPanel("data",
               FileUI("datafile", "User Data")
      ),
      # ============================================================
      tabPanel("OLS fit",
               RegressionLinUI("linreg.pl", "simple regression")
      ),
      # ============================================================
      tabPanel("knn fit",
               RegressionknnUI("knnreg.pl", "knn regression")
      ),
      # ============================================================
      tabPanel("k means",
               ClusterKMUI("kmeans.pl", "km clustering")
      ),
      # ============================================================
      tabPanel("hierarchical cl",
               ClusterHCUI("hier.pl", "hierar clustering")
      ),
      # ============================================================
      tabPanel("density-based cl",
               ClusterDBUI("dens.pl", "densbase clustering")
      )
    )
  )

  # --------------------------------------------------------------------------------------------------------------
  # Define server logic

  server <- function(input, output, session) {

    dt <- callModule(File, "datafile", reactive(data))

    callModule(RegressionLin, "linreg.pl", reactive(dt()))

    callModule(Regressionknn, "knnreg.pl", reactive(dt()))

    callModule(ClusterKM, "kmeans.pl", reactive(dt()))

    callModule(ClusterHC, "hier.pl", reactive(dt()))

    callModule(ClusterDB, "dens.pl", reactive(dt()))

  }

  # Run the application
  # shinyApp(ui = ui, server = server)
  runApp(list(ui = ui, server = server), launch.browser = T)
  }


