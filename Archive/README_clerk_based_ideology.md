# Judge Ideology using their Clerks' Political Contributions

Education Data Science Practicum Spring 2019

Project Started: 1/30/2019  
Updated: 2/13/2019

### New Plan (What happend to Old Plan? See bottom of page):

Bonica (2014) uses data on law clerks' political contributions to calculate their ideological scores. Then, judges' ideological scores can be estimated as the mean of their clerks' ideological scores. The purpose of my project is to use this proxy method of measurement to better understand clusters and patterns in judges' ideologies.  So first goal is to replicate the data collection methodology. Then, using judges' ideology, represented by either the vector of their clerks' scores or its mean, I can apply unsupervised learning techniques to understand my original questions: How much do federal judges' ideologies cluster according to the president who nominated the judge? Clearly, there are many other questions I can address such as... (1) how do judges' ideologies change over time? (2) do judges' ideologies change when nominated on to the Supreme Court?, etc... 

For more details on the paper, see "The Political Ideologies of Law Clerks, by Bonica, Chilton, Goldin, Rozema, and Sen" in the Literature Review folder.

#### Data:
1. [Database on Ideology, Money in Politics, and Elections (DIME), Stanford SSDS](https://data.stanford.edu/dime)
    - contains political donations disclosed by Federal Election Commission and state agencies
    - donations made in local, state, federal elections from 1979 to 2014 for individuals, politial action committees, corporations
    - ~ 100 million donations
    - [link to data](https://data.stanford.edu/dime#download-data)
2. Katz and Stafford dataset provides information on clerks who worked for federal circuit / district judges between 1995 and 2004 (there may be more up-to-date sources!)
3. Supreme Court Information office contains data on Supere Court clerks
4. Martindale-Hubbell directory contains data on attorneys in the United States (unique identifier, current employer, geographic location, area of practice)

Linkage: Use Bonica (2014) method to link clerks to federal judges ([article](https://politicalscience.stanford.edu/news/new-data-show-how-liberal-merrick-garland-really), [paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2739478))

#### Measurement:
- Use DIME data to compute ideological scores known as Campaign Finance scores (CFscores), following scaling methodology described in Bonica (2014)

#### Key Assumptions:
- Law clerks donate to candidates with whom they are in ideological agreement 
- Law clerks' ideologies do not change between time of clerkship and contribution (majority of donations used to derive CFscores come years after clerkship)
- Whether a law clerk donated or not is independent of judges' ideologies (note: over 40% of lawyers donate)
- Given some judge, the mean of their clerks' ideologies is representative of the judge's ideology. (Mostly true, sometimes judges intentionally hire clerks with conflicting viewpoints)

Note that judges' CFscores may be computed too using judges' donations prior to being confirmed (or after retirement). Once on the bench, judges are prohibited from making political donations.

***

### **Why did I abandon trying to measure judges' ideology using text of their decisions**:
- Personally, I was thinking of this project as an opportunity to do cool things with text as opposed to deeply understanding a question with the aid of data. I decided that I'm not married to text analysis and I can return to it another time. I could have applied text analysis to Congress floor speeches, but I'd rather stick with learning about federal judges. 
- Challenge: Text analysis of judge decisions may be able to identify differences in style, but differences in ideology are much too subtle. Suppose I have vector representations of appellate judges. Ash and Chen show that even after mean-centering for year, topic, and circuit, there are no discernible differences between the vector representations of democratic vs republican judges. Why? One reason may be that  legal language is jargony and typically avoids coloquialisms (e.g. in Congress, members use colloquial speech in floor speeches such as "death tax", "estate tax", "fake news", "alternative facts", "pro-life", "anti-choice"), as discussed in [538 article](https://fivethirtyeight.com/features/how-conservative-is-brett-kavanaugh/). 
- I still think it's possible -- but this is more like a 10-year problem than a semeseter problem. But just to elaborate a little... consider Snyder vs. Phelps (2011):
- Quick facts: Westboro church members picketed with egregious homophobic signs at the funeral service of Marine Lance Corporal Matthew Snyder
- Briefly, Roberts states there are "special protections" for first amendment for speech regarding public issues that takes place on public land. Here's a passage I annotated:

![Roberts](notes/pics/roberts.png)

- Alito dissents that free speech is not a license to inflict harm. Here's a passage:

![Alito](notes/pics/alito.png)

This is just one example... but it feels that with enough passages like this, it should be possible to compute judge profiles using text data. But these passages are few and far between. Even if one can methodically remove the fact pattern from opinions... that step alone may be helpful in isolating the more ideology-revealing text.

Another complication with Appellate courts is that there are even fewer "ideology-revealing" moments in the lower courts comapred to Supreme Court. 

### Bonus idea in case anyone is interested: 

**Style Fingerprint**: 
- Livermore and Rockmore find that there has been a decrease in "friendliness" of court decisions (friendliness measured based on frequency "positive" words).
- An opportunity for further research is to find out why: is it because the language is less formal? is this evidence for more divisiveness? 
- Livermore and Rockmore also measure the "stylistic fingerprint" of judges, which is based on judges' use of function words (e.g. prepositions, conjunctions, pronouns, determiners, auxiliary verbs). They say that we use different parts of our brain for function vs content words (e.g. nouns, main verbs, adjectives, certain adverbs, negatives). Further, the way that we use function words yields a unique stylistic fingerprint.

### Anyways, I will pivot to working with law (CLERKS): 

![Clerks](notes/pics/Clerks.png)
