# Paquetes necesarios
library(sf)
library(dplyr)
library(leaflet)

# Cargar shapefiles y transformar a WGS84 (se ejecuta una sola vez)
# Monterrey
colonias_monterrey <- st_read("colonias _mty.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Monterrey")%>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# San Nicolás de los Garza
colonias_sndlg <- st_read("colonias_sannicolas.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "San Nicolás de los Garza") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Apodaca
colonias_apodaca <- st_read("colonias_apodaca.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Apodaca") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Gral. Escobedo
colonias_escobedo <- st_read("colonias_escobedo.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "General Escobedo") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# García
colonias_garcia <- st_read("colonias_garcia.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "García") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Guadalupe
colonias_guadalupe <- st_read("colonias_guadalupe.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Guadalupe") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Santa Catarina
colonias_santacatarina <- st_read("colonias_santacatarina.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Santa Catarina") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Santa Pedro Garza García
colonias_sanpedro <- st_read("colonias_spgg3.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Santa Pedro Garza García") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Unir todas las colonias
colonias <- bind_rows(colonias_apodaca, colonias_escobedo, colonias_garcia, colonias_guadalupe, colonias_monterrey, 
                      colonias_sanpedro, colonias_santacatarina, colonias_sndlg)


# Cargar shapefiles de formas por municipio
# Apodaca
forma_apodaca <- st_read("forma_apodaca.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Apodaca") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Escobedo
forma_escobedo <- st_read("forma_escobedo.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "General Escobedo") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# García
forma_garcia <- st_read("forma_garcia.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "García") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Guadalupe
forma_guadalupe <- st_read("forma_guadalupe.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Guadalupe") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Monterrey
forma_monterrey <- st_read("forma_mty.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Monterrey") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# San Pedro Garza García
forma_sanpedro <- st_read("forma_spgg_2.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "San Pedro Garza García") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Santa Catarina
forma_santacatarina <- st_read("forma_santacatarina.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "Santa Catarina") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# San Nicolás de los Garza
forma_sndlg <- st_read("forma_sannicolas.shp") %>%
  st_transform(4326) %>%
  st_make_valid() %>%
  mutate(MUNICIPIO = "San Nicolás de los Garza") %>% 
  filter(st_geometry_type(geometry) %in% c("POLYGON", "MULTIPOLYGON"))

# Unir todas las formas
formas <- bind_rows(forma_apodaca, forma_escobedo, forma_garcia, forma_guadalupe,
                    forma_monterrey, forma_sanpedro, forma_santacatarina, forma_sndlg)

# Crear paleta de colores para GM_2020
paleta <- colorFactor("YlOrRd", domain = colonias$GM_2020)
