### Grilla de departamentos de la provincia de Chaco



chaco_grid <- data.frame(
  name = c("General Güemes", "Almirante Brown", "Libertador General San Martín", "9 de Julio",
           "Sargento Cabral", "Quitilipi", "Maipú", "General Belgrano", "Independencia", "Bermejo", 
           "Chacabuco", "General Donovan", "25 de Mayo", "O'Higgins", "1 de Mayo",
           "12 de Octubre", "Libertad", "Comandante Fernández", "Presidencia de la Plaza",
           "Mayor Luis Jorge Fontana", "San Fernando", "Fray Justo Santa María de Oro", "San Lorenzo", "Tapenagá"),
  code = c(025, 024, 008, 019,        #### Codigo de Departamento que utiliza INDRA para resultados electorales (coddepto)
           005, 014, 016, 018, 017, 007,
           020, 004, 015, 012, 002,
           021, 003, 013, 006, 
           011, 001, 023, 010, 009),
  row = c(2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6),
  col = c(2, 1, 4, 2, 5, 4, 3, 3, 4, 7, 2, 6, 5, 3, 7, 2, 6, 4, 5, 3, 6, 2, 4, 5),
  stringsAsFactors = FALSE
)
