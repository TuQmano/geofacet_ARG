# ¿Cual es la posición de los legisladores de Argentina sobre el aborto? 

---

El equipo de [@EconomiaFeminita](https://twitter.com/EcoFeminita/) juntó y puso a disposición una [base de datos](https://docs.google.com/spreadsheets/d/1mOiTT3JIdQPxVLTQ-a3OivQqE15oLvdWMv6I_DpMZak/edit?ts=5a91f1d7#gid=0) para registrar la posición de los legisladores de Argentina (diputados y senadores) respecto el aborto. 

(El registro fue descargado con la actualización de datos hasta el día 22 de mayo de 2018)

El [repositorio](https://github.com/TuQmano/geofacet_ARG/tree/master/ARGENTINA/ABORTO) incluye:
* un script de `R` con el manejo de datos y el código para producir los 6 gráficos. 
* archivos `.csv` con los datos (uno por cámara legislativa)
* archivos `.png`con los gráficos. 



**DIPUTADOS**


![plot1](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot1.png)

El gráfico anterior resume las posiciones (en %) de los 257 diputados nacionales (magnitud variable). La tabla que sigue detalla la frecuencia y los porcentajes. 


Posición | Frecuencia |Porcentaje
--- | --- |---
A Favor | 105 | 40.8
En Contra| 112 |43.5
No confirmado | 37 |14.39
Se Abstiene | 3 | 1.16

Esta es una buena oportunidad para poner a prueba la utilidad del mapa de Argentina en su versión `geofacet`(argentina_grid2). 

El gráfico que sigue es la posición de los diputados por provincia respecto del aborto. 

![plot2](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot2.png)

**SENADORES**

El mismo ejercicio se repitió para la cámara alta (72 senadores; 3 por provincia). 

Posición | Frecuencia |Porcentaje
--- | --- |---
A Favor | 16 | 22.22
En Contra| 27 |37.5
No confirmado | 29 |40.27



![plot3](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot3.png)
![plot4](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot4.png)


---
# POSICIONES PARTIDARIAS

Otra manera de ver los datos es incluyendo la variable partidaria de los legisladores. ¿Cómo se ven estos números si diferenciamos además por el partido al que pertenecen los legisladores?


**DIPUTADOS**
De forma agragada el siguiente es el cuadro para los diputados en el Congreso de la Nación: 

![plot5](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot5.png)

Podemos también hacer el ejercicio de graficar las posiciones partidarias de cada uno de los diputados en función de su provincia de origen. Este es el resultado. 

![plot6](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot6.png)

**SENADORES**

Esta es la situación de las posiciones de los legiladores en la camara alta (Senado) teniendo en cuenta su pertenencia partidaria. 

![plot7](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot7.png)

Y esta sería la respresentación geográfica de la posición de los senadores teniendo en cuenta la provincia de procedencia, además de su pertenencia partidaria. 

![plot8](https://github.com/TuQmano/geofacet_ARG/blob/master/ARGENTINA/ABORTO/plot8.png)


