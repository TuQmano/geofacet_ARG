# `geofacet_ARG` 

* Plantillas para  gráficos con data *georeferenciada* /// Templates for graphics with georeferenced data .
--------------------
_"El paquete geofacet amplía `ggplot2` de una manera que facilita la creación de visualizaciones geográficamente facetadas en `R`. Para hacer `geofacet` se toman datos que representan diferentes entidades geográficas y se aplica un método de visualización para cada entidad, con el conjunto resultante de visualizaciones establecidas en una cuadrícula que imita la topología geográfica original lo más cerca posible."_ (Ryan Hafen)

Este repositorio incluye una serie de ejemplos de cómo se puede utilizar `geofacet` para la creación de grillas de gráficos con diseños que replican mapas de entidades de Argentina. Una buena explicación de cuáles son las ventajas de esta técnica está disponible en el post del [blog del autor](http://ryanhafen.com/blog/geofacet) del paquete.

## Plantillas y ejemplos 

En el [repositorio](https://github.com/TuQmano/geofacet_ARG) se puede encontrar el código de `R` con un mapa-grilla de `Argentina` y sus provincias y la división política (en general departamentos) de:
* `CABA` (comunas)
* `CATAMARCA`
* `CHACO`
* `CÓRDOBA`
* `CORRIENTES`
* `ENTRE RÍOS`
* `FORMOSA`
* `JUJUY`
* `LA PAMPA`
* `LA RIOJA`
* `MENDOZA`
* `MISIONES`
* `NEUQUÉN`
* `PROVINCIA DE BUENOS AIRES` (secciones electorales)
* `RÍO NEGRO`
* `SALTA`
* `SAN JUAN`
* `SAN LUIS`
* `SANTA CRUZ`
* `SANTA FE`
* `SANTIAGO DEL ESTERO`
* `TIERRA DEL FUEGO`(y territorio de Antártida Argentina. Sin islas del Atlántico Sur)
* `TUCUMÁN`

Cargamos además ejemplos concretos de aplicaciones de las grillas para los casos de [`ARGENTINA`](https://github.com/TuQmano/geofacet_ARG/tree/master/ARGENTINA) (provincias); [`CABA`](https://github.com/TuQmano/geofacet_ARG/tree/master/CABA) (comunas); departamentos de [`CÓRDOBA`](https://github.com/TuQmano/geofacet_ARG/tree/master/CORDOBA) y  [`TUCUMÁN`](https://github.com/TuQmano/geofacet_ARG/tree/master/TUCUMAN); secciones electorales de la [`PROVINCIA DE BUENOS AIRES`](https://github.com/TuQmano/geofacet_ARG/tree/master/PBA), y un ejemplo adicional con resultados electorales nacionales de [`URUGUAY`](https://github.com/TuQmano/geofacet_ARG/tree/master/zExtra_URUGUAY) (por departamento).


----


_"The geofacet package extends ggplot2 in a way that makes it easy to create geographically faceted visualizations in R. To geofacet is to take data representing different geographic entities and apply a visualization method to the data for each entity, with the resulting set of visualizations being laid out in a grid that mimics the original geographic topology as closely as possible"._ (Ryan Hafen).

This repository includes a series of examples of how `geofacet` can be used to create graphics grids with designs that replicate maps of Argentine entities. A good explanation of what the advantages of this technique are is available in the blog post of the [package author] (http://ryanhafen.com/blog/geofacet).

## TEMPLATES & EXAMPLES
The [repo](https://github.com/TuQmano/geofacet_ARG) includes `R` code with an `Argentina`_map - grid_ of it´s provinces and others with each province political division (`departamentos`in general):

* `CABA` (_comunas_)
* `CATAMARCA`
* `CHACO`
* `CÓRDOBA`
* `CORRIENTES`
* `ENTRE RÍOS`
* `FORMOSA`
* `JUJUY`
* `LA PAMPA`
* `LA RIOJA`
* `MENDOZA`
* `MISIONES`
* `NEUQUÉN`
* `PROVINCIA DE BUENOS AIRES` (electoral districts)
* `RÍO NEGRO`
* `SALTA`
* `SAN JUAN`
* `SAN LUIS`
* `SANTA CRUZ`
* `SANTA FE`
* `SANTIAGO DEL ESTERO`
* `TIERRA DEL FUEGO`(Includes Antarctica Argentina territory & excludes the South Atlantic islands)
* `TUCUMÁN`

We also load concrete examples of applications of the grids for the cases of [`ARGENTINA`](https://github.com/TuQmano/geofacet_ARG/tree/master/ARGENTINA) (provinces); [`CABA`](https://github.com/TuQmano/geofacet_ARG/tree/master/CABA) (comunas); [`CÓRDOBA`] (https://github.com/TuQmano/geofacet_ARG/tree/master/CORDOBA) & [`TUCUMÁN`](https://github.com/TuQmano/geofacet_ARG/tree/master/TUCUMAN) departments; [`PROVINCIA DE BUENOS AIRES`](https://github.com/TuQmano/geofacet_ARG/tree/master/PBA) electoral districts and an additional example with national election results from [`URUGUAY`](https://github.com/TuQmano/geofacet_ARG/tree/master/zExtra_URUGUAY) with departamental totals.
