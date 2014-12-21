# ui.R

library(shiny)
library(rCharts)

shinyUI(navbarPage("Developing Data Products",
            tabPanel("Application",
            headerPanel("Federal Reserve Industrial Production Index (G17)"),
            sidebarPanel(
        
                radioButtons("disptype", "Display type:",
                     c("Full data" = "norm",
                       "6 month moving average" = "average")),
                br(),
                p("(Drag inside the lower chart to zoom)"),
                p("The display may be laggy, please allow time for refresh."),
                p("Thanks!")
        ),
        mainPanel(
            h3("Energy Production and Generation"),
            showOutput('mchart', lib='nvd3')
        )
    ),
    tabPanel("Documentation",
             p("This Shiny app presents data from the Federal Reserve showing Industrial Production from selected energy sectors."),
             p("The full description of this data can be found at (external link)"),
             a("Industrial Production and Capacity Utilization - G.17", href="http://www.federalreserve.gov/releases/G17/default.htm"),
             p("The source of this data can be found at "),
             a("Data Link", href="http://www.federalreserve.gov/datadownload/Output.aspx?rel=G17&series=40c934df8880a37c309bcb363e69966d&lastObs=&from=01/01/1970&to=12/31/2014&filetype=csv&label=include&layout=seriescolumn"),
             br(),
             br(),
             p("To use this application:"),
             tags$div(
                tags$ul(
                    tags$li("Select one or more series to display using the legend at the top of the chart"),
                    tags$li("Click and drag in the bottom overview chart to zoom in for a particular date range"),
                    tags$li("Click in the bottom overview chart to reset the date range"),
                    tags$li("Select the radio button in the left panel to view raw data or a 6-month moving average")
                )
             ),
             br(),
             hr(),
             p(strong("Description of the data"), "(from the FRB site)"),
             p("The production index measures real output and is expressed as a percentage of real output in a base year, currently 2007. The capacity index, which is an estimate of sustainable potential output, is also expressed as a percentage of actual output in 2007. The production indexes are computed as Fisher indexes since 1972; the weights are based on annual estimates of value added. The rate of capacity utilization equals the seasonally adjusted output index expressed as a percentage of the related capacity index.")
             ))
)
