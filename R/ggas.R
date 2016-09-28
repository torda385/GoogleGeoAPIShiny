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
if(!require(leaflet)) install_github("rstudio/leaflet")
#install shiny
if(!require(shiny)) install_github("shiny")
#install GoogleGeoAPI app
if(!require(GoogleGeoAPI)) install_github("Rchieve/GoogleGeoAPI")

shinyApp(
  ui <- fluidPage(
    titlePanel(
      "Geocoding with GoogleGeoAPI"
    ),
    
    sidebarPanel(
      fluidRow(
        radioButtons("first_choice",
                  h1("Input Type"),
                  c("Address","Coordinates")),
        h1("Input Location"),
        bsCollapse(
          bsCollapsePanel(tile="details",
                          uiOutput("second_choice")),
          id="collapser",multiple=FALSE, open=NULL
        )
      ),
      hr(),
      fluidRow(
        sliderInput("slider1",label=h3("Slider"),min=0,max=100,value=10
        )
      ),
      fluidRow(
        verbatimTextOutput("value")
      ),
      hr()
  ),
    mainPanel(
      leafletOutput('myMap'),
      p()
    )
  ),

  
  server <- function(input,output,session){
      #change ui component depending on input$input_type
      switch(input$first_choice,
             "Address"=textInput("addr1","Address", value="Linköping University, 58183, Linköping"),
             "Coordinates"=(textInput("latitude","Latitude",value="58.400101"),textInput("longitude","Longitude",value="15.576227"))
      )
      
      
      
    #set zoom
    output$value <- renderPrint({input$slider1})
    if (input$type1 == 1){
      address <- input$addr1
    } else {
      latitude
    }

    textPop<-
    longitude<-
    latitude<-
  #create the base map
  map=leaflet() %>%
    addTiles() %>%
    setView(lng=longitude,lat=latitude,zoom=output$value) %>% #add the location and set map size from data
    addPopups(lng=longitude,lat=latitude,popup=textPop) #add the marker to the coordinates
    output$myMap=renderLeaflet(map) #create map from output
  }
)
