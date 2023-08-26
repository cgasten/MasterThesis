#@author: Caroline Gasten

#The present script prepares dataframes to feed them into the functions for Model 3 and Model 4. The obtained coefficient estimates and variance-covariance matrices are stored.

source("C:/Users/gasten/OneDrive - Stichting Deltares/Documents/03b_RScripts/Models.R")#path to script Models.R

#load packages
require("clubSandwich")
require("lmtest")
require(tidyverse)

#Input and output paths
path_mapping_input <- "C:/Users/gasten/OneDrive - Stichting Deltares/Documents/02_Data/06_Drought_Conflict_Mapping" #path to drought-conflict-mapping
path_statistics_output <- "C:/Users/gasten/OneDrive - Stichting Deltares/Documents/04b_Results" #path to store LRM output


#model configurations to loop through
foci <- c("dry", "wet")
DIs <- c("SPI-1", "SPI-3", "SPI-6", "SPI-12", "SPEI-1", "SPEI-3", "SPEI-6", "SPEI-12")
lags <- c(0, 1, 2, 3, 4, 5, 6, 7)
stats <- c("Mean", "Median", "P25", "P75") #"P10",, "P90"




for (foc in foci){
  for (DI in DIs){
    for (dt in lags){
      for (stat in stats){
        #loading dataframe with conflict and drought data at ethnic group level
        mapping_df <- read.csv(paste0(path_mapping_input, '/', 'eth_', DI, '_', foc, '_lag', dt, '_conflict.csv'))
        mapping_df <- mapping_df[-1]
        
        #create two-year sequences for two-year dummies
        breaks <- seq(min(mapping_df$year), max(mapping_df$year)+1,2)
        mapping_df$nr_year <- cut(mapping_df$year, breaks=breaks) 
        
        #retrieve months from date
        mapping_df$time <- lubridate::ymd(mapping_df$time)
        mapping_df$month <- month(mapping_df$time)
        
        #translate months to wet season and dry season -> see Appendix B in thesis for sources
        mapping_df <- mapping_df %>%
          mutate(season = case_when(
            (mapping_df$month %in% c(3, 4, 5, 6, 11, 12) & mapping_df$eth_group=='Turkana') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 7, 8, 9, 10) & mapping_df$eth_group=='Turkana') ~ "dry season",
            (mapping_df$month %in% c(4, 5, 6, 10, 11) & mapping_df$eth_group=='Borana') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 3, 7, 8, 9, 12) & mapping_df$eth_group=='Borana') ~ "dry season",
            (mapping_df$month %in% c(4, 5, 6, 10, 11) & mapping_df$eth_group=='Dassanetch') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 3, 7, 8, 9, 12) & mapping_df$eth_group=='Dassanetch') ~ "dry season",
            (mapping_df$month %in% c(4, 5, 6, 11, 12) & mapping_df$eth_group=='Gabra') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 3, 7, 8, 9, 10) & mapping_df$eth_group=='Gabra') ~ "dry season",
            (mapping_df$month %in% c(3, 4, 5, 6, 10, 11, 12) & mapping_df$eth_group=='Pokot') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 7, 8, 9) & mapping_df$eth_group=='Pokot') ~ "dry season",
            (mapping_df$month %in% c(4, 5, 6, 7, 8, 9, 10, 11) & mapping_df$eth_group=='Toposa') ~ "wet season",
            (mapping_df$month %in% c(1, 2, 3, 12) & mapping_df$eth_group=='Toposa') ~ "dry season",
          ))
        
        #run Model 3 and Model 4 and store obtained coefficients and variance-covariance matrix 
        m3 <- model_3(mapping_df, stat)
        write.csv(m3$coeffs, file=paste0(path_statistics_output, '/', 'Model3/R_', 'Model3_', DI, '_', foc, '_', stat, '_lag', dt, '_coeffs2years.csv'))
        write.csv(m3$vcov, file=paste0(path_statistics_output, '/', 'Model3/R_', 'Model3_', DI, '_', foc, '_', stat, '_lag', dt, '_vcov2years.csv'))
        
        m4 <- model_4(mapping_df, stat)
        write.csv(m4$coeffs, file=paste0(path_statistics_output, '/', 'Model4/R_', 'Model4_', DI, '_', foc, '_', stat, '_lag', dt, '_coeffs2years.csv'))
        write.csv(m4$vcov, file=paste0(path_statistics_output, '/', 'Model4/R_', 'Model4_', DI, '_', foc, '_', stat, '_lag', dt, '_vcov2years.csv'))
      }
    }
  }
}


