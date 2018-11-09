

```r
# title: "NEON Tutorial: Using the API to request data"
# author: "Wynne Moss"
```

date: "November 8, 2018"
output: md_document
neonscience.org/neon-api-usage
API uses url to get the data 
Getting started----------------------####
install.packages("httr")
install.packages("jsonlite")
install.packages("downloader")


```r
library(httr)

library(jsonlite) # data are in JSON format and this library will parse it

library(downloader)
```

(If this is buggy, download NEONutilities packages too)
Bird data example-----------####


```r
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10003.001") # up to V0 is the base URL
```

product id for bird data


```r
str(req)
```

```
## List of 10
##  $ url        : chr "http://data.neonscience.org/api/v0/products/DP1.10003.001"
##  $ status_code: int 200
##  $ headers    :List of 10
##   ..$ date                       : chr "Fri, 09 Nov 2018 20:08:22 GMT"
##   ..$ server                     : chr "Apache/2.2.15 (Oracle)"
##   ..$ x-content-type-options     : chr "nosniff"
##   ..$ x-frame-options            : chr "SAMEORIGIN"
##   ..$ x-xss-protection           : chr "1"
##   ..$ set-cookie                 : chr "JSESSIONID=DFE4E23BFA720D960127598F3ECF29EE.dmz-portal-web-1; Path=/; HttpOnly"
##   ..$ access-control-allow-origin: chr "*"
##   ..$ connection                 : chr "close"
##   ..$ transfer-encoding          : chr "chunked"
##   ..$ content-type               : chr "application/json;charset=UTF-8"
##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
##  $ all_headers:List of 1
##   ..$ :List of 3
##   .. ..$ status : int 200
##   .. ..$ version: chr "HTTP/1.1"
##   .. ..$ headers:List of 10
##   .. .. ..$ date                       : chr "Fri, 09 Nov 2018 20:08:22 GMT"
##   .. .. ..$ server                     : chr "Apache/2.2.15 (Oracle)"
##   .. .. ..$ x-content-type-options     : chr "nosniff"
##   .. .. ..$ x-frame-options            : chr "SAMEORIGIN"
##   .. .. ..$ x-xss-protection           : chr "1"
##   .. .. ..$ set-cookie                 : chr "JSESSIONID=DFE4E23BFA720D960127598F3ECF29EE.dmz-portal-web-1; Path=/; HttpOnly"
##   .. .. ..$ access-control-allow-origin: chr "*"
##   .. .. ..$ connection                 : chr "close"
##   .. .. ..$ transfer-encoding          : chr "chunked"
##   .. .. ..$ content-type               : chr "application/json;charset=UTF-8"
##   .. .. ..- attr(*, "class")= chr [1:2] "insensitive" "list"
##  $ cookies    :'data.frame':	1 obs. of  7 variables:
##   ..$ domain    : chr "#HttpOnly_data.neonscience.org"
##   ..$ flag      : logi FALSE
##   ..$ path      : chr "/"
##   ..$ secure    : logi FALSE
##   ..$ expiration: POSIXct[1:1], format: NA
##   ..$ name      : chr "JSESSIONID"
##   ..$ value     : chr "DFE4E23BFA720D960127598F3ECF29EE.dmz-portal-web-1"
##  $ content    : raw [1:13697] 7b 22 64 61 ...
##  $ date       : POSIXct[1:1], format: "2018-11-09 20:08:22"
##  $ times      : Named num [1:6] 0 0.0596 0.064 0.0641 0.0721 ...
##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
##  $ request    :List of 7
##   ..$ method    : chr "GET"
##   ..$ url       : chr "http://data.neonscience.org/api/v0/products/DP1.10003.001"
##   ..$ headers   : Named chr "application/json, text/xml, application/xml, */*"
##   .. ..- attr(*, "names")= chr "Accept"
##   ..$ fields    : NULL
##   ..$ options   :List of 2
##   .. ..$ useragent: chr "libcurl/7.43.0 r-curl/3.2 httr/1.3.1"
##   .. ..$ httpget  : logi TRUE
##   ..$ auth_token: NULL
##   ..$ output    : list()
##   .. ..- attr(*, "class")= chr [1:2] "write_memory" "write_function"
##   ..- attr(*, "class")= chr "request"
##  $ handle     :Class 'curl_handle' <externalptr> 
##  - attr(*, "class")= chr "response"
```

all this says is that the data exist
use JSON lite package to pull out the actual data


```r
req.content <- content(req, as = "parsed")
```

req.content # big old nested list
available sites and months for the product we queried


```r
available <- fromJSON(content(req, as = "text"))
available
```

