
# Importer le fichier texte
fichier <- readLines(
  "data/auto2004_original_ligne3.txt",
  encoding = "UTF-8",
  warn = FALSE
)

# Afficher les 10 premières lignes
head(fichier, 10)

# Afficher les 10 premières lignes avec les numéros
cat(paste(1:10, fichier[1:10], sep = " : "), sep = "\n")


donnees <- read.table(
  "data/auto2004_original_ligne3.txt",
  skip = 1,
  header = TRUE,
  sep = ";",
  fileEncoding = "UTF-8"
)

