library(dplyr)

rm(list=ls())
setwd('/Users/chansoosong/Desktop/Research/edsp2019project-chansooligans/using_voting/')
load(file='stan_fit_using_voting_1PL.RDATA')
raw_data = read.csv('data/SCDB_2018_02_justiceCentered_Citation.csv')
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

df$vote = df$vote - 1
df$justice = as.integer(as.factor(df$justice))
df$caseId = as.integer(as.factor(as.integer(as.factor(df$caseId))))

###

res = as.data.frame(stan_fit_0)[,2:38]
res = apply(res,2,mean)

###

temp = raw_data %>% filter(vote <= 2)
temp$judge_id = df$justice
temp = temp %>%
  group_by(judge_id,justice,justiceName) %>%
  dplyr::summarize(n=n()) 

temp$ideology = res

temp = temp %>% arrange(ideology)
plot(temp$ideology)
text(temp$ideology, labels = temp$justiceName, pos=4, cex=0.8, col = 4)





