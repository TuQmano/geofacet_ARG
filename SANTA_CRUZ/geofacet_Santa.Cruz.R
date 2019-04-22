# Grilla Mapa de departamentos de la provincia de Santa Cruz

scruz_grid <- data.frame(
  name = c("Deseado", "Lago Buenos Aires", "Magallanes",
           "Río Chico", "Corpen Aike", "Lago Argentino", "Güer Aike"),
  code = c("001", "002", "003",
           "004", "005", "006", "007"),
  row = c(1, 1, 2, 2, 3, 3, 4),
  col = c(2, 1, 2, 1, 2, 1, 2),
  stringsAsFactors = FALSE
)
#geofacet::grid_preview(scruz_grid)
