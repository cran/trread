## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(dplyr)
library(trread)

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
routes_df_frequencies <- nyc$routes_df %>% 
  inner_join(nyc$routes_frequency_df, by = "route_id") %>% 
          select(route_long_name,
                 median_headways, 
                 mean_headways, 
                 st_dev_headways, 
                 stop_count)
head(routes_df_frequencies)

## ------------------------------------------------------------------------
head(sample_n(nyc$calendar_df,10))

## ------------------------------------------------------------------------
select_service_id <- filter(nyc$calendar_df,monday==1) %>% pull(service_id)
select_route_id <- sample_n(nyc$routes_df,1) %>% pull(route_id)

## ------------------------------------------------------------------------
some_trips <- nyc$trips_df %>%
  filter(route_id %in% select_route_id & service_id %in% select_service_id)

some_stop_times <- nyc$stop_times_df %>% 
  filter(trip_id %in% some_trips$trip_id) 

some_stops <- nyc$stops_df %>%
  filter(stop_id %in% some_stop_times$stop_id)

