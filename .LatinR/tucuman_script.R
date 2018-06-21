
###################################################
###################################################
#     
#     
#     Geofaceting Argentina
#     
#     Created by @TuQmano
#     March 21st, 2018
#     www.github.com/tuqmano
#     www.tuqmano.com
#     
#     

###################################################
###################################################

rm(list=ls())  # DELETE R MEMORY
setwd("~/Dropbox/R/geofacet/TUCUMAN") # SET WORKING DIRECTORY

###################### Needed Packages ###################
library(magrittr)
library(tidyverse)
library(readxl)
library(dplyr)
library(plyr)
library(geofacet) # <--- geofacet


###################################################

tuc.historico <- read_excel("LupuXDepto.xlsx")  # dataset import
      # Source: Noam Lupu´s  "Argentina Electoral Dataset" -> http://www.noamlupu.com/data.html


# variable selection (dplyr) ("departamento", "año", "votos totales", "votos ucr" y "votos pj")
tuc.historico <- select(tuc.historico, department, year, total, ucr, pj)


####### TUCUMAN´s departments "grid.map"  ->  to fit grids as if they where a map
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
 

## RECODE DEPARTMENTS NAMES IN DATA TO FIT GRID

tuc.historico$department[which(tuc.historico$department == "Tafi")] <- "T.Viejo"
tuc.historico$department[which(tuc.historico$department == "Yerba Buena")] <- "Y.Buena"
tuc.historico$department[which(tuc.historico$department == "Tafi del Valle")] <- "T.del Valle"
tuc.historico$department[which(tuc.historico$department == "Tafi Viejo")] <- "T.Viejo"


### new vars - vote share (%) for both parties (PJ y UCR)
tuc.historico$ucr.pc <- (tuc.historico$ucr/tuc.historico$total)*100
tuc.historico$pj.pc <- (tuc.historico$pj/tuc.historico$total)*100

##### data.frame:   wide -> long 
tuc.historico.long <- gather(tuc.historico, party, votos, ucr.pc, pj.pc)



#### convert variable type 
tuc.historico$department <- as.factor(tuc.historico$department)

tuc.historico$ucr.pc <- as.factor(tuc.historico$ucr.pc)
tuc.historico$pj.pc <-  as.factor(tuc.historico$pj.pc)


# Final Data Frame
# variables selection
tuc.electoral <- select(tuc.historico.long, department, year, party, votos) 


#recode values in "Partidos" variable (col)
tuc.electoral$party[which(tuc.electoral$party == "ucr.pc")] <- "UCR" 
tuc.electoral$party[which(tuc.electoral$party == "pj.pc")] <- "PJ"


# rename de variables
colnames(tuc.electoral) <- c("depto", "year", "party", "votes") # rename de variables


tuc.electoral$votes[is.na(tuc.electoral$votes)] <- 0 # recode NA´s = 0


# PLOT 

attach(tuc.electoral)
ggplot(tuc.electoral)+
  geom_line(aes(year, votes, group=party, colour=party)) +
  facet_geo(~ depto, grid = mygrid)+
  ylab("%") + 
  scale_colour_manual(name="Party Labels", breaks = c("PJ", "UCR"), 
                    values=c("#0B25E1", "#EF1111")) + 
  scale_x_continuous(name = "Year", breaks = c(1916, 1936, 1956, 1976,1996), 
                     labels = function(x) paste0("'", substr(x, 3, 4))) + 
  theme_bw() +
  theme(legend.position="top", 
        axis.title.y = element_text(size = 20), 
        plot.title = element_text(size = 20, face = "bold")) +
ggsave("TUCGeoFacet.png", plot = last_plot(), width = 14, height = 15, units = "cm")



