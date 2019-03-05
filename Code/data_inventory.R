rm(list=ls())

##################################################
# 1. Set Up
##################################################
require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)

# File Paths
#########################
# stored on usb drive bc file is large
# data is available here: https://www.courtlistener.com/api/bulk-info/
decisions_path = '/Volumes/RESEARCH/EDSP/opinions/ca1/' 
decisions_files = list.files(decisions_path)
head(decisions_files)
n = length(decisions_files)

# Load Data
#########################

# Initialize Variables
local_path = rep(NA,n)
absolute_url = rep(NA,n)
circuit = rep('ca1',n)

# For each file, save the file name and year
for(i in 1:n){
  result = fromJSON(file=paste(decisions_path, decisions_files[i],sep=''))
  if(!is.null(result$local_path)){
    local_path[i] = result$local_path
    absolute_url[i] = result$absolute_url
  } else {
    local_path[i] = NA
    absolute_url[i] = NA
  }
  if(i %% 100 == 0) print(i)
}

# Extract Year and Case Names from the Local Path and Absolute URLs
# Since Case Name formatting vary, I have two casenames
year = sapply(local_path, function(x) strsplit(x,'/')[[1]][2])
case_name = sapply(local_path, function(x) strsplit(x,'/')[[1]][5])
case_name = gsub('.pdf','',case_name)
case_name2 = sapply(absolute_url, function(x) strsplit(x,'/')[[1]][4])

# Create Data Frame
df = setNames(as.data.frame(cbind(decisions_files,year,case_name,case_name2,circuit,local_path,absolute_url),
                            stringsAsFactors = F),
             c('file_name','year','case_name','alt_case_name','circuit','local_path','absolute_url'))

write.csv(df,file='/Volumes/RESEARCH/EDSP/ca1.csv',row.names = F)
