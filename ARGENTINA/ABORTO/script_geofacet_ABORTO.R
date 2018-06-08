#
#       
#       geofacet ARGENTINA - ABORTO
#
#       Creado por @TuQmano - www.github.com/tuqmano  
#       Creado el 22 de mayo de 2018
#       Úlrima modificación: 7 de junio de 2018 (con datos actualizados hasta el momento)
#



# PAQUETES NECESARIOS
library(tidyverse)
library(geofacet)
library(ggthemes)

# IMPORTAR BASE DE DATOS
# Recopilación de EconomíaFeminita 
#   -> http://economiafeminita.com/aborto-legal-como-votarian-nuestros-representantes/


dataDipu <- "~/Desktop/Aborto_geofacet/data/AbortoLegal_ Contando Porotos - Diputados7jun.csv"
dataSen <- "~/Desktop/Aborto_geofacet/data/AbortoLegal_ Contando Porotos - Senadores 7jun.csv"
plots <- "~/Desktop/Aborto_geofacet/plots"


######## DIPUTADOS ########



DipAborto <- read_csv(dataDipu, na = "NA", trim_ws = FALSE)


DipAborto <- select(DipAborto, c(9,16)) # SELECCIONAR VARIABLES (Distrito y posición)

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
  geom_col(aes(Posición, Porcentaje, fill= Posición))+
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7", "#9933ff"))+
  labs(title = " % Diputados respecto al #AbortoLegalYa",
       subtitle = "(7 de junio)",
       caption = " @TuQmano con datos de @EcoFeminita") +
  theme_fivethirtyeight() +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) + 
  ggsave("posDip.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")

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

# RENNOMBRAR DISTRITOS SEGUN NOMBRES DE GRILLAS
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
  labs(title = "Diputados respecto a #AbortoLegalYa (7 de junio)",
       caption = "@TuQmano con datos de @EcoFeminita",
       x = NULL, 
       y = "Porcentaje ") +
  theme(axis.title.x = element_blank(),
           axis.text.x = element_blank(),
           axis.ticks.x = element_blank(),
           strip.text.x = element_text(size = 8)) + 
  ggsave("GeoDip.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")




#
#
#
######     SENADO      ####
#
#
#

SenAborto <- read_csv(dataSen)


SenAborto.provincia <- select(SenAborto, c(10,19)) # SELECCIONAR VARIABLES (Distrito y posición)

colnames(SenAborto.provincia) <- c("dist", "pos") # renombrar variables

# Transformar clase de variable (de "caractéres" a "factor")
SenAborto.provincia$dist <- as.factor(SenAborto.provincia$dist) # 24 niveles (uno x distrito)  #levels(partido.provincia.sen$dist)
SenAborto.provincia$pos <- as.factor(SenAborto.provincia$pos) # 3 niveles (Favor, Contra, S/Confirmar)


# CREAR UN df a partir de una tabla de frecuencia de las posiciones
tablaPosSEN <- as.data.frame(table(SenAborto.provincia$pos)) 

################  MISMO QUE ANTERIOR PERO VERSION TIDY
SenAborto.provincia$n.pos <- 1

SenAborto.provincia %>% 
  group_by(pos) %>%
  summarize(n.pos=sum(n.pos)) %>%
  data.frame()
###


tablaPosSEN$pct <- (tablaPosSEN$Freq/72)*100 # Nueva variable con el porcentual de cada una de las posiciones
colnames(tablaPosSEN) <- c("Posición", "Frecuencia", "Porcentaje") # Renombrar variables


##
### PLOT 3 #################################
##

# BARRAS CON NUMEROS AGREGADOS SOBRE POSICION DE LOS  72 SENADORES
ggplot(tablaPosSEN) + 
  geom_col(aes(Posición, Porcentaje, fill= Posición))+
  ylim(0,50) +
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7"))+
  labs(title = "% Senadores respecto al #AbortoLegalYa",
       subtitle = "(7 de junio)",
       caption = "@TuQmano con datos de @EcoFeminita") +
  theme_fivethirtyeight() +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) + 
  ggsave("posSen.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")




# TABLA PARA CONTAR CANTIDAD DE SENADORES POR PROVINCIA
Sen.Prov <- as.data.frame(table(SenAborto.provincia$dist))  # NO TIENE MUCHO SENTIDO. SON 3 FIJOS POR PROVINCIA. LO HACEMOS IGUAL
colnames(Sen.Prov) <- c("dist", "nSen")   # RENOMBRAR

SenAborto.provincia <- SenAborto.provincia %>%  
  group_by(pos, dist) %>%
  summarize(n.pos=sum(n.pos)) %>%
  data.frame()


SenAborto.provincia <- merge(SenAborto.provincia, Sen.Prov) # COMBINAR BASES DE DATOS


SenAborto.provincia$pct <- SenAborto.provincia$n.pos/SenAborto.provincia$nSen*100  # PORCENTAJE DE POSICION POR PROVINCIA

