# `geofacet_ARG` 

Templates para creación de gráficos de data *georeferenciada* (`geofacet`). 
--------------------
_"El paquete geofacet amplía `ggplot2` de una manera que facilita la creación de visualizaciones geográficamente facetadas en `R`. Para hacer `geofacet` se toman datos que representan diferentes entidades geográficas y se aplica un método de visualización para cada entidad, con el conjunto resultante de visualizaciones establecidas en una cuadrícula que imita la topología geográfica original lo más cerca posible."_ (Ryan Hafen)

Este repositorio incluye una serie de ejemplos de cómo se puede utilizar `geofacet` para la creación de grillas de gráficos con diseños que replican mapas de entidades de Argentina. Una buena explicación de cuáles son las ventajas de esta técnica está disponible en el post del [blog del autor](http://ryanhafen.com/blog/geofacet) del paquete.

## TEMPLATES Y EJEMPLOS

En el repositorio se puede encontrar el código de `R` con un mapa-grilla de `Argentina` y sus provincias y la división política (en general departamentos) de:
* `CABA` (comunas)
* `CATAMARCA`
* `CHACO`
* `CÓRDOBA`
* `FORMOSA`
* `JUJUY`
* `LA RIOJA`
* `MENDOZA`
* `NEUQUÉN`
* `PROVINCIA DE BUENOS AIRES` (secciones electorales)
* `SALTA`
* `SANTA FE`
* `SANTIAGO DEL ESTERO`
* `SAN JUAN`
* `SAN LUIS`
* `TUCUMÁN`

Cargamos además ejemplos concretos de aplicaciones de las grillas para los casos de [`ARGENTINA`](https://github.com/TuQmano/geofacet_ARG/tree/master/ARGENTINA) (provincias); [`CABA`](https://github.com/TuQmano/geofacet_ARG/tree/master/CABA) (comunas); departamentos de [`CÓRDOBA`](https://github.com/TuQmano/geofacet_ARG/tree/master/CORDOBA) y  [`TUCUMÁN`](https://github.com/TuQmano/geofacet_ARG/tree/master/TUCUMAN); secciones electorales de la [`PROVINCIA DE BUENOS AIRES`](https://github.com/TuQmano/geofacet_ARG/tree/master/PBA), y un ejemplo adicional con resultados electorales nacionales de [`URUGUAY`](https://github.com/TuQmano/geofacet_ARG/tree/master/zExtra_URUGUAY) (por departamento).
