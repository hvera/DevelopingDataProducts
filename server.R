# server.R

library(shiny)


library(zoo)
library(rCharts)


df <- read.csv("./data/FRB_G17.csv", header=FALSE, sep=",", skip=6)
# remove last two empty rows
df <- head(df, -2)

names(df) <- c("Time.period", "Crude.oil.production", "Natural.gas.production",
               "Coal.mining", "Hydroelectric.generation",
               "Fossil.fuel.electric.generation", "Nuclear.power.generation")

df$Time.period <- as.Date(as.yearmon(df$Time.period))

# h <- Highcharts$new()
# h$xAxis(categories=1970:2014)
# #h$yAxis(list(title = list(text = 'Rainfall')), list(title = list(text = 'Temperature'), opposite = TRUE), list(title = list(text = 'Sea Pressure'), opposite = TRUE))
# h$series(name = 'Crude Oil pro.', type = 'spline', color = '#4572A7',
#          data = df$Crude.oil.production)
# 
# h$series(name = 'Natural gas prod', type = 'spline', color = '#89A54E',
#          data = df$Natural.gas.production)
# 
# h$series(name = 'Coal mining', type = 'spline', color = '#AA4643',
#          data = df$Coal.mining)
# 
# h
# 
# m1a <- mPlot(x = "date", y = colnames(df), 
#              data = df, type = "Line")
# m1a$set(pointSize = 0)
# m1a$set(hideHover = "auto")
# m1a$print()
# 
# m1a

#df <- transform(df, Time.period=as.character(Time.period))
# m1 <- mPlot(x="Time.period", y=c("Crude.oil.production", "Natural.gas.production",
#                                  "Coal.mining", "Hydroelectric.generation", 
#                                  "Fossil.fuel.electric.generation",
#                                  "Nuclear.power.generation"), type="Line", data=df)

Crude.oil.production6 <- rollmean(df$Crude.oil.production, 6)
Natural.gas.production6 <- rollmean(df$Natural.gas.production, 6)
Hydroelectric.generation6 <- rollmean(df$Hydroelectric.generation, 6)
Fossil.fuel.electric.generation6 <- rollmean(df$Fossil.fuel.electric.generation, 6)

Time.period6 <- head(df$Time.period, -5)

df2 <- data.frame(Time.period6,
                  Crude.oil.production6,
                  Natural.gas.production6,
                  Hydroelectric.generation6,
                  Fossil.fuel.electric.generation6)


energy <- reshape2::melt(df[, c('Time.period', 'Crude.oil.production', 
                               "Natural.gas.production",
                               "Hydroelectric.generation", 
                               "Fossil.fuel.electric.generation"
                               )], id = 'Time.period')


energy6 <- reshape2::melt(df2[, c('Time.period6', 'Crude.oil.production6', 
                                        "Natural.gas.production6",
                                        "Hydroelectric.generation6", 
                                        "Fossil.fuel.electric.generation6"
                                    )], id = 'Time.period6')


m2 <- nPlot(value ~ Time.period, data=energy, group='variable', type="lineWithFocusChart")
m6 <- nPlot(value ~ Time.period6, data=energy6, group='variable', type="lineWithFocusChart")

m2$xAxis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )            
m2$x2Axis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )            
m2$xAxis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )            
m6$x2Axis( tickFormat="#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#" )            



#m1$set(pointSize=0, lineWidth=1)


shinyServer(
    function(input, output) {
        output$mchart <- renderChart2({
            #m1$params$y <-input$cb
            if (input$disptype == "average") {
                return(m6)
            } else {
                return(m2)
            }
        })
    }
)