# Measuring Judge Ideology 

Education Data Science Practicum Spring 2019

Project Started: 1/30/2019  
Updated: 3/10/2019

## See "Week 7 Progress Report.ipynb" for progress
## See "Journal.md" for journal

#### Accomplished so far:
1. Data collection: 
	- gain all federal appellate court opinions
2. Pre-Analysis:
	- made sure vector representation of opinions is possible (works for first circuit)
3. Text Cleaning (lots of regex nightmares!):
	- need to build metadata, for each opinion:
		- authoring judge
		- year
		- court
	- identify documents that contain dissents/concurrences from other judges
	- identify documents that are per curiam
4. Modeling:
	- average document vectors for each judge to get judge vectors
	- PCA on judge vectors to look for clusters (for 1st circuit)

Notes:
1. Part (3) above is incomplete. JSON raw data's "year" is sparse. I need to extract year from the opinions.
2. Once Part (3) is complete, de-mean documents by court and by year. 
3. How to de-mean by topic? I need topic labels. Ash and Chen won't share metadata with topic labels :(
 

***
### Purpose:
There are lots of models that can be used to estimate ideal points of judges (i.e. Poole and Rosenthal, Martin-Quinn, Clinton, etc). These models use mostly voting records of the judges. The purpose of this study is to try ideal-point modeling using the text of opinions instead of voting behavior. The subjects of the study are federal judges in the Appellate Courts of the United States (i.e. 1st Circuit Court of Appeals).    

### Data:
- [Court Listener](https://www.courtlistener.com/api/bulk-info/)
- [Duke](https://law.duke.edu/lib/facultyservices/empirical/links/courts/)
- [The Judicial Research Initiative](http://artsandsciences.sc.edu/poli/juri/appct.htm)

### Analysis:

#### Part one:

Some things to watch out for include **era-effects**, **topic-effects** and **circuit effects**.

1. Start with one circuit court
2. Learn to implement doc2vec using "fastTextR", "textTinyR"
3. The idea is to apply this onto all federal appellate court opinions

Problem:
- I need to extract "year" from the opinions. Where do I get topic? Should I model this?

#### Part two:

Now that I know I can implenent vector representations of these documents, need to clean text.

1. Identify the judge who wrote the opinion (Metadata not available for all federal appellate court cases)
2. Identify dissent, concurrence, per curiam
3. Extract year from decisions
4. Then, de-mean document vectors by **year** and **circuit** THEN average for each judge