```
## $data
## $data$productCodeLong
## [1] "NEON.DOM.SITE.DP1.10003.001"
## 
## $data$productCode
## [1] "DP1.10003.001"
## 
## $data$productCodePresentation
## [1] "NEON.DP1.10003"
## 
## $data$productName
## [1] "Breeding landbird point counts"
## 
## $data$productDescription
## [1] "Count, distance from observer, and taxonomic identification of breeding landbirds observed during point counts"
## 
## $data$productStatus
## [1] "ACTIVE"
## 
## $data$productCategory
## [1] "Level 1 Data Product"
## 
## $data$productHasExpanded
## [1] TRUE
## 
## $data$productScienceTeamAbbr
## [1] "TOS"
## 
## $data$productScienceTeam
## [1] "Terrestrial Observation System (TOS)"
## 
## $data$productAbstract
## [1] "This data product contains the quality-controlled, native sampling resolution data from NEON's breeding landbird sampling. Breeding landbirds are defined as “smaller birds (usually exclusive of raptors and upland game birds) not usually associated with aquatic habitats” (Ralph et al. 1993). The breeding landbird point counts product provides records of species identification of all individuals observed during the 6-minute count period, as well as metadata which can be used to model detectability, e.g., weather, distances from observers to birds, and detection methods. The NEON point count method is adapted from the Integrated Monitoring in Bird Conservation Regions (IMBCR): Field protocol for spatially-balanced sampling of landbird populations (Hanni et al. 2017; http://bit.ly/2u2ChUB). For additional details, see protocol [NEON.DOC.014041](http://data.neonscience.org/api/v0/documents/NEON.DOC.014041vF): TOS Protocol and Procedure: Breeding Landbird Abundance and Diversity and science design [NEON.DOC.000916](http://data.neonscience.org/api/v0/documents/NEON.DOC.000916vB): TOS Science Design for Breeding Landbird Abundance and Diversity."
## 
## $data$productDesignDescription
## [1] "Depending on the size of the site, sampling for this product occurs either at either randomly distributed individual points or grids of nine points each. At larger sites, point count sampling occurs at five to fifteen 9-point grids, with grid centers collocated with distributed base plot centers (where plant, beetle, and/or soil sampling may also occur), if possible. At smaller sites (i.e., sites that cannot accommodate a minimum of 5 grids) point counts occur at the southwest corner (point 21) of 5-25 distributed base plots. Point counts are conducted once per breeding season at large sites and twice per breeding season at smaller sites. Point counts are six minutes long, with each minute tracked by the observer, following a two-minute settling-in period. All birds are recorded to species and sex, whenever possible, and the distance to each individual or flock is measured with a laser rangefinder, except in the case of flyovers."
## 
## $data$productStudyDescription
## [1] "This sampling occurs at all NEON terrestrial sites."
## 
## $data$productSensor
## NULL
## 
## $data$productRemarks
## [1] "Queries for this data product will return data collected during the date range specified for brd_perpoint and brd_countdata, but will return data from all dates for brd_personnel (quiz scores may occur over time periods which are distinct from when sampling occurs) and brd_references (which apply to a broad range of sampling dates). A record from brd_perPoint should have 6+ child records in brd_countdata, at least one per pointCountMinute. Duplicates or missing data may exist where protocol and/or data entry aberrations have occurred; users should check data carefully for anomalies before joining tables. Taxonomic IDs of species of concern have been 'fuzzed'; see data package readme files for more information."
## 
## $data$themes
## [1] "Organisms, Populations, and Communities"
## 
## $data$changeLogs
## NULL
## 
## $data$specs
##   specId             specNumber
## 1   3656      NEON.DOC.000916vC
## 2   2565 NEON_bird_userGuide_vA
## 3   3729      NEON.DOC.014041vJ
## 
## $data$keywords
##  [1] "birds"                 "diversity"            
##  [3] "taxonomy"              "community composition"
##  [5] "distance sampling"     "avian"                
##  [7] "species composition"   "population"           
##  [9] "vertebrates"           "invasive"             
## [11] "introduced"            "native"               
## [13] "landbirds"             "animals"              
## [15] "Animalia"              "Aves"                 
## [17] "Chordata"              "point counts"         
## 
## $data$siteCodes
##    siteCode                             availableMonths
## 1      ORNL                   2016-05, 2016-06, 2017-05
## 2      UKFS                                     2017-06
## 3      CPER 2013-06, 2015-05, 2016-05, 2017-05, 2017-06
## 4      WOOD                            2015-07, 2017-07
## 5      HEAL                                     2017-06
## 6      TALL                   2015-06, 2016-07, 2017-06
## 7      JERC                            2016-06, 2017-05
## 8      NOGP                                     2017-07
## 9      LAJA                                     2017-05
## 10     OSBS                            2016-05, 2017-05
## 11     DCFS                            2017-06, 2017-07
## 12     KONZ                                     2017-06
## 13     DEJU                                     2017-06
## 14     LENO                                     2017-06
## 15     RMNP                            2017-06, 2017-07
## 16     HARV          2015-05, 2015-06, 2016-06, 2017-06
## 17     BART                   2015-06, 2016-06, 2017-06
## 18     BONA                                     2017-06
## 19     BARR                                     2017-07
## 20     SJER                                     2017-04
## 21     STEI                   2016-05, 2016-06, 2017-06
## 22     JORN                            2017-04, 2017-05
## 23     GRSM                   2016-06, 2017-05, 2017-06
## 24     OAES                            2017-05, 2017-06
## 25     SERC                            2017-05, 2017-06
## 26     ABBY                            2017-05, 2017-06
## 27     MOAB                            2015-06, 2017-05
## 28     STER          2013-06, 2015-05, 2016-05, 2017-05
## 29     BLAN                            2017-05, 2017-06
## 30     DELA                            2015-06, 2017-06
## 31     ONAQ                                     2017-05
## 32     SRER                                     2017-05
## 33     SOAP                                     2017-05
## 34     CLBJ                                     2017-05
## 35     SCBI 2015-06, 2016-05, 2016-06, 2017-05, 2017-06
## 36     NIWO                            2015-07, 2017-07
## 37     PUUM                                     2018-04
## 38     TREE                            2016-06, 2017-06
## 39     DSNY                   2015-06, 2016-05, 2017-05
## 40     GUAN                            2015-05, 2017-05
## 41     TEAK                                     2017-06
## 42     UNDE                   2016-06, 2016-07, 2017-06
## 43     TOOL                                     2017-06
##                                                                                                                                                                                                                                                                                                                                                    availableDataUrls
## 1                                                                                                                                                http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2017-05
## 2                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UKFS/2017-06
## 3  http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2013-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-06
## 4                                                                                                                                                                                                                       http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2017-07
## 5                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HEAL/2017-06
## 6                                                                                                                                                http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2016-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2017-06
## 7                                                                                                                                                                                                                       http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2017-05
## 8                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NOGP/2017-07
## 9                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LAJA/2017-05
## 10                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2017-05
## 11                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-07
## 12                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/KONZ/2017-06
## 13                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DEJU/2017-06
## 14                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LENO/2017-06
## 15                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-07
## 16                                                                        http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2017-06
## 17                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2017-06
## 18                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BONA/2017-06
## 19                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BARR/2017-07
## 20                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SJER/2017-04
## 21                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2017-06
## 22                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-04, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-05
## 23                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-06
## 24                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-06
## 25                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-06
## 26                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-06
## 27                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2017-05
## 28                                                                        http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2013-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2017-05
## 29                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-06
## 30                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2017-06
## 31                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ONAQ/2017-05
## 32                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SRER/2017-05
## 33                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SOAP/2017-05
## 34                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CLBJ/2017-05
## 35 http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-06
## 36                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2015-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2017-07
## 37                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/PUUM/2018-04
## 38                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2017-06
## 39                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2017-05
## 40                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2017-05
## 41                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TEAK/2017-06
## 42                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2017-06
## 43                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TOOL/2017-06
```

