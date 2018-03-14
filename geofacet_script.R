

library(magrittr)
library(tidyverse)
library(readxl)
library(geofacet)
library(dplyr)
library(plyr)
library(lubridate)
library(anytime)

provs <- read_xls("Desktop/provs.xls") #IMPORTAR BASE DE DATOS


# FILTRAR BASE DE DATOS Y SELECCIONAR VARIABLES
provs <- select(provs, frec_temporal, indice_tiempo , alcance_nombre, empleo_tot, tasa_nat) #selecciono variables
provs <- filter(provs, provs$alcance_nombre != "Argentina") #elimino Total Argentina
provs <- filter(provs, provs$frec_temporal!= "trimestral") #selecciono periodo de observaciones trimestral

#RENOMBRAR VARIABLES
colnames(provs) <- c("frecuencia", "fecha", "distrito", "empleo", "natalidad")

###################################################
###################################################

########            CASO 1 EMPLEO TOTAL

###################################################
###################################################


#### LIMPIAR DATA -> BUENOS AIRES = "PARTIDOS DE GBA" + "RESTO DE BUENOS AIRES"
provs$empleo[which(provs$distrito == "BUENOS AIRES")] <- 0
provs$distrito[which(provs$distrito == "PARTIDOS DE GBA")] <-  "BUENOS AIRES"
provs$distrito[which(provs$distrito == "RESTO DE BUENOS AIRES")] <-  "BUENOS AIRES"       


# TRANSFORMAR type DE DATA
provs$empleo <-  as.numeric(provs$empleo)

#COLAPSAR "BUENOS AIRES" ANTES TRANSFORMADA (SUMA)
provs <- ddply(provs, c("frecuencia", "fecha", "distrito"), summarize, empleo = sum (empleo))


provs <- na.omit(provs) #elimino observaciones con valroes ausentes



# EMPATAR NOMBRES DE DISTRITOS DE GRILLA Y BASE DE DATOS
grilla <- argentina_grid1
provincias <- grilla$name_es
#provincias                                 Sacar el # para imprimir listado de provincias
#levels(provs$distrito)                     Sacar el # para imprimir listado de provincias

provs$distrito[which(provs$distrito == "BUENOS AIRES" )] <- "Buenos Aires" 
provs$distrito[which(provs$distrito == "CAPITAL FEDERAL")] <-  "Ciudad Autónoma de Buenos Aires" 
provs$distrito[which(provs$distrito == "CATAMARCA")] <-  "Catamarca"   
provs$distrito[which(provs$distrito ==  "CHACO" )] <-  "Chaco" 
provs$distrito[which(provs$distrito == "CHUBUT")] <-  "Chubut"   
provs$distrito[which(provs$distrito == "CORDOBA")] <-  "Córdoba"  
provs$distrito[which(provs$distrito ==  "CORRIENTES")] <-   "Corrientes" 
provs$distrito[which(provs$distrito == "ENTRE RIOS" )] <-  "Entre Ríos"  
provs$distrito[which(provs$distrito == "FORMOSA")] <-   "Formosa"
provs$distrito[which(provs$distrito == "JUJUY")] <-  "Jujuy" 
provs$distrito[which(provs$distrito == "LA PAMPA" )] <-  "La Pampa" 
provs$distrito[which(provs$distrito == "LA RIOJA")] <-  "La Rioja"  
provs$distrito[which(provs$distrito == "MENDOZA")] <-   "Mendoza"   
provs$distrito[which(provs$distrito == "MISIONES")] <-  "Misiones"  
provs$distrito[which(provs$distrito == "NEUQUEN")] <-  "Neuquén" 
provs$distrito[which(provs$distrito == "RIO NEGRO" )] <-  "Río Negro"  
provs$distrito[which(provs$distrito == "SALTA" )] <-  "Salta"   
provs$distrito[which(provs$distrito == "SAN JUAN" )] <-  "San Juan"   
provs$distrito[which(provs$distrito == "SAN LUIS" )] <-  "San Luis"  
provs$distrito[which(provs$distrito == "SANTA CRUZ" )] <-  "Santa Cruz"  
provs$distrito[which(provs$distrito ==  "SANTA FE"  )] <-   "Santa Fe"  
provs$distrito[which(provs$distrito == "SANTIAGO DEL ESTERO" )] <-  "Santiago del Estero"  
provs$distrito[which(provs$distrito == "TIERRA DEL FUEGO" )] <-  "Tierra del Fuego"   
provs$distrito[which(provs$distrito == "TUCUMAN" )] <-  "Tucumán"  

