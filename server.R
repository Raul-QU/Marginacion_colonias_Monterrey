library(shiny)
library(dplyr)
library(leaflet)

server <- function(input, output, session) {
  
  # Actualizar opciones de grado de marginación según municipio
  observeEvent(input$municipio, {
    opciones_marginacion <- colonias %>%
      filter(MUNICIPIO == input$municipio) %>%
      pull(GM_2020) %>%
      unique() %>%
      sort()
    
    updateSelectInput(session, "filtro",
                      choices = c("Todos", opciones_marginacion),
                      selected = "Todos")
  })
  
  # Datos filtrados
  datos_colonias <- reactive({
    datos <- colonias %>% filter(MUNICIPIO == input$municipio)
    if (input$filtro != "Todos") {
      datos <- datos %>% filter(GM_2020 == input$filtro)
    }
    datos
  })
  
  datos_forma <- reactive({
    formas %>% filter(MUNICIPIO == input$municipio)
  })
  
  output$mapa <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("OpenStreetMap") %>%
      addPolygons(data = datos_forma(),
                  color = "black", weight = 4,
                  fill = FALSE, group = "Municipio") %>%
      addPolygons(data = datos_colonias(),
                  fillColor = ~paleta(GM_2020),
                  color = "black", weight = 1.2,
                  opacity = 1,
                  fillOpacity = 0.7,
                  popup = ~paste0(
                    "<strong>Colonia:</strong> ", COLONIA, "<br>",
                    "<strong>Grado de Marginación:</strong> ", GM_2020
                  ),
                  group = "Colonias") %>%
      addLegend("bottomright", pal = paleta, values = colonias$GM_2020,
                title = "GM_2020", opacity = 0.9)
  })
}