```r
# same info but in a little more readable form
available$data$siteCodes
```

```
##    siteCode                             availableMonths
## 1      ORNL                   2016-05, 2016-06, 2017-05
## 2      UKFS                                     2017-06
## 3      CPER 2013-06, 2015-05, 2016-05, 2017-05, 2017-06
## 4      WOOD                            2015-07, 2017-07
## 5      HEAL                                     2017-06
## 6      TALL                   2015-06, 2016-07, 2017-06
## 7      JERC                            2016-06, 2017-05
## 8      NOGP                                     2017-07
## 9      LAJA                                     2017-05
## 10     OSBS                            2016-05, 2017-05
## 11     DCFS                            2017-06, 2017-07
## 12     KONZ                                     2017-06
## 13     DEJU                                     2017-06
## 14     LENO                                     2017-06
## 15     RMNP                            2017-06, 2017-07
## 16     HARV          2015-05, 2015-06, 2016-06, 2017-06
## 17     BART                   2015-06, 2016-06, 2017-06
## 18     BONA                                     2017-06
## 19     BARR                                     2017-07
## 20     SJER                                     2017-04
## 21     STEI                   2016-05, 2016-06, 2017-06
## 22     JORN                            2017-04, 2017-05
## 23     GRSM                   2016-06, 2017-05, 2017-06
## 24     OAES                            2017-05, 2017-06
## 25     SERC                            2017-05, 2017-06
## 26     ABBY                            2017-05, 2017-06
## 27     MOAB                            2015-06, 2017-05
## 28     STER          2013-06, 2015-05, 2016-05, 2017-05
## 29     BLAN                            2017-05, 2017-06
## 30     DELA                            2015-06, 2017-06
## 31     ONAQ                                     2017-05
## 32     SRER                                     2017-05
## 33     SOAP                                     2017-05
## 34     CLBJ                                     2017-05
## 35     SCBI 2015-06, 2016-05, 2016-06, 2017-05, 2017-06
## 36     NIWO                            2015-07, 2017-07
## 37     PUUM                                     2018-04
## 38     TREE                            2016-06, 2017-06
## 39     DSNY                   2015-06, 2016-05, 2017-05
## 40     GUAN                            2015-05, 2017-05
## 41     TEAK                                     2017-06
## 42     UNDE                   2016-06, 2016-07, 2017-06
## 43     TOOL                                     2017-06
##                                                                                                                                                                                                                                                                                                                                                    availableDataUrls
## 1                                                                                                                                                http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2017-05
## 2                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UKFS/2017-06
## 3  http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2013-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-06
## 4                                                                                                                                                                                                                       http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2017-07
## 5                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HEAL/2017-06
## 6                                                                                                                                                http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2016-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2017-06
## 7                                                                                                                                                                                                                       http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2017-05
## 8                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NOGP/2017-07
## 9                                                                                                                                                                                                                                                                                              http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LAJA/2017-05
## 10                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2017-05
## 11                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-07
## 12                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/KONZ/2017-06
## 13                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DEJU/2017-06
## 14                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LENO/2017-06
## 15                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-07
## 16                                                                        http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2017-06
## 17                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2017-06
## 18                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BONA/2017-06
## 19                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BARR/2017-07
## 20                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SJER/2017-04
## 21                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2017-06
## 22                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-04, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-05
## 23                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-06
## 24                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-06
## 25                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-06
## 26                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-06
## 27                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2017-05
## 28                                                                        http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2013-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2017-05
## 29                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-06
## 30                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2017-06
## 31                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ONAQ/2017-05
## 32                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SRER/2017-05
## 33                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SOAP/2017-05
## 34                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CLBJ/2017-05
## 35 http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-06
## 36                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2015-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2017-07
## 37                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/PUUM/2018-04
## 38                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2017-06
## 39                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2015-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2016-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2017-05
## 40                                                                                                                                                                                                                      http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2015-05, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2017-05
## 41                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TEAK/2017-06
## 42                                                                                                                                               http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-06, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-07, http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2017-06
## 43                                                                                                                                                                                                                                                                                             http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TOOL/2017-06
```

