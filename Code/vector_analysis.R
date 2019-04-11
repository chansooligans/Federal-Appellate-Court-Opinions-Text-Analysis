rm(list=ls())
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)
library(dplyr)
library(ggplot2)

#########################
# Load Metadata and Vectors
#########################

df.vecs.list = list()
df.inventory = list()
court = c('ca1','ca2','ca3','ca4')

for(i in 1:4){
  print(i)
  # Load Data
  load(file=paste('/Volumes/RESEARCH/EDSP/vectors/',court[i],'_vectors.RDATA',sep=''))
  df.vecs.list[[i]] = as.data.frame(doc2_sum)
  rm(doc2_idf,doc2_norm)
  print(dim(df.vecs.list[[i]]))
  
  load(file=paste('/Volumes/RESEARCH/EDSP/inventory/data_inventory.',court[i],'.RDATA',sep=''))
  df.inventory[[i]] = df
  print(dim(df.inventory[[i]]))
}

df.vecs = plyr::rbind.fill(df.vecs.list)
df = plyr::rbind.fill(df.inventory)

#########################
# Some Data Cleaning
#########################

# Remove Missing Data
df = df[which(!is.na(df$plain_text)),]

# Merge Document Vectors to Metadata
df = cbind(df.vecs,df[,c('judge','year','circuit')])
df = df[which(!is.na(df$year)),]

# If Judge is numeric, it's missing Set these to NA then remove
df[,301][!is.na(as.numeric(df[,301]))] = NA
df = df[!is.na(df[,301]),]
dim(df)

# Fix Judge Names
df[,301] = tolower(df[,301])
df[,301] = gsub(',','',df[,301])
df[,301] = gsub('and','',df[,301])
df[,301] = gsub('<span>','',df[,301])
df[,301] = gsub('senior','',df[,301])

for(i in 1:length(df[,301])){
  if(length(strsplit(df[i,301],' ')[[1]]) > 1){
    max.len = length(strsplit(df[i,301],' ')[[1]])
    df[i,301] = strsplit(df[i,301],' ')[[1]][max.len]
  }
}

df[,301] = trimws(df[,301])
df = df[nchar(df[,301])<20,]
dim(df)

# How many unique judges?
length(unique(df[,301]))
 
# Convert to Data Frame
df = as.data.frame(df, stringsAsFactors = F)

#########################
# De-Mean by Year and by Court
#########################

# Convert doc vectors to numeric
for(i in 1:300) df[,i] = as.numeric(df[,i])

# Remove cases heard before 1925 and after 2017 (first year where I have more than 100 cases)
df = df %>% filter(year >= 1925, year <= 2017)

# De-mean by Year
year.vectors = df %>%
  select(-judge,-circuit) %>%
  group_by(year) %>%
  summarise_all("mean") %>%
  filter(!is.na(year))

years = unique(df$year[!is.na(df$year)])
df = df[!is.na(df$year),]

for(i in years){
  print(i)
  vectors.in.year.i = as.matrix(df[df$year==i,1:300])
  mean.vector.year.i = as.matrix(year.vectors[year.vectors$year==i,] %>% select(-year))
  df[df$year==i,1:300] = sweep(vectors.in.year.i,2,mean.vector.year.i)
}

# df = df %>% select(-year)

# De-mean by Court
circuit.vectors = df %>%
  select(-judge,-year) %>%
  group_by(circuit) %>%
  summarise_all("mean") %>%
  filter(!is.na(circuit))

circuits = unique(df$circuit[!is.na(df$circuit)])
df = df[!is.na(df$circuit),]

for(i in circuits){
  print(i)
  vectors.in.circuit.i = as.matrix(df[df$circuit==i,1:300])
  mean.vector.circuit.i = as.matrix(circuit.vectors[circuit.vectors$circuit==i,] %>% select(-circuit))
  df[df$circuit==i,1:300] = sweep(vectors.in.circuit.i,2,mean.vector.circuit.i)
}

# df = df %>% select(-circuit)
save(df, file='/Volumes/RESEARCH/EDSP/vectors/doc_vecs.RDATA')
