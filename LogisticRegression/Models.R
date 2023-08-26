#@author: Caroline Gasten

#The present script contains the four functions for the four different Logistic Regression model (LRM) set-ups used as part of the thesis


#Model 1: LRM at administrative unit level with fixed effects for admin unit, 2-year booleans, season
model_1 <- function(data_df, stat){
  #data_df: input dataframe with DI, conflict, county, nr_year and season columns
  #stat: spatial statistic of DI used
  
  #set county, season and nr_year to "categorical" input features
  data_df$county <- as.factor(data_df$county)
  data_df$season <- as.factor(data_df$season)
  data_df$nr_year <- as.factor(data_df$nr_year)
  data_df <<- data_df
  
  #Logistic Regression formula
  form <- paste0("conflict_boolean ~", stat, "+ county + nr_year + season")
  form <- as.formula(form)
  
  #set up LRM
  model <- glm(formula=form, data=data_df, family=binomial(link="logit"))
  
  #cluster standard errors with adjustment for degrees of freedom
  vcov = vcovCR(model, cluster=mapping_df$county, type="CR2")
  coeffs <- coeftest(model, vcov=vcov, df = 2)
  
  return(list("model"=model, "coeffs"=coeffs, "vcov"=vcov))
}

#Model 2: LRM at administrative unit level with fixed effects for admin unit, 2-year booleans, season and interaction with the admin-unit
model_2 <- function(data_df, stat){
  #data_df: input dataframe with DI, conflict, county, nr_year and season columns
  #stat: spatial statistic of DI used
  
  #set county, season and nr_year to "categorical" input features
  data_df$county <- as.factor(data_df$county)
  data_df$year <- as.factor(data_df$year)
  data_df$season <- as.factor(data_df$season)
  data_df$nr_year <- as.factor(data_df$nr_year)
  data_df <<- data_df
  
  #Logistic Regression formula
  form <- paste0("conflict_boolean ~", stat, "* county + nr_year + season")
  form <- as.formula(form)
  
  #set up LRM
  model <- glm(formula=form, data=data_df, family=binomial(link="logit"))
  
  #cluster standard errors with adjustment for degrees of freedom
  vcov = vcovCR(model, cluster=mapping_df$county, type="CR2")
  coeffs <- coeftest(model, vcov=vcov, df = 2)
  
  return(list("model"=model, "coeffs"=coeffs, "vcov"=vcov))
}

#Model 3: LRM at ethnic group level with fixed effects for ethnic group, 2-year booleans, season
model_3 <- function(data_df, stat){
  #data_df: input dataframe with DI, conflict, eth_group, nr_year and season columns
  #stat: spatial statistic of DI used
  
  #set eth_group, season and nr_year to "categorical" input features
  data_df$eth_group <- as.factor(data_df$eth_group)
  data_df$season <- as.factor(data_df$season)
  data_df$nr_year <- as.factor(data_df$nr_year)
  data_df <<- data_df
  
  #Logistic Regression formula
  form <- paste0("conflict_boolean ~", stat, "+ eth_group + nr_year + season")
  form <- as.formula(form)
  
  #set up LRM
  model <- glm(formula=form, data=data_df, family=binomial(link="logit"))
  
  #cluster standard errors with adjustment for degrees of freedom
  vcov = vcovCR(model, cluster=mapping_df$eth_group, type="CR2")
  coeffs <- coeftest(model, vcov=vcov, df=5)
  
  return(list("model"=model, "coeffs"=coeffs, "vcov"=vcov))
}

#Model 4: LRM at ethnic group level with fixed effects for ethnic group, 2-year booleans, season and interaction with ethnic group
model_4 <- function(data_df, stat){
  #data_df: input dataframe with DI, conflict, eth_group, nr_year and season columns
  #stat: spatial statistic of DI used
  
  #set eth_group, season and nr_year to "categorical" input features
  data_df$eth_group <- as.factor(data_df$eth_group)
  data_df$season <- as.factor(data_df$season)
  data_df$nr_year <- as.factor(data_df$nr_year)
  data_df <<- data_df
  
  #Logistic Regression formula
  form <- paste0("conflict_boolean ~", stat, "* eth_group + nr_year + season")
  form <- as.formula(form)
  
  #set up LRM
  model <- glm(formula=form, data=data_df, family=binomial(link="logit"))
  
  #cluster standard errors with adjustment for degrees of freedom
  vcov = vcovCR(model, cluster=mapping_df$eth_group, type="CR2")
  coeffs <- coeftest(model, vcov=vcov, df = 5)
  
  return(list("model"=model, "coeffs"=coeffs, "vcov"=vcov))
}
