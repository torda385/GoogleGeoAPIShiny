#' Plot a web map with an address.
#'
#' Use \code{ggas} to plot a map with an address.
#'
#' @param lat a number representing the latitude of a location
#' @param lng a number representing the longitude of a location
#'
#'
#' @examples
#' ggas(lat=37.4238253802915,lng=-122.0829009197085)
#'
#' \dontrun{
#' ggas(TRUE, TRUE)
#' }
#' @export

#install devtools if needed
if(!require(devtools)) install.packages("devtools")
#install leaflet
if(!require(leaflet)) install.packages("leaflet")
#install shiny
if(!require(shiny)) install.packages("shiny")
#install GoogleGeoAPI app
if(!require(GoogleGeoAPI)) install_github("Rchieve/GoogleGeoAPI")
library(shiny)
library(leaflet)
shinyApp(
  ui <- fluidPage(
    titlePanel(
      "Geocoding with GoogleGeoAPI"
    ),
    
    sidebarPanel(
      fluidRow(
        radioButtons("input_type",
                  h1("Input Type"),
                  c(Address="Address",Coordinates="Coordinates")),
        h1("Input Location"),
        conditionalPanel("input.input_type=='Address'",
            textInput("text1","Address",value="")),
        conditionalPanel("input.input_type=='Coordinates'",
            textInput("text2","Latitude",value="11.43141"),
            textInput("text3","Longitude",value="16.12341"))   
      ),
      fluidRow(
        sliderInput("slider1",label=h3("Slider"),min=0,max=50,value=10)
      )
  ),
    mainPanel(
      leafletOutput('mymap'),
      p()
    )
  ),

  
  server <- function(input,output){
    textPop <- "You are here"
    #create the base map
    output$mymap<-renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        setView(lng=input$text3,lat=input$text2,zoom=input$slider1) %>% #add the location and set map size from data
      addPopups(lng=input$text3,lat=input$text2,popup=textPop)  #add the marker to the coordinates
      
    })
    
    }
)
