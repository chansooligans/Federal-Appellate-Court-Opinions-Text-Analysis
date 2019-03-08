rm(list=ls())
library(dplyr)

court = 'ca1'

# Load Data
load(file=paste('/Volumes/RESEARCH/EDSP/vectors/',court,'_vectors.RDATA',sep=''))
load(file=paste('/Volumes/RESEARCH/EDSP/inventory/data_inventory.',court,'.RDATA',sep=''))

# Remove Missing Data
df = df[which(!is.na(df$plain_text)),]

# Merge Document Vectors
test = cbind(doc2_sum,df$judge)
dim(test)

# If Judge is Missing, it's numeric. Set these to NA then remove
test[,301][!is.na(as.numeric(test[,301]))] = NA
test = test[!is.na(test[,301]),]
dim(test)

# Fix Judge Names
test[,301] = tolower(test[,301])
test[,301] = gsub(',','',test[,301])
test[,301] = gsub('and','',test[,301])
test[,301] = gsub('<span>','',test[,301])
test[,301] = gsub('senior','',test[,301])
test[,301] = trimws(test[,301])
test = test[nchar(test[,301])<20,]
dim(test)

# How many unique judges?
length(unique(test[,301]))
 
# Convert to Data Frame
df = as.data.frame(test, stringsAsFactors = F)
# Convert doc vectors to numeric
for(i in 1:300) df[,i] = as.numeric(df[,i])

# Summarize vectors for judge
judge_vecs = df %>% group_by(V301) %>% summarise_all("mean")
# Obtain count of docs per judge
counts = df %>% group_by(V301) %>% summarise(n=n())
counts$n

# Join Judge Vec matrix with Counts. Only Keep vecs with more than 100 docs
judge_vecs = judge_vecs %>% left_join(counts, by = 'V301') %>% filter(n>10) %>% select(-n)
row.names(judge_vecs) = judge_vecs$V301

# Join Judge Metadata
write.csv(judge_vecs,file='/Volumes/RESEARCH/EDSP/ca1_judges.csv')
judge_meta = read.csv(file=paste('/Volumes/RESEARCH/EDSP/metadata/',court,'_Judge_Metadata.csv',sep=''))
final = judge_vecs %>% left_join(judge_meta,by=c('V301'='Judge'))

judge_vecs = judge_vecs[!is.na(final$Judge.full),]
final = final[!is.na(final$Judge.full),]

# Principal Components
temp = judge_vecs %>% select(-V301)
word_pca <- irlba::prcomp_irlba(temp, n = 10, center = T, scale. = T) # n = no. of principal component vectors to return


final$Appointed.By = as.factor(as.character(final$Appointed.By))
final$Born = as.factor(round(final$Born*.1)*10)


par(bg = 'white')
plot(word_pca$x[,1],word_pca$x[,2], col=final$Appointed.By, pch=19, xlim=c(-20,25))
text(word_pca$x[,1],word_pca$x[,2], labels=final$Appointed.By, cex=0.5, col = "red", pos=3)

plot(word_pca$x[,1],word_pca$x[,2], col=final$Born, pch=19, xlim=c(-20,25))
text(word_pca$x[,1],word_pca$x[,2], labels=final$Born, cex=0.5, col = "red", pos=3)


# 
















