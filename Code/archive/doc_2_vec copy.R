##################################################
# 1. Set Up
##################################################

# Set Court ***
i=1

require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)
require(dplyr)
require(tidyr)
require(irlba) # fast and memory efficient methods for truncated singular value decomp + PCA of large sparse matrices

# FastText Installation
#########################
# NOTE: fasTextR Installation will fail on Mac
# Click links below to see issue and to learn to use OpenMP in R on Mac
    # https://github.com/mlampros/ClusterR/issues/12#issuecomment-444386654
    # https://thecoatlessprofessor.com/programming/openmp-in-r-on-os-x/
# Then link below to resolve "fatal error: 'math.h' file not found"
    # https://github.com/RcppCore/Rcpp/issues/922
# devtools::install_github('mlampros/fastTextR')
require(fastTextR)

# Text Cleaning Functions
#########################
htmlBreaks <- function(htmlString) {
  htmlString = gsub("<br>", " ", htmlString)
  return(gsub("\n", " ", htmlString))
}

htmlRemove <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}

# File Paths
#########################
# data is available here: https://www.courtlistener.com/api/bulk-info/
courts = paste('ca',c(seq(1,11),'dc'),sep='')
# decisions_path = paste('data/',courts,'/',sep='')
decisions_path = paste('/Volumes/RESEARCH/EDSP/data/',courts,'/',sep='')
decisions_files = sapply(decisions_path, function(x) list.files(x))
n_cases = unlist(lapply(decisions_files,length))
n_cases=10

# Load Data
#########################
decisions = list()

decisions = rep(NA,n_cases[i])
for(j in 1:n_cases[i]){
  j=100
  result = fromJSON(file=paste(decisions_path[i], decisions_files[[i]][j],sep=''))
  if(result$html_with_citations != ''){
    decisions[j] = result$html_with_citations  
  } else if(result$plain_text != ''){
    decisions[j] = result$plain_text  
  }
  decisions[j] = htmlRemove(decisions[j])
  decisions[j] = htmlBreaks(decisions[j])
  if(j %% 2000==0) print(paste('loading opinion',j,'from court',courts[i]))
}

concat = unlist(decisions)
concat = concat[!is.na(concat)]





# Exclude type = '010combined'
j=3000
result = fromJSON(file=paste(decisions_path[i], decisions_files[[i]][j],sep=''))
result
