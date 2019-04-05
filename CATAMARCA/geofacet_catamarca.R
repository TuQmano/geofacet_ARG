# GeoFacet departamentos de CATAMARCA

catamarca_grid <- data.frame(
  name = c("Antofagasta de la Sierra", "Santa María", "Belén", 
           "Tinogasta", "Andalgalá", "Paclín", "Santa Rosa",
           "Ambato", "Pomán", "El Alto", "Fray Mamerto Esquiú", 
           "Capital", "Ancasti", "Valle Viejo", "Capayán", "La Paz"),
  code = c("014", "016", "013",
          "015", "012", "007", "006",
          "010", "011", "005", "009",
          "001", "004", "008", "002", "003"), 
  row = c(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(1, 3, 2, 1, 3, 5, 6, 4, 3, 6, 5, 4, 6, 5, 4, 7),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(catamarca_grid)
