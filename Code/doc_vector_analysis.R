rm(list=ls())
lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)
library(dplyr)
library(ggplot2)

#########################
# Load Metadata and Vectors
#########################

# Load document vectors from "vector_analysis.R"
load(file='/Volumes/RESEARCH/EDSP/vectors/doc_vecs.RDATA')

#########################
# Exploratory + Summaries
#########################

# "df" contains document vectors (each vector has 300 dimensions)
# Columns 301, 301, 303 are judge, year, and circuit respectively
names(df)

# Check Years
by.year = df %>%
  group_by(year) %>%
  summarise(n=dplyr::n()) %>%
  arrange(year) %>%
  print(n=100)

by.year$year = as.numeric(by.year$year)
ggplot(data=by.year, aes(x=year,y=n)) +
  geom_point() +
  labs(title = 'test')