# TRANSFORMAR type DE DATA a "DATE" (FECHA)

provs$fecha <- as.character(provs$fecha)
provs$fecha <- substr(provs$fecha, 1, 4)
provs$fecha <- as.numeric(provs$fecha)

attach(provs)


ggplot(provs, aes(fecha, empleo)) +
  geom_col(color = "steelblue") +
  facet_geo(~ distrito, grid = "argentina_grid1", scales = "free_y") +
  scale_x_continuous(labels = c("1996", "2001", "2006", "2011")) +
  ylab("Empleo en provincias de Argentina") +
  theme_bw()
  

###################################################
###################################################

########            CASO 2 TASA NATALIDAD

###################################################
###################################################




# TRANSFORMAR type DE DATA
provs$natalidad <-  as.numeric(provs$natalidad)

provs.nat <- select(provs, frecuencia, fecha , distrito, natalidad) #Elimino variable "EMPLEO" que contiene NAs para BUENOS AIRES

provs.nat <- na.omit(provs.nat) #elimino observaciones con valroes ausentes



# EMPATAR NOMBRES DE DISTRITOS DE GRILLA Y BASE DE DATOS
#grilla <- argentina_grid1
#provincias <- grilla$name_es
#provincias                                 Sacar el # para imprimir listado de provincias
#levels(provs$distrito)                     Sacar el # para imprimir listado de provincias

provs.nat$distrito[which(provs.nat$distrito == "BUENOS AIRES" )] <- "Buenos Aires" 
provs.nat$distrito[which(provs.nat$distrito == "CAPITAL FEDERAL")] <-  "Ciudad Autónoma de Buenos Aires" 
provs.nat$distrito[which(provs.nat$distrito == "CATAMARCA")] <-  "Catamarca"   
provs.nat$distrito[which(provs.nat$distrito ==  "CHACO" )] <-  "Chaco" 
provs.nat$distrito[which(provs.nat$distrito == "CHUBUT")] <-  "Chubut"   
provs.nat$distrito[which(provs.nat$distrito == "CORDOBA")] <-  "Córdoba"  
provs.nat$distrito[which(provs.nat$distrito ==  "CORRIENTES")] <-   "Corrientes" 
provs.nat$distrito[which(provs.nat$distrito == "ENTRE RIOS" )] <-  "Entre Ríos"  
provs.nat$distrito[which(provs.nat$distrito == "FORMOSA")] <-   "Formosa"
provs.nat$distrito[which(provs.nat$distrito == "JUJUY")] <-  "Jujuy" 
provs.nat$distrito[which(provs.nat$distrito == "LA PAMPA" )] <-  "La Pampa" 
provs.nat$distrito[which(provs.nat$distrito == "LA RIOJA")] <-  "La Rioja"  
provs.nat$distrito[which(provs.nat$distrito == "MENDOZA")] <-   "Mendoza"   
provs.nat$distrito[which(provs.nat$distrito == "MISIONES")] <-  "Misiones"  
provs.nat$distrito[which(provs.nat$distrito == "NEUQUEN")] <-  "Neuquén" 
provs.nat$distrito[which(provs.nat$distrito == "RIO NEGRO" )] <-  "Río Negro"  
provs.nat$distrito[which(provs.nat$distrito == "SALTA" )] <-  "Salta"   
provs.nat$distrito[which(provs.nat$distrito == "SAN JUAN" )] <-  "San Juan"   
provs.nat$distrito[which(provs.nat$distrito == "SAN LUIS" )] <-  "San Luis"  
provs.nat$distrito[which(provs.nat$distrito == "SANTA CRUZ" )] <-  "Santa Cruz"  
provs.nat$distrito[which(provs.nat$distrito ==  "SANTA FE"  )] <-   "Santa Fe"  
provs.nat$distrito[which(provs.nat$distrito == "SANTIAGO DEL ESTERO" )] <-  "Santiago del Estero"  
provs.nat$distrito[which(provs.nat$distrito == "TIERRA DEL FUEGO" )] <-  "Tierra del Fuego"   
provs.nat$distrito[which(provs.nat$distrito == "TUCUMAN" )] <-  "Tucumán"  

