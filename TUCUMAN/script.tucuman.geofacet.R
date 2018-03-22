
###################################################
###################################################
#     
#     
#     Electrocardiograma político en TUCUMÁN X Depto(geofacet)
#     
#     Creado por @TuQmano
#     21 de marzo de 2018
#     www.github.com/tuqmano
#     www.tuqmano.com
#     
#     

###################################################
###################################################

rm(list=ls())  #BORRAR MEMORIA DE R
setwd("~/Dropbox/R/geofacet/TUCUMAN") #Establecer directorio de trabajo

###################### PAQUETES ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(plyr)
library(geofacet) # <--- geofacet


###################################################

tuc.historico <- read_excel("LupuXDepto.xlsx")# data set import
            #Base de datos construida por Noam Lupu


#seleccion de variables (departamento, año, votos totales, votos ucr y votos pj)
tuc.historico <- select(tuc.historico, department, year, total, ucr, pj)


####### TUC "grid.map"
mygrid <- data.frame(
  name = c("Trancas", "Burruyacu", "T.del Valle", "Cruz Alta", 
           "Y.Buena", "Capital", "T.Viejo", "Leales", "Monteros",
           "Famailla", "Lules", "Chicligasta", "Rio Chico", 
           "Simoca", "Graneros", "Alberdi", "La Cocha"),
  code = c("2", "3", "1", "7", "5", "6", "4", "11", "10", "9", "8", "12", "14", "13", "16", "15", "17"),
  row = c(1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 5, 5, 6),
  col = c(3, 4, 1, 5, 3, 4, 2, 5, 2, 3, 4, 2, 3, 4, 4, 3, 3),
  stringsAsFactors = FALSE
)
 # geofacet::grid_preview(mygrid)   Sacar # para previsualizar el mapa-grilla
 # 
 

## RECODE DATA NAMES de los departamentos

tuc.historico$department[which(tuc.historico$department == "Tafi")] <- "T.Viejo"
tuc.historico$department[which(tuc.historico$department == "Yerba Buena")] <- "Y.Buena"
tuc.historico$department[which(tuc.historico$department == "Tafi del Valle")] <- "T.del Valle"
tuc.historico$department[which(tuc.historico$department == "Tafi Viejo")] <- "T.Viejo"


#### convert variables type

tuc.historico$department <- as.factor(tuc.historico$department)


### GRID TUC NAMES    / Usado la primera vez para ver compatibilidad de nombres entre grid y dBase
#TucDeptos.Grid <- as.data.frame(mygrid$name)
#### DATA TUC NAMES
#TucDeptos.Lupu <- as.data.frame(levels(tuc.historico$department))
#names(TucDeptos.Lupu) <- c("depto") 



### new vars - vote % del PJ y UCR
tuc.historico$ucr.pc <- (tuc.historico$ucr/tuc.historico$total)*100
tuc.historico$pj.pc <- (tuc.historico$pj/tuc.historico$total)*100



##### data.frame:   wide -> long
tuc.historico.long <- gather(tuc.historico, party, votos, ucr.pc, pj.pc)

# CONVERTIR A type "factor"
tuc.historico$ucr.pc <- as.factor(tuc.historico$ucr.pc)
tuc.historico$pj.pc <-  as.factor(tuc.historico$pj.pc)


# DF final para graficar
# #seleccion de variables
tuc.electoral <- select(tuc.historico.long, department, year, party, votos) 

#recode de valores de "Partidos"
tuc.electoral$party[which(tuc.electoral$party == "ucr.pc")] <- "UCR" 
tuc.electoral$party[which(tuc.electoral$party == "pj.pc")] <- "PJ"

colnames(tuc.electoral) <- c("depto", "year", "Partido", "Votos") # rename de variables

tuc.electoral$Votos[is.na(tuc.electoral$Votos)] <- 0 # recode valores ausentes = 0


# PLOT 

attach(tuc.electoral)
ggplot(tuc.electoral)+
  geom_line(aes(year, Votos, group=Partido, colour=Partido)) +
  facet_geo(~ depto, grid = mygrid)+
  ggtitle("Tucumán Electoral (1916 - 2003)") +
  ylab("%")+ 
  scale_colour_manual(breaks = c("PJ", "UCR"), 
                    values=c("#0B25E1", "#EF1111")) + 
  scale_x_continuous(name = "Año", breaks = c(1916, 1936, 1956, 1976,1996), 
                     labels = function(x) paste0("'", substr(x, 3, 4)))+
  theme(legend.position="top", 
        axis.title.y = element_text(size = 20), 
        plot.title = element_text(size = 20, face = "bold")) 



#GUARDAR ULTIMO PLOT EN working directory
ggsave("TUCGeoFacet.svg", plot = last_plot(), device = pdf)