```r
available$data$siteCodes[,3]
```

```
## [[1]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-06"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2017-05"
## 
## [[2]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UKFS/2017-06"
## 
## [[3]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2013-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2015-05"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2016-05"
## [4] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-05"
## [5] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-06"
## 
## [[4]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2017-07"
## 
## [[5]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HEAL/2017-06"
## 
## [[6]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2016-07"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2017-06"
## 
## [[7]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2016-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2017-05"
## 
## [[8]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NOGP/2017-07"
## 
## [[9]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LAJA/2017-05"
## 
## [[10]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2016-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2017-05"
## 
## [[11]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-07"
## 
## [[12]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/KONZ/2017-06"
## 
## [[13]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DEJU/2017-06"
## 
## [[14]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LENO/2017-06"
## 
## [[15]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-07"
## 
## [[16]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-06"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2016-06"
## [4] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2017-06"
## 
## [[17]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2016-06"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2017-06"
## 
## [[18]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BONA/2017-06"
## 
## [[19]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BARR/2017-07"
## 
## [[20]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SJER/2017-04"
## 
## [[21]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-06"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2017-06"
## 
## [[22]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-04"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-05"
## 
## [[23]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2016-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-05"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-06"
## 
## [[24]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-06"
## 
## [[25]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-06"
## 
## [[26]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-06"
## 
## [[27]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2017-05"
## 
## [[28]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2013-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2015-05"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2016-05"
## [4] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2017-05"
## 
## [[29]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-06"
## 
## [[30]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2017-06"
## 
## [[31]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ONAQ/2017-05"
## 
## [[32]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SRER/2017-05"
## 
## [[33]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SOAP/2017-05"
## 
## [[34]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CLBJ/2017-05"
## 
## [[35]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-05"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-06"
## [4] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-05"
## [5] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-06"
## 
## [[36]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2015-07"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2017-07"
## 
## [[37]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/PUUM/2018-04"
## 
## [[38]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2016-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2017-06"
## 
## [[39]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2015-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2016-05"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2017-05"
## 
## [[40]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2015-05"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2017-05"
## 
## [[41]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TEAK/2017-06"
## 
## [[42]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-06"
## [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-07"
## [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2017-06"
## 
## [[43]]
## [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TOOL/2017-06"
```

third columns is the urls of SPECIFIC data sites/months


```r
bird.urls <- unlist(available$data$siteCodes$availableDataUrls)
bird.urls
```

