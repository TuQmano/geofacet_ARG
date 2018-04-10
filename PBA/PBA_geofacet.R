###################################################
###################################################
#     
#     Geofaceting Argneinta
#     PBA - Secciones Electorales
#
#     www.github.com/tuqmano
#     Por @TuQMano   - 10 de abril de 2017
###################################################
###################################################

###################### PAQUETES ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(geofacet) # <--- geofacet


###################################################

PBA <- read_excel("~/Desktop/geofacet LatinR/DATA_PBA2017.xlsx") # data set import
#Base de datos descargada del escrutinio provisorio. Elección General 2017
PBA$seccion <- as.factor(PBA$seccion)
PBA$partido <- as.factor(PBA$partido)

PBA$electores <- PBA$electores/1000000 # MILLONES DE ELECTORES
PBA$votos <- PBA$votos/1000 #MILLONES  DE VOTOS


colnames(PBA) <- c("names", "partido", "votos", "electores")
####### PBA "grid.map"
PBA_grid <- data.frame(
  name = c("Segunda", "Primera", "Tercera", "Capital", "Septima", "Cuarta", "Quinta", "Sexta"),
  code = c(" 2", " 1", " 3", " CAP", " 7", " 4", " 5", " 6"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3),
  col = c(2, 3, 4, 4, 2, 1, 3, 1),
  stringsAsFactors = FALSE
)
# geofacet::grid_preview(mygrid)   Sacar # para previsualizar el mapa-grilla

  

# PLOT 
ggplot(PBA) + geom_point(aes(votos, partido, color=partido, size=electores))+
  facet_geo(~names, grid=PBA_grid, scales="free_x") +
  ggtitle("Provincia de Buenos AIres (Diputados 2017)") +
  ylab("")+
  xlab("Miles de votos")+
  theme(axis.title.x = element_text(size = 20), 
        plot.title = element_text(size = 20, face = "bold")) +
  scale_colour_manual(breaks = c("UNIDAD CIUDADANA", "FRENTE JUSTICIALISTA",
                                 "FRENTE DE IZQUIERDA Y DE LOS TRABAJADORES", 
                                 "CAMBIEMOS BUENOS AIRES", "1PAIS"), 
                      values=c("#0e8c64", "#f2f911", "#ff0000", "#4c2e5b", "#74c2ed"), guide = FALSE) +
  guides(size=guide_legend(title="Millones de electores"))
  

