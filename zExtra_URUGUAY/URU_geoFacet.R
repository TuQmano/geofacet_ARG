###################################################
###################################################
#     
#     Geofaceting URUGUAY
#     DEPARTAMENTOS
#
#     www.github.com/tuqmano
#     Por @TuQMano   - 11de abril de 2017
###################################################
###################################################

###################### PAQUETES ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(geofacet) # <--- geofacet


###################################################

URUGUAY <- read_excel("~/Desktop/URUGUAY.xlsx") # data set import
# Fuente de base de datos -> http://www.montevideo.com.uy/Noticias/Datos-de-la-Corte-Electoral-por-departamento-uc251040

URUGUAY <- gather(URUGUAY, "depto", "votos",  2:20)  # Wide to Long Format

colnames(URUGUAY) <- c("partido", "name", "votos")

####### URUGUAY "grid.map"
UR_grid <- data.frame(
  name = c("Artigas", "Rivera", "Salto", "Cerro Largo", "Paysandu", "Tacuarembo", "Durazno", "Rio Negro", "Treinta y Tres", "Flores", "Florida", "Lavalleja", "Rocha", "Soriano", "Canelones", "Colonia", "Maldonado", "San Jose", "Montevideo"),
  code = c("Artigas", "Rivera", "Salto", "Cerro Largo", "Paysandú", "Tacuarembó", "Durazno", "Río Negro", "Treinta y Tres", "Flores", "Florida", "Lavalleja", "Rocha", "Soriano", "Canelones", "Colonia", "Maldonado", "San José", "Montevideo"),
  row = c(1, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 7),
  col = c(2, 3, 2, 4, 2, 3, 3, 2, 4, 2, 3, 4, 5, 1, 3, 1, 4, 2, 3),
  stringsAsFactors = FALSE
)
# geofacet::grid_preview(mygrid)   Sacar # para previsualizar el mapa-grilla

  

# PLOT 
ggplot(URUGUAY) + geom_point(aes(votos, partido, color=partido))+
  facet_geo(~name, grid=UR_grid, scales="free_x") +
  ggtitle("Elecciones 2014 (URUGUAY)") +
  ylab("")+
  xlab("%") +
  theme(axis.text.y = element_blank())
  