```
##  [1] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-05"
##  [2] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2016-06"
##  [3] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ORNL/2017-05"
##  [4] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UKFS/2017-06"
##  [5] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2013-06"
##  [6] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2015-05"
##  [7] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2016-05"
##  [8] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-05"
##  [9] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CPER/2017-06"
## [10] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07"
## [11] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2017-07"
## [12] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HEAL/2017-06"
## [13] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2015-06"
## [14] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2016-07"
## [15] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TALL/2017-06"
## [16] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2016-06"
## [17] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JERC/2017-05"
## [18] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NOGP/2017-07"
## [19] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LAJA/2017-05"
## [20] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2016-05"
## [21] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OSBS/2017-05"
## [22] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-06"
## [23] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DCFS/2017-07"
## [24] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/KONZ/2017-06"
## [25] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DEJU/2017-06"
## [26] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/LENO/2017-06"
## [27] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-06"
## [28] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/RMNP/2017-07"
## [29] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-05"
## [30] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2015-06"
## [31] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2016-06"
## [32] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/HARV/2017-06"
## [33] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2015-06"
## [34] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2016-06"
## [35] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BART/2017-06"
## [36] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BONA/2017-06"
## [37] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BARR/2017-07"
## [38] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SJER/2017-04"
## [39] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-05"
## [40] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2016-06"
## [41] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STEI/2017-06"
## [42] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-04"
## [43] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/JORN/2017-05"
## [44] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2016-06"
## [45] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-05"
## [46] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GRSM/2017-06"
## [47] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-05"
## [48] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/OAES/2017-06"
## [49] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-05"
## [50] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SERC/2017-06"
## [51] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-05"
## [52] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ABBY/2017-06"
## [53] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2015-06"
## [54] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/MOAB/2017-05"
## [55] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2013-06"
## [56] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2015-05"
## [57] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2016-05"
## [58] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/STER/2017-05"
## [59] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-05"
## [60] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/BLAN/2017-06"
## [61] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2015-06"
## [62] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DELA/2017-06"
## [63] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/ONAQ/2017-05"
## [64] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SRER/2017-05"
## [65] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SOAP/2017-05"
## [66] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/CLBJ/2017-05"
## [67] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2015-06"
## [68] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-05"
## [69] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2016-06"
## [70] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-05"
## [71] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/SCBI/2017-06"
## [72] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2015-07"
## [73] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/NIWO/2017-07"
## [74] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/PUUM/2018-04"
## [75] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2016-06"
## [76] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TREE/2017-06"
## [77] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2015-06"
## [78] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2016-05"
## [79] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/DSNY/2017-05"
## [80] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2015-05"
## [81] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/GUAN/2017-05"
## [82] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TEAK/2017-06"
## [83] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-06"
## [84] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2016-07"
## [85] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/UNDE/2017-06"
## [86] "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/TOOL/2017-06"
```

```r
bird <- GET(bird.urls[grep("WOOD/2015-07", bird.urls)]) #' just get the URL with this
```

GET will only work with one URL


```r
str(bird) #' another request response
```

```
## List of 10
##  $ url        : chr "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07"
##  $ status_code: int 200
##  $ headers    :List of 10
##   ..$ date                       : chr "Fri, 09 Nov 2018 20:08:22 GMT"
##   ..$ server                     : chr "Apache/2.2.15 (Oracle)"
##   ..$ x-content-type-options     : chr "nosniff"
##   ..$ x-frame-options            : chr "SAMEORIGIN"
##   ..$ x-xss-protection           : chr "1"
##   ..$ set-cookie                 : chr "JSESSIONID=3DCDECF4F6AD4EEE5F15AEF2ECA42C63.dmz-portal-web-3; Path=/; HttpOnly"
##   ..$ access-control-allow-origin: chr "*"
##   ..$ connection                 : chr "close"
##   ..$ transfer-encoding          : chr "chunked"
##   ..$ content-type               : chr "application/json;charset=UTF-8"
##   ..- attr(*, "class")= chr [1:2] "insensitive" "list"
##  $ all_headers:List of 1
##   ..$ :List of 3
##   .. ..$ status : int 200
##   .. ..$ version: chr "HTTP/1.1"
##   .. ..$ headers:List of 10
##   .. .. ..$ date                       : chr "Fri, 09 Nov 2018 20:08:22 GMT"
##   .. .. ..$ server                     : chr "Apache/2.2.15 (Oracle)"
##   .. .. ..$ x-content-type-options     : chr "nosniff"
##   .. .. ..$ x-frame-options            : chr "SAMEORIGIN"
##   .. .. ..$ x-xss-protection           : chr "1"
##   .. .. ..$ set-cookie                 : chr "JSESSIONID=3DCDECF4F6AD4EEE5F15AEF2ECA42C63.dmz-portal-web-3; Path=/; HttpOnly"
##   .. .. ..$ access-control-allow-origin: chr "*"
##   .. .. ..$ connection                 : chr "close"
##   .. .. ..$ transfer-encoding          : chr "chunked"
##   .. .. ..$ content-type               : chr "application/json;charset=UTF-8"
##   .. .. ..- attr(*, "class")= chr [1:2] "insensitive" "list"
##  $ cookies    :'data.frame':	1 obs. of  7 variables:
##   ..$ domain    : chr "#HttpOnly_data.neonscience.org"
##   ..$ flag      : logi FALSE
##   ..$ path      : chr "/"
##   ..$ secure    : logi FALSE
##   ..$ expiration: POSIXct[1:1], format: NA
##   ..$ name      : chr "JSESSIONID"
##   ..$ value     : chr "3DCDECF4F6AD4EEE5F15AEF2ECA42C63.dmz-portal-web-3"
##  $ content    : raw [1:9687] 7b 22 64 61 ...
##  $ date       : POSIXct[1:1], format: "2018-11-09 20:08:22"
##  $ times      : Named num [1:6] 0 0.000019 0.005146 0.005253 0.041663 ...
##   ..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
##  $ request    :List of 7
##   ..$ method    : chr "GET"
##   ..$ url       : chr "http://data.neonscience.org:80/api/v0/data/DP1.10003.001/WOOD/2015-07"
##   ..$ headers   : Named chr "application/json, text/xml, application/xml, */*"
##   .. ..- attr(*, "names")= chr "Accept"
##   ..$ fields    : NULL
##   ..$ options   :List of 2
##   .. ..$ useragent: chr "libcurl/7.43.0 r-curl/3.2 httr/1.3.1"
##   .. ..$ httpget  : logi TRUE
##   ..$ auth_token: NULL
##   ..$ output    : list()
##   .. ..- attr(*, "class")= chr [1:2] "write_memory" "write_function"
##   ..- attr(*, "class")= chr "request"
##  $ handle     :Class 'curl_handle' <externalptr> 
##  - attr(*, "class")= chr "response"
```

