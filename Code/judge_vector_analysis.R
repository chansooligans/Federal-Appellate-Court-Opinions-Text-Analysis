

#########################
# Get Judge Vectors
#########################

# Summarize vectors for judge
judge_vecs = df %>% group_by(judge) %>% summarise_all("mean")

# Obtain count of docs per judge
counts = df %>% group_by(judge) %>% summarise(n=dplyr::n())
counts$n

# Join Judge Vec matrix with Counts. Only Keep vecs with more than 100 docs
judge_vecs = judge_vecs %>% left_join(counts, by = 'judge') %>% filter(n>5) %>% select(-n)
row.names(judge_vecs) = judge_vecs$judge

# Join Judge Metadata
# write.csv(judge_vecs,file='/Volumes/RESEARCH/EDSP/judges.csv')
judge_meta = read.csv(file='/Volumes/RESEARCH/EDSP/metadata/Judge_Metadata - Export.csv', stringsAsFactors = F)
final = judge_vecs %>% left_join(judge_meta,by=c('judge'='Judge'))

# Duplicate last names
dupes = final %>% 
  group_by(judge) %>%
  dplyr::summarise(n=dplyr::n()) %>%
  filter(n>1)

# Remove Dupes
final = final %>% filter(!judge %in% dupes$judge)
judge_vecs = judge_vecs %>% filter(!judge %in% dupes$judge)

# Remove Rows with Missing Judge Metadata
judge_vecs = judge_vecs[!is.na(final$Judge.full),]
final = final[!is.na(final$Judge.full),]

# Principal Components
temp = judge_vecs %>% select(-judge)
word_pca <- irlba::prcomp_irlba(temp, n = 10, center = T, scale. = T) # n = no. of principal component vectors to return
plot(word_pca)

final$Appointed.By = as.factor(as.character(final$Appointed.By))
final$Born = as.factor(round(final$Born*.1)*10)

plot.df = as.data.frame(word_pca$x[,1:4])
plot.df$appointed = final$Appointed.By
plot.df$party = final$Party
plot.df$Born = as.numeric(as.character(final$Born))

# Plots
ggplot(plot.df, aes(x=PC1, y=PC2,col=appointed,label=appointed)) + 
  geom_point() +
  geom_text() +
  ggtitle('Principle Components of Judge Vectors')

# 
ggplot(plot.df, aes(x=PC1, y=PC2,col=Born,label=appointed)) + 
  geom_point() +
  geom_text() +
  ggtitle('Principle Components of Judge Vectors')

# 
ggplot(plot.df, aes(x=PC1, y=PC2,col=party,label=party)) + 
  geom_point() +
  geom_text() +
  ggtitle('Principle Components of Judge Vectors')

# 












