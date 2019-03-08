rm(list=ls())

##################################################
# 1. Set Up
##################################################
require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)
require(dplyr)
require(tidyr)
require(irlba) # fast and memory efficient methods for truncated singular value decomp + PCA of large sparse matrices

load(file='/Users/chansoosong/Desktop/Research/edsp2019project-chansooligans/Results/vectors.RDATA')

##################################################
# 2. PCA
##################################################

word_pca <- irlba::prcomp_irlba(doc2_sum, n = 15, center = T, scale. = T) # n = no. of principal component vectors to return
plot(word_pca$x[,1:2])

##################################################
# 3. Clustering
##################################################

scal_dat = ClusterR::center_scale(doc2_sum)     # center and scale the data

# Optimal number of clusters for kmeans
# distortion_fk criterion is based on 'Selection of K in K-means clustering' in
# "https://www.ee.columbia.edu/~dpwe/papers/PhamDN05-kmeans.pdf"
opt_cl = ClusterR::Optimal_Clusters_KMeans(scal_dat, max_clusters = 15,
                                           criterion = "distortion_fK",
                                           fK_threshold = 0.85, num_init = 3,
                                           max_iters = 50,
                                           initializer = "kmeans++", tol = 1e-04,
                                           plot_clusters = TRUE,
                                           verbose = T, tol_optimal_init = 0.3,
                                           seed = 1)

num_clust = 2

km = ClusterR::KMeans_rcpp(scal_dat, clusters = num_clust, num_init = 3, max_iters = 50,
                           initializer = "kmeans++", fuzzy = T, verbose = F,
                           CENTROIDS = NULL, tol = 1e-04, tol_optimal_init = 0.3, seed = 2)

# Word Frequencies for Clusters
freq_clust = textTinyR::cluster_frequency(tokenized_list_text = clust_vec$token,
                                          cluster_vector = km$clusters, verbose = T)


test = freq_clust$`1`[1:100] %>%
  full_join(freq_clust$`2`[1:100], by = 'WORDS') %>%
  replace_na(list(COUNTS.x=0,COUNTS.y=0)) %>%
  mutate(COUNTS.x = COUNTS.x / sum(COUNTS.x),
         COUNTS.y = COUNTS.y / sum(COUNTS.y),
         diff = abs(COUNTS.x - COUNTS.y)) %>%
  arrange(-diff)
test
