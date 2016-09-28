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
#**************#



ggas <- function (lng, lat, z){
  if(missing(z)) {
    z=10
  }
  #create the base map
  (m<-leaflet() %>% addTiles())
  img<-readPNG("~/repos/Creating-maps-in-R/figure//shiny_world.png")
  grid.raster(img)
  #add a marker to the map
  (m2 <- m %>% 
    setView(lng=lng,lat=lat,zoom=z) %>% #add the location and set map size from data
    addMarkers(lng,lat)) #add the marker to the coordinates
  


}