

###################################################
###################################################
#     
#     
#     Template para publicación de datos en grilla
#     formateada como mapa de Argentina (geofacet)
#     
#     Creado por @TuQmano
#     5 de abril de 2018
#     www.github.com/tuqmano
#     www.tuqmano.com
#     
#     


###################################################
###################################################


#PAQUETES NECESARIOS
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(plyr)
library(geofacet)  # PAQUETE PARA GENERAR GRAFICOS
library(RCurl)


###################################################
###################################################

######## PLOT:  NUMERO EFECTIVO DE PARTIDOS EN 
#               PROVINCIAS ARGENTINAS

###################################################
###################################################

nep.prov <- read.csv(text=getURL("https://raw.githubusercontent.com/TuQmano/geofacet_ARG/master/ARGENTINA/ENP_f.csv"),header=T)

nep.prov$Provincia <- as.character(nep.prov$Provincia)
nep.prov$Provincia[which(nep.prov$Provincia == "Capital.Federal")] <- "C.A.B.A."
nep.prov$Provincia[which(nep.prov$Provincia == "Santiago.del.Estero")] <- "S.del.Estero"
nep.prov$Provincia[which(nep.prov$Provincia == "Tierra.del.Fuego")] <- "T.del.Fuego"
nep.prov$Provincia <- as.factor(nep.prov$Provincia)

#El cálculo del NEP lo realizó @Crst_Cen base a datos del atlas del gran @andy_tow.
# En este post se puede encontrar la información 
#   http://observablesyhechos.blogspot.mx/2014/08/numero-efectivo-de-partidos-en.html   <-------------


# COMANDOS EMPATAR NOMBRES DE DISTRITOS DE GRILLA (geofacet) Y BASE DE DATOS
argentina_grid2 <-  data.frame(
  col = c(1, 3, 5, 1, 2, 1, 3, 4, 2, 2, 4, 1, 3, 3, 4, 1, 2, 2, 1, 1, 2, 1, 1, 1),
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 7, 7, 8, 9, 10),
  code = c("AR-Y", "AR-P", "AR-N", "AR-A", "AR-T", "AR-K", "AR-H", "AR-W", "AR-G", "AR-X", "AR-E", "AR-F", "AR-S", "AR-B", "AR-C", "AR-J", "AR-D", "AR-L", "AR-M", "AR-Q", "AR-R", "AR-U", "AR-Z", "AR-V"),
  name_es = c("Jujuy", "Formosa", "Misiones", "Salta", "Tucumán", "Catamarca", "Chaco", "Corrientes", "S.del.Estero", "Córdoba", "Entre.Ríos", "La.Rioja", "Santa.Fe", "Buenos.Aires", "C.A.B.A.", "San.Juan", "San.Luis", "La.Pampa", "Mendoza", "Neuquén", "Río.Negro", "Chubut", "Santa.Cruz", "T.del.Fuego"),
  stringsAsFactors = FALSE
)

#### BORRAR OBSERVACIONES "TOTAL"

nep.prov <- nep.prov[!(nep.prov$Provincia == "Total"),]


### RENOMBRO VARIABLES

colnames(nep.prov) <- c("id", "name_es", "year", "NEPp", "NEPb") # renombro las variables de l abase de datos de NEP


##### codigo base para el gráfico
attach(nep.prov)
ggplot(nep.prov, aes(year, NEPp)) +
  geom_line(color = "blue") +
  facet_geo(~ name_es, grid = argentina_grid2, scales = "free_y") +
  ylab("Número Efectivo de Partidos (NEP)") + 
  scale_x_continuous(name = "Año", breaks = c(1983, 1994, 2005))+ 
  geom_vline(xintercept = 2001, colour="red")+ labs(caption="FUENTE: @Crst_C - http://observablesyhechos.blogspot.mx" ) +
  theme_bw()

