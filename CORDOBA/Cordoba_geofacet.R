###################################################
###################################################
#     
#     Electores CÓRDOBA X Depto 
#     (geofacet -> by @hafenstats)
#     
#     Creado por @TuQmano
#     28 de marzo de 2018
#     www.github.com/tuqmano
#     www.tuqmano.com
#     
###################################################
###################################################

rm(list=ls())  #BORRAR MEMORIA DE R
setwd("~/Dropbox/R/geofacet/CORDOBA") #Establecer directorio de trabajo

###################### PAQUETES ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(plyr)
library(geofacet) # <--- geofacet
library(Unicode)


################################################### CARGA DE BASE DE DATOS A VISAULIZAR

electores.cordoba <- read_excel("Electores por Circuito acumulados 2007 - 2017 Córdoba.xlsx")# data set import
#Base de datos del PORTAL DE DATOS ABIERTOS - MUNICIPALIDAD DE CÓRDOBA 
# https://gobiernoabierto.cordoba.gob.ar/data/datos-abiertos/categoria/elecciones-provinciales/electores-por-circuito-en-la-provincia-de-cordoba/216


electores.cordoba <- select(electores.cordoba, 3, 5, 6, 7, 8, 9) #SELECCIONO VARIABLES POR NUMERO DE COLUMNA

electores.cordoba[is.na(electores.cordoba)] <- 0  # REMPLAZAR VALORES PERDIDOS (NA) POR 0

#LAS OBSERVACIONES ESTAN A NIVEL DE CIRCUITOS ELECTORALES
electores.cordoba %>% group_by(`Nombre Seccion`) %>% summarise_all(sum)-> electores.cordoba  #COLPAPSAR A NIEL DEPARTAMENTO

#renombrar variables
colnames(electores.cordoba) <- c("name", "elec.2007", "elec.2011", "elec.2013", "elec.2015", "elec.2017") 

# nuevas variables -> variación de electores entre comicios
attach(electores.cordoba)
electores.cordoba$cambio_2011 <- (elec.2011 - elec.2007)/elec.2011*100
electores.cordoba$cambio_2013 <- (elec.2013 - elec.2011)/elec.2013*100
electores.cordoba$cambio_2015 <- (elec.2015 - elec.2013)/elec.2015*100
electores.cordoba$cambio_2017 <- (elec.2017 - elec.2015)/elec.2017*100
detach(electores.cordoba)

#elijo nuevas variables
electores.cordoba <- select(electores.cordoba, 1, 7, 8, 9, 10)

#renombro variables
colnames(electores.cordoba) <- c("name", "e2011", "e2013", "e2015","e2017")


## RECODE DATA NAMES de los departamentos
electores.cordoba$name[which(electores.cordoba$name == "GENERAL ROCA")] <- "GRAL.ROCA"
electores.cordoba$name[which(electores.cordoba$name == "MARCOS JUAREZ")] <- "M.JUAREZ"
electores.cordoba$name[which(electores.cordoba$name == "GENERAL ROCA")] <- "GRAL.ROCA"
electores.cordoba$name[which(electores.cordoba$name == "ROQUE SAENZ PENA")] <- "R.S.PENA"
electores.cordoba$name[which(electores.cordoba$name == "SAN ALBERTO")] <- "S.ALBERTO"
electores.cordoba$name[which(electores.cordoba$name == "SAN JAVIER")] <- "S.JAVIER"
electores.cordoba$name[which(electores.cordoba$name == "SAN JUSTO")] <- "S.JUSTO"
electores.cordoba$name[which(electores.cordoba$name == "SANTA MARIA")] <- "S.MARIA"
electores.cordoba$name[which(electores.cordoba$name == "JUAREZ CELMAN")] <- "J.CELMAN"
electores.cordoba$name[which(electores.cordoba$name == "GRAL SAN MARTIN")] <- "GRAL.S.MARTIN"
electores.cordoba$name[which(electores.cordoba$name == "TERCERO ARRIBA")] <- "3RO ARRIBA"

#### convertir variables type de distritos como "factor"
electores.cordoba$name <- as.factor(electores.cordoba$name)


##### data.frame:   wide -> long


    electores.cordoba.long <- gather(electores.cordoba,key = year, value = electores, e2011, 
                                     e2013, e2015,e2017)


    
#### GRILLA GEO_FACET ####
    
    mygrid <- data.frame( name = toupper(c("Sobremonte", "Rio Seco", "Ischilin", "Cruz del Eje", "Totoral",
                                           "Tulumba", "S.Justo", "Minas", "Punilla", "Colon", "Rio Primero",
                                           "Pocho", "S.Alberto", "Capital", "Rio Segundo", "Gral.S.Martin", 
                                           "S.Maria", "S.Javier", "Calamuchita", "Union", "M.Juarez",
                                           "Rio Cuarto", "3RO Arriba", "J.Celman", 
                                           "Gral.Roca", "R.S.Pena")), 
                          code = toupper(c("Sobremonte", "Rio Seco", "Ischilin", "Cruz del Eje", "Totoral",
                                           "Tulumba", "S.Justo", "Minas", "Punilla", "Colon", "Rio Primero",
                                           "Pocho", "S.Alberto", "Capital", "Rio Segundo", "Gral.S.Martin", 
                                           "S.Maria", "S.Javier", "Calamuchita", "Union", "M.Juarez",
                                           "Rio Cuarto", "3RO Arriba", "J.Celman", 
                                           "Gral.Roca", "R.S.Pena")),   
                          row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 7, 7, 8), 
                          col = c(3, 4, 2, 1, 3, 4, 5, 1, 2, 3, 4, 1, 2, 3, 4, 4, 3, 1, 2, 5, 6, 2, 3, 3, 2, 3), 
                          stringsAsFactors = FALSE )
    
    
 #### DATA FINAL PARA PLOT ####   
    
data.cor <- electores.cordoba.long
grilla <- mygrid

data.cor$year <- substr(data.cor$year, 2, 5) # Modificar variables year
data.cor$year <- as.factor(data.cor$year)  # Cambiar var a tipo "factor"

# PLOT  ####
ggplot(data.cor)+
  geom_col(aes(year, electores), fill="blue") +
  facet_geo(~ name, grid = grilla)+
  ggtitle("CORDOBA 2011-2017 (por Departamento)") +
  ylab("Cambio de electores (%)") + 
  xlab("")+
  scale_x_discrete(breaks = c(2007, 2009, 2011, 2013, 2015, 2017), 
                     labels = function(x) paste0("'", substr(x, 3, 4)))+
  theme_bw()