```r
bird.files <- fromJSON(content(bird, as = "text"))
str(bird.files)
```

```
## List of 1
##  $ data:List of 4
##   ..$ files      :'data.frame':	16 obs. of  4 variables:
##   .. ..$ crc32: chr [1:16] "4d4f86c1379dece680185e992a471432" "71e695abae2d1943d13e53c95430c6f5" "5428880d2a72e66319eb6f29576a49af" "7c999e9ae4f7d94eaa2c11aadaeecd0b" ...
##   .. ..$ name : chr [1:16] "NEON.D09.WOOD.DP1.10003.001.brd_perpoint.2015-07.basic.20180418T200718Z.csv" "NEON.D09.WOOD.DP1.10003.001.EML.20150701-20150705.20180418T200718Z.xml" "NEON.D09.WOOD.DP1.10003.001.readme.20180418T200718Z.txt" "NEON.D09.WOOD.DP1.10003.001.brd_countdata.2015-07.basic.20180418T200718Z.csv" ...
##   .. ..$ size : chr [1:16] "23962" "70196" "12361" "355660" ...
##   .. ..$ url  : chr [1:16] "https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801"| __truncated__ "https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801"| __truncated__ "https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801"| __truncated__ "https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801"| __truncated__ ...
##   ..$ productCode: chr "DP1.10003.001"
##   ..$ siteCode   : chr "WOOD"
##   ..$ month      : chr "2015-07"
```

```r
bird.files$data
```

