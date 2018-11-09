# title: "NEON Tutorial: Using the API to request data"
# author: "Wynne Moss"
#' date: "November 8, 2018"
#' output: md_document

#' neonscience.org/neon-api-usage
#' API uses url to get the data 
####' Getting started----------------------####
#' install.packages("httr")
#' install.packages("jsonlite")
#' install.packages("downloader")
library(httr)

library(jsonlite) # data are in JSON format and this library will parse it

library(downloader)

#' (If this is buggy, download NEONutilities packages too)



####' Bird data example-----------####
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10003.001") # up to V0 is the base URL
#' product id for bird data
str(req)
#' all this says is that the data exist
#' use JSON lite package to pull out the actual data
req.content <- content(req, as = "parsed")
#' req.content # big old nested list
#' available sites and months for the product we queried

available <- fromJSON(content(req, as = "text"))
available
# same info but in a little more readable form
available$data$siteCodes
available$data$siteCodes[,3]

#' third columns is the urls of SPECIFIC data sites/months

bird.urls <- unlist(available$data$siteCodes$availableDataUrls)
bird.urls

bird <- GET(bird.urls[grep("WOOD/2015-07", bird.urls)]) #' just get the URL with this
#' GET will only work with one URL
str(bird) #' another request response
bird.files <- fromJSON(content(bird, as = "text"))
str(bird.files)
bird.files$data
#' all the files available for birds at this site in this month
#' order is not predictable!
#' basic and expanded file for each type of data
#' lots of different data types
bird.count <- read.delim(bird.files$data$files$url[intersect(
      grep("countdata", bird.files$data$files$name),
      grep("basic", bird.files$data$files$name))], sep = ",") #' want to get both BASIC and COUNT (only one file)

head(bird.count)

####' taxon endpoint-------------------####
loon.req <- GET("http://data.neonscience.org/api/v0/taxonomy/?family=Gaviidae") #'query to search
loon.req
loon.list <- fromJSON(content(loon.req, as = "text"))
loon.list




