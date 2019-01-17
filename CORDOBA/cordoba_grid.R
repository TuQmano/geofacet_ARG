# GRILLA CORDOBA 
  # code es el correspondiente a coddepto de bases de datos de resultados electorales de INDRA. 

cordoba.grid <-data.frame( name = c("Sobremonte", "Rio Seco", "Ischilin", "Cruz del Eje", "Totoral",
                             "Tulumba", "S.Justo", "Minas", "Punilla", "Colon", "Rio Primero",
                             "Pocho", "S.Alberto", "Capital", "Rio Segundo", "Gral.S.Martin", 
                             "S.Maria", "S.Javier", "Calamuchita", "Union", "M.Juarez",
                             "Rio Cuarto", "Tercero Arriba", "J.Celman", 
                             "Gral.Roca", "R.S.Pena"), 
            code = c("022", "015", "007", "004", "024",
                             "025", "020", "010", "012", "003", "014",
                             "011", "018", "001", "016", "006", 
                             "021", "019", "002", "026", "009",
                             "013", "023", "008", 
                             "005", "017"),   
            row = c(1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 
                    4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 7, 7, 8), 
            col = c(3, 4, 2, 1, 3, 4, 5, 1, 2, 3, 4,
                    1, 2, 3, 4, 4, 3, 1, 2, 5, 6, 2, 3, 3, 2, 3), 
            stringsAsFactors = TRUE)
            