```
## $files
##                               crc32
## 1  4d4f86c1379dece680185e992a471432
## 2  71e695abae2d1943d13e53c95430c6f5
## 3  5428880d2a72e66319eb6f29576a49af
## 4  7c999e9ae4f7d94eaa2c11aadaeecd0b
## 5  19adfd2c8bedfe867646644e1985dca0
## 6  0cde0267b9141a0f37a14dc7e5c7084a
## 7  dd27e83b9a5e4a7453f284ae13d1f32d
## 8  28bbedc80a738c2cd16afad21319136f
## 9  4d4f86c1379dece680185e992a471432
## 10 dd27e83b9a5e4a7453f284ae13d1f32d
## 11 02506292f09b5a4ebcc055b279621f8e
## 12 81ddde9f27c7ba6d5a9f6cfb07ae78d3
## 13 19adfd2c8bedfe867646644e1985dca0
## 14 bba1d7554ff524604e64ffcb0b23c0b0
## 15 51b19ca519653f87c7732791b345f89e
## 16 8dca69c9edcf4f3df4ee7fa3a0a624dc
##                                                                               name
## 1      NEON.D09.WOOD.DP1.10003.001.brd_perpoint.2015-07.basic.20180418T200718Z.csv
## 2           NEON.D09.WOOD.DP1.10003.001.EML.20150701-20150705.20180418T200718Z.xml
## 3                          NEON.D09.WOOD.DP1.10003.001.readme.20180418T200718Z.txt
## 4     NEON.D09.WOOD.DP1.10003.001.brd_countdata.2015-07.basic.20180418T200718Z.csv
## 5                      NEON.D09.WOOD.DP0.10003.001.validation.20180418T200718Z.csv
## 6                   NEON.D09.WOOD.DP1.10003.001.2015-07.basic.20180418T200718Z.zip
## 7                       NEON.D09.WOOD.DP1.10003.001.variables.20180418T200718Z.csv
## 8                NEON.D09.WOOD.DP1.10003.001.2015-07.expanded.20180418T200718Z.zip
## 9   NEON.D09.WOOD.DP1.10003.001.brd_perpoint.2015-07.expanded.20180418T200718Z.csv
## 10                      NEON.D09.WOOD.DP1.10003.001.variables.20180418T200718Z.csv
## 11          NEON.D09.WOOD.DP1.10003.001.EML.20150701-20150705.20180418T200718Z.xml
## 12 NEON.D09.WOOD.DP1.10003.001.brd_countdata.2015-07.expanded.20180418T200718Z.csv
## 13                     NEON.D09.WOOD.DP0.10003.001.validation.20180418T200718Z.csv
## 14                          NEON.Bird_Conservancy_of_the_Rockies.brd_personnel.csv
## 15                         NEON.D09.WOOD.DP1.10003.001.readme.20180418T200718Z.txt
## 16        NEON.D09.WOOD.DP1.10003.001.brd_references.expanded.20180418T200718Z.csv
##      size
## 1   23962
## 2   70196
## 3   12361
## 4  355660
## 5    9830
## 6   67654
## 7    7280
## 8   72540
## 9   23962
## 10   7280
## 11  78407
## 12 376383
## 13   9830
## 14  11918
## 15  12640
## 16    650
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        url
## 1         https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.brd_perpoint.2015-07.basic.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=661ee51f1eaa25b84326ad9fd1305f7ebd673a43f9c53f43800b2857dd381d0b
## 2              https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.EML.20150701-20150705.20180418T200718Z.xml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=b345fca9e24161f31af4c1710edd35e4e43c3dc8549ccb30c7dfd16ed09e9207
## 3                             https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.readme.20180418T200718Z.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=1d4cb18efddf91443b2bc5e1de655a4f12c0d995c79547b077d19b0df4102e05
## 4        https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.brd_countdata.2015-07.basic.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=1c8c2878ad0187483361fd2d169dfb76302a3709d7658e9d18342d4471b94bc5
## 5                         https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP0.10003.001.validation.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=a791a99e0dfbe315e786a1284968c2c05cb40f1bfdddc0fa7dc75f5fb7590b04
## 6                      https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.2015-07.basic.20180418T200718Z.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=9bb581e9a5bc63fbd8e32c0b2a98fb6c561efcc8c3a831fbf47a32f9afa9917b
## 7                          https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/basic/NEON.D09.WOOD.DP1.10003.001.variables.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=4a9fc495125641b5c7cacc789f19a52a2ecfe6fa1d044b01556a666aed16f5b2
## 8                https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.2015-07.expanded.20180418T200718Z.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=a2948f87ae952d0cfd34de02b763088a1bafbbe1e50b5598a21c4fc4f7961a66
## 9   https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.brd_perpoint.2015-07.expanded.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=ca8f845b1d567b9306f56e143455e674305c1acb02ea3291840c4244fc007050
## 10                      https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.variables.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=7f37ebbae3566f90b07f4979180e0dc465e3a430d84d80c7db28fe7f402bb644
## 11          https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.EML.20150701-20150705.20180418T200718Z.xml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=f9ebecc53f5a38bbfce17b945b284eb2f0462cbfeb75706971a6bd4de4412e2e
## 12 https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.brd_countdata.2015-07.expanded.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=00046cd3e4c86bac70370457509f6a7c5e9c17e44618de9392353650837c92eb
## 13                     https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP0.10003.001.validation.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=081681ce55c95bb957c1ea75a83a1ba09e67ce666d8986558cc072aabd7f416c
## 14                          https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.Bird_Conservancy_of_the_Rockies.brd_personnel.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=c4c92494e09de7c86e555c984b9ba4b38031cb7aaef61223dc95ca7f01723f83
## 15                         https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.readme.20180418T200718Z.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=6c671432ccc8256ad6d4ecf9e7decdfe91dcb93d9dce1bae845536a3b406f9a8
## 16        https://neon-prod-pub-1.s3.data.neonscience.org/NEON.DOM.SITE.DP1.10003.001/PROV/WOOD/20150701T000000--20150801T000000/expanded/NEON.D09.WOOD.DP1.10003.001.brd_references.expanded.20180418T200718Z.csv?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20181109T200822Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=pub-internal-read%2F20181109%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Signature=632f4c0885985eaaae5357471e790dc95f0cde379f2b0035086c6a9a032380f0
## 
## $productCode
## [1] "DP1.10003.001"
## 
## $siteCode
## [1] "WOOD"
## 
## $month
## [1] "2015-07"
```

all the files available for birds at this site in this month
order is not predictable!
basic and expanded file for each type of data
lots of different data types


```r
bird.count <- read.delim(bird.files$data$files$url[intersect(
      grep("countdata", bird.files$data$files$name),
      grep("basic", bird.files$data$files$name))], sep = ",") #' want to get both BASIC and COUNT (only one file)

head(bird.count)
```

