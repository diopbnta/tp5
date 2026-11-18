

library(tidyverse)

library(readxl)
# =====================================================
# 1. Pluie 2025 : passer du format large au format long
# =====================================================



# Importer la feuille 2025 du fichier Excel
pluie25 <- read_excel(
  "data/pluie_mensuelle.xlsx",
  sheet = "2025",
  skip = 3
)

pluie25_long <- pluie25 %>%
  pivot_longer(
    cols = -station,
    names_to = "mois",
    values_to = "pluie"
  )

# Afficher le résultat
print(pluie25_long)


# =====================================================
# 2. Cumul annuel et mois le plus pluvieux par station
# =====================================================

bilan_pluie <- pluie25_long %>%
  group_by(station) %>%
  summarise(
    cumul_annuel = sum(pluie, na.rm = TRUE),
    mois_plus_pluvieux = mois[which.max(pluie)],
    pluie_max = max(pluie, na.rm = TRUE),
    .groups = "drop"
  )

print(bilan_pluie)


# =====================================================
# 3. Note moyenne de chaque vin par étape
#    Puis passage au format large
# =====================================================
vins <- read_excel("data/wines.xlsx")
vins_long <-vins|>
  select(Wines,rest1:tasting9) |>
  pivot_longer(-Wines,
               names_to = c("etape","numero"),
               names_pattern = "([a-z]+)(\\d+)",
               values_to = "note")

head(vins_long)


vins_moyennes <- vins_long |>
  group_by(Wines, etape) |>
  summarise(
    note_moyenne = mean(note, na.rm = TRUE),
    .groups = "drop"
  )

# Passer au format large
vins_large <- vins_moyennes |>
  pivot_wider(
    names_from = etape,
    values_from = note_moyenne
  )

print(vins_large)

# =====================================================
# 4. Vin ayant la meilleure note moyenne à tasting
# =====================================================

meilleur_vin <- vins_moyennes %>%
  filter(etape == "tasting") %>%
  slice_max(note_moyenne, n = 1, with_ties = TRUE)

print(meilleur_vin)


