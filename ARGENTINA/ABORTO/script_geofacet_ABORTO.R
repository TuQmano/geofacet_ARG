#######################################
#       
#       geofacet ARGENTINA - ABORTO
#
#       Creado por @TuQmano - www.github.com/tuqmano  
#       22 de mayo de 2018
#######################################

# PAQUETES NECESARIOS
library(tidyverse)
library(geofacet)


# IMPORTAR BASE DE DATOS
# Recopilación de EconomíaFeminita 
#   -> http://economiafeminita.com/aborto-legal-como-votarian-nuestros-representantes/


DipAborto <- read_csv("~/Desktop/Aborto_geofacet/AbortoLegal_ Contando Porotos - Diputados.csv",
                      na = "NA", trim_ws = FALSE)


DipAborto <- select(DipAborto, c(9,14)) # SELECCIONAR VARIABLES (Distrito y posición)

colnames(DipAborto) <- c("dist", "pos") # renombrar variables


# Transformar clase de variable (de "caractéres" a "factor")
DipAborto$dist <- as.factor(DipAborto$dist) # 24 niveles (uno x distrito)
DipAborto$pos <- as.factor(DipAborto$pos) # 4 niveles (Favor, Contra, S/Confirmar y abstención)

# CREAR UN df a partir de una tabla de frecuencia de las posiciones
tablaPos <- as.data.frame(table(DipAborto$pos)) 

################  MISMO QUE ANTERIOR PERO VERSION TIDY
DipAborto$n.pos <- 1
DipAborto %>% 
  group_by(pos) %>%
  summarize(n.pos=sum(n.pos)) %>%
  data.frame()
###


tablaPos$pct <- (tablaPos$Freq/257)*100 # Nueva variable con el porcentual de cada una de las posiciones
colnames(tablaPos) <- c("Posición", "Frecuencia", "Porcentaje") # Renombrar variables

# TABLA PARA CONTAR CANTIDAD DE DIPUTADOS POR PROVINCIA
Dip.Prov <- as.data.frame(table(DipAborto$dist)) 
colnames(Dip.Prov) <- c("dist", "nDip")   # RENOMBRAR

DipAbortoProv <- DipAborto %>%  
  group_by(pos, dist) %>%
  summarize(n.pos=sum(n.pos)) %>%
  data.frame()


DipAbortoProv <- merge(DipAbortoProv, Dip.Prov) # COMBINAR BASES DE DATOS


DipAbortoProv$pct <- DipAbortoProv$n.pos/DipAbortoProv$nDip*100  # PORCENTAJE DE POSICION POR PROVINCIA
aborto <- DipAbortoProv  # DUBLICAR BASE DE DATOS CON NUEVO NOMBRE 
colnames(aborto) <- c("Distrito", "Posición","Diputados", "Total", "Porcentaje") # CAMBIAR NOMBRE A LAS VARIABLES

##
### PLOT 1#################################
##




                          # BARRAS CON NUMEROS AGREGADOS SOBRE POSICION DE LOS  257 DIPUTADOS
ggplot(tablaPos) + 
  geom_col(aes(Posición, Porcentaje, fill= Posición)) +
  labs(title = "Posición de miembros de la Cámara de Diputados de la Nación respecto al aborto",
       caption = "Nota: Creado por @TuQmano. Los datos utilizados fueron recopilados por @EcoFeminita") +
  theme_bw()

####
####   PLOT 2 #######################################
####



### GRILLA PARA MAPA geofacet

argentina_grid2 <-  data.frame(
  col = c(1, 3, 5, 1, 2, 1, 3, 4, 2, 2, 4, 1, 3, 3, 4, 1, 2, 2, 1, 1, 2, 1, 1, 1),
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 7, 7, 8, 9, 10),
  code = c("AR-Y", "AR-P", "AR-N", "AR-A", "AR-T", "AR-K", "AR-H", "AR-W", "AR-G", "AR-X", "AR-E", "AR-F", "AR-S", "AR-B", "AR-C", "AR-J", "AR-D", "AR-L", "AR-M", "AR-Q", "AR-R", "AR-U", "AR-Z", "AR-V"),
  name_es = c("Jujuy", "Formosa", "Misiones", "Salta", "Tucumán", "Catamarca",
              "Chaco", "Corrientes", "S.del.Estero", "Córdoba", "Entre.Ríos", "La.Rioja", 
              "Santa.Fe", "Buenos.Aires", "C.A.B.A.", "San.Juan", "San.Luis", "La.Pampa", 
              "Mendoza", "Neuquén", "Río.Negro", "Chubut", "Santa.Cruz", "T.del.Fuego"),
  stringsAsFactors = FALSE
)


# levels(DipAborto$dist) Chequear compatibilidad de variable ID de geografía (Sacar # para ejecutar)

# RNNOMBRAR DISTRITOS SEGUN NOMBRES DE GRILLAS
aborto$Distrito <- as.character(aborto$Distrito)
aborto$Distrito[which(aborto$Distrito == "Buenos Aires")] <- "Buenos.Aires"
aborto$Distrito[which(aborto$Distrito == "Ciudad Autónoma de Buenos Aires")] <- "C.A.B.A."
aborto$Distrito[which(aborto$Distrito == "Entre Ríos")] <- "Entre.Ríos"
aborto$Distrito[which(aborto$Distrito == "La Pampa")] <- "La.Pampa"
aborto$Distrito[which(aborto$Distrito == "La Rioja")] <- "La.Rioja"
aborto$Distrito[which(aborto$Distrito == "Río Negro")] <- "Río.Negro"
aborto$Distrito[which(aborto$Distrito == "San Juan")] <- "San.Juan"
aborto$Distrito[which(aborto$Distrito == "San Luis")] <- "San.Luis"
aborto$Distrito[which(aborto$Distrito == "Santa Cruz")] <- "Santa.Cruz"
aborto$Distrito[which(aborto$Distrito == "Santa Fe")] <- "Santa.Fe"
aborto$Distrito[which(aborto$Distrito == "Santiago del Estero")] <- "S.del.Estero"
aborto$Distrito[which(aborto$Distrito == "Tierra del Fuego")] <- "T.del.Fuego"
aborto$Distrito <- as.factor(aborto$Distrito)


## PLOTEO  geofacet de columnas. Porcentaje de diputados ... del aborto
ggplot(aborto, aes("", Porcentaje, fill = Posición)) + 
  geom_col(alpha = 0.8, width = 1) +
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7", "#9933ff")) +
  facet_geo(~ Distrito, grid = argentina_grid2) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(title = "Posición respecto al aborto",
       caption = "@TuQmano con datos de @EcoFeminita",
       x = NULL, 
       y = "Porcentaje de Diputados") +
  theme(axis.title.x = element_blank(),
           axis.text.x = element_blank(),
           axis.ticks.x = element_blank(),
           strip.text.x = element_text(size = 6))
