



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
inspect(doc.corpus[1])

review_dtm <- DocumentTermMatrix(doc.corpus)
inspect(review_dtm[1:10,11:20])

review_dtm = removeSparseTerms(review_dtm, 0.99)
review_dtm

findFreqTerms(review_dtm, 500)


# TF-IDF
#########################
review_dtm_tfidf <- DocumentTermMatrix(doc.corpus, control = list(weighting = weightTfIdf))
review_dtm_tfidf = removeSparseTerms(review_dtm_tfidf, 0.95)
review_dtm_tfidf
inspect(review_dtm_tfidf[1:10,11:20])
