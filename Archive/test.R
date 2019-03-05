library(rjson)
library(tm)
library(SnowballC)
library(readr)

# Load Data
#########################
rm(list=ls())
files_slug = '/Users/Chansoo/Desktop/test_sc_cases/'
files = list.files(files_slug)
files = files[1:4]

# Text Cleaning Functions
#########################
htmlBreaks <- function(htmlString) {
  return(gsub("<br>", " ", htmlString))
}

htmlRemove <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}

# Load Data
#########################
opinions = rep(NA, 3)

for(i in 1:4){
  fileName = paste(files_slug,files[i],sep='')
  opinions[i] = read_file(fileName) 
}
opinions[2]

doc.vec = VectorSource(opinions)
doc.corpus = Corpus(doc.vec)
doc.corpus = tm_map(doc.corpus, content_transformer(tolower))
doc.corpus = tm_map(doc.corpus, htmlBreaks)
doc.corpus = tm_map(doc.corpus, htmlRemove)
doc.corpus = tm_map(doc.corpus, removeNumbers)
doc.corpus = tm_map(doc.corpus, removePunctuation)
doc.corpus = tm_map(doc.corpus, removeWords, stopwords('english'))
doc.corpus = tm_map(doc.corpus, stemDocument)
doc.corpus = tm_map(doc.corpus, stripWhitespace)

review_dtm1 <- DocumentTermMatrix(doc.corpus[1])
review_dtm2 <- DocumentTermMatrix(doc.corpus[2])
review_dtm3 <- DocumentTermMatrix(doc.corpus[3])
review_dtm4 <- DocumentTermMatrix(doc.corpus[4])
inspect(review_dtm1[1,1:10])

case1 = c(unlist(findMostFreqTerms(review_dtm1,n=51))/sum(review_dtm1))[2:51]
case2 = unlist(findMostFreqTerms(review_dtm2,n=50))/sum(review_dtm2)
case3 = unlist(findMostFreqTerms(review_dtm3,n=50))/sum(review_dtm3)
case4 = c(unlist(findMostFreqTerms(review_dtm4,n=51))/sum(review_dtm4))[2:51]


names(case1) =gsub('1.','',names(case1))
names(case2) =gsub('1.','',names(case2))
names(case3) =gsub('1.','',names(case3))
names(case4) =gsub('1.','',names(case4))

case1
case2
case3
case4
files
