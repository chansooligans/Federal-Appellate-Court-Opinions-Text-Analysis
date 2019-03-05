# Judicial Decisions Text Analysis

Education Data Science Practicum Spring 2019

Project Started: 1/30/2019  
Updated: 2/10/2019

### Purpose:
There are lots of models that can be used to estimate ideal points of judges (i.e. Poole and Rosenthal, Martin-Quinn, Clinton, etc). These models use voting records of the judges. The purpose of this study is to try ideal-point modeling using the text instead of the votes. Couple things to watch out for include **era-effects**, **topic-effects** and **circuit effects**. 


## To-Do:

## Background, Literature, Methods, Resources, Data:

### I. Background: 

#### Martin-Quinn Scores:

[Martin-Quinn](http://mqscores.lsa.umich.edu/) scores aim to pinpoint justices' ideologies on a left-right political spectrum based on justices' votes
![Source: Andrew D. Martin, Kevin M. Quinn](/notes/pics/pic4.png)

Martin and Quinn employ Markhov chain Monte Carlo methods to fit a Bayesian measurement model of ideal points for all justices serving on the U.S> Supreme Court from 1953 through 1999. To investigate preference change, they posit a dynamic item response model that allows ideal points to change systematically over time. 

Example of a __basic ideal-point model for Supreme Court voting__ based on Gelman + Hill ARM Ch. 11:

![Ideal-point model for Supreme Court voting](/notes/pics/pic5.png)

#### Appeals Process:

[Source](https://www.ca3.uscourts.gov/brief-overview-appeals-process): Appeal begins when you file a notice of appeal or a petition for review from a final decision of a district court or agency. Court of Appeals Clerk's Office assigns a court of appeals docket number. Clerk will issue a briefing schedule. Your brief is the primary focus of the appeal. Once all briefs have been filed, they will be sent to a panel of judges for a decision on the merits of the appeal. The majority of cases are decided on briefs only. No new evidence or testimony can be presented in this court. **This Court is permitted only to examine the district court / agency records for possible constitutional, legal, or factual error. Your appeal may be decided with or without a written opinion.**

After a final judgement is entered by Court of Appeals, a dissatisfied litigant may file a petition for rehearing OR petition for writ of certiorari in the Supreme Court of the United States.

#### Nomination Process:

1. Supreme court judges, court of appeals judges, and district court judges are nominated by the President and confirmed by the United States Senate
2. Senate Judiciary Committee typically conducts confirmation hearings for each nominee
3. Judicial officers are appointed for a life term

![Judicial Appointments by President](/notes/pics/pic3.png)

#### The Federal courts / The judicial branch:
1. Supreme Court: Chief Justice and 8 Associate Justices   
2. U.S. Court of Appeals: 13 appellate courts: Federal Circuit, District of Columbia Circuit, First Circuit, Second Circuit, ..., Eleventh Circuit
3. District Courts: 94 district or trial courts

![Based on 2010; source: wikipedia](/notes/pics/pic1.png)

#### Federal Court vs State Courts

![Federal Court vs State Courts](/notes/pics/pic2.png)

#### Main Legal Topics:
1. Criminal Appeal
2. Civil Rights
3. First Amendment
4. Due Process
5. Privacy
6. Labor
7. Regulation



___
### II. Articles:

1. [Five Thirty Eight: How Conservative is Brett Kavanaugh?](https://fivethirtyeight.com/features/how-conservative-is-brett-kavanaugh/)
2. [New Yorker: How Obama Transformed the Federal Judiciary](https://www.newyorker.com/magazine/2014/10/27/obama-brief)
3. [New Yorker: Why Did Chief Justice Roberts Decide to Speak Out Against Trump?](https://www.newyorker.com/news/our-columnists/why-did-chief-justice-john-roberts-decide-to-speak-out-against-trump)
4. [Wash Post: Exactly How Conservative are the judges on Trump's short list for the Supreme Court? Take a look at this one chart](https://www.washingtonpost.com/news/monkey-cage/wp/2018/07/07/exactly-how-conservative-are-the-judges-on-trumps-short-list-for-the-supreme-court-take-a-look-at-this-one-chart/?utm_term=.d10658cba78a)
5. [NYTimes: Chief Justice Defends Judicial Independence After Trump Attacks 'Obama Judge'](https://www.nytimes.com/2018/11/21/us/politics/trump-chief-justice-roberts-rebuke.html)
6. [Wash Post: Chief Justice Roberts is wrong. We do have Obama judges and Trump judges](https://www.washingtonpost.com/opinions/chief-justice-roberts-is-wrong-we-do-have-obama-judges-and-trump-judges/2018/11/23/ee8de9a2-ef2c-11e8-8679-934a2b33be52_story.html?utm_term=.c97df93848fc)
7. [The Appellate Courts’ Role in the Federal Judicial System](https://www.americanbar.org/content/dam/aba-cms-dotorg/products/inv/book/214907/5310396%20chapter%201_abs.pdf)

Medium Projects (informal, not peer-reviewed):
1. [Predicting Supreme Court Rulings](https://medium.com/@datahacked/predicting-supreme-court-rulings-f845ce5626f4)
2. [Topic Modeling with LSA, PLSA, LDA & lda2Vec](https://medium.com/nanonets/topic-modeling-with-lsa-psla-lda-and-lda2vec-555ff65b0b05)

Misc:
1. [Ideological Leanings of Supreme Court Justices](https://en.wikipedia.org/wiki/Ideological_leanings_of_United_States_Supreme_Court_justices)
2. [Andrew Gelman: "Ideal point models"](https://statmodeling.stat.columbia.edu/2004/11/02/ideal_point_mod/)
___
### III. Related Studies and Projects:

1. [Martin-Quinn Scores](http://mqscores.lsa.umich.edu/)
2. [Approaches to Text Mining Arguments from Legal Cases (Wyner, Mochales-Palau, Moens, Milward 2009)](http://wyner.info/research/Papers/WynerMochalesPalauMoensMilward2009.pdf)    
3. [Mapping the Geometry of Law using Document Embeddings (Chen and Ash 2018)](http://users.nber.org/~dlchen/papers/Mapping_the_Geometry_of_Law_using_Document_Embeddings.pdf)
4. [Estimating Judicial Traits from Text Analysis of Expert Evaluations (Cope and Feldman 2018)](http://kevinlcope.com/wp-content/uploads/2018/07/AFJ-Article-MC2.pdf)
5. [The Supreme Court and the Judicial Genre](https://poseidon01.ssrn.com/delivery.php?ID=776114008100074125082093000101115014038018014015006038127117109011068081076116008007106099010022103035124021029119010104083023126008014016039096084008114112103122037061009111123103126096071113014025066127090112076065115004096001123104098067085118117&EXT=pdf)
6. [Practical Issues in Implementing and Understanding Bayesian Ideal Point Estimation (Bafumi, Gelman, Park, Kaplan)](http://www.stat.columbia.edu/~gelman/research/unpublished/Manuscript_idealpoints.pdf)

___
### IV. Methods
1. [Latent Dirichlet Allocation (Blei, Ng, Jordan)](http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf)
2. [Paragraph Vector (Le, Mikolov)](https://cs.stanford.edu/~quocle/paragraph_vector.pdf)
3. [Word2Vec (Mikolov et al, Google)](https://papers.nips.cc/paper/5021-distributed-representations-of-words-and-phrases-and-their-compositionality.pdf)

___
### V. Resources:

1. [Keras for R](https://keras.rstudio.com/)
2. [Tensorflow RStudio](https://tensorflow.rstudio.com/)
3. [R Datacamp: NLP]( https://www.datacamp.com/community/tutorials/R-nlp-machine-learning)

___
### VI. Data:

Main source of data: 
1. [Court Listener -- API Available](https://www.courtlistener.com/ )
2. [Duke Law -- Data Sources](https://law.duke.edu/lib/facultyservices/empirical/links/courts/)

Other potential sources of data:  

1. [WashU in St Louis: Center for Empirical Research in the Law](http://cerl.wustl.edu/project/)
2. [Corpus of US Supreme Court Opinions](https://corpus.byu.edu/scotus/)
3. [Justia](https://supreme.justia.com/cases/federal/us/)
4. [FindLaw](https://caselaw.findlaw.com/court/us-supreme-court)