```
##                                    uid         namedLocation domainID
## 1 05d116ad-1acd-4a74-ad00-0c0ad161f240 WOOD_013.birdGrid.brd      D09
## 2 7f0ae987-3732-487b-9261-8da73de796a6 WOOD_013.birdGrid.brd      D09
## 3 03159800-413e-4294-bdf9-9b4e2ac59230 WOOD_013.birdGrid.brd      D09
## 4 71ad1c00-b8bb-4e95-8921-9311e7ac4b8a WOOD_013.birdGrid.brd      D09
## 5 e9b73fde-c397-4017-8288-b1f98ed15205 WOOD_013.birdGrid.brd      D09
## 6 1344ace6-7414-4531-b25d-998788d85e4d WOOD_013.birdGrid.brd      D09
##   siteID   plotID    plotType pointID      startDate
## 1   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
## 2   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
## 3   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
## 4   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
## 5   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
## 6   WOOD WOOD_013 distributed      B1 2015-07-01T10Z
##                                          eventID pointCountMinute
## 1 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                2
## 2 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                1
## 3 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                1
## 4 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                1
## 5 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                1
## 6 WOOD_013.B1.2015-07-01T05:02-05:00[US/Central]                3
##   targetTaxaPresent taxonID        scientificName taxonRank
## 1                 Y    MODO      Zenaida macroura   species
## 2                 Y    UNBL         Icteridae sp.    family
## 3                 Y    WEME    Sturnella neglecta   species
## 4                 Y    WEME    Sturnella neglecta   species
## 5                 Y    MAWR Cistothorus palustris   species
## 6                 Y    BHCO        Molothrus ater   species
##         vernacularName observerDistance detectionMethod visualConfirmation
## 1        Mourning Dove              152         singing                 No
## 2                                   131         singing                 No
## 3   Western Meadowlark              251         singing                 No
## 4   Western Meadowlark              217         singing                 No
## 5           Marsh Wren               62         singing                 No
## 6 Brown-headed Cowbird              136         calling                Yes
##   sexOrAge clusterSize clusterCode identifiedBy
## 1  Unknown           1             6vhK5g7y5oE=
## 2  Unknown           1             6vhK5g7y5oE=
## 3  Unknown           1             6vhK5g7y5oE=
## 4  Unknown           1             6vhK5g7y5oE=
## 5  Unknown           1             6vhK5g7y5oE=
## 6  Unknown           3             6vhK5g7y5oE=
```

taxon endpoint-------------------####


```r
loon.req <- GET("http://data.neonscience.org/api/v0/taxonomy/?family=Gaviidae") #'query to search
loon.req
```

```
## Response [http://data.neonscience.org/api/v0/taxonomy/?family=Gaviidae]
##   Date: 2018-11-09 20:08
##   Status: 200
##   Content-Type: application/json;charset=UTF-8
##   Size: 2.28 kB
```

```r
loon.list <- fromJSON(content(loon.req, as = "text"))
loon.list
```

```
## $count
## [1] 5
## 
## $total
## [1] 5
## 
## $prev
## NULL
## 
## $`next`
## NULL
## 
## $data
##   taxonTypeCode taxonID acceptedTaxonID dwc:scientificName
## 1          BIRD    ARLO            ARLO      Gavia arctica
## 2          BIRD    COLO            COLO        Gavia immer
## 3          BIRD    PALO            PALO     Gavia pacifica
## 4          BIRD    RTLO            RTLO     Gavia stellata
## 5          BIRD    YBLO            YBLO      Gavia adamsii
##   dwc:scientificNameAuthorship dwc:taxonRank dwc:vernacularName
## 1                   (Linnaeus)       species        Arctic Loon
## 2                   (Brunnich)       species        Common Loon
## 3                   (Lawrence)       species       Pacific Loon
## 4                (Pontoppidan)       species  Red-throated Loon
## 5                 (G. R. Gray)       species Yellow-billed Loon
##      dwc:nameAccordingToID dwc:kingdom dwc:phylum dwc:class   dwc:order
## 1 doi: 10.1642/AUK-15-73.1    Animalia   Chordata      Aves Gaviiformes
## 2 doi: 10.1642/AUK-15-73.1    Animalia   Chordata      Aves Gaviiformes
## 3 doi: 10.1642/AUK-15-73.1    Animalia   Chordata      Aves Gaviiformes
## 4 doi: 10.1642/AUK-15-73.1    Animalia   Chordata      Aves Gaviiformes
## 5 doi: 10.1642/AUK-15-73.1    Animalia   Chordata      Aves Gaviiformes
##   dwc:family dwc:genus gbif:subspecies gbif:variety
## 1   Gaviidae     Gavia              NA           NA
## 2   Gaviidae     Gavia              NA           NA
## 3   Gaviidae     Gavia              NA           NA
## 4   Gaviidae     Gavia              NA           NA
## 5   Gaviidae     Gavia              NA           NA
```

