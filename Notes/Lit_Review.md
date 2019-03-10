# Literature Review 

### Past approaches of meassuring judge ideology:
1. [Judicial Common Space score](http://epstein.wustl.edu/research/JCS.html)
- developed in early 1980s 
- uses appointing political actors' ["nominate scores"](https://en.wikipedia.org/wiki/NOMINATE_(scaling_method)) (multidimensional scaling applied to voting behavior), Poole and Rosenthal's measures of the nominating president and/or state home Senator
2. [Segal and Cover](https://en.wikipedia.org/wiki/Segal%E2%80%93Cover_score)
- analyze pre-confirmation newspaper editorials (e.g. NY Times, WSJ, Washington POst, Chicago Tribune, LA Times)
- For each article, nominee receives two binary scores: qualified vs unqualified, conservative vs liberal
3. [Martin-Quinn scores](http://mqscores.lsa.umich.edu/)
- developed in 2002
- Uses Bayesian IRT to generate measures of Supreme Court ideology
- MC scores cannot be used for lower courts since I cannot compare judges across different circuits
4. [CFscores](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2739478)
- developed in 2016
- uses judges' political contributions
5. [Clerk-Based Ideology](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2739478)
- developed in 2016
- uses judges' clerks' political contributions

### Past text analysis approaches of measuring judge ideology:
1. [Mapping the Geometry of Law using Document Embeddings (Ash & Chen](http://users.nber.org/~dlchen/papers/Mapping_the_Geometry_of_Law_using_Document_Embeddings.pdf)
- NBER, 2018 working paper
- Apply vector representation NLP techniques to federal appellate court judges 
- "The vectors do not reveal spatial distinctions in terms of political party or law school attended, but they do highlight generational differences across judges. we conclude the paper by outlining a range of promising future applications of these methods." 
2. [What Kind of Judge is Brett Kavanaugh (Ash & Chen)](http://cardozolawreview.com/what-kind-of-judge-is-brett-kavanaugh/)
- Cardozo Law Review, 2018
- Uses doc2vec to compare SC justices' writing styles
3. [Inferring Multi-Dimensional Ideal Points for US Supreme Court Justices (Islam, Hossain, Krishnan, Ramakrishnan)](https://www.aaai.org/ocs/index.php/AAAI/AAAI16/paper/view/12306)
- Discovery Analytics Center, Virginia Tech (2017)
- Ideal Point modeling of SC justices' ideology using both judge voting and text of decisions
4. [The Supreme Court and the Judicial Genre (Livermore, Riddell, Rockmore](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2740126)
- Arizona Law Review, 2017
- Latent Dirichlet Allocation, topic modeling to estimate degree of semantic distinctiveness of SC opinions + track changes in distinctiveness over second half of 20th century
