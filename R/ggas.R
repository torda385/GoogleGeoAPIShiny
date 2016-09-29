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
                  c("Address","Coordinates")),
        h1("Input Location"),
        conditionalPanel(condition=(input.input_type==1),
            textInput("text1","Address",value="Linköping University, 58183, Linköping")),
        conditionalPanel(condition=(input.input_type==2),
            textInput("text2","Latitude",value="58.397774"),
            textInput("text3","Longitude",value="15.575977"))   
      ),
      fluidRow(
        sliderInput("slider1",label=h3("Slider"),min=0,max=50,value=10)
      )
  ),
    mainPanel(
      leafletOutput("myMap"),
      p()
    )
  ),

  
  server <- function(input,output){
    #set zoom
    output$value <- renderPrint({input$slider1})
    if (input$input_type == 1){
      address <- input$text1
    } else {
      latitude <- input$text2
      longitude <- input$text3
    }
    textpop <- paste(as.character(address),as.character(latitude),as.character(longitude),sep="\n")
  #create the base map
  map=leaflet() %>%
    addTiles() %>%
    setView(lng=longitude,lat=latitude,zoom=output$value) %>% #add the location and set map size from data
    addPopups(lng=longitude,lat=latitude,popup=textPop) #add the marker to the coordinates
    output$myMap=renderLeaflet(map) #create map from output
  }
)
