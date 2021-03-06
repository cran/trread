## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(trread)
library(dplyr)

## ---- eval=FALSE---------------------------------------------------------
#  install.packages('trread')
#  
#  # For the development version from Github:
#  # install.packages("devtools")
#  devtools::install_github("r-transit/trread")

## ------------------------------------------------------------------------
# Read in GTFS feed
# here we use a feed included in the package, but note that you can read directly from the New York City Metropolitan Transit Authority using the following URL:
# nyc <- read_gtfs("http://web.mta.info/developers/data/nyct/subway/google_transit.zip")

local_gtfs_path <- system.file("extdata", 
                               "google_transit_nyc_subway.zip", 
                               package = "trread")
nyc <- read_gtfs(local_gtfs_path, 
                 local=TRUE,
                 frequency=TRUE)

## ------------------------------------------------------------------------
head(nyc$routes_frequency_df)

## ------------------------------------------------------------------------
head(nyc$stops_frequency_df)