colnames(SenAborto.provincia) <- c("Distrito", "Posición","Senadores", "Total", "Porcentaje") # CAMBIAR NOMBRE A LAS VARIABLES




# RENOMBRAR DISTRITOS SEGUN NOMBRES DE GRILLAS
SenAborto.provincia$Distrito <- as.character(SenAborto.provincia$Distrito)
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Buenos Aires")] <- "Buenos.Aires"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Ciudad Autónoma de Buenos Aires")] <- "C.A.B.A."
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Entre Ríos")] <- "Entre.Ríos"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "La Pampa")] <- "La.Pampa"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "La Rioja")] <- "La.Rioja"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Río Negro")] <- "Río.Negro"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "San Juan")] <- "San.Juan"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "San Luis")] <- "San.Luis"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Santa Cruz")] <- "Santa.Cruz"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Santa Fe")] <- "Santa.Fe"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Santiago del Estero")] <- "S.del.Estero"
SenAborto.provincia$Distrito[which(SenAborto.provincia$Distrito == "Tierra del Fuego")] <- "T.del.Fuego"
SenAborto.provincia$Distrito <- as.factor(SenAborto.provincia$Distrito)



### PLOT 4 ####
## PLOTEO  geofacet de columnas. Porcentaje de senadores ... del aborto 
ggplot(SenAborto.provincia, aes("", Porcentaje, fill = Posición)) + 
  geom_col(alpha = 0.8, width = 1) +
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7")) +
  facet_geo(~ Distrito, grid = argentina_grid2) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(title = "Senadores respecto a #AbortoLegalYa (7 de junio)",
       caption = "@TuQmano con datos de @EcoFeminita",
       x = NULL, 
       y = "Porcentaje de Senadores") +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        strip.text.x = element_text(size = 8)) + 
  ggsave("geoSen.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")


#             
###
###
##              
#
###########        ANALISIS ABORTO POR ESPACIO POLÍTICO ####
#
##
###


### DIPUTADOS - PARTIDO ####

partido <- read_csv(dataDipu, trim_ws = FALSE)
partido <-table(partido$Fuerza,partido$PosicionFrenteAlAborto) # crea tabla de frecuencia de dos variables categoricas
partido <- as.data.frame.matrix(partido) # Transformar objeto  de la tabla en una matriz - data frame
partido <- rownames_to_column(partido) # Crear variable con nombre de filas


attach(partido)
partido$total <- `A Favor`+`En Contra`+`Se Abstiene`+`No confirmado`
detach(partido)

partido$pct <- round((partido$total/sum(partido$total))*100, digits = 1)
partido$favor.pct <- round((partido$`A Favor`/sum(partido$total))*100, digits = 1)
partido$contra.pct <- round((partido$`En Contra`/sum(partido$total))*100, digits = 1)
partido$NOconfirmado.pct <- round((partido$`No confirmado`/sum(partido$total))*100, digits = 1)
partido$abstiene.pct <- round((partido$`Se Abstiene`/sum(partido$total))*100, digits = 1)

attach(partido)
partido <- gather(partido, key = "posición", value = "votos", c(2:5))
partido <- select(partido, c(1, 8, 9))
partido$posición <- as.factor(partido$posición)

#### PLOT 5 ####  

# FACET WRAP (PARTIDO POLITICO)
ggplot(partido) +
  geom_col(aes(posición, votos, fill = posición))+
  scale_fill_manual(values = c("#59a14f", "#e15759", "#808080", "#808080")) + 
  facet_wrap(~ toupper(rowname)) +
  labs(title = "Diputados frente al #AbortoLegalYa",
       subtitle = "(7 de junio)", 
       x="",
       y="", 
      fill = "Posición", 
      caption = "@TuQmano con datos de @ecofeminita") +
  theme_fivethirtyeight() +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) + 
  ggsave("posDipPart.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")


detach(partido)




### PLOT 6 ####
#### POR PARTIDO Y PROVINCIA

partido.provincia <- read_csv(dataDipu, na = "NA", trim_ws = FALSE)

partido.provincia <- select(partido.provincia, c(8, 9, 16))
colnames(partido.provincia) <-  c("Fuerza", "Distrito", "Posición")

attach(partido.provincia)
partido.provincia$Fuerza[which(partido.provincia$Fuerza == "izq")] <- "otros"


