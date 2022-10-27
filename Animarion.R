library(gifski)
library(raster)
library(readr)
library(terra)
library(tidyterra)

DF <- read_csv("O:/Nat_Ecoinformatics/C_Write/_User/DerekCorcoran_au687614/Prioritization/Sols.csv")



gifski::save_gif(expr = for(i in 1:nrow(DF)){
  Temp <- terra::rast(paste0("O:/Nat_Ecoinformatics/C_Write/_User/DerekCorcoran_au687614/Prioritization/MaxUtilitySols/Solution_", DF$Budget[i], ".tif"))
  names(Temp) <- "Solution"
  cls <- data.frame(id=0:1, 
                    Solution=c("non-selected", "Selected"))
  
  levels(Temp) <- cls
  
  
  g <- ggplot() +
    geom_spatraster(data = Temp) +
    scale_fill_viridis_d(na.translate = F) +
    theme_bw() +
    ggtitle(paste0(round(DF$PropArea[i]*100), "%"))
  print(g)
})


