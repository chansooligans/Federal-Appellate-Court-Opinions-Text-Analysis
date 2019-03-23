rm(list=ls())

##################################################
# 1. Set Up
##################################################
library(stringr)
require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)

# File Paths
#########################
# stored on usb drive bc file is large
# data is available here: https://www.courtlistener.com/api/bulk-info/
court='ca2'
# decisions_path = '/Volumes/RESEARCH/EDSP/data/ca2/'
decisions_path = paste('/scratch/cs2737/',court,'/',sep='')
decisions_files = list.files(decisions_path)
n = length(decisions_files)


# Load Data
#########################

# Initialize Variables
local_path = absolute_url = type = author = joined_by = download_url = rep(NA,n)
plain_text = judge = year = rep(NA,n)
dissent = concurring = per_curiam = errata = rep(NA,n)
circuit = rep(court,n)

# For each file, save metadata
for(i in 1:n){
  result = fromJSON(file=paste(decisions_path, decisions_files[i],sep=''))
  if(!is.null(result$local_path)) local_path[i] = result$local_path else local_path[i] = NA
  if(!is.null(result$absolute_url)) absolute_url[i] = result$absolute_url else absolute_url[i] = NA
  if(!is.null(result$type)) type[i] = result$type else type[i] = NA
  if(!is.null(result$author)) author[i] = result$author else author[i] = NA
  if(length(result$joined_by)>0) joined_by[i] = result$joined_by else joined_by[i] = NA
  if(!is.null(result$download_url)) download_url[i] = result$download_url else download_url[i] = NA
  
  if(result$plain_text!=""){
    plain_text[i] = 'plain'
  } else if(result$html_with_citations!="") {
    plain_text[i] = 'html_with_citations'
    result$plain_text = result$html_with_citations
  } else {
    plain_text[i] = NA
  }
  
  if(is.character(plain_text[i])){
    # \n\f format
    judge[i] = str_match(result$plain_text, "\n\f (.*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "\n\f (.*?) Circuit[ \t]+Judge[.:]")[,2]
    
    # Negative Lookahead "and"
    # <p> format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p>(?!.*and)(.*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p>(?!.*and)(.*?) Circuit[ \t]+Judge[.:]")[,2]
    # gt format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "gt;(?!.*and)(.*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "gt;(?!.*and)(.*?) Circuit[ \t]+Judge[.:]")[,2]
    # <p><span> format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p><span>([ \t]*)([a-zA-Z,]*)[ \t]Chief[ \t]+Judge[.:]")[,3]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p><span>([ \t]*)([a-zA-Z,]*)[ \t]Circuit[ \t]+Judge[.:]")[,3]
    # <p class=\"indent\">
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p class=\"indent\">(?!.*and)(.*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p class=\"indent\">(?!.*and)(.*?) Circuit[ \t]+Judge[.:]")[,2]
    
    # Chunk of characters between tag and Judge
    # <p> format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p>([ \t]*)([a-zA-Z,]*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p>([ \t]*)([a-zA-Z,]*?) Circuit[ \t]+Judge[.:]")[,2]
    # gt format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "gt;([ \t]*)([a-zA-Z,]*?) Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "gt;([ \t]*)([a-zA-Z,]*?) Circuit[ \t]+Judge[.:]")[,2]
    # <p><span> format
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p><span>([ \t]*)([a-zA-Z,]*)[ \t]Chief[ \t]+Judge[.:]")[,3]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p><span>([ \t]*)([a-zA-Z,]*)[ \t]Circuit[ \t]+Judge[.:]")[,3]
    # <p class=\"indent\">
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p class=\"indent\">([ \t]*)([a-zA-Z,]*)[ \t]Chief[ \t]+Judge[.:]")[,2]
    if(is.na(judge[i])) judge[i] = str_match(result$plain_text, "<p class=\"indent\">([ \t]*)([a-zA-Z,]*)[ \t]Circuit[ \t]+Judge[.:]")[,2]
    
    # Get Year
    regex_date = '(Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)\\s+\\d{1,2},\\s+\\d{4}'
    date = str_match(result$plain_text, regex_date)[1]
    date_n = nchar(date)
    year[i] = substr(date, date_n-3,date_n)
    
    if(is.na(judge[i])) judge[i] = nchar(result$plain_text)
    dissent[i] = str_count(result$plain_text,'Dissenting')    
    concurring[i] = str_count(result$plain_text,'.oncurring')    
    per_curiam[i] = str_count(result$plain_text,'Per Curiam')    
    errata[i] = str_count(result$plain_text,'ERRATA SHEET')    
  }
  
  if(i %% 100 == 0) print(i)
}

# Extract Year and Case Names from the Local Path and Absolute URLs
# Since Case Name formatting vary, I have two casenames
# year = sapply(local_path, function(x) strsplit(x,'/')[[1]][2])
case_name = sapply(local_path, function(x) strsplit(x,'/')[[1]][5])
case_name = gsub('.pdf','',case_name)
case_name2 = sapply(absolute_url, function(x) strsplit(x,'/')[[1]][4])

# Create Data Frame
df = setNames(as.data.frame(cbind(decisions_files,year,case_name,case_name2,circuit,local_path,absolute_url,type,author,joined_by,download_url,plain_text,judge,dissent,concurring,per_curiam,errata),
                            stringsAsFactors = F),
             c('file_name','year','case_name','alt_case_name','circuit','local_path','absolute_url','type','author','joined_by','download_url','plain_text','judge','dissent','concurring','per_curiam','errata'))
row.names(df) = 1:nrow(df)
df$judge = trimws(df$judge)


# Export
save(df,file=paste('/home/cs2737/Chansoo/edsp_judge/data_inventory/data_inventory.',court,'.RDATA',sep=''))








