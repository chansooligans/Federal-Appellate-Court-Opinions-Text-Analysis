##################################################
# 1. Set Up
##################################################

# Set Court ***
i=2

require(rjson)
require(tm)
require(SnowballC)
require(textTinyR)
require(ClusterR)
require(dplyr)
require(tidyr)
require(irlba) # fast and memory efficient methods for truncated singular value decomp + PCA of large sparse matrices

# FastText Installation
#########################
# NOTE: fasTextR Installation will fail on Mac
# Click links below to see issue and to learn to use OpenMP in R on Mac
    # https://github.com/mlampros/ClusterR/issues/12#issuecomment-444386654
    # https://thecoatlessprofessor.com/programming/openmp-in-r-on-os-x/
# Then link below to resolve "fatal error: 'math.h' file not found"
    # https://github.com/RcppCore/Rcpp/issues/922
# devtools::install_github('mlampros/fastTextR')
require(fastTextR)

# Text Cleaning Functions
#########################
htmlBreaks <- function(htmlString) {
  htmlString = gsub("<br>", " ", htmlString)
  return(gsub("\n", " ", htmlString))
}

htmlRemove <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}

# File Paths
#########################
# data is available here: https://www.courtlistener.com/api/bulk-info/
courts = paste('ca',c(seq(1,11),'dc'),sep='')
# decisions_path = paste('data/',courts,'/',sep='')
decisions_path = paste('/scratch/cs2737/',courts,'/',sep='')
decisions_files = sapply(decisions_path, function(x) list.files(x))
n_cases = unlist(lapply(decisions_files,length))

# Load Data
#########################
decisions = list()

decisions = rep(NA,n_cases[i])
for(j in 1:n_cases[i]){
  result = fromJSON(file=paste(decisions_path[i], decisions_files[[i]][j],sep=''))
  if(result$html_with_citations != ''){
    decisions[j] = result$html_with_citations  
  } else if(result$plain_text != ''){
    decisions[j] = result$plain_text  
  }
  decisions[j] = htmlRemove(decisions[j])
  decisions[j] = htmlBreaks(decisions[j])
  if(j %% 2000==0) print(paste('loading opinion',j,'from court',courts[i]))
}

concat = unlist(decisions)
concat = concat[!is.na(concat)]

##################################################
# 2. Text Pre-Processing
##################################################

# Convert to lower case, trim tokens, remove stopwords, porter stemming, 
# keep words with minimum number of characters equal to 3 
# For each document, tokenize terms
clust_vec = textTinyR::tokenize_transform_vec_docs(object = concat, as_token = T,
                                                   to_lower = T, 
                                                   remove_punctuation_vector = F,
                                                   remove_numbers = F, 
                                                   trim_token = T,
                                                   split_string = T,
                                                   split_separator = " \r\n\t.,;:()?!//", 
                                                   remove_stopwords = T,
                                                   language = "english", 
                                                   min_num_char = 3, 
                                                   max_num_char = 100,
                                                   stemmer = "porter2_stemmer", 
                                                   threads = 4,
                                                   verbose = T)

# All unique terms from all documents
unq = unique(unlist(clust_vec$token, recursive = F))

# Term matrix to get the global-term-weights (idf global term weights)
utl = textTinyR::sparse_term_matrix$new(vector_data = concat, file_data = NULL,
                                        document_term_matrix = TRUE)
tm = utl$Term_Matrix(sort_terms = FALSE, to_lower = T, remove_punctuation_vector = F,
                     remove_numbers = F, trim_token = T, split_string = T, 
                     stemmer = "porter2_stemmer",
                     split_separator = " \r\n\t.,;:()?!//", remove_stopwords = T,
                     language = "english", min_num_char = 3, max_num_char = 100,
                     print_every_rows = 100000, normalize = NULL, tf_idf = F, 
                     threads = 6, verbose = T)
gl_term_w = utl$global_term_weights()

# For each document, tokenize terms (same as "clust_vec" above) BUT
# using "path_2folder" parameter saves output in a .txt file, which is memory efficient
save_dat = textTinyR::tokenize_transform_vec_docs(object = concat, as_token = T, 
                                                  to_lower = T, 
                                                  remove_punctuation_vector = F,
                                                  remove_numbers = F, 
                                                  trim_token = T, 
                                                  split_string = T, 
                                                  split_separator = " \r\n\t.,;:()?!//",
                                                  remove_stopwords = T, 
                                                  language = "english", 
                                                  min_num_char = 3, 
                                                  max_num_char = 100, 
                                                  stemmer = "porter2_stemmer", 
                                                  path_2folder = paste("/scratch/cs2737/models/",courts[i],'/',sep=''), 
                                                  threads = 4, 
                                                  verbose = T)

# Tokenized Text Input Path / Model Output Path
# Storing on USB drive bc space
PATH_INPUT = paste("/scratch/cs2737/models/",courts[i],'/output_token_single_file.txt', sep = '')
PATH_OUT = paste("/scratch/cs2737/models/",courts[i],'/rt_fst_model', sep = '')

# Use fastTextR to build the word-vectors
vecs = fastTextR::skipgram_cbow(input_path = PATH_INPUT, 
                                output_path = PATH_OUT, 
                                method = "skipgram", 
                                lr = 0.075, 
                                lrUpdateRate = 100, 
                                dim = 300, 
                                ws = 5, 
                                epoch = 5, 
                                minCount = 1, 
                                neg = 5, 
                                wordNgrams = 2, 
                                loss = "ns", 
                                bucket = 2e+06,
                                minn = 0, 
                                maxn = 0, 
                                thread = 6, 
                                t = 1e-04, 
                                verbose = 2)

# The word vectors are based on the decisions themselves
# However, if I used word vectors based on external data, such as Wikipedia data, then 
# I can use function below to keep only word-vectors that appear in decisions corpus here
# This helps with computation time
init = textTinyR::Doc2Vec$new(token_list = clust_vec$token, 
                              word_vector_FILE = paste("/scratch/cs2737/models/",courts[i],'/rt_fst_model.vec',sep=''),
                              print_every_rows = 20000, # specifies print intervals (frequent outputs can slow down function)
                              verbose = TRUE, # whether to print information or not
                              copy_data = FALSE) # use of external pointer

# Transformed vectors using three methods:
# sum_sqrt, min_max_norm, idf
# see documentation for details: https://cran.r-project.org/web/packages/textTinyR/textTinyR.pdf
doc2_sum = init$doc2vec_methods(method = "sum_sqrt", threads = 6)
doc2_norm = init$doc2vec_methods(method = "min_max_norm", threads = 6)
doc2_idf = init$doc2vec_methods(method = "idf", global_term_weights = gl_term_w, threads = 6)

save(doc2_sum,doc2_norm,doc2_idf,file=paste('/scratch/cs2737/results/',courts[i],'_vectors.RDATA',sep=''))
save(clust_vec,file=paste('/scratch/cs2737/results/',courts[i],'_cluster_vec.RDATA',sep=''))