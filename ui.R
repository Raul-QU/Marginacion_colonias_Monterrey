library(shiny)
library(leaflet)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #mapa {
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        z-index: 1;
      }
      #panel-filtros {
        position: absolute;
        top: 20px; left: 20px;
        z-index: 1000;
        background: rgba(255, 255, 255, 0.9);
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0,0,0,0.3);
      }
    "))
  ),
  
  # Panel de filtros flotante
  div(id = "panel-filtros",
      selectInput("municipio", "Selecciona un municipio:",
                  choices = sort(unique(colonias$MUNICIPIO)),
                  selected = unique(colonias$MUNICIPIO)[1]),
      
      selectInput("filtro", "Filtrar por grado de marginación:",
                  choices = c("Todos"),
                  selected = "Todos")
  ),
  
  leafletOutput("mapa", height = "100%")
)
