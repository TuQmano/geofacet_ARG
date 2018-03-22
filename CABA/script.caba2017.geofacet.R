
###################################################
###################################################
#     
#     
#     Resultados Electorales CABA 2017 (geofacet)
#     
#     Creado por @TuQmano
#     16 de marzo de 2018
#     www.github.com/tuqmano
#     www.tuqmano.com
#     
#     

###################################################
###################################################


###################### PAQUETES ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(plyr)
library(geofacet) # <--- geofacet



setwd("~/Dropbox/R/geofacet/CABA")
rm(list=ls())

###################################################

caba2017 <- read_excel("caba2017.xls") # data set import


##### data.frame:   wide -> long
caba2017.long <- gather(caba2017, comuna, votos, `1`:`15`)

#### convert to factor variables
caba2017.long$Partido <- as.factor(caba2017.long$Partido)
caba2017.long$comuna <- as.factor(caba2017.long$comuna)

### change to percent values
caba2017.long$votos <- caba2017.long$votos*100


####### CABA "grid.map"
mygrid <- data.frame(
  code = c("13", "12", "11", "14", "15", "2", "6", "10", "5", "3", "7", "9", "1", "4", "8"),
  name = c("13", "12", "11", "14", "15", "2", "6", "10", "5", "3", "7", "9", "1", "4", "8"),
  row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 3, 4, 5),
  col = c(3, 2, 1, 3, 2, 4, 2, 1, 3, 4, 2, 1, 5, 3, 2),
  stringsAsFactors = FALSE
)


# PLOT  - grafico de columnas (geom_col)

attach(caba2017.long)
ggplot(caba2017.long, aes(Partido,votos, fill=Partido)) +
  geom_col() + coord_flip()+
  facet_geo(~ comuna, grid = mygrid)+ 
  scale_fill_manual(breaks = c("Carrio", "Filmus", "Lousteau"), 
                                 values=c("#d7e514", "#1e17e8", "#2e8e16"))+
  scale_x_discrete(breaks = NULL)+
  ggtitle("Resultados CABA 2017 (por comuna)") +
  ylab("% Votos") + 
  xlab("")+ 
  labs(fill = "Candidatos")+ 
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(), 
        legend.position="top", 
        axis.title.y = element_text(size = 20), 
        plot.title = element_text(size = 20, face = "bold")) 
  

#GUARDAR ULTIMO PLOT EN working directory
ggsave("cabaGeoFacet.svg", plot = last_plot(), device = svg)



#### COORDINATE FLIP & theme(axis.elements TRUE!)
ggplot(caba2017.long, aes(Partido,votos, fill=Partido)) +
  geom_col() + coord_flip()+
  facet_geo(~ comuna, grid = mygrid)+ 
  scale_fill_manual(breaks = c("Carrio", "Filmus", "Lousteau"), 
                    values=c("#d7e514", "#1e17e8", "#2e8e16"))+
  scale_x_discrete(breaks = NULL)+
  ggtitle("Resultados CABA 2017 (por comuna)") +
  ylab("% Votos") + 
  xlab("")+ 
  labs(fill = "Candidatos")+ 
  theme(legend.position="top", 
        axis.title.y = element_text(size = 20), 
        plot.title = element_text(size = 20, face = "bold")) 
