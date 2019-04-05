# Grilla Mapa de departamentos de la provincia de Entre Ríos (CODE corresponde al código de INDRA)

grilla_ER <- data.frame(
  name = c("Federación", "Feliciano", "Concordia", "Federal", "La Paz",
           "Colón", "Paraná", "San Salvador", "Villaguay", "Diamante", 
           "Nogoyá", "Tala", "Uruguay", "Gualeguay", "Gualeguaychú", "Victoria", "Islas del Ibicuy"),
  code = c("017", "016", "013", "014", "003",
           "015", "001", "018", "012", "004",
           "006", "008", "009", "007", "010", "005", "011"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(4, 3, 4, 3, 2, 4, 1, 3, 2, 1, 2, 3, 4, 3, 4, 2, 4),
  stringsAsFactors = FALSE
)