# RENOMBRAR DISTRITOS SEGUN NOMBRES DE GRILLAS
partido.provincia$Distrito <- as.character(partido.provincia$Distrito)
partido.provincia$Distrito[which(partido.provincia$Distrito == "Buenos Aires")] <- "Buenos.Aires"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Ciudad Autónoma de Buenos Aires")] <- "C.A.B.A."
partido.provincia$Distrito[which(partido.provincia$Distrito == "Entre Ríos")] <- "Entre.Ríos"
partido.provincia$Distrito[which(partido.provincia$Distrito == "La Pampa")] <- "La.Pampa"
partido.provincia$Distrito[which(partido.provincia$Distrito == "La Rioja")] <- "La.Rioja"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Río Negro")] <- "Río.Negro"
partido.provincia$Distrito[which(partido.provincia$Distrito == "San Juan")] <- "San.Juan"
partido.provincia$Distrito[which(partido.provincia$Distrito == "San Luis")] <- "San.Luis"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Santa Cruz")] <- "Santa.Cruz"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Santa Fe")] <- "Santa.Fe"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Santiago del Estero")] <- "S.del.Estero"
partido.provincia$Distrito[which(partido.provincia$Distrito == "Tierra del Fuego")] <- "T.del.Fuego"
detach(partido.provincia)

# geofacet  DIPUTADO - PARTIDO
ggplot(partido.provincia) +
  geom_bar(aes(Fuerza, fill = Posición)) +
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7", "#9933ff"))+ 
  facet_geo(~Distrito, grid = argentina_grid2) + 
  coord_flip() +
  labs(x="", y="") + labs(title = "Diputados frente al #AbortoLegalYa",
                          subtitle = "(7 de junio)", 
                         x="",
                         y="", 
                         fill = "Posición", 
                         caption = "@TuQmano con datos de @ecofeminita")  + 
  ggsave("GeoDipPart.png", last_plot(), path = plots, width = 165, height = 200, units = "mm")

  


### SENADORES  - PARTIDO ####

partido.sen <- read_csv(dataSen,na = "NA", trim_ws = FALSE)
partido.sen <-table(partido.sen$orientacion ,partido.sen$PosicionFrenteAlAborto) # crea tabla de frecuencia de dos variables categoricas
partido.sen <- as.data.frame.matrix(partido.sen) # Transformar objeto  de la tabla en una matriz - data frame
partido.sen <- rownames_to_column(partido.sen) # Crear variable con nombre de filas


attach(partido.sen)
partido.sen$total <- `A Favor`+`En Contra`+`No confirmado`


partido.sen <- gather(partido.sen, key = "posición", value = "votos", c(2:4))
# PLOT 7 ####

# FACET WRAP (PARTIDO POLITICO)
ggplot(partido.sen) +
  geom_col(aes(posición, votos, fill = posición))+
  scale_fill_manual(values = c("#59a14f", "#e15759", "#808080")) + 
  facet_wrap(~ toupper(rowname)) +
  labs(title = "Senadores frente al #AbortoLegalYa",
       subtitle = "(7 de junio)",
       x="",
       y="", 
       fill = "Posición de senadores", 
       caption = "@TuQmano con datos de @ecofeminita") +
  theme_fivethirtyeight() +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) + 
  ggsave("posSenPart.png", last_plot(), path = plots, width = 150, height = 200, units = "mm")



detach(partido.sen)



#### PLOT 8####
#### POR PARTIDO Y PROVINCIA

partido.sen.provincia <- read_csv(dataSen, na = "NA", trim_ws = FALSE)

partido.sen.provincia <- select(partido.sen.provincia, c(9,10,19))
colnames(partido.sen.provincia) <-  c("Fuerza", "Distrito", "Posición")


attach(partido.sen.provincia)

# RENOMBRAR DISTRITOS SEGUN NOMBRES DE GRILLAS
partido.sen.provincia$Distrito <- as.character(partido.sen.provincia$Distrito)
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Buenos Aires")] <- "Buenos.Aires"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Ciudad Autónoma de Buenos Aires")] <- "C.A.B.A."
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Entre Ríos")] <- "Entre.Ríos"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "La Pampa")] <- "La.Pampa"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "La Rioja")] <- "La.Rioja"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Río Negro")] <- "Río.Negro"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "San Juan")] <- "San.Juan"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "San Luis")] <- "San.Luis"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Santa Cruz")] <- "Santa.Cruz"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Santa Fe")] <- "Santa.Fe"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Santiago del Estero")] <- "S.del.Estero"
partido.sen.provincia$Distrito[which(partido.sen.provincia$Distrito == "Tierra del Fuego")] <- "T.del.Fuego"
detach(partido.sen.provincia)


ggplot(partido.sen.provincia) +
  geom_bar(aes(Fuerza, fill = Posición)) +
  scale_fill_manual(values = c("#59a14f", "#e15759", "#4e79a7"))+ 
  facet_geo(~Distrito, grid = argentina_grid2) + 
  coord_flip() +
  labs(title = "Senadores frente al #AbortoLegalYa",
       subtitle = "(7 de junio)", 
       x="",
       y="", 
       fill = "Posición de senadores", 
       caption = "@TuQmano con datos de @ecofeminita") +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank()) + 
  ggsave("GeoSenPart.png", last_plot(), path = plots, width = 175, height = 200, units = "mm")



