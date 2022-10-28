########################### Merge Arterdk and IUCNredlist species names #################################################


library(taxize)
library(dplyr)
library(rgbif)
library(readxl)





Data1 <- read_excel("2022-09-21.xlsx") %>%
  tibble::rowid_to_column() %>% 
  janitor::clean_names()



#Data 1 ----

# go through each name and check if it has a match in the 11th name database and a score of how well it matches. That name is the in the matched_name2 column
Resolve1 <- list()

for(i in 1:nrow(Data1)){
  try({
    Resolve1[[i]] <- taxize::gnr_resolve(Data1$videnskabeligt_navn[i],
                                         data_source_ids = "11", canonical = TRUE, best_match_only = T)
    if((i %% 500) == 0){
      saveRDS(Resolve1, "Resolve1.rds")
    }
    if((i %% 100) == 0){
      print(paste(i, "of", nrow(Data1), "Ready!", Sys.time()))
    }
    gc()
  })
  
}

Resolve1 <- Resolve1 %>% purrr::reduce(bind_rows)

#Resolve1 <- Resolve1 %>% dplyr::full_join(Data1) # convert the result from list to dataframe


DF1 <- rgbif::name_backbone_checklist(Resolve1$matched_name2) #Lookup names in the GBIF backbone taxonomy in a checklist.
# It gives you the code for the species name from the GBIF database and additional information such as whether the name is a real species or a synonym



DF1 <- DF1 %>% distinct()

saveRDS(DF1, "DF1.rds")