# TRANSFORMAR type DE DATA a "DATE" (FECHA)

provs.nat$fecha <- as.character(provs.nat$fecha)
provs.nat$fecha <- substr(provs.nat$fecha, 1, 4)
provs.nat$fecha <- as.numeric(provs.nat$fecha)




ggplot(provs.nat, aes(fecha, natalidad)) +
  geom_col(color = "steelblue") +
  facet_geo(~ distrito, grid = "argentina_grid1", scales = "free_y") +
  ylab("Tasa de natalidad en provincias de Argentina") + 
  scale_x_continuous(name = "Año", breaks = c(1996, 2006, 2015))+ 
  geom_vline(xintercept = 2001, colour="red")+ labs(caption="DATOS: Ministerio de Hacienda - https://www.minhacienda.gob.ar/datos/" ) +
  theme_bw()


###################################################
###################################################

########            CASO 3 NUMERO EFECTIVO DE PARTIDOS

###################################################
###################################################

nep.prov <- read_csv("Desktop/ENP_f.csv") #IMPORTAR BASE DE DATOS


# EMPATAR NOMBRES DE DISTRITOS DE GRILLA Y BASE DE DATOS
grilla <- argentina_grid1
provincias <- grilla$name_es

prov.175n <- as.data.frame(rep(provincias,each=7))
colnames(prov.175n) <- "provincia"
prov.175n <- filter(prov.175n, prov.175n$provincia != "Islas Malvinas") #elimino Malvinas
prov.175n <- filter(prov.175n, prov.175n$provincia != "Antártida Argentina") #elimino Antartida


total.175 <- as.data.frame(c("Total","Total","Total","Total","Total","Total","Total" ))
colnames(total.175) <- "provincia"


prov.175n <- rbind(prov.175n, total.175)

colnames(prov.175n) <- "provincia"



colnames(nep.prov) <- c("id", "provincia", "year", "NEPp", "NEPb")


attach(nep.prov)
nep.prov <- as.data.frame(nep.prov[order(provincia),])
detach(nep.prov)

nep.prov <- cbind(nep.prov, prov.175n)

colnames(nep.prov) <- c("id", "provincia", "year", "NEPp", "NEPb", "name")


#provincias                                 Sacar el # para imprimir listado de provincias
#levels(provs$distrito)                     Sacar el # para imprimir listado de provincias

nep.prov$name[which(nep.prov$provincia == "Tucum<e1>n"  )] <- "Tucumán" 
nep.prov$name[which(nep.prov$provincia == "Total")] <- "Total"


attach(nep.prov)
ggplot(nep.prov, aes(year, NEPp)) +
  geom_line(color = "blue") +
  facet_geo(~ name, grid = "argentina_grid1", scales = "free_y") +
  ylab("Número Efectivo de Partidos (NEP)") + 
  scale_x_continuous(name = "Año", breaks = c(1983, 1994, 2005))+ 
  geom_vline(xintercept = 2001, colour="red")+ labs(caption="FUENTE: @Crst_C - http://observablesyhechos.blogspot.mx/2014/08/numero-efectivo-de-partidos-en.html " ) +
  theme_bw()






