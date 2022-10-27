library(gifski)
library(raster)
library(readr)

DF <- read_csv("O:/Nat_Ecoinformatics/C_Write/_User/DerekCorcoran_au687614/Prioritization/Sols.csv")



gifski::save_gif(expr = for(i in 1:nrow(DF)){
  Temp <- raster(paste0("O:/Nat_Ecoinformatics/C_Write/_User/DerekCorcoran_au687614/Prioritization/MaxUtilitySols/Solution_", DF$Budget[3], ".tif"))
  print(plot(Temp, colNA = "black", main = paste0(round(DF$PropArea[3]*100), "%")))
})


