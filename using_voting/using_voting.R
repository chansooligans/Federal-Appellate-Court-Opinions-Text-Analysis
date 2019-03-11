#########################
# Set Up
#########################
library(shinystan)
library(parallel)
library(dplyr)
library(rstan)

options(mc.cores = parallel::detectCores())
rstan::rstan_options(auto_write = TRUE)
nChains <- 2

raw_data = read.csv('data/SCDB_2018_02_justiceCentered_Citation.csv')
head(raw_data)
cols_to_keep = c('caseId','justice','vote')

# Vote:
# 1: Concur
# 2: Dissent
# 3: Regular Concurrence
# 4: Special Concurrence
# 5-8:

# Subset Data
df = raw_data %>%
  select(cols_to_keep) %>%
  filter(vote <= 2)

#########################
# Models
#########################

df$vote = df$vote - 1
df$justice = as.integer(as.factor(df$justice))
df$caseId = as.integer(as.factor(as.integer(as.factor(df$caseId))))

data_list_0 = list(J = length(unique(df$justice)),
                   K = length(unique(df$caseId)),
                   N = nrow(df),
                   jj = df$justice,
                   kk = df$caseId,
                   y = df$vote)

stan_fit_0 = stan(file = 'stan/stan_irt_2PL.stan',
                  data = data_list_0,
                  chains = nChains,
                  iter = 2000)


save(stan_fit_0,file='stan_fit_using_voting.RDATA')

print(stan_fit_0, pars = c('alpha','beta','delta'))

