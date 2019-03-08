# Journal 

## Week 1: 1/28/2019

- Goal: Create project idea presentation video
- I want to look at the text of judges' decisions to determine whether judges ideologies' tend to cluster according to their nominating president
- Created github page with a README
- Found data source, downloaded data
- Read news articles about the topic, start reading some academic papers on topic
- To-Do:
1. Literature Review
2. Learn about other methods of measuring ideology (Martin-Quinn Scores, Clerk-Based Ideology, etc...)

## Week 2: 2/04/2019

- Goal: Continue Literature Review, Learning about Judge Ideology Measurement
- OF COURSE there are "Obama"-judges and "Reagan"-judges. But maybe my question is more general: can I use text to measure judge ideology?
- Should I abandon idea of using text? Clerk-based ideology looks interesting. Need federal clerks data from a professor but he is unresponsive. I'll stick with text analysis.
- Learned about ideal-point modeling, Martin-Quinn Scores (fairly high-level)
- To-do:
1. Start looking at data
2. Narrow study question

## Week 3: 2/11/2019 + Week 4: 2/18/2019

- Goal: Create a journal, start looking at the data
- Forget Clerk-Based Ideology idea, commit to text analysis
- Successfully coded doc2vec in R using the fasttextR and texttinyR libraries
- It would be cool to code these functions from scratch at some point in both Python and in R. (Learning Tensorflow in R API would be a fun task) 
- I have year and circuit for all federal appellate cases. I don't have "topic" which would be nice. Can I find this somewhere?
- No Class in Week 4

## Week 5: 2/25/2019 + Week 6: 3/4/2019

- Goal: Work on improving text-preprocessing, improve on doc2vec code, Martin-Quinn

#### Accomplishments:

1. Moved analysis to HPC Cluster, Text Cleaning, Collect Metadata from Opinions (Only for First Circuit for Now)
    - Only keep main opinion (remove dissents, concurrences, per curiam)
        - for now, just not using opinion if there is a dissent/concur/per curiam
        - maybe i can separate dissents later, but there aren't many in Appellate courts anyway
    - Keep name of the judge who wrote the opinion
        - Use Regex to do this (this was a nightmare!)
        - Sometimes District Judge delivers opinion in the Appellate Court. Discarding these.
        - Sometimes Supreme Court Justice "sits by designation". Discard these.
    - Create metadata spreadsheet
        - For each opinion, includes:
            - urls
            - whether plain_text is available
            - whether html is available
            - year
            - court name
    - Get judge data
        - I can use wikipedia for this (e.g. judge birth year, appointed by)
2. Learned about Martin-Quinn Scores (which has little to do with text analysis but I have been procrastinating on learning this properly)
	- Code simple 1PL (Rasch) Model in Stan (just borrowed from documentation)
	- Ran in NYU HPC (had some trouble with StanHeaders on Rstan)
	- Supreme Court voting data is here: http://scdb.wustl.edu/data.php
    - I will be working on Bayesian Ideal Point Estimation research with Ying, I might transition away from text to this
3. Sent email to Prof Elliott Ash and Prof Daniel Chen for Federal Appellate Court Metadata
	- Chen responded: only willing to share data with co-authors (too expensive to build dataset)
4. Sent third email to Prof Daniel Martin Katz for Federal Appellate Court Metadata


#### Thoughts:
- I would like to replicate Martin-Quinn scores as well (which looks complicated but manageable using Stan -- most difficult part would be using the dynamic linear model algorithm if it is not already available)

#### Misc Notes:
- Computer broke !!!! Spent a lot of time setting everything up on new device... but back on track.

Some resources:
- https://medium.com/scaleabout/a-gentle-introduction-to-doc2vec-db3e8c0cce5e
- https://www.hvitfeldt.me/blog/using-pca-for-word-embedding-in-r/
- https://github.com/saudiwin/idealstan/blob/master/src/stan_files/irt_standard.stan
- https://cran.r-project.org/web/packages/idealstan/vignettes/Package_Introduction.html



