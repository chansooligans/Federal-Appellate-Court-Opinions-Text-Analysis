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

- Goal: Work on improving text-preprocessing, improve on doc2vec code, try LDA

#### Accomplishments:
1. Including bag_of_words + PCA model to analysis as well
2. Started data inventory 
    - create a single .csv that contains all documents (or one .csv for each court). 
    - The .csv should include the .json file name and the year.
3. Use data inventory to subset list of .json files to the year. Then run doc2vec for that particular year.
4. Setting things up on HPC Cluster so I can try running doc2vec on more than 1000 opinions
    - Not necessary if I'm processing a Corpus from year/topic/court at a time
    - I found topic labels on this site: http://artsandsciences.sc.edu/poli/juri/databases.htm
    - BUT linkage will be tricky, particularly if the case names are different, e.g. "United States vs U.S."
5. Learn about Martin-Quinn Scores (which has little to do with text analysis but I have been procrastinating on learning this properly)

#### To-Do:
- Need to get "Topic" for cases
- Need to complete data inventory

#### Thoughts:
- From 2018, [How Conservatives Weaponized the First Amendment](https://www.nytimes.com/2018/06/30/us/politics/first-amendment-conservatives-supreme-court.html), based off of a quote by Elena Kagan. It could be interesting to zoom in on First Amendment-related decisions from federal appellate courts (if there are enough) and look for patterns. 
- I would like to replicate Martin-Quinn scores as well (which looks complicated but manageable using Stan -- most difficult part would be using the dynamic linear model algorithm if it is not already available)

#### Misc Notes:
- Computer broke !!!! Spent a lot of time setting everything up on new device... but back on track.

Some resources:
- https://medium.com/scaleabout/a-gentle-introduction-to-doc2vec-db3e8c0cce5e
- https://www.hvitfeldt.me/blog/using-pca-for-word-embedding-in-r/
- https://github.com/saudiwin/idealstan/blob/master/src/stan_files/irt_standard.stan
- https://cran.r-project.org/web/packages/idealstan/vignettes/Package_Introduction.html



