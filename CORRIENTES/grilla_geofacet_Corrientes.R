# Grilla - mapa de Departamentos de la provincia de Corrientes

mygrid <- data.frame(
  name = c("Capital", "San Cosme", "Itatí", "Berón de Astrada", "Ituzaingó", "Santo Tomé", "San Luis del Palmar", "Empedrado", "General Paz", "San Miguel", "Bella Vista", "Saladas", "Concepción", "Mburucuyá", "General Alvear", "Mercedes", "Lavalle", "San Roque", "San Martín", "Goya", "Paso de los Libres", "Curuzú Cuatiá", "Monte Caseros", "Esquina", "Sauce"),
  code = c("Capital", "San Cosme", "Itatí", "Berón de Astrada", "Ituzaingó", "Santo Tomé", "San Luis del Palmar", "Empedrado", "General Paz", "San Miguel", "Bella Vista", "Saladas", "Concepción", "Mburucuyá", "General Alvear", "Mercedes", "Lavalle", "San Roque", "San Martín", "Goya", "Paso de los Libres", "Curuzú Cuatiá", "Monte Caseros", "Esquina", "Sauce"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6, 6, 6),
  col = c(2, 3, 4, 5, 6, 6, 3, 2, 4, 5, 1, 2, 4, 3, 5, 3, 1, 2, 4, 1, 3, 2, 3, 1, 2),
  stringsAsFactors = FALSE
)
geofacet::gr
