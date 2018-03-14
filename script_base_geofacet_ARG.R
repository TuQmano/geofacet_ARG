
###################################################
###################################################
#     
#     
#     Template para publicación de datos en grilla
#     formateada como mapa de Argentina (geofacet)
#     
#     Creado por @TuQmano
#     14 de marzo de 2018
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


###################################################
###################################################

######## PLOT:  NUMERO EFECTIVO DE PARTIDOS EN 
#               PROVINCIAS ARGENTINAS

###################################################
###################################################

nep.prov <- read_csv("Desktop/ENP_f.csv") #IMPORTAR BASE DE DATOS 

#El cálculo del NEP lo realizó @Crst_Cen base a datos del atlas del gran @andy_tow.
# En este post se puede encontrar la información 
#   http://observablesyhechos.blogspot.mx/2014/08/numero-efectivo-de-partidos-en.html   <-------------


# COMANDOS EMPATAR NOMBRES DE DISTRITOS DE GRILLA (geofacet) Y BASE DE DATOS
grilla <- argentina_grid1
provincias <- grilla$name_es  #para extraer y poder visualizar cómo estan escritos los nombres de las provincias

prov.175n <- as.data.frame(rep(provincias,each=7))  # genero una secuncia de nombres de provincias para cantidad de observaciones de la base de datos de NEP
colnames(prov.175n) <- "provincia"  # renombro la variable
prov.175n <- filter(prov.175n, prov.175n$provincia != "Islas Malvinas") #elimino Malvinas
prov.175n <- filter(prov.175n, prov.175n$provincia != "Antártida Argentina") #elimino Antartida


total.175 <- as.data.frame(c("Total","Total","Total","Total","Total","Total","Total" )) # genero secuencia "total" que no estaba incluida en base de datos
colnames(total.175) <- "provincia" # renombro la variable


prov.175n <- rbind(prov.175n, total.175) # sumo las dos estructuras de datos para que tengan misma cantidad de observaciones
colnames(prov.175n) <- "provincia" # renombro la variable

colnames(nep.prov) <- c("id", "provincia", "year", "NEPp", "NEPb") # renombro las variables de l abase de datos de NEP


attach(nep.prov)
nep.prov <- as.data.frame(nep.prov[order(provincia),]) #ORDENO BASE DE DATOS POR PROVINCIAS ALFABETICAMENTE
detach(nep.prov)

nep.prov <- cbind(nep.prov, prov.175n)  # COMBINO BASE DE DATOS NEP CON LA QUE CREAMOS DE NOMBRES DE PROVINCIAS DE "GEOFACET"

colnames(nep.prov) <- c("id", "provincia", "year", "NEPp", "NEPb", "name") # renombro las variables


#por algún motivo, al ordenar alfabeticamente "total" y "tucumán" quedan intercambiadas. 
#Con los siguientes comandos renombramos esos casos para que las columnas de nombres estén parejas

nep.prov$name[which(nep.prov$provincia == "Tucum<e1>n"  )] <- "Tucumán" 
nep.prov$name[which(nep.prov$provincia == "Total")] <- "Total"

##### codigo base para el gráfico
attach(nep.prov)
ggplot(nep.prov, aes(year, NEPp)) +
  geom_line(color = "blue") +
  facet_geo(~ name, grid = "argentina_grid1", scales = "free_y") +
  ylab("Número Efectivo de Partidos (NEP)") + 
  scale_x_continuous(name = "Año", breaks = c(1983, 1994, 2005))+ 
  geom_vline(xintercept = 2001, colour="red")+ labs(caption="FUENTE: @Crst_C - http://observablesyhechos.blogspot.mx/2014/08/numero-efectivo-de-partidos-en.html " ) +
  theme_bw()


