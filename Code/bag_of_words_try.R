rm(list=ls())

##################################################
# 1. Set Up
##################################################
require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)
require(irlba) # fast and memory efficient methods for truncated singular value decomp + PCA of large sparse matrices



# Number of Decisions
#########################
n = 5000

# Resources
#########################
# https://cran.r-project.org/web/packages/textTinyR/vignettes/word_vectors_doc2vec.html


# File Paths
#########################
# stored on usb drive bc file is large
# data is available here: https://www.courtlistener.com/api/bulk-info/
decisions_path = '/Volumes/RESEARCH/EDSP/opinions/ca1/' 
decisions_files = list.files(decisions_path)
decisions_files = decisions_files[1:n]


# Text Cleaning Functions
#########################
htmlBreaks <- function(htmlString) {
  htmlString = gsub("<br>", " ", htmlString)
  return(gsub("\n", " ", htmlString))
}

htmlRemove <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}


# Load Data
#########################
decisions = rep(NA,n)

for(i in 1:n){
  result = fromJSON(file=paste(decisions_path, decisions_files[i],sep=''))
  decisions[i] = result$html_with_citations
  decisions[i] = htmlRemove(decisions[i])
  decisions[i] = htmlBreaks(decisions[i])
}


doc.vec = VectorSource(decisions)
doc.corpus = Corpus(doc.vec) 
doc.corpus = tm_map(doc.corpus, content_transformer(tolower))
doc.corpus = tm_map(doc.corpus, htmlBreaks)
doc.corpus = tm_map(doc.corpus, htmlRemove)
doc.corpus = tm_map(doc.corpus, removeNumbers)
doc.corpus = tm_map(doc.corpus, removePunctuation)
doc.corpus = tm_map(doc.corpus, removeWords, stopwords('english'))
doc.corpus = tm_map(doc.corpus, stemDocument)
doc.corpus = tm_map(doc.corpus, stripWhitespace)

review_dtm1 <- DocumentTermMatrix(doc.corpus)
inspect(review_dtm1[1,1:10])

review_dtm1_scaled = scale(review_dtm1)
review_dtm1_scaled[1:10,1:10]
dim(review_dtm1_scaled)

word_pca <- irlba::prcomp_irlba(review_dtm1_scaled, n = 15, center = T) # n = no. of principal component vectors to return
plot(word_pca$x[,1:2])